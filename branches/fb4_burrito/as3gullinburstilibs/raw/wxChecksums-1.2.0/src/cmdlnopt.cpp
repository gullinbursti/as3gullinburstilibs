/*
 * wxChecksums
 * Copyright (C) 2003-2004 Julien Couot
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

/**
 * \file cmdlnopt.cpp
 * Options passed by the command line.
 */


//---------------------------------------------------------------------------
// For compilers that support precompilation, includes "wx.h".
#include <wx/wxprec.h>

#ifdef __BORLANDC__
#pragma hdrstop
#endif

#ifndef WX_PRECOMP
// Include your minimal set of headers here, or wx.h
#include <wx/wx.h>
#endif

#include <wx/cmdline.h>
#include <wx/config.h>
#include <wx/fileconf.h>
#include <wx/filename.h>
#include <wx/msgout.h>
#include <wx/tokenzr.h>
#include <wx/txtstrm.h>
#include <wx/wfstream.h>

#include "cmdlnopt.hpp"
#include "utils.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


// Static attributes of the CmdLineOptions class
CmdLineOptions::Actions CmdLineOptions::action;
CmdLineOptions::CkSumsFileTypes CmdLineOptions::createType;
wxArrayString CmdLineOptions::files;
wxString CmdLineOptions::checksumsFileName;
bool CmdLineOptions::deleteTempLists;
//---------------------------------------------------------------------------


/// Messages output stream.
static wxMessageOutput* msgOut = NULL;
//---------------------------------------------------------------------------


/**
 * Default constructor.
 *
 * Don't allow to create an instance out this of this class.
 */
CmdLineOptions::CmdLineOptions()
{
}
//---------------------------------------------------------------------------


/**
 * Initializes the options.
 *
 * Should be called at the application startup.
 *
 * param  parser  Command line parser.
 * @return <CODE>true</CODE> if the passed commands are corrects,
 *         <CODE>false</CODE> otherwise.
 */
bool CmdLineOptions::init(const wxCmdLineParser& parser)
{
  msgOut = wxMessageOutput::Get();
  wxString str;

  action = aNone;
  createType = cftNone;
  deleteTempLists = false;
  files.Clear();
  checksumsFileName.Clear();

  if (parser.Found(wxT("V")))
  {
    msgOut->Printf(wxT("%s"), ::getAppName().c_str());
    return false;
  }

  // Get the list of files.
  size_t paramCount = parser.GetParamCount();
  for (size_t i = 0; i < paramCount; i++)
    files.Add(parser.GetParam(i));

  // Expand the list of names of files.
  deleteTempLists = parser.Found(wxT("delete-temp-list"));
  expandFilesList(parser);

  // Checks for incompatibles switchs and/or options and/or number of given
  // files. Checks the validity of the given options.
  if (!checkVerifySwitch(parser) || !checkCreateOption(parser) ||
      !checkAppendOption(parser) || !checkCreateTypeOption(parser))
    return false;

  // If no action has been set, checks if a checksums' file must be opened.
  if (!checkOpenChecksumsFile(parser))
    return false;

  return true;
}
//---------------------------------------------------------------------------


/**
 * Cleans up the structures that take memory.
 *
 * Call this function when you do not need the command line options.
 */
void CmdLineOptions::cleanup()
{
  files.Clear();
  checksumsFileName.Clear();
}
//---------------------------------------------------------------------------


/**
 * Get the type of the checksums' file to create.
 *
 * If the ct parameter has been specified, return the given type, otherwise
 * try to get the type with the extension of the checksums' file.
 *
 * @return The type of the checksums' file to create or <CODE>cftNone</CODE>
 *         if the type of the checksums' file cannot be determined.
 */
CmdLineOptions::CkSumsFileTypes CmdLineOptions::getchecksumsFileType()
{
  CkSumsFileTypes res = createType;
  
  if (res == cftNone)
  {
    // Try to get the type of the checksums' file with the extension.
    wxString ext;
    wxFileName::SplitPath(checksumsFileName, NULL, NULL, &ext);
    if (ext.CmpNoCase(wxT("sfv")) == 0)
      res = cftSFV;
    else if (ext.CmpNoCase(wxT("md5")) == 0)
      res = cftMD5;
  }

  return res;
}
//---------------------------------------------------------------------------


/**
 * Loads the list(s) of files, delete the file that contains the list if the
 * <CODE>deleteTempLists</CODE> switch is activated.
 *
 * @param  parser  Command line parser.
 */
void CmdLineOptions::expandFilesList(const wxCmdLineParser& parser)
{
  wxString lists;
  if (!parser.Found(wxT("fl"), &lists))
    // No file.
    return;
  
  wxStringTokenizer tkzLists(lists, wxT("|"), wxTOKEN_STRTOK);
  while (tkzLists.HasMoreTokens())
  {
    wxString fileName = tkzLists.GetNextToken();
    if (!fileName.empty())
    {
      wxLogNull logNo;   // No log
      bool read = false; // the file has been opened and read ?

      {  // open a block to destroy the wxFileInputStream before erasing the file
        wxFileInputStream input(fileName);
        if (input.Ok())
        {
          // Reads the lines
          wxTextInputStream text(input);
          wxString line;

          line = text.ReadLine();
          while (!input.Eof())
          {
            line.Strip(wxString::both);
            if (!line.empty())
              files.Add(line);
            line = text.ReadLine();
          }
          read = true;
        }
      }

      if (read && deleteTempLists)
      {
        // Checks if the read file has the extension of the temp file.
        wxString ext;
        wxFileName::SplitPath(fileName, NULL, NULL, NULL, &ext);
        wxString tmpExts = wxConfig::Get()->Read(_T("Files/TempExts"), _T("tmp temp"));
        wxStringTokenizer tkz(tmpExts, wxT(" \t\r\n"), wxTOKEN_STRTOK);
        bool found = false;
        while (!found && tkz.HasMoreTokens())
          if (::compareFileName(tkz.GetNextToken(), ext) == 0)
            found = true;
          
        if (found)
          ::wxRemoveFile(fileName);
      }
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Make all the names of the files in the array of files absolute.
 *
 * You should call <CODE>expandFilesList</CODE> before to be sure that the
 * list of names of files doesn't contain pointer to list of files.
 *
 * @param  cwd  Reference path to make the paths absolute. Must be an absolute
 *              path (if not, nothing is done) and don't contains a name of file.
 */
void CmdLineOptions::makeFilesListAbsolute(const wxString& cwd)
{
  wxFileName refPath(cwd, wxString());
  if (!refPath.IsAbsolute())
    return;

  wxString ref = refPath.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR);

  size_t l = files.GetCount();
  for (size_t i = 0; i < l; i++)
  {
    wxFileName fn(files[i]);
    if (!fn.IsAbsolute())
    {
      fn.MakeAbsolute(ref);
      files[i] = fn.GetFullPath();
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Checks the compatibility of the verify switch with other options or switchs.
 *
 * param  parser  Command line parser.
 * @return <CODE>true</CODE> if the verify switch is compatible with other
 *         options or switchs, <CODE>false</CODE> otherwise.
 */
bool CmdLineOptions::checkVerifySwitch(const wxCmdLineParser& parser)
{
  if (parser.Found(wxT("v")))
  {
    // Checks for incompatible switchs or options.
    if (parser.Found(wxT("c")))
    {
      msgOut->Printf(_("The verify switch and the create option are incompatibles."));
      return false;
    }
    if (parser.Found(wxT("a")))
    {
      msgOut->Printf(_("The verify switch and the append option are incompatibles."));
      return false;
    }
    
    // Checks the number of given file
    if (files.IsEmpty())
    {
      msgOut->Printf(_("The verify switch needs that you specify one file to check."));
      return false;
    }
    if (files.GetCount() > 1)
    {
      msgOut->Printf(_("The verify switch needs that you specify only one file to check."));
      return false;
    }
    
    // Checks the name of the file to open
    files[0] = files[0].Strip(wxString::both);
    if (files[0].empty())
    {
      msgOut->Printf(_("The name of the file to check is empty."));
      return false;
    }
    
    // Make the file name to open absolute if needed.
    wxFileName fn(files[0]);
    if (!fn.IsAbsolute())
    {
      fn.MakeAbsolute(wxFileName::GetCwd());    
      files[0] = fn.GetFullPath();
    }

    // Set the action to do.
    action = aVerify;
  }
  
  return true;
}
//---------------------------------------------------------------------------


/**
 * Checks the compatibility of the append option with other options or switchs.
 *
 * @param  parser  Command line parser.
 * @return <CODE>true</CODE> if the append option is compatible with other
 *         options or switchs, <CODE>false</CODE> otherwise.
 */
bool CmdLineOptions::checkAppendOption(const wxCmdLineParser& parser)
{
  wxString param;

  if (parser.Found(wxT("a"), &param))
  {
    param = param.Strip(wxString::both);
    
    // Remove the path separators at the end of the file name
    wxString seps = wxFileName::GetPathSeparators();
    while (!param.empty() && seps.Find(param.Last()) != -1)
      param.RemoveLast();
    
    wxFileName fn(param);
    
    // Checks for incompatible switchs or options.
    if (parser.Found(wxT("v")))
    {
      msgOut->Printf(_("The append option and the verify switch are incompatibles."));
      return false;
    }
    if (parser.Found(wxT("c")))
    {
      msgOut->Printf(_("The append and create options are incompatibles."));
      return false;
    }

    // Checks if the file name where the checksums will be added is empty.
    if (param.empty())
    {
      msgOut->Printf(_("The name of the checksums' file where the checksums will be added is empty."));
      return false;
    }
    
    // Make the file name where the checksums will be added absolute if needed.
    if (!fn.IsAbsolute())
      fn.MakeAbsolute(wxFileName::GetCwd());
      
    // checks if the directory of the where the checksums will be added exists
    if (!wxFileName::DirExists(fn.GetPath(wxPATH_GET_VOLUME)))
    {
      msgOut->Printf(_("The directory %s doesn't exist."), fn.GetPath(wxPATH_GET_VOLUME).c_str());
      return false;
    }
    
    // Make the names of the files to add absolute.
    makeFilesListAbsolute(::wxGetCwd());
    
    checksumsFileName = fn.GetFullPath();

    // Set the action to do.
    action = aAppend;
  }

  return true;
}
//---------------------------------------------------------------------------


/**
 * Checks the compatibility of the create option with other options or switchs.
 *
 * @param  parser  Command line parser.
 * @return <CODE>true</CODE> if the create option is compatible with other
 *         options or switchs, <CODE>false</CODE> otherwise.
 */
bool CmdLineOptions::checkCreateOption(const wxCmdLineParser& parser)
{
  wxString param;

  if (parser.Found(wxT("c"), &param))
  {
    param = param.Strip(wxString::both);

    // Remove the path separators at the end of the file name
    wxString seps = wxFileName::GetPathSeparators();
    while (!param.empty() && seps.Find(param.Last()) != -1)
      param.RemoveLast();

    wxFileName fn(param);
    
    // Checks for incompatible switchs or options.
    if (parser.Found(wxT("v")))
    {
      msgOut->Printf(_("The create option and the verify switch are incompatibles."));
      return false;
    }
    if (parser.Found(wxT("a")))
    {
      msgOut->Printf(_("The create and append options are incompatibles."));
      return false;
    }

    // Checks if the file name to create is empty.
    if (param.empty())
    {
      msgOut->Printf(_("The name of the checksums' file to create is empty."));
      return false;
    }
    
    // Make the file name to create absolute if needed.
    if (!fn.IsAbsolute())
      fn.MakeAbsolute(wxFileName::GetCwd());
      
    // checks if the directory of the file to create exists
    if (!wxFileName::DirExists(fn.GetPath(wxPATH_GET_VOLUME)))
    {
      msgOut->Printf(_("The directory %s doesn't exist."), fn.GetPath(wxPATH_GET_VOLUME).c_str());
      return false;
    }
    
    // Make the names of the files to add absolute.
    makeFilesListAbsolute(::wxGetCwd());
    
    checksumsFileName = fn.GetFullPath();

    // Set the action to do.
    action = aCreate;
  }

  return true;
}
//---------------------------------------------------------------------------


/**
 * Checks the compatibility of the create type option with other options or
 * switchs.
 *
 * @param  parser  Command line parser.
 * @return <CODE>true</CODE> if the create type option is compatible with other
 *         options or switchs, <CODE>false</CODE> otherwise.
 */
bool CmdLineOptions::checkCreateTypeOption(const wxCmdLineParser& parser)
{
  wxString param;

  if (parser.Found(wxT("ct"), &param))
  {
    // Checks the given type
    param = param.Strip(wxString::both);
    
    if (param.CmpNoCase(wxT("sfv")) == 0)
      createType = cftSFV;
    else if (param.CmpNoCase(wxT("md5")) == 0)
      createType = cftMD5;
    else
    {
      msgOut->Printf(_("The type of the checksums' file to create is invalid. Valids types are 'sfv' and 'md5'."));
      return false;      
    }
  }  

  return true;
}
//---------------------------------------------------------------------------


/**
 * If no action has been set, checks if a checksums' file must be opened.
 *
 * param  parser  Command line parser.
 * @return <CODE>true</CODE> if no error or incompatibility has been detected,
 *         <CODE>false</CODE> otherwise.
 */
bool CmdLineOptions::checkOpenChecksumsFile(const wxCmdLineParser& parser)
{
  if (action == aNone)
  {
    if (files.GetCount() > 1)
    {
      msgOut->Printf(_("You can specify only one file to check at the same time."));
      return false;
    }
    
    if (files.GetCount() == 1)
    {    
      // Checks the name of the file to open
      files[0] = files[0].Strip(wxString::both);
      if (files[0].empty())
      {
        msgOut->Printf(_("The name of the file to check is empty."));
        return false;
      }
    
      // Make the file name to open absolute if needed.
      wxFileName fn(files[0]);
      if (!fn.IsAbsolute())
      {
        fn.MakeAbsolute(wxFileName::GetCwd());    
        files[0] = fn.GetFullPath();
      }

      // Set the action to do.
      action = aOpen;
    }
  }
  
  return true;
}
//---------------------------------------------------------------------------
