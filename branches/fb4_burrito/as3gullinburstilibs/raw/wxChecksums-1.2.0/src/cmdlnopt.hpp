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
 * \file cmdlnopt.hpp
 * Options passed by the command line.
 */

#ifndef INC_CMDLNOPT_HPP
#define INC_CMDLNOPT_HPP

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
//---------------------------------------------------------------------------


/**
 * Options passed by the command line.
 */
class CmdLineOptions
{
 private:
  // Don't allow to create an instance out this of this class.
  CmdLineOptions();

 public:
  // General operations
  // Initializes the options.
  static bool init(const wxCmdLineParser& parser);
  
  // Cleanup.
  static void cleanup();
  // ----------------------------------------------------
  
  /// Action to do at the startup
  enum Actions
  {
    aNone = 0,
    aOpen,
    aVerify,
    aCreate,
    aAppend
  };
  
  /// Type of checksums' files that the application know
  enum CkSumsFileTypes
  {
    cftNone = 0,
    cftSFV,
    cftMD5
  };
  // ----------------------------------------------------

  /// Action to do at the startup of the application.
  static Actions action;
  
  /// Type of the checksums' file
  static CkSumsFileTypes createType;
  
  /// List of the files given on the command line
  static wxArrayString files;
  
  /// Name of the checksums' file to create or where the files will be added.
  static wxString checksumsFileName;
  
 private: 
  /// Delete  temporary lists of files
  static bool deleteTempLists;
  // ----------------------------------------------------

 public: 
  // Helper operations
  // Get the type of the checksums' file to create.
  static CkSumsFileTypes getchecksumsFileType();
  // ----------------------------------------------------
  
 private:
  // Specific operations.  
  // Look if the array of files contains a list of files, load it and delete
  // the file that contains the list if the deleteTempLists switch is activated.
  static void expandFilesList(const wxCmdLineParser& parser);

  // Make all the names of the files in the array of files absolute.
  static void makeFilesListAbsolute(const wxString& cwd);
  
  // Checks the compatibility of the verify switch with other options or switchs.
  static bool checkVerifySwitch(const wxCmdLineParser& parser);

  // Checks the compatibility of the append option with other options or switchs.
  static bool checkAppendOption(const wxCmdLineParser& parser);

  // Checks the compatibility of the create option with other options or switchs.
  static bool checkCreateOption(const wxCmdLineParser& parser); 

  // Checks the compatibility of the create type option with other options or switchs.
  static bool checkCreateTypeOption(const wxCmdLineParser& parser); 

  // If no action has been set, checks if a checksums' file must be opened.
  static bool checkOpenChecksumsFile(const wxCmdLineParser& parser);
};
//---------------------------------------------------------------------------


/// Indicates when displaying the GUI.
enum DisplayGUI
{
  clgNever = 0,
  clgOnError,
  clgOnWarning,
  clgAlways
};


#endif  // INC_CMDLNOPT_HPP
