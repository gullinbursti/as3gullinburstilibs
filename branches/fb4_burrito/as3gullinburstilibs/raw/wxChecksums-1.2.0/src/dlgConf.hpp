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
 * \file dlgConf.hpp
 * Configuration dialog.
 */

#ifndef INC_DLGCONF_HPP
#define INC_DLGCONF_HPP

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
#include <wx/splitter.h>
#include <wx/treectrl.h>
//---------------------------------------------------------------------------


/**
 * The configuration dialog.
 */
class dlgConfigure : public wxDialog
{
 public:
  // Creates a new dialog.
  dlgConfigure();

  // Creates a new dialog.
  dlgConfigure(wxWindow* parent);

  // Destructor.
  virtual ~dlgConfigure();

  // Creates and initializes the controls of the dialog.
  void createControls();

 public:
  wxSplitterWindow* sptConfigure;         ///< Configuration splitter.
  wxTreeCtrl* trePages;                   ///< Configuration tree pages.
  
  wxCheckBox* chkWindowSavePosition;      ///< Save the window position.
  wxCheckBox* chkWindowSaveSize;          ///< Save the window size.
  wxListBox* lstSumsHeaders;              ///< List of the sums' list headers.
  wxCheckBox* chkSumsSaveColumnToSort;    ///< Save the column to sort (and the order).
  wxCheckBox* chkSumsSaveColumnsWidths;   ///< Save the widths of the columns.
  wxCheckBox* chkSumsDirInAbsolutePath;   ///< Display directories in absolute path.
  wxRadioButton* rbtSumsValuesCaseUpper;  ///< Display the checksums values in uppercase.
  wxRadioButton* rbtSumsValuesCaseLower;  ///< Display the checksums values in lowercase.
  wxCheckBox* chkSumsHRules;              ///< Draws light horizontal rules between rows.
  wxCheckBox* chkSumsVRules;              ///< Draws light vertical rules between columns.

  wxCheckBox* chkAutoCheckOnOpen;         ///< Checks automatically the checksums file when opening it.
  wxCheckBox* chkDlgSumUpCheck;           ///< Opens a dialog box to sum up the check.
  wxCheckBox* chkWarnOnInvalidWhenSaving; ///< Displays a warning if the state of all the files is not 'OK' when saving a checksums file.

  wxListBox* lstLanguages;                ///< List of the languages.
  
  wxCheckBox* chkCLnVerifyDontShowGUI;    ///< Don't show the GUI when all checksums are corrects.
  wxRadioButton* rbxCLnAppendNeverShowGUI;  ///< Never show the GUI.
  wxRadioButton* rbxCLnAppendShowGUIOnError;  ///< Show the GUI only when an error occurs.
  wxRadioButton* rbxCLnAppendShowGUIOnWarning;  ///< Show the GUI only when an warning or an error occurs.
  wxRadioButton* rbxCLnAppendAlwaysGUI;   ///< Always show the GUI.
  wxRadioButton* rbxCLnCreateNeverShowGUI;  ///< Never show the GUI.
  wxRadioButton* rbxCLnCreateShowGUIOnError;  ///< Show the GUI only when an error occurs.
  wxRadioButton* rbxCLnCreateShowGUIOnWarning;  ///< Show the GUI only when an warning or an error occurs.
  wxRadioButton* rbxCLnCreateAlwaysGUI;  ///< Always show the GUI.

  wxRadioButton* rbxSFVPathSepReadAuto;   ///< Path separator on reading SFV files.
  wxRadioButton* rbxSFVPathSepReadUnix;   ///< Path separator on reading SFV files.
  wxRadioButton* rbxSFVPathSepReadWindows; ///< Path separator on reading SFV files.
  wxRadioButton* rbxSFVPathSepReadMAC;    ///< Path separator on reading SFV files.
  wxCheckBox* chkSFVSaveGenerator;        ///< Save the name of the generator and the date of creation in the comments
  wxChoice* cboSFVIdentifyAs;             ///< Identify as selector.
  wxCheckBox* chkSFVSaveFilesInfo;        ///< Save the size and the modification date of the files in the comments
  wxRadioButton* rbxSFVPathSepWriteSystem; ///< Path separator to write in SFV files.
  wxRadioButton* rbxSFVPathSepWriteUnix;  ///< Path separator to write in SFV files.
  wxRadioButton* rbxSFVPathSepWriteWindows; ///< Path separator to write in SFV files.
  wxRadioButton* rbxSFVPathSepWriteMAC;   ///< Path separator to write in SFV files.
  wxRadioButton* rbxSFVEOLWriteSystem;    ///< End of line to write in SFV files.
  wxRadioButton* rbxSFVEOLWriteWindows;   ///< End of line to write in SFV files.
  wxRadioButton* rbxSFVEOLWriteUnix;      ///< End of line to write in SFV files.
  wxRadioButton* rbxSFVEOLWriteMAC;       ///< End of line to write in SFV files.

  wxRadioButton* rbxMD5PathSepReadAuto;   ///< Path separator on reading MD5 files.
  wxRadioButton* rbxMD5PathSepReadUnix;   ///< Path separator on reading MD5 files.
  wxRadioButton* rbxMD5PathSepReadWindows; ///< Path separator on reading MD5 files.
  wxRadioButton* rbxMD5PathSepReadMAC;    ///< Path separator on reading MD5 files.
  wxTextCtrl* txtMD5PathSepRead;          ///< Path separator on reading MD5 files.
  wxCheckBox* chkMD5SaveGenerator;        ///< Save the name of the generator and the date of creation in the comments
  wxCheckBox* chkMD5SaveFilesInfo;        ///< Save the size and the modification date of the files in the comments
  wxRadioButton* rbxMD5PathSepWriteSystem; ///< Path separator to write in MD5 files.
  wxRadioButton* rbxMD5PathSepWriteUnix;  ///< Path separator to write in MD5 files.
  wxRadioButton* rbxMD5PathSepWriteWindows; ///< Path separator to write in MD5 files.
  wxRadioButton* rbxMD5PathSepWriteMAC;   ///< Path separator to write in MD5 files.
  wxTextCtrl* txtMD5PathSepWrite;         ///< Path separator to write in MD5 files.
  wxRadioButton* rbxMD5EOLWriteSystem;    ///< End of line to write in MD5 files.
  wxRadioButton* rbxMD5EOLWriteWindows;   ///< End of line to write in MD5 files.
  wxRadioButton* rbxMD5EOLWriteUnix;      ///< End of line to write in MD5 files.
  wxRadioButton* rbxMD5EOLWriteMAC;       ///< End of line to write in MD5 files.

  wxCheckBox* chkMCGlobalSummary;         ///< Display a global summary.
  wxCheckBox* chkMCChecksumsFileSummary;  ///< Display a summary for each checksums' file.
  wxCheckBox* chkMCFileState;             ///< Display the state of each checked file.
  wxCheckBox* chkMCNoCorrectFileState;    ///< Don't display the state of the corrects files.
  wxBitmapButton* btnMCNormalColour;      ///< Button for colour of normal text.
  wxBitmapButton* btnMCSuccessColour;     ///< Button for colour of success text.
  wxBitmapButton* btnMCWarningColour;     ///< Button for colour of warning text.
  wxBitmapButton* btnMCErrorColour;       ///< Button for colour of error or failure text.
  wxColour    MCNormalColour;             ///< Colour of normal text.
  wxColour    MCSuccessColour;            ///< Colour of success text.
  wxColour    MCWarningColour;            ///< Colour of warning text.
  wxColour    MCErrorColour;              ///< Colour of error or failure text.

  wxRadioButton* rbxBCSkipExistingCkFile;      ///< Skip the file if a checksum's file already exists.
  wxRadioButton* rbxBCOverwriteExistingCkFile; ///< Compute the checksum and overwrite the existing checksums' file.
  wxRadioButton* rbxBCReplaceFileExtension;    ///< Replace the extension of the file for the name of the checksums' file.
  wxRadioButton* rbxBCAddFileExtension;        ///< Add the extension of the checksums' file to the name of the added file.
  wxChoice*   cboBCVerbosityLevel;        ///< Report's verbosity level.
  wxBitmapButton* btnBCNormalColour;      ///< Button for colour of normal text.
  wxBitmapButton* btnBCSuccessColour;     ///< Button for colour of success text.
  wxBitmapButton* btnBCWarningColour;     ///< Button for colour of warning text.
  wxBitmapButton* btnBCErrorColour;       ///< Button for colour of error or failure text.
  wxColour    BCNormalColour;             ///< Colour of normal text.
  wxColour    BCSuccessColour;            ///< Colour of success text.
  wxColour    BCWarningColour;            ///< Colour of warning text.
  wxColour    BCErrorColour;              ///< Colour of error or failure text.

 protected:
  // Data for the tree of configuration pages.
  class TreePagesItemData;
  
  /// Identifiers of the elements of the tree that contains the configuration pages.
  enum TreePagesId
  {
    TpInterface,
    TpDisplay,
    TpBehavior,
    TpLanguage,
    TpCmdLine,
    TpChecksumsFiles,
    TpSFVFiles,
    TpMD5Files,
    TpTools,
    TpMultiCheck,
    TpBatchCreation
  };

  /// Table that contains pointers on the pages. Index is <CODE>TreePagesId</CODE>.
  wxArrayPtrVoid pagesArray;

 protected:
  /// Controls IDs
  enum
  {
    TRE_PAGES = wxID_HIGHEST + 1,
    LST_SUMS_HEADERS,
    BTN_SUMS_HEADERS_UP,
    BTN_SUMS_HEADERS_DOWN,
    CBO_SFV_IDENTIFY_AS,
    CHK_MC_FILE_STATE,
    BTN_MC_NORMAL_COLOUR,
    BTN_MC_SUCCESS_COLOUR,
    BTN_MC_WARNING_COLOUR,
    BTN_MC_ERROR_COLOUR,
    BTN_BC_NORMAL_COLOUR,
    BTN_BC_SUCCESS_COLOUR,
    BTN_BC_WARNING_COLOUR,
    BTN_BC_ERROR_COLOUR
  };
  
  // Event handler for a selection change.
  void trePagesSelChanged(wxTreeEvent& event);

  // Processes button Up
  void btnSumsHeadersUpClick(wxCommandEvent& event);
  // Processes button Down
  void btnSumsHeadersDownClick(wxCommandEvent& event);

  // Processes a selection in the choices of SFV generators.
  void cboSFVIdentifyAsSelect(wxCommandEvent& event);

  // Processes check on the <CODE>chkMCFileState</CODE> check box.
  void chkMCFileStateCheck(wxCommandEvent& event);
  // Processes button for changing colours of the results text of the multiple check dialog.
  void btnMCColoursClick(wxCommandEvent& event);

  DECLARE_EVENT_TABLE()

  // Makes a panel that contains the title of a configuration page.
  wxPanel* makePageTitlePanel(wxWindow* parent, const wxString& title, int const level = 2);

  // Adds an item in the choices of the generators identifiers on saving SFV files.
  int addSFVGeneratorIdentifier(const wxString& identifier);

 public:
  // Gets the configuration key of the nth generator identifier on saving SFV files.
  wxString getSFVGeneratorIdentifierConfigKey(const int n) const;
  
  // Gets the maximum size of the history of the generators identifiers on saving SFV files.
  int getSFVGeneratorIdentifierHistoryMaxSize() const;

 private:
  DECLARE_DYNAMIC_CLASS(dlgConfigure)
};
//---------------------------------------------------------------------------

#endif  // INC_DLGCONF_HPP
