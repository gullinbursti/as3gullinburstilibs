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
 * \file lvwSums.hpp
 * A personalized listview to display information about checksums.
 */

#ifndef INC_LVWSUMS_HPP
#define INC_LVWSUMS_HPP

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
#include <wx/listctrl.h>
#include "sumfile.hpp"
//---------------------------------------------------------------------------

/// Number of columns in the list of checksums.
#define  LVW_SUMS_NBCOLS  4

/**
 * The list that will display information about checksums.
 */
class ChecksumsListView : public wxListView
{
 public:
  // Default constructor
  ChecksumsListView();

  // Creates a new list
  ChecksumsListView(wxWindow* parent, wxWindowID id,
                    SumFile* checksumFile,
                    const wxPoint& pos = wxDefaultPosition,
                    const wxSize& size = wxDefaultSize,
                    long style = wxLC_REPORT,
                    const wxValidator& validator = wxDefaultValidator,
                    const wxString& name = wxT("checksumslistview"));

  // Destructor
  virtual ~ChecksumsListView();

  // Initializes the list parameters
  void init();


  //------------------------------------------
  // Operations on columns

  /// Sort order of the column
  enum SortOrder
  {
    NONE,
    ASCENDING,
    DESCENDING,
  };

  /// Columns enumeration.
  enum Columns
  {
    FILE_NAME = 0,
    DIRECTORY,
    CHECKSUM_VALUE,
    STATE
  };
  
  // Gets to sort order
  SortOrder getSortOrder() const;
  
  // Sets the sort order
  void setSortOrder(const SortOrder newSortOrder);
  
  // Gets the column to be sorted
  int getColumnToSort() const;
  
  // Sets the column to be sorted
  void setColumnToSort(const int col);
  
  // Sets the column to be sorted
  void setColumnToSort(const int col, const SortOrder newSortOrder);
  
  // Sort the list
  void sort();

 protected:
  /**
   * List of the columns (size = nb elements of enum Columns).
   *
   * Must contain once one of the elements of enum Columns.
   */
  Columns columns[LVW_SUMS_NBCOLS];  

  // Reformats the list.
  void reformat(Columns oldColumns[LVW_SUMS_NBCOLS]);
  
 public:
  // Gets the name of a column.
  static wxString getColumnName(const Columns col);
  
  // Gets the columns.
  void getColumns(Columns cols[LVW_SUMS_NBCOLS]);

  // Sets the columns.
  bool setColumns(Columns newColumns[LVW_SUMS_NBCOLS]);


  //------------------------------------------
  // Operations on the list

  // Selects all the items
  void selectAll();
  
  // Inverts the selection
  void invertSelection();

  // Reformats the list.
  void reformat();


  //------------------------------------------
  // Operations on the checksums

  // Gets a pointer on the checksum file.
  SumFile* getSumFile() const;
  
  // Sets the checksum file.
  void setSumFile(SumFile* pSumFile);

  // Checks the files.
  void check();

  // Recompute the checksums
  void recompute();

 protected:
  // Adds a checksum in the list
  long addChecksum(const long key, const wxString& stateMsg);

  // Sets an item.
  void setChecksum(long item, const wxString& stateMsg);

  // Sets the state of a checksum
  void setChecksumState(long item, const ChecksumData::State state, const wxString& msg);

  // Indicates if the specified file is present in the list of checksums.
  bool isInList(const wxString& fileName);

  // Removes the files that are already in the list
  bool removeFilesInList(wxArrayString& files, wxArrayString* in = NULL);

 public:
  // Removes selected chechsum from the list
  void removeSelectedChecksums();

  // Gets the total of each state in the list of checksums.
  wxArrayInt getStates(const bool onlySelected = false) const;

  // Sums up the total of each state in the list of checksums.
  wxString sumUpStates(const bool onlySelected = false) const;

  //------------------------------------------
  // Other operations

  // Open a dialog to select the files to add to the list
  void selectFilesToAdd();

  // Open a dialog to select the directories to add to the list
  void selectDirectoriesToAdd();
  
  // Open a dialog to select files to add from matching patterns
  void selectMatchingFilesToAdd();

  // Adds files to the list of checksums.
  void addFiles(const wxArrayString& files);

  // Processes a drop of files on the list.
  void DnDFiles(wxCommandEvent& event);

  // Open a checksum file
  bool openChecksumFile(const wxFileName& fileName);

 protected:
   SumFile* sumFile;     ///< Checksums file linked with the list.
   SortOrder sortOrder;  ///< Sort order
   int colToSort;        ///< Column to sort

  #if defined(__WXMSW__)
  // Event handler for the context menu demand.
  void OnContextMenu(wxContextMenuEvent& event);
  #else
  // Event handler for the context menu demand.
  void OnRightUp(wxMouseEvent& event);
  #endif  // defined(__WXMSW__)
  // Shows the context menu.
  void ShowContextMenu(const wxPoint& p);
  
  // Event handler for a key pressed.
  //void KeyPressed(wxKeyEvent& event);

  // Event handler a pop-up menu click on 'Add files...'.
  void itpAddFilesClick(wxCommandEvent& event);
  // Event handler a pop-up menu click on 'Add directories...'.
  void itpAddDirectoriesClick(wxCommandEvent& event);
  // Event handler a pop-up menu click on 'Add matching files...'.
  void itpAddMatchingFilesClick(wxCommandEvent& event);
  // Event handler a pop-up menu click on 'Remove'.
  void itpRemoveClick(wxCommandEvent& event);

  enum
  {
    ITP_FILESADD = wxID_HIGHEST + 1000,
    ITP_DIRECTORIESADD,
    ITP_ADDMATCHINGFILES,
    ITP_REMOVE
  };  

  DECLARE_EVENT_TABLE()
  
 private:
  DECLARE_DYNAMIC_CLASS(ChecksumsListView)
  
  // Progress updater
  class ChecksumProgress;
};
//---------------------------------------------------------------------------


/*
 * Defines a custom event for updating the dialog title.
 * Use this event when a child want the dialog title to be updated.
 */
BEGIN_DECLARE_EVENT_TYPES()
    DECLARE_LOCAL_EVENT_TYPE(EVENT_UPDATE_SUMS_FRAME_TITLE_COMMAND, 11001)
END_DECLARE_EVENT_TYPES()

/*
 * Defines a custom event for updating the status bar.
 * Use this event when a child want the dialog status bar to be updated.
 */
BEGIN_DECLARE_EVENT_TYPES()
    DECLARE_LOCAL_EVENT_TYPE(EVENT_UPDATE_SUMS_FRAME_STATUSBAR_COMMAND, 11002)
END_DECLARE_EVENT_TYPES()

/*
 * Defines a custom event for adding a file in the open recently file list.
 */
BEGIN_DECLARE_EVENT_TYPES()
    DECLARE_LOCAL_EVENT_TYPE(EVENT_OPEN_RECENT_ADD_FILE, 11003)
END_DECLARE_EVENT_TYPES()


#endif  // INC_LVWSUMS_HPP
