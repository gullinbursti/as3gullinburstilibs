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
 * \file dlgAddMatchFiles.hpp
 * Dialog for adding files by pattern matching.
 */

#ifndef INC_DLGADDMATCHFILES_HPP
#define INC_DLGADDMATCHFILES_HPP

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
 * Dialog for choosing a new file name.
 *
 * If no name of checksums' file is given to the constructor, give one with
 * the setChecksumsFileName() method before showing the dialog.
 */
class dlgAddMatchFiles : public wxDialog
{
 public:  // classes used by the dialog
  // Match pattern.
  class MatchPattern;
  
  // Array of match pattern entries.
  class ArrayMatchPattern;
 
 public:
  // Creates a new dialog.
  dlgAddMatchFiles();

  // Creates a new dialog.
  dlgAddMatchFiles(wxWindow* parent, const wxString& checksumsFileName = wxEmptyString);

  // Destructor.
  virtual ~dlgAddMatchFiles();

  // Creates and initializes the controls of the dialog.
  void createControls();

 protected:
  // Sets the title of the dialog.
  void setDialogTitle();

 protected:
  static long    idGen;        ///< Value for unique identifiers generation.
  wxSortableListView* lvwPatterns;  ///< List of patterns.
  ArrayMatchPattern* matchPatterns;  ///< Match patterns given by the validator.
  wxButton*      btnRemove;    ///< Button for removing patterns.
  wxRadioBox*    rbxSortBy;    ///< Sort by radio box buttons.
  wxRadioBox*    rbxSortOrder; ///< Sort order radio box buttons.
  wxButton*      btnAddPattern;///< Add a pattern to the list.
  wxComboBox*    cboPattern;   ///< Pattern to add.
  wxComboBox*    cboDirectory; ///< Directory of the pattern.
  wxSpinCtrl*    spnDepth;     ///< Search depth.
  wxString       checksumsFileName;  ///< Name of the checksums' file where the files will be added.

  // Gets a new unique identifier.
  static long getID();

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
  // Processes button Add pattern.
  void btnAddPatternClick(wxCommandEvent& event);

  // Event handler for the selection of an item.
  void lvwPatternsSelectItem(wxListEvent& event);
  // Event handler for the deselection of an item.
  void lvwPatternsDeselectItem(wxListEvent& event);
  // Event handler for the key down event.
  void lvwPatternsKeyDown(wxListEvent& event);
  // Processes a click on a header of a column of the list of patterns.
  void lvwPatternsColumnClick(wxListEvent& event);

  // Processes a selection of the column to sort.
  void rbxSortBySelect(wxCommandEvent& event);
  // Processes a selection of the sort order.
  void rbxSortOrderSelect(wxCommandEvent& event);

  // Event handler for the enter key pressed on a search combo box.
  void cboAddTextEnter(wxCommandEvent& event);

  // Processes button Add.
  void btnAddClick(wxCommandEvent& event);

  /// Controls IDs
  enum
  {
    LVW_FILES = wxID_HIGHEST + 1,
    BTN_REMOVE,
    BTN_ADDLIST,
    BTN_LOADLIST,
    BTN_SAVELIST,
    CBO_PATTERN,
    CBO_DIRECTORY,
    BTN_BROWSE,
    BTN_ADD_PATTERN,
    SPN_DEPTH,
    RBX_SORT_BY,
    RBX_SORT_ORDER,
    BTN_ADD
  };

  // Add a pattern to the list view of patterns.
  void addPatternToListView(const MatchPattern& pattern);

  // A validator for the patterns' list.
  class PatternsListValidator;
  /// <CODE>FilesListValidator</CODE> can access to <CODE>getID()</CODE>.
  friend class PatternsListValidator;

  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(dlgAddMatchFiles)

 public:
  // Gets the matching patterns.
  void getMatchPatterns(ArrayMatchPattern& patterns) const;

  // Gets the name of the checksums' file where the files will be added.
  wxString getChecksumsFileName() const;
  
  // Sets the name of the checksums' file where the files will be added.
  void setChecksumsFileName(const wxString& fileName);

 public:  
  // Gets the root configuration key for parameters of this dialog
  static wxString getRootConfigKey();
  
  // Gets the configuration key for the last patterns
  static wxString getMatchPatternConfigKey(const int n);

  // Gets the configuration key for the last directories
  static wxString getDirectoryConfigKey(const int n);
  
  // Gets the maximum size of the history of the last patterns and directories
  static int getHistoryMaxSize();
  
 protected:
  /// Preferences keys
  enum PreferencesKey
  {
    prGUI_ADD_MATCH_FILES_SORT_BY = 0,
    prGUI_ADD_MATCH_FILES_SORT_ORDER,
    prGUI_ADD_MATCH_FILES_DIRECTORY_WIDTH,
    prGUI_ADD_MATCH_FILES_PATTERN_WIDTH,
    prGUI_ADD_MATCH_FILES_DEPTH_WIDTH,
    prGUI_ADD_MATCH_FILES_WINDOW_SIZE
  };

  // Gets the configuration key corresponding to the given preference key.
  static wxString getConfigKey(const PreferencesKey pk);

 private: // Utility functions
  // Adds a file or a directory or a match pattern to a combo box.
  static void addLineToComboBox(wxComboBox* cboBox, const int maxLines);

  // Gets the last directory used and the filter for the open or save dialog.
  static void getLastDirectoryAndFilter(const wxString& configKey, wxString& lastDirKey, wxString& lastDir, wxFileDialogFilterMaker& fltMaker);

  // Reads a file of matching patterns.
  static void readMatchPatternsFile(const wxString& fileName, ArrayMatchPattern& patterns);
};
//---------------------------------------------------------------------------


/**
 * Represent a match pattern used by the 'Add match files' dialog.
 *
 * It contains:
 * - A directory in which the search of files begins.
 * - A set of patterns separated by the character ';'.
 * - The depth of recursion in the subdirectories (0 = infinite).
 */
class dlgAddMatchFiles::MatchPattern
{
 protected:
  wxString directory;  ///< directory of the match pattern.
  wxString pattern;    ///< match pattern.
  int      depth;      ///< search depth.

  // Clones the source instance in this instance.
  void clone(const MatchPattern& source);

 public:
  /// Default constructor.
  MatchPattern() : depth(0) {}

  // Constructor.
  MatchPattern(const wxString& dir, const wxString& pat, const int dep);

  /**
   * Copy constructor.
   *
   * @param  source  Source instance.
   */
  MatchPattern(const MatchPattern& source)
  {
    clone(source);
  }

  // Assignment operator.
  MatchPattern& operator=(const MatchPattern& source);

  // Accessors
  /**
   * Gets the directory.
   *
   * @return The directory.
   */
  wxString getDirectory() const
  {
    return directory;
  }

  /**
   * Sets the directory.
   *
   * @param  newDir  New directory.
   */
  void setDirectory(const wxString& newDir)
  {
    directory = newDir;
  }

  /**
   * Gets the pattern.
   *
   * @return The pattern.
   */
  wxString getPattern() const
  {
    return pattern;
  }

  /**
   * Sets the pattern.
   *
   * @param  newPattern  The new pattern.
   */
  void setPattern(const wxString& newPattern)
  {
    pattern = newPattern;
  }

  /**
   * Gets the depth.
   *
   * @return The depth.
   */
  int getDepth() const
  {
    return depth;
  }

  /**
   * Sets the depth.
   *
   * @param  newDepth  The new depth.
   */
  void setDepth(const int newDepth)
  {
    depth = newDepth;
  }

  // Useful methods
  // Gets the patterns.
  wxArrayString getPatterns() const;
  
  // Adds the given patterns to this pattern.
  void addPatterns(const wxString& patterns);

  // Remove the given patterns from this pattern.
  void removePatterns(const wxString& patterns);

  // Indicates if the pattern includes all the given patterns.
  bool isIncludingAllPatterns(const wxString& patterns) const;

  // Compare the depths of this pattern and the given one.
  int compareDepth(const MatchPattern& cmp) const;
  
  // Compare two match patterns.
  bool operator==(const MatchPattern& cmp) const;
};
//---------------------------------------------------------------------------


/**
 * Array of matching patterns.
 */
class dlgAddMatchFiles::ArrayMatchPattern
{
 protected:
  typedef MatchPattern* pMatchPattern;  ///< Pointer on a matching pattern.
  static const size_t ALLOC_NEW;  ///< Number of patterns to allocate when the array is to small for new elements.
  size_t allocated;  ///< number of allocated matching patterns.
  size_t used;       ///< number of used matching patterns.
  pMatchPattern* patterns;  ///< Array of patterns.

  // Clones the source instance in this instance.
  void clone(const ArrayMatchPattern& source);

 public:
  // Default constructor.
  ArrayMatchPattern();
  
  // Constructor with an amount of allocated elements.
  ArrayMatchPattern(size_t count);

  // Copy constructor.
  ArrayMatchPattern(const ArrayMatchPattern& source);

  // Assignment operator.
  ArrayMatchPattern& operator=(const ArrayMatchPattern& source);

  // Destructor.
  ~ArrayMatchPattern();

  // Adds a pattern to the array.
  void add(MatchPattern pattern);
  
  // Preallocates memory for a given number of patterns.
  void alloc(size_t count);
  
  // Empties the array.
  void clear();
  
  // Gets the number of patterns in the array.
  size_t getCount() const;

  // Gets the pattern at the given index.
  MatchPattern& item(size_t index) const;
  
  // Gets the pattern at the given index.
  MatchPattern& operator[](size_t index) const;
};
//---------------------------------------------------------------------------


#endif  // INC_DLGADDMATCHFILES_HPP
