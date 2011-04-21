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
 * \file dlgNewFile.hpp
 * New file dialog.
 */

#ifndef INC_DLGNEWFILE_HPP
#define INC_DLGNEWFILE_HPP

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
//---------------------------------------------------------------------------


/**
 * Dialog for choosing a new file name.
 */
class dlgNewFile : public wxDialog
{
 public:
  // Creates a new dialog.
  dlgNewFile();

  // Creates a new dialog.
  dlgNewFile(wxWindow* parent);

  // Destructor.
  virtual ~dlgNewFile();

  // Creates and initializes the controls of the dialog.
  void createControls();

  /// Enumeration of the file types
  enum FileType
  {
    ftSFV = 1,
    ftMD5
  };

  // Gets the choosen file type.
  FileType getFileType() const;
  
  // Gets the name of the file.
  wxString getFileName() const;
  

 protected:
  wxRadioButton* rbxSFV;       ///< Create an SFV file.
  wxRadioButton* rbxMD5;       ///< Create an MD5 file.
  wxTextCtrl*    txtFileName;  ///< Name of the file.
  wxString       fileName;     ///< Name of the file given by the validator.

  // Processes button Browse
  void btnBrowseClick(wxCommandEvent& event);

  /// Controls IDs
  enum
  {
    BTN_BROWSE = wxID_HIGHEST + 1,
  };

  // A validator for the file name.
  class FileNameValidator;

  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(dlgNewFile)
};
//---------------------------------------------------------------------------

#endif  // INC_DLGNEWFILE_HPP
