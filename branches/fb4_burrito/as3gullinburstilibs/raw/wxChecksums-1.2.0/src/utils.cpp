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
 * \file utils.cpp
 * Various utility functions.
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
#include <wx/datetime.h>
#include <wx/dir.h>
#include <wx/filename.h>
#include <wx/tokenzr.h>

#include <climits>

// Include the Windows API header at the end prevents some problems that can
// occur at the linking procedure.
#if defined(__WXMSW__)
#include <windows.h>
#include <winbase.h>
#include <winnls.h>
#include <winuser.h>
#include <wx/msw/private.h>
#endif   // __WXMSW__

#include "utils.hpp"
#include "comdefs.hpp"
#include "dlgProgress.hpp"
#include "osdep.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------

/// The C++ standard namespace.
using namespace std;


/**
 * Compares two file names.
 *
 * Under Windows the comparison is case insensitive.
 *
 * @param  fn1  First file name.
 * @param  fn2  Second file name.
 * @return A negative value if <CODE>f1 < f2</CODE>, a positive value if
 *         <CODE>f1 > f2</CODE>, <CODE>0</CODE> if <CODE>f1 == f2</CODE>.
 */
int compareFileName(const wxString& fn1, const wxString& fn2)
{
  int res;
  #if defined(__WXMSW__)
  res = CompareString(LOCALE_USER_DEFAULT, NORM_IGNORECASE, fn1.c_str(), -1, fn2.c_str(), -1) - CSTR_EQUAL;
  #else
  res = fn1.Cmp(fn2);
  #endif  // __WXMSW__
  
  return res;
}
//---------------------------------------------------------------------------


/**
 * Convert progress bar counter values.
 *
 * For getFilesInSubdirectories() and getFilesInSubdirectoriesRec() internal
 * usage only.
 *
 * @param  pc  Progress bar value.
 * @param  mn  Minimum value.
 * @param  mx  Maximal value.
 */
static int FilesInSubdirectoriesCounterConverter(const double pc, const int mn, const int mx)
{
  int cpval = static_cast<int>(pc);
  if (cpval < mn) cpval = mn; 
  if (cpval > mx) cpval = mx; 
  
  return cpval;
}
//---------------------------------------------------------------------------


/**
 * Find all the files in the subdirectories from a list of files and directories.
 *
 * For internal usage only.
 *
 * @param  lFiles  List of files and directories to search into.
 * @param  res     Array of string where all the founded files will to stored.
 *                 All files present in lFiles will be copied (but not the
 *                 directories).
 * @param  filesSize Will contains the total size of the parsed files.
 * @param  matchPatterns  Optionnal matching patterns for files' names.
 * @param  depth   Maximal depth of recursion.
 * @param  lt      Last time when the dialog has been updated.
 * @param  dlgProgress  Progress dialog.
 * @param  cp      Current position for the progress bar.
 * @param  cpMax   Maximal position for the progress bar.
 * @return <CODE>true</CODE> on success, <CODE>false</CODE> on failure or if
 *         the user has canceled.
 */
static bool getFilesInSubdirectoriesRec(const wxArrayString& lFiles, wxArrayString& res,
                                 BytesDisplayer& filesSize,
                                 const wxArrayString& matchPatterns,
                                 const unsigned int depth,
                                 wxDateTime& lt,
                                 dlgProgress& dlgProgress, double cp,
                                 double cpMax)
{
  if (lFiles.IsEmpty())  // to avoid div by 0 in initialization of incrByFile.
    return true;
  if (depth == 0)
    return true;

  wxDateTime ct;            // current time
  wxTimeSpan timeSpan(0, 0, 0, UPDATE_PROGRESS_DLG);
  bool   cont = true;   // continue ?
  double incrByFile = (cpMax - cp) / static_cast<double>(lFiles.GetCount());
  const  wxChar pathSeparator = wxFileName::GetPathSeparator();
  bool   matched;

  for (size_t i = 0; i < lFiles.GetCount() && cont; i++)
  {
    // Show information
    ct = wxDateTime::UNow();
    if (ct.IsLaterThan(lt))
    {
      int cpval = FilesInSubdirectoriesCounterConverter(cp, 0, SHRT_MAX - 2);
      cont = dlgProgress.Update(cpval, lFiles[i]);
      ::wxYield();
      lt = ct + timeSpan;
    }

    // Pause ?
    while (dlgProgress.isPaused())
      ::wxYield();

    if (::wxDirExists(lFiles[i]))
    // Explore the directory
    {
      if (depth > 1)
      // Don't explore the directory if it isn't needed.
      {
        wxArrayString files;
        wxDir dir(lFiles[i]);
        wxFileName dirName;
        wxFileName fn;
        dirName.AssignDir(lFiles[i]);
        if (dir.IsOpened())
        {
          wxString f;
          bool found = dir.GetFirst(&f, wxEmptyString, wxDIR_FILES | wxDIR_DIRS | wxDIR_HIDDEN);
          while (found)
          {
            fn = dirName;
            fn.SetFullName(f);
            files.Add(fn.GetFullPath());
            found = dir.GetNext(&f);
          }
          cont = getFilesInSubdirectoriesRec(files, res, filesSize, matchPatterns, depth - 1, lt, dlgProgress, cp, cp + incrByFile);
        }
      }
    }
    else  // match the file
    {
      if (matchPatterns.IsEmpty())
        matched = true;
      else
      {
        matched = false;
        size_t c = 0;
        while (!matched && c < matchPatterns.GetCount())
        {
          matched = ::wxMatchWild(matchPatterns[c], lFiles[i], false);
          c++;
        }
      }

      if (matched)
      {
        res.Add(lFiles[i]);
        wxCOff_t fs;
        if ((fs = wxCGetFileLength(lFiles[i])) != static_cast<wxCOff_t>(wxInvalidOffset))
          filesSize += static_cast<double>(fs);
      }
    }
  
    cp += incrByFile;
  }
  
  return cont;
}
//---------------------------------------------------------------------------


/**
 * Find all the files in the subdirectories from a list of files and directories.
 *
 * A matching pattern can be speficied. Wildcards are <CODE>*</CODE> and
 * <CODE>?</CODE>. <CODE>*</CODE> subtitutes one or more characters,
 * <CODE>?</CODE> one character.<BR>
 * Matching patterns are separated by the <CODE>;</CODE> character.<BR>
 * If no matching patterns are given, all the files will be matched.
 *
 * The depth of recursion can be <CODE>0</CODE> for no limit,
 * <CODE>1</CODE> for the given directories, <CODE>2</CODE> for the given
 * directories and their subdirectories, etc...
 *
 * @param  lFiles  List of files and directories to search into.
 * @param  res     Array of string where all the founded files will to stored.
 *                 All files present in lFiles will be copied (but not the
 *                 directories).
 * @param  filesSize Will contains the total size of the parsed files.
 * @param  matchPattern  Optionnal matching pattern for files' names.
 * @param  maxDepth  Maximal depth of recursion.
 * @return <CODE>true</CODE> on success, <CODE>false</CODE> on failure or if
 *         the user has canceled.
 */
bool getFilesInSubdirectories(const wxArrayString& lFiles, wxArrayString& res,
                              BytesDisplayer& filesSize,
                              const wxString& matchPattern,
                              unsigned int maxDepth)
{
  if (lFiles.IsEmpty())
    return true;

  dlgProgress dlgProgress(_("Searching files"), _("Beginning..."), SHRT_MAX - 1, NULL,
    wxPD_APP_MODAL | wxPD_AUTO_HIDE | wxPD_CAN_ABORT | wxPD_ELAPSED_TIME | wxPD_ESTIMATED_TIME | wxPD_REMAINING_TIME);

  // Get the matching patterns
  wxArrayString matchPatterns;
  wxStringTokenizer tkz(matchPattern, wxT(";"), wxTOKEN_STRTOK);
  while (tkz.HasMoreTokens())
  {
    wxString token = tkz.GetNextToken();

    if (!wxFileName::IsCaseSensitive())
      GetAllTokenCases(token, matchPatterns);
    else
      matchPatterns.Add(token);
  }

  unsigned int depth = (maxDepth == 0 || maxDepth == UINT_MAX) ? UINT_MAX : maxDepth + 1;
  wxTimeSpan timeSpan(0, 0, 0, UPDATE_PROGRESS_DLG);
  wxDateTime lt = wxDateTime::UNow() - timeSpan;  // last time
  bool   cont;                 // continue ?

  cont = getFilesInSubdirectoriesRec(lFiles, res, filesSize, matchPatterns,
                                     depth, lt, dlgProgress, 0.0,
                                     static_cast<double>(SHRT_MAX - 2));
  
  dlgProgress.Update(SHRT_MAX - 1, _("Finished"));
  
  return cont;
}
//---------------------------------------------------------------------------


/**
 * Gets the application's name.
 *
 * @param  addVersion  If <CODE>true</CODE>, add the version number + special.
 * @return The application's name.
 */
wxString getAppName(bool addVersion)
{
  wxString res;
  
  if (addVersion)
  {
    res.Printf(wxT("%s v%d.%d.%d"), wxT(APP_NAME), APP_MAJOR_VER, APP_MINOR_VER, APP_SUBVER);
    wxString special(wxT(APP_SPECIAL));
    if (!special.empty())
      res += wxString::Format(wxT(" (%s)"), special.c_str());
  }
  else
    res = wxT(APP_NAME);
  
  return res;
}
//---------------------------------------------------------------------------


/**
 * Convert a <CODE>wxColour</CODE> value to a <CODE>long</CODE> value.
 *
 * @param  value  The value to convert.
 * @return The value converted to a <CODE>long</CODE> value.
 */
long wxColourToLong(const wxColour& value)
{
  long res;

  res = (static_cast<long>(value.Red()) << 16) | 
        (static_cast<long>(value.Green()) << 8) | 
        (static_cast<long>(value.Blue()));
  return res;
}
//---------------------------------------------------------------------------


/**
 * Convert a <CODE>long</CODE> value to a <CODE>wxColour</CODE> value.
 *
 * @param  value  The value to convert.
 * @return The value converted to a <CODE>wxColour</CODE> value.
 */
wxColour longTowxColour(long value)
{
  wxColour res(static_cast<unsigned char>((value & 0xFF0000) >> 16),
               static_cast<unsigned char>((value & 0x00FF00) >> 8),
               static_cast<unsigned char>((value & 0x0000FF)));
  
  return res;
}
//---------------------------------------------------------------------------


/**
 * Convert the specified character to the lower case.
 *
 * @param  s    String that contains the character to lower.
 * @param  idx  Index in <CODE>s</CODE> of the character to lower.
 */
void ToLower(wxString& s, size_t idx)
{
  if (idx < s.size())
  {
    wxString t = s[idx];
    t.LowerCase();
    wxChar c = t.GetChar(0);
    s[idx] = c;
  }
}
//---------------------------------------------------------------------------


/**
 * Convert the specified character to the upper case.
 *
 * @param  s    String that contains the character to upper.
 * @param  idx  Index in <CODE>s</CODE> of the character to upper.
 */
void ToUpper(wxString& s, size_t idx)
{
  if (idx < s.size())
  {
    wxString t = s[idx];
    t.UpperCase();
    wxChar c = t.GetChar(0);
    s[idx] = c;
  }
}
//---------------------------------------------------------------------------


/**
 * Get the given token with all the possible cases. Result is added to tk.
 *
 * @param  token  Token to get with all the possible cases.
 * @param  tk     Arary of string when the tokens will be added.
 * @param  p      Current position in the token (only for internal recursivity).
 */
void GetAllTokenCases(wxString token, wxArrayString& tk, size_t p)
{
  if (p == token.size())
  {
    if (tk.Index(token, true) == wxNOT_FOUND)
      tk.Add(token);    
    return;
  }

  ToUpper(token, p);
  GetAllTokenCases(token, tk, p + 1);
  ToLower(token, p);
  GetAllTokenCases(token, tk, p + 1);
}
//---------------------------------------------------------------------------
