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
 * \file frmSums.hpp
 * Application's main window definitions.
 */

#ifndef INC_FRMSUMS_HPP
#define INC_FRMSUMS_HPP

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
#include "lvwSums.hpp"
//---------------------------------------------------------------------------


/**
 * The application main window.
 */
class frmSums : public wxFrame
{
 public:
  // Creates a new frame.
  frmSums();

  // Creates a new frame.
  frmSums(const wxChar* title, int xpos, int ypos, int width, int height);

  // Creates a new frame.
  frmSums(const wxChar* title);
  
  // Destructor.
  virtual ~frmSums();

 protected:
  // Creates and initializes the controls of window. Creates the window's controls.
  void createControls();

  // Creates the tools bar
  void createToolbar();

  // Creates the status bar
  void createStatusbar();

 public: 
  // Initializes some parameters from the command line.
  void initializeFromCmdLine(bool& error, bool& warning);

  // Checks if the window should be closed after initialisation from the command line.
  bool closeAfterInitFromCmdLine(bool error, bool warning);

 protected:
  // Sets the frame title
  void updateTitle();
  
  // Saves the current checksum file
  bool saveChecksumFile(const wxString& fileName);
  
  // Checks if the current checksums' file has been saved before closing it
  int checkFileBeforeClose();

  // Initializes the open recent files.
  void initializeOpenRecent();
  
  // Adds a name of file to the open recent submenu.
  void addFileNameToOpenRecent(const wxString& fileName);

  // Gets the name of the file corresponding to the given identifier.
  wxString getOpenRecentFileName(const int id);

  // Gets the configuration key for the last files' names open recently.
  static wxString getOpenRecentConfigKey(const int n);

  // Gets the number of maximal files in the open recent history.
  static int getOpenRecentHistoryMaxSize();

  static const int TOOL_BITMAP_SIZE;  ///< The maximum size of a toolbar button.
  ChecksumsListView* lvwSums;    ///< The listview which displays information about checksums.
  wxToolBar*    tlbTools;        ///< The tools bar.
  wxStatusBar*  stbStatus;       ///< The status bar.
  wxMenu*       mnuOpenRecent;   ///< Open recent sub menu.
  wxArrayString openRecent;      ///< Open recent files.


  // Processes menu File->New
  void itmFileNewClick(wxCommandEvent& event);
  // Processes menu File->Open
  void itmFileOpenClick(wxCommandEvent& event);
  // Processes menu File->Open recent
  void itmFileOpenRecentClick(wxCommandEvent& event);
  // Processes menu File->Save
  void itmFileSaveClick(wxCommandEvent& event);
  // Processes menu File->Save as
  void itmFileSaveAsClick(wxCommandEvent& event);
  // Processes menu File->Close
  void itmFileCloseClick(wxCommandEvent& event);
  // Processes menu File->Quit
  void itmFileQuitClick(wxCommandEvent& event);

  // Processes menu Sums->Add files...
  void itmSumsAddFilesClick(wxCommandEvent& event);
  // Processes menu Sums->Add directories...
  void itmSumsAddDirectoriesClick(wxCommandEvent& event);
  // Processes menu Sums->Add matching files...
  void itmSumsAddMatchingFilesClick(wxCommandEvent& event);
  // Processes menu Sums->Remove...
  void itmSumsRemoveClick(wxCommandEvent& event);
  // Processes menu Sums->Check
  void itmSumsCheckClick(wxCommandEvent& event);
  // Processes menu Sums->Recompute
  void itmSumsRecomputeClick(wxCommandEvent& event);
  // Processes menu Sums->Sort by...
  void itmSumsSortByClick(wxCommandEvent& event);
  // Update the state of the Sort by... submenu
  void itmSumsSortByUpdate();
  // Processes menu Sums->Select all
  void itmSumsSelectAllClick(wxCommandEvent& event);
  // Processes menu Sums->Invert selection
  void itmSumsInvertSelectionClick(wxCommandEvent& event);

  // Processes menu Tools->Check multiple checksum's files
  void itmToolsCheckMultipleClick(wxCommandEvent& event);
  // Processes menu Tools->Batch creation of checksums' files
  void itmToolsBatchCreationClick(wxCommandEvent& event);
  // Processes menu Tools->Show toolbar
  void itmToolsShowToolbarClick(wxCommandEvent& event);
  // Processes menu Tools->Show statusbar
  void itmToolsShowStatusbarClick(wxCommandEvent& event);
  // Processes menu Tools->Configure
  void itmToolsConfigureClick(wxCommandEvent& event);

  // Processes menu Help->About
  void itmHelpAboutClick(wxCommandEvent& event);

  // Event handler for a keypressed.
  void FrameCharHook(wxKeyEvent& event);
  
  // Event handler to respond to system close events.
  void FrameClose(wxCloseEvent& event);

  // Processes a click on a header of a column of the list of checksums.
  void lvwSumsColumnClick(wxListEvent& event);

  // Processes the EVENT_UPDATE_SUMS_FRAME_TITLE_COMMAND event.
  void OnUpdateTitle(wxCommandEvent& event);
  
  // Processes the EVENT_UPDATE_SUMS_FRAME_STATUSBAR_COMMAND event.
  void OnUpdateStatusBar(wxCommandEvent& event);

  // Processes the EVENT_OPEN_RECENT_ADD_FILE event.
  void OnOpenRecentAddFile(wxCommandEvent& event);

  /// Controls IDs
  enum
  {
    STB_STATUS = wxID_HIGHEST + 1,
    LVW_SUMS,
    ITM_FILE_NEW,
    ITM_FILE_OPEN,
    MNU_FILE_OPENRECENT,
    ITM_FILE_OPENRECENT1,    // Must be the same number as getOpenRecentHistoryMaxSize() returns.
    ITM_FILE_OPENRECENT2,
    ITM_FILE_OPENRECENT3,
    ITM_FILE_OPENRECENT4,
    ITM_FILE_OPENRECENT5,
    ITM_FILE_OPENRECENT6,
    ITM_FILE_OPENRECENT7,
    ITM_FILE_OPENRECENT8,
    ITM_FILE_OPENRECENT9,
    ITM_FILE_OPENRECENT10,
    ITM_FILE_OPENRECENT11,
    ITM_FILE_OPENRECENT12,
    ITM_FILE_OPENRECENT13,
    ITM_FILE_OPENRECENT14,
    ITM_FILE_OPENRECENT15,
    ITM_FILE_OPENRECENT16,
    ITM_FILE_SAVE,
    ITM_FILE_SAVEAS,
    ITM_FILE_CLOSE,
    ITM_FILE_QUIT,
    ITM_SUMS_ADDFILES,
    ITM_SUMS_ADDDIRECTORIES,
    ITM_SUMS_ADDMATCHINGFILES,
    ITM_SUMS_REMOVE,
    ITM_SUMS_CHECK,
    ITM_SUMS_RECOMPUTE,
    ITM_SUMS_SORTBY,
    ITM_SUMS_SORTBY_FILENAME,
    ITM_SUMS_SORTBY_DIRECTORY,
    ITM_SUMS_SORTBY_CHECKSUMVALUE,
    ITM_SUMS_SORTBY_STATE,
    ITM_SUMS_SORTBY_SEPARATOR1,  // needed to separate radio item groups
    ITM_SUMS_SORTBY_ASCENDING,
    ITM_SUMS_SORTBY_DESCENDING,
    ITM_SUMS_SORTBY_NONE,
    ITM_SUMS_SELECTALL,
    ITM_SUMS_INVERTSELECTION,
    ITM_TOOLS_CHECK_MULTIPLE,
    ITM_TOOLS_BATCH_CREATION,
    ITM_TOOLS_SHOW_TOOLBAR,
    ITM_TOOLS_SHOW_STATUSBAR,
    ITM_TOOLS_CONFIGURE,
    ITM_HELP_ABOUT
  };  

  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(frmSums)  
};
//---------------------------------------------------------------------------


#endif  // INC_FRMSUMS_HPP
