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
 * \file dlgNewFile.cpp
 * New file dialog.
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

#include <wx/file.h>
#include <wx/filename.h>

#include "dlgNewFile.hpp"
#include "appprefs.hpp"
#include "comdefs.hpp"
#include "fdftlmk.hpp"
#include "fileutil.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


//###########################################################################
// A validator for the file name
//###########################################################################


/**
 * A validator for the file name.
 *
 * Checks that the given file name has an absolute path and that the path
 * exists.
 *
 * If the file already exists, ask for overwriting.
 */
class dlgNewFile::FileNameValidator : public wxValidator
{
 protected:
  wxString* value;  ///< Adress of the string where the value will be transfered.

  // Clones the source instance in this instance.
  void clone(const FileNameValidator& source);

  // Returns the wxTextCtrl associated with the validator.
  wxTextCtrl* GetTextCtrl() const;

 public:
  // Constructor.
  FileNameValidator(wxString* pValue);

  // Copy constructor.
  FileNameValidator(const FileNameValidator& source);
  
  // Assignment operator.
  FileNameValidator& operator=(const FileNameValidator& source);

  // Returns a copy of the instance of the validator.
  virtual wxObject* Clone() const;

  // Validates the value in the associated window.
  virtual bool Validate(wxWindow* parent);
  
  // Transfers the value in the window to the validator.
  virtual bool TransferFromWindow();

  // Transfers the value associated with the validator to the window.
  virtual bool TransferToWindow();
};
//---------------------------------------------------------------------------


/**
 * Constructor.
 *
 * @param  pValue  Pointer on a string where to value will be transfered.
 */
dlgNewFile::FileNameValidator::FileNameValidator(wxString* pValue)
{
  value = pValue;
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void dlgNewFile::FileNameValidator::clone(const FileNameValidator& source)
{
  if (this != &source)
  {
    this->value = source.value;
  }
}
//---------------------------------------------------------------------------


/**
 * Copy constructor.
 *
 * @param  source  Source instance.
 */
dlgNewFile::FileNameValidator::FileNameValidator(const FileNameValidator& source)
{
  clone(source);
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  source  Source instance.
 * @return A reference on the instance.
 */
dlgNewFile::FileNameValidator& dlgNewFile::FileNameValidator::operator=(const FileNameValidator& source)
{
  clone(source);
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Returns a copy of the instance of the validator.
 *
 * @return A copy of the instance of the validator.
 */
wxObject* dlgNewFile::FileNameValidator::Clone() const
{
  return new FileNameValidator(*this);
}
//---------------------------------------------------------------------------


/**
 * Returns the <CODE>wxTextCtrl</CODE> associated with the validator.
 *
 * @return The <CODE>wxTextCtrl</CODE> associated with the validator or
 *         <CODE>NULL</CODE> if the <CODE>wxTextCtrl</CODE> associated with
 *         the validator isn't a <CODE>wxTextCtrl</CODE>.
 */
wxTextCtrl* dlgNewFile::FileNameValidator::GetTextCtrl() const
{
  wxWindow* win = GetWindow();
  if (win == NULL)
    return NULL;
  if (!win->IsKindOf(CLASSINFO(wxTextCtrl)))
    return NULL;

  return wxDynamicCast(win, wxTextCtrl);
}
//---------------------------------------------------------------------------


/**
 * Validates the value in the associated window.
 *
 * @param  parent  Parent window.
 */
bool dlgNewFile::FileNameValidator::Validate(wxWindow* parent)
{
  wxTextCtrl* control = GetTextCtrl();
  if (control == NULL)
    return false;

  wxString   msg;
  wxString   val = control->GetValue();
  wxFileName fn(val);
  bool       OK = true;


  if (val.empty() || fn.GetFullName().empty())
  {
    msg = _("Please give a name for the new checksum file.");
    OK = false; 
  }
  else if (!fn.IsAbsolute())
  {
    msg = _("Please give an absolute path for the name of the new checksum file.");
    OK = false;
  }
  else if (!::wxDirExists(fn.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR)))
  {
    msg.Printf(_("The directory '%s' doesn't exist."), fn.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR).c_str());
    OK = false;
  }
  else if (::wxDirExists(fn.GetFullPath()))
  {
    msg.Printf(_("'%s' is a directory."), val.c_str());
    OK = false;
  }
  else if (fn.FileExists())
  {
    if (wxFile::Access(val, wxFile::write))
    {
      if (::wxMessageBox(wxString::Format(_("The file '%s' already exists.\nDo you want to overwrite it?"), val.c_str()), _("Create a new file"), wxYES_NO | wxCANCEL | wxICON_EXCLAMATION) != wxYES)
        OK = false;
    }
    else
    {
      msg.Printf(_("You don't have sufficient rights to write on '%s'."), val.c_str());
      OK = false;
    }
  }

  if (!OK)
  {
    if (!msg.empty())
      ::wxMessageBox(msg, _("Invalid file name"), wxOK | wxICON_EXCLAMATION);
    control->SetFocus();
  }

  return OK;
}
//---------------------------------------------------------------------------
  

/**
 * Transfers the value in the window to the validator.
 *
 * @return <CODE>true</CODE> on success, <CODE>false</CODE> otherwise.
 */
bool dlgNewFile::FileNameValidator::TransferFromWindow()
{
  wxTextCtrl* control = GetTextCtrl();
  if (control == NULL || value == NULL)
    return false;
  else
  {
    *value = control->GetValue();
    return true;
  }
}
//---------------------------------------------------------------------------


/**
 * Transfers the value associated with the validator to the window.
 *
 * return <CODE>true</CODE> on success, <CODE>false</CODE> otherwise.
 */
bool dlgNewFile::FileNameValidator::TransferToWindow()
{
  wxTextCtrl* control = GetTextCtrl();
  if (control == NULL || value == NULL)
    return false;
  else
  {
    control->SetValue(*value);
    return true;
  }
}
//---------------------------------------------------------------------------



//###########################################################################
// dlgNewFile methods
//###########################################################################

IMPLEMENT_DYNAMIC_CLASS(dlgNewFile, wxDialog)


/**
 * Creates a new dialog.
 */
dlgNewFile::dlgNewFile() : wxDialog()
{
  createControls();
}
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 *
 * @param  parent  Parent of the dialog.
 */
dlgNewFile::dlgNewFile(wxWindow* parent) :
  wxDialog(parent, -1, _("Create a new checksums file"), wxDefaultPosition, wxDefaultSize, 
           wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
  createControls();
 
  int w, h;
  ::wxDisplaySize(&w, &h);
  Fit();
  Centre();
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the dialog.
 */
void dlgNewFile::createControls()
{
  // Creates the controls
  wxStaticText* lblFileType = new wxStaticText(this, -1, _("Type of the new file:"));
  rbxSFV = new wxRadioButton(this, -1, _("&SFV file"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxMD5 = new wxRadioButton(this, -1, _("&MD5 file"));

  wxStaticText* lblFileName = new wxStaticText(this, -1, _("&Name of the new file:"));
  txtFileName = new wxTextCtrl(this, -1, wxEmptyString, wxDefaultPosition,
                               wxSize((this->GetParent()->GetSize().GetWidth() * 2) / 3, -1),
                               0, FileNameValidator(&(this->fileName)));
  wxButton* btnBrowse = new wxButton(this, BTN_BROWSE, _("&Browse..."));
  
  wxButton* btnOK = new wxButton(this, wxID_OK, _("&OK"));
  btnOK->SetDefault();
  wxButton* btnCancel = new wxButton(this, wxID_CANCEL, _("&Cancel"));

  // Initializes the controls
  switch (static_cast<FileType>(AppPrefs::get()->readLong(prGUI_NEWFILE_LAST_FILETYPE)))
  {
    case ftMD5: rbxMD5->SetValue(true); break;
    default   : rbxSFV->SetValue(true); break;
  }
  
  this->fileName = AppPrefs::get()->readString(prGUI_NEWFILE_LAST_DIRECTORY);
  if (this->fileName.empty())
  {
    wxFileName curdir;
    curdir.AssignCwd();
    this->fileName = curdir.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR);
  }
  txtFileName->SetFocus();

  //-------------------------------------------------------------------------
  // Creates the dialog sizers

  // Dialog sizer
  wxBoxSizer* dlgNewFileSizer2 = new wxBoxSizer(wxVERTICAL);
  this->SetSizer(dlgNewFileSizer2);
  wxBoxSizer* dlgNewFileSizer = new wxBoxSizer(wxVERTICAL);
  dlgNewFileSizer2->Add(dlgNewFileSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // File type
  dlgNewFileSizer->Add(lblFileType);
  dlgNewFileSizer->Add(rbxSFV, 0, wxTOP, 0);
  dlgNewFileSizer->Add(rbxMD5, 0, wxTOP, CONTROL_SPACE / 2);

  // File name
  dlgNewFileSizer->Add(lblFileName, 0, wxTOP, CONTROL_SPACE);
  wxBoxSizer* fileNameSizer = new wxBoxSizer(wxHORIZONTAL);
  fileNameSizer->Add(txtFileName, 1, wxALIGN_CENTER_VERTICAL);
  fileNameSizer->Add(btnBrowse, 0, wxLEFT | wxALIGN_CENTER_VERTICAL, CONTROL_SPACE);
  dlgNewFileSizer->Add(fileNameSizer, 0, wxGROW);

  // Validation buttons sizer
  wxGridSizer* buttonsSizer = new wxGridSizer(2, 0, 2 * CONTROL_SPACE);
  buttonsSizer->Add(btnOK);
  buttonsSizer->Add(btnCancel);
  dlgNewFileSizer->Add(buttonsSizer, 0, wxTOP | wxALIGN_RIGHT, 2 * CONTROL_SPACE);

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();
}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
dlgNewFile::~dlgNewFile()
{
}
//---------------------------------------------------------------------------


/**
 * Processes button Browse.
 *
 * @param  event  The event's parameters
 */
void dlgNewFile::btnBrowseClick(wxCommandEvent& event)
{
  wxString defDir = wxFileName(txtFileName->GetValue()).GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR);
  wxString defName = _("new");
  int      filterIdx;

  if (!::wxDirExists(defDir))
    defDir.Clear();

  // Gets the filter for knows types of checksums' files
  wxFileDialogFilterMaker fltMaker = ::getFilterForKnownTypesOfChecksumsFiles();
  
  // Look in getFilterForKnownTypesOfChecksumsFiles() in the fileutil.cpp file
  // which is the order of the filters.
  switch (this->getFileType())
  {
    case ftSFV :
      defName += wxT(".sfv");
      filterIdx = 1;
      break;
    case ftMD5 :
      defName += wxT(".md5");
      filterIdx = 2;
      break;
  }

  // Shows the dialog of file's selection
  wxFileDialog dlgNew(this, _("Choose a name for the new checksums file"),
                       defDir, defName, fltMaker.GetFilters(),
                       wxSAVE, wxDefaultPosition);
  dlgNew.SetFilterIndex(filterIdx);

  if (dlgNew.ShowModal() == wxID_OK)
  {
    txtFileName->SetValue(dlgNew.GetPath());
    txtFileName->SetFocus();
  }
}
//---------------------------------------------------------------------------


/**
 * Gets the choosen file type.
 *
 * @return The choosen file type.
 */
dlgNewFile::FileType dlgNewFile::getFileType() const
{
  if (rbxSFV->GetValue())
    return ftSFV;
  else
    return ftMD5;
}
//---------------------------------------------------------------------------

  
/**
 * Gets the name of the file.
 *
 * @return The name of the file.
 */
wxString dlgNewFile::getFileName() const
{
  return this->fileName;
}
//---------------------------------------------------------------------------


BEGIN_EVENT_TABLE(dlgNewFile, wxDialog)
  EVT_BUTTON(BTN_BROWSE, dlgNewFile::btnBrowseClick)
END_EVENT_TABLE()
//---------------------------------------------------------------------------
