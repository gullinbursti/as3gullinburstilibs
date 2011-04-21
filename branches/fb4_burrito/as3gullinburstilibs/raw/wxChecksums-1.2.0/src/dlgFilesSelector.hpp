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
 * \file dlgFilesSelector.hpp
 * Configuration dialog for selecting multiple files.
 */

#ifndef INC_DLGFILESSELECTOR_HPP
#define INC_DLGFILESSELECTOR_HPP

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

#include <wx/spinctrl.h>

#include "fdftlmk.hpp"
#include "slstview.hpp"
//---------------------------------------------------------------------------


/**
 * Dialog for choosing multiple files to process.
 *
 * <B>Important:</B> you must call the <CODE>initialize()</CODE> method just
 * after the constructor the create the widgets of the window (this can't be
 * done in the constructor because <CODE>createControls()</CODE> calls pure
 * virtual methods.
 */
class dlgFilesSelector : public wxDialog
{
 public:
  // Creates a new dialog.
  dlgFilesSelector();

  // Creates a new dialog.
  dlgFilesSelector(wxWindow* parent, const bool extendDialog = false);

  // Initializes the dialog.
  virtual void initialize();

  // Destructor.
  virtual ~dlgFilesSelector();

  // Creates and initializes the controls of the dialog.
  void createControls();


 protected:
  bool           extend;       ///< Is the dialog will be extended ?
  wxSortableListView* lvwFiles;     ///< List of selected files.
  wxArrayString  fileNames;    ///< Names of the files given by the validator.
  wxButton*      btnAdd;       ///< Button for adding files.
  wxButton*      btnRemove;    ///< Button for removing files.
  wxRadioBox*    rbxSortBy;    ///< Sort by radio box buttons.
  wxRadioBox*    rbxSortOrder; ///< Sort order radio box buttons.
  wxButton*      btnSearchAndAdd;  ///< Search and add files to the list of files.
  wxComboBox*    cboNamed;     ///< Name of the file to search.
  wxComboBox*    cboLookIn;    ///< Directory to begin the search.
  wxSpinCtrl*    spnDepth;     ///< Search depth.
  wxBoxSizer*    extendSizer;  ///< Sizer where controls should be added (it is positionned before the validation buttons).

  // Gets a new unique identifier.
  static long getID();

  // Processes button Add.
  void btnAddClick(wxCommandEvent& event);
  // Processes button Remove.
  void btnRemoveClick(wxCommandEvent& event);
  // Processes button Add list.
  void btnAddListClick(wxCommandEvent& event);
  // Processes button Load list.
  void btnLoadListClick(wxCommandEvent& event);
  // Processes button Save list.
  void btnSaveListClick(wxCommandEvent& event);
  // Processes button Browse.
  void btnBrowseClick(wxCommandEvent& event);
  // Processes button Search and Add.
  void btnSearchAndAddClick(wxCommandEvent& event);

  // Event handler for the selection of an item.
  void lvwFilesSelectItem(wxListEvent& event);
  // Event handler for the deselection of an item.
  void lvwFilesDeselectItem(wxListEvent& event);
  // Event handler for the key down event.
  void lvwFilesKeyDown(wxListEvent& event);
  // Processes a click on a header of a column of the list of files.
  void lvwFilesColumnClick(wxListEvent& event);

  // Processes a selection of the column to sort.
  void rbxSortBySelect(wxCommandEvent& event);
  // Processes a selection of the sort order.
  void rbxSortOrderSelect(wxCommandEvent& event);

  // Event handler for the enter key pressed on a search combo box.
  void cboSearchTextEnter(wxCommandEvent& event);

  // Processes button OK.
  void btnOKClick(wxCommandEvent& event);

  /// Controls IDs
  enum
  {
    LVW_FILES = wxID_HIGHEST + 1,
    BTN_ADD,
    BTN_REMOVE,
    BTN_ADDLIST,
    BTN_LOADLIST,
    BTN_SAVELIST,
    CBO_NAMED,
    CBO_LOOKIN,
    BTN_BROWSE,
    BTN_SEARCH_AND_ADD,
    SPN_DEPTH,
    RBX_SORT_BY,
    RBX_SORT_ORDER,
    BTN_OK,
    DLG_FILESSELECTOR_ID_HIGHEST
  };

  // Adds the given array of file names to the listview of file names.
  void addFileNamesToListView(const wxArrayString& fileNames);

  // A validator for the files' list.
  class FilesListValidator;
  /// <CODE>FilesListValidator</CODE> can access to <CODE>getID()</CODE>.
  friend class FilesListValidator;

  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(dlgFilesSelector)

 public:
  // Gets the names of the files.
  void getFileNames(wxArrayString& names) const;

 public:  
  /**
   * Gets the root configuration key for parameters of this dialog.
   *
   * The returned string must be ended the a '<CODE>/</CODE>' character.
   *
   * @return  The root configuration key for parameters of this dialog.
   */
  virtual wxString getRootConfigKey() = 0;
  
  // Gets the configuration key for the last files' names for searching files
  wxString getNamedConfigKey(const int n);

  // Gets the configuration key for the last directories for searching files
  wxString getLookInConfigKey(const int n);
  
  // Gets the maximum size of the history of the last files' names and directories for searching files
  int getHistoryMaxSize();
  
 protected:
  /// Preferences keys
  enum PreferencesKey
  {
    prGUI_SORT_BY = 0,
    prGUI_SORT_ORDER,
    prGUI_FILENAME_WIDTH,
    prGUI_DIRECTORY_WIDTH,
    prGUI_WINDOW_SIZE
  };

  // Gets the configuration key corresponding to the given preference key.
  wxString getConfigKey(const PreferencesKey pk);
  
 protected:
  /// Custumised UI strings.
  enum UIStrings
  {
    uiDialogTitle = 0,
    uiBtnOK,
    uiFraFilesList,
    uiFraSearchFiles,
    uiOpenDlgAddFiles,
    uiOpenDlgAddList,
    uiOpenDlgLoadList,
    uiSaveDlgAddList
  };
 
  /**
   * Gets the string for the specified UI element.
   *
   * @param  id  Identifier of the wanted UI element.
   * @return The string for the specified UI element and an empty string if the
   *         given UI element is invalid.
   */
  virtual wxString getUIString(UIStrings id) = 0;
   
  /**
   * Returns a set of filters for the "Add files" dialog.
   *
   * @return A set of filters for the "Add files" dialog.
   */
  virtual wxFileDialogFilterMaker getFiltersForAddFilesDialog() = 0;

 private: // Utility functions
  // Adds a file or a directory or a match pattern to a combo box.
  static void addLineToComboBox(wxComboBox* cboBox, const int maxLines);

  // Gets the last directory used and the filter for the open or save dialog.
  void getLastDirectoryAndFilter(const wxString& configKey, wxString& lastDirKey, wxString& lastDir, wxFileDialogFilterMaker& fltMaker);
};
//---------------------------------------------------------------------------

#endif  // INC_DLGFILESSELECTOR_HPP
