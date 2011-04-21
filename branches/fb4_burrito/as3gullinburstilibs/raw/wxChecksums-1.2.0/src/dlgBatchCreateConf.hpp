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
 * \file dlgBatchCreateConf.hpp
 * Configuration dialog for creating one checksums' file for each selected file.
 */

#ifndef INC_DLGBATCHCREATECONF_HPP
#define INC_DLGBATCHCREATECONF_HPP

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

#include "dlgFilesSelector.hpp"
#include "dlgBatchCreate.hpp"
#include "fdftlmk.hpp"
//---------------------------------------------------------------------------


/**
 * Dialog for choosing files from which a checksums' file will be create for
 * each of them.
 */
class dlgBatchCreationConf : public dlgFilesSelector
{
 public:
  // Creates a new dialog.
  dlgBatchCreationConf();

  // Creates a new dialog.
  dlgBatchCreationConf(wxWindow* parent);

  // Initializes the dialog.
  virtual void initialize();

  // Destructor.
  virtual ~dlgBatchCreationConf();

  // Creates and initializes the controls of the dialog.
  void createControls();


 protected:
  /// Array of check boxes.
  WX_DEFINE_ARRAY(wxCheckBox*, ArrayCheckBox);

  wxButton*      btnOptions;   ///< Button for editings options.
  ArrayCheckBox  chkCkFileTypes;   ///< Checkbox for select the type of checksums' file to create.
  wxArrayInt     ckFileTypes;  ///< Checksums' file types to create.
  dlgBatchCreation::Options options;  ///< Options for <CODE>dlgBatchCreation</CODE>.

  // Processes button OK (overrides the one defined in dlgFilesSelector).
  void btnOKClick(wxCommandEvent& event);
  // Processes button Options.
  void btnOptionsClick(wxCommandEvent& event);

  /// Controls IDs
  enum
  {
    BTN_OPTIONS = DLG_FILESSELECTOR_ID_HIGHEST + 1
  };

  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(dlgBatchCreationConf)

 public:  
  // Gets the types of the checksums' file to create.
  wxArrayInt getChecksumsFileTypeToCreate() const;
  
  // Gets the options for dlgBatchCreation.
  dlgBatchCreation::Options getOptions() const;
  
  // Gets the root configuration key for parameters of this dialog
  virtual wxString getRootConfigKey();

 protected:
  // Gets the configuration key for the values of the checksums' files types check boxes.
  wxString getCkFileTypeCreateConfigKey(const int sumFileType);

  // Gets the string for the specified UI element.
  virtual wxString getUIString(UIStrings id);

  // Returns a set of filters for the "Add files" dialog.
  virtual wxFileDialogFilterMaker getFiltersForAddFilesDialog();
};
//---------------------------------------------------------------------------

#endif  // INC_DLGBATCHCREATECONF_HPP
