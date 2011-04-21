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
 * \file dlgBatchCreateConf.cpp
 * Configuration dialog for creating one checksums' file for each selected file.
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

#include <wx/config.h>
#include <wx/valgen.h>

#include "dlgBatchCreateConf.hpp"
#include "appprefs.hpp"
#include "checksumfactory.hpp"
#include "comdefs.hpp"
#include "fdftlmk.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


//###########################################################################
// dlgBatchCreationConfOptions class
//###########################################################################

/**
 * Dialog for changing batch creation options.
 */
class dlgBatchCreationConfOptions : public wxDialog
{
 public:
  /// Creates a new dialog.
  dlgBatchCreationConfOptions() : wxDialog() { createControls(); }

  // Creates a new dialog.
  dlgBatchCreationConfOptions(wxWindow* parent, const dlgBatchCreation::Options& options);

  // Destructor.
  virtual ~dlgBatchCreationConfOptions();

 protected: 
  // Creates and initializes the controls of the dialog.
  void createControls();

  int verbosity;  ///< Report's Verbosity.
  /**
   * If <CODE>true</CODE>, when a checksums' file already exists it is
   * overwritten. Otherwise the creation of the checksums' file is skipped.
   */
  bool ovrCkFileWhenItExists;
  /**
   * If <CODE>true</CODE> the name of the checksums' file will be made by 
   * replacing the extension of the source file with the extension of the type
   * of the checksums' file. Otherwise, the name of the checksums' file will be
   * made by adding the extension of the type of checksums' file to the name of
   * the source file.
   */
  bool replaceExtension;

 public:
  // Gets the options modified by the user.
  dlgBatchCreation::Options getOptions() const;

 private:
  DECLARE_DYNAMIC_CLASS(dlgBatchCreationConfOptions)  
};
//---------------------------------------------------------------------------

IMPLEMENT_DYNAMIC_CLASS(dlgBatchCreationConfOptions, wxDialog)


/**
 * Creates a new dialog.
 *
 * @param  parent   Parent of the dialog.
 * @param  options  Initial options.
 */
dlgBatchCreationConfOptions::dlgBatchCreationConfOptions(wxWindow* parent,
                                     const dlgBatchCreation::Options& options) :
  wxDialog(parent, -1, wxString(_("Options of the batch creation of checksums' files")))
{
  // Initializes the options.
  ovrCkFileWhenItExists = options.ovrCkFileWhenItExists;
  replaceExtension = options.replaceExtension;
  verbosity = options.getVerbosity();
  
  // Creates the controls.
  createControls();

  // Make a well-sized dialog
  Fit();
  Centre();
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the dialog.
 */
void dlgBatchCreationConfOptions::createControls()
{
  // "When a checksums' file alrealdy exists" frame.
  wxStaticBox* fraBCCkFileExists = new wxStaticBox(this, -1, _("When a checksums' file alrealdy exists:"));
  wxRadioButton* rbxBCSkipExistingCkFile = new wxRadioButton(this, -1, _("S&kip the creation"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  wxRadioButton* rbxBCOverwriteExistingCkFile = new wxRadioButton(this, -1, _("&Overwrite it"), wxDefaultPosition, wxDefaultSize, 0, wxGenericValidator(&ovrCkFileWhenItExists));
    
  // "Create the name of the checksums' file by:" frame
  wxStaticBox* fraBCChecksumsFileName = new wxStaticBox(this, -1, _("Create the name of the checksums' file by:"));
  wxRadioButton* rbxBCReplaceFileExtension = new wxRadioButton(this, -1, _("&Replacing the extension of the source file with the extension of the type of the checksums' file."), wxDefaultPosition, wxDefaultSize, wxRB_GROUP, wxGenericValidator(&replaceExtension));
  wxRadioButton* rbxBCAddFileExtension = new wxRadioButton(this, -1, _("&Adding the extension of the type of the checksums' file to the name of the source file."), wxDefaultPosition, wxDefaultSize);

  // The "Verbosity level of the report:" frame
  wxStaticBox* fraBCVerbosityLevel = new wxStaticBox(this, -1, _("Level of &verbosity of the report:"));
  const wxString strVerbosityLevels[] = { _("Errors only"), _("Errors and warnings"), _("Normal"), _("Talkative") };
  wxChoice* cboBCVerbosityLevel = new wxChoice(this, -1, wxDefaultPosition, wxDefaultSize,
    4, strVerbosityLevels, 0, wxGenericValidator(&verbosity));
  if (verbosity < dlgBatchCreation::Verbosity_Min || verbosity > dlgBatchCreation::Verbosity_Max)
    verbosity = dlgBatchCreation::vNormal;

  wxButton* btnOK = new wxButton(this, wxID_OK, _("&OK"));
  btnOK->SetDefault();
  wxButton* btnCancel = new wxButton(this, wxID_CANCEL, _("&Cancel"));

  // Batch creation page sizer
  // The dialog sizer
  wxBoxSizer* dlgBatchCreationConfOptionsSizer2 = new wxBoxSizer(wxVERTICAL);
  this->SetSizer(dlgBatchCreationConfOptionsSizer2);
  wxBoxSizer* dlgBatchCreationConfOptionsSizer = new wxBoxSizer(wxVERTICAL);
  dlgBatchCreationConfOptionsSizer2->Add(dlgBatchCreationConfOptionsSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // The "When a checksums' file alrealdy exists" frame sizer
  wxStaticBoxSizer* fraBCCkFileExistsSizer2 = new wxStaticBoxSizer(fraBCCkFileExists, wxVERTICAL);
  dlgBatchCreationConfOptionsSizer->Add(fraBCCkFileExistsSizer2, 0, wxGROW);
  wxBoxSizer* fraBCCkFileExistsSizer = new wxBoxSizer(wxVERTICAL);
  fraBCCkFileExistsSizer2->Add(fraBCCkFileExistsSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraBCCkFileExistsSizer->Add(rbxBCSkipExistingCkFile);
  fraBCCkFileExistsSizer->Add(rbxBCOverwriteExistingCkFile, 0, wxTOP, CONTROL_SPACE / 2);

  // The "Create the name of the checksums' file by:" frame sizer
  wxStaticBoxSizer* fraBCChecksumsFileNameSizer2 = new wxStaticBoxSizer(fraBCChecksumsFileName, wxVERTICAL);
  dlgBatchCreationConfOptionsSizer->Add(fraBCChecksumsFileNameSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraBCChecksumsFileNameSizer = new wxBoxSizer(wxVERTICAL);
  fraBCChecksumsFileNameSizer2->Add(fraBCChecksumsFileNameSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraBCChecksumsFileNameSizer->Add(rbxBCReplaceFileExtension);
  fraBCChecksumsFileNameSizer->Add(rbxBCAddFileExtension, 0, wxTOP, CONTROL_SPACE / 2);

  // The "Verbosity level of the report:" frame sizer
  wxStaticBoxSizer* fraBCVerbosityLevelSizer2 = new wxStaticBoxSizer(fraBCVerbosityLevel, wxVERTICAL);
  dlgBatchCreationConfOptionsSizer->Add(fraBCVerbosityLevelSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraBCVerbosityLevelSizer = new wxBoxSizer(wxVERTICAL);
  fraBCVerbosityLevelSizer2->Add(fraBCVerbosityLevelSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraBCVerbosityLevelSizer->Add(cboBCVerbosityLevel);

  // Validation buttons sizer
  wxGridSizer* buttonsSizer = new wxGridSizer(2, 0, 2 * CONTROL_SPACE);
  buttonsSizer->Add(btnOK);
  buttonsSizer->Add(btnCancel);
  dlgBatchCreationConfOptionsSizer->Add(buttonsSizer, 0, wxTOP | wxALIGN_RIGHT, 2 * CONTROL_SPACE);

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();

  // Initializes the controls.
  this->TransferDataToWindow();

  // Needed because the validator don't choose another control.
  if (ovrCkFileWhenItExists)
    rbxBCOverwriteExistingCkFile->SetValue(true);
  else
    rbxBCSkipExistingCkFile->SetValue(true);

  if (replaceExtension)
    rbxBCReplaceFileExtension->SetValue(true);
  else
    rbxBCAddFileExtension->SetValue(true);

}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
dlgBatchCreationConfOptions::~dlgBatchCreationConfOptions()
{
}
//---------------------------------------------------------------------------


/**
 * Gets the options modified by the user.
 *
 * @return The options modified by the user.
 */
dlgBatchCreation::Options dlgBatchCreationConfOptions::getOptions() const
{
  return dlgBatchCreation::Options(ovrCkFileWhenItExists, replaceExtension,
                           static_cast<dlgBatchCreation::Verbosity>(verbosity));
}
//---------------------------------------------------------------------------




//###########################################################################
// dlgBatchCreationConf methods
//###########################################################################

IMPLEMENT_DYNAMIC_CLASS(dlgBatchCreationConf, dlgFilesSelector)


/**
 * Creates a new dialog.
 */
dlgBatchCreationConf::dlgBatchCreationConf() : dlgFilesSelector()
{
}
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 *
 * @param  parent  Parent of the dialog.
 */
dlgBatchCreationConf::dlgBatchCreationConf(wxWindow* parent) :
  dlgFilesSelector(parent, true)
{
}
//---------------------------------------------------------------------------


/**
 * Initializes the dialog.
 *
 * If you derivate this method, please call the one of the parent class before
 * doing anything.
 */
void dlgBatchCreationConf::initialize()
{
  dlgFilesSelector::initialize();

  createControls();
 
  // These folling lines are necessary even if they are in
  // dlgFilesSelector::initialize()  :(
   Fit();
  
   // Get the size of the window
   wxSize s;
   if (PreferenceValue::read(getConfigKey(prGUI_WINDOW_SIZE), &s))
     SetSize(s);
  
   Centre();
   
  // Initialazing dlgBatchCreate options
  options = dlgBatchCreation::Options(AppPrefs::get()->readBool(prBC_OVERWRITE_WHEN_CKFILE_EXISTS),
                                      AppPrefs::get()->readBool(prBC_REPLACE_FILE_EXTENSION),
                                      static_cast<dlgBatchCreation::Verbosity>(AppPrefs::get()->readLong(prBC_VERBOSITY_LEVEL)));
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the dialog.
 */
void dlgBatchCreationConf::createControls()
{
  int i;
  
  // Creates the controls
  wxStaticBox* fraCkFileTypes = new wxStaticBox(this, -1, _("Create the following types of checks&ums' file:"));
  btnOptions = new wxButton(this, BTN_OPTIONS, _("O&ptions..."));
  for (i = 0; i < SumFileFactory::getSumFilesCount(); i++)
    chkCkFileTypes.Add(new wxCheckBox(this, -1, SumFileFactory::getSumFileName(i)));


  //-------------------------------------------------------------------------
  // Creates the dialog sizers

  // Static frame
  wxStaticBoxSizer* fraCkFileTypesSizer2 = new wxStaticBoxSizer(fraCkFileTypes, wxVERTICAL);
  extendSizer->Add(fraCkFileTypesSizer2, 1, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraCkFileTypesSizer = new wxBoxSizer(wxHORIZONTAL);
  fraCkFileTypesSizer2->Add(fraCkFileTypesSizer, 1, wxALL | wxGROW, CONTROL_SPACE / 2);

  // Checksums' file types
  wxBoxSizer* ckFileTypeSizer = new wxBoxSizer(wxHORIZONTAL);
  fraCkFileTypesSizer->Add(ckFileTypeSizer, 1, wxGROW | wxALIGN_CENTER_VERTICAL);
  for (i = 0; i < SumFileFactory::getSumFilesCount(); i++)
    if (i == 0)
      ckFileTypeSizer->Add(chkCkFileTypes[i], 0, wxALIGN_CENTER_VERTICAL);
    else
      ckFileTypeSizer->Add(chkCkFileTypes[i], 0, wxLEFT | wxALIGN_CENTER_VERTICAL, CONTROL_SPACE);
  
  // Options button
  fraCkFileTypesSizer->Add(btnOptions, 0, wxALIGN_CENTER_VERTICAL | wxALIGN_RIGHT | wxLEFT, CONTROL_SPACE);

  this->Layout();


  //-------------------------------------------------------------------------
  // Initializes the controls
  for (i = 0; i < SumFileFactory::getSumFilesCount(); i++)
  {
    bool value;
    wxConfig::Get()->Read(getCkFileTypeCreateConfigKey(i), &value, true);
    chkCkFileTypes[i]->SetValue(value);
  }  
}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
dlgBatchCreationConf::~dlgBatchCreationConf()
{
}
//---------------------------------------------------------------------------


/**
 * Processes button Options.
 *
 * @param  event  The event's parameters
 */
void dlgBatchCreationConf::btnOptionsClick(wxCommandEvent& event)
{
  dlgBatchCreationConfOptions dlg(this, options);
  if (dlg.ShowModal() == wxID_OK)
    options = dlg.getOptions();
}
//---------------------------------------------------------------------------


/**
 * Processes button OK.
 *
 * @param  event  The event's parameters
 */
void dlgBatchCreationConf::btnOKClick(wxCommandEvent& event)
{
  ckFileTypes.Empty();
  for (int i = 0; i < SumFileFactory::getSumFilesCount(); i++)
  {
    if (chkCkFileTypes[i]->GetValue())
      ckFileTypes.Add(i);
    wxConfig::Get()->Write(getCkFileTypeCreateConfigKey(i), chkCkFileTypes[i]->GetValue());
  }

  if (ckFileTypes.IsEmpty())
  {
    ::wxMessageBox(_("Select as least a type of checksums' file."), _("Warning"), wxOK | wxICON_EXCLAMATION);
    return;
  }
  else
    event.Skip();  // let the rest of the work to the superclass event handler.
}
//---------------------------------------------------------------------------


/**
 * Gets the types of the checksums' file to create.
 *
 * @return The types of the checksums' file to create.
 */
wxArrayInt dlgBatchCreationConf::getChecksumsFileTypeToCreate() const
{
  return ckFileTypes;
}
//---------------------------------------------------------------------------


/**
 * Gets the options for <CODE>dlgBatchCreation</CODE>.
 *
 * @return The options for <CODE>dlgBatchCreation</CODE>.
 */
dlgBatchCreation::Options dlgBatchCreationConf::getOptions() const
{
  return options;
}
//---------------------------------------------------------------------------


/**
 * Gets the root configuration key for parameters of this dialog.
 *
 * The returned string must be ended the a '<CODE>/</CODE>' character.
 *
 * @return  The root configuration key for parameters of this dialog.
 */
wxString dlgBatchCreationConf::getRootConfigKey()
{
  return wxT("GUI/BatchCreationConfigDlg/");
}
//---------------------------------------------------------------------------


/**
 * Gets the configuration key for the values of the checksums' files types
 * check boxes.
 *
 * @param  sumFileType  Type of the checksums' file of which the caller want
 *                      the configuration key. Should be a value of the
 *                      <CODE>SumFileFactory::SumFileType</CODE> enumeration.
 * @return The configuration key for the values of the checksums' files types
 *         check boxes or an empty string if <CODE>sumFileType</CODE> has an
 *         invalid value.
 */ 
wxString dlgBatchCreationConf::getCkFileTypeCreateConfigKey(const int sumFileType)
{
  if (sumFileType < 0 || sumFileType >= SumFileFactory::getSumFilesCount())
    return wxEmptyString;
  
  return getRootConfigKey() + wxT("CreateChecksumsFileType/") + SumFileFactory::getSumFileName(sumFileType);
}
//---------------------------------------------------------------------------


/**
 * Gets the string for the specified UI element.
 *
 * @param  id  Identifier of the wanted UI element.
 * @return The string for the specified UI element and an empty string if the
 *         given UI element is invalid.
 */
wxString dlgBatchCreationConf::getUIString(UIStrings id)
{
  wxString res;
  switch (id)
  {
    case uiDialogTitle :
      res = _("Batch creation of checksums' files"); break;
    case uiBtnOK :
      res = _("&Create"); break;
    case uiFraFilesList :
      res = _("List of files from which the c&hecksums' files will be created:"); break;
    case uiFraSearchFiles :
      res = _("Search &for some files:"); break;
    case uiOpenDlgAddFiles :
      res = _("Select the files to be added"); break;
    case uiOpenDlgAddList :
      res = _("Add a list of files"); break;
    case uiOpenDlgLoadList :
      res = _("Load a list of files"); break;
    case uiSaveDlgAddList :
      res = _("Save a list of files"); break;
  };
 
  return res;  
}
//---------------------------------------------------------------------------


/**
 * Returns a set of filters for the "Add files" dialog.
 *
 * @return A set of filters for the "Add files" dialog.
 */
wxFileDialogFilterMaker dlgBatchCreationConf::getFiltersForAddFilesDialog()
{
  wxFileDialogFilterMaker fltMaker;
  fltMaker.AddFilter(_("All the files"), wxT("*"));
  
  return fltMaker;
}
//---------------------------------------------------------------------------



BEGIN_EVENT_TABLE(dlgBatchCreationConf, dlgFilesSelector)
  EVT_BUTTON(BTN_OPTIONS, dlgBatchCreationConf::btnOptionsClick)
  EVT_BUTTON(BTN_OK, dlgBatchCreationConf::btnOKClick)
END_EVENT_TABLE()
//---------------------------------------------------------------------------

