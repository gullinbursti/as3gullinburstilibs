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
 * \file dlgInvalidFiles.hpp
 * Invalid files dialog.
 */

#ifndef INC_DLGINVALIDFILES_HPP
#define INC_DLGINVALIDFILES_HPP

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
#include <wx/hashmap.h>
//---------------------------------------------------------------------------


/// A hashmap of string keys and string values
WX_DECLARE_STRING_HASH_MAP(wxString, InvalidFilesContainer);


/**
 * Displays invalid files.
 */
class dlgInvalidFiles : public wxDialog
{
 public:
  // Creates a new dialog.
  dlgInvalidFiles();

  // Creates a new dialog.
  dlgInvalidFiles(wxWindow* parent, const wxString& title, const wxString& msg,
                  const InvalidFilesContainer& files);

  // Destructor.
  virtual ~dlgInvalidFiles();

  // Creates and initializes the controls of the dialog.
  void createControls(const wxString& msg, const InvalidFilesContainer& files);


 protected:
  /// Controls IDs
  enum
  {
    BTN_CLOSE = wxID_HIGHEST + 1,
  };
  
  // Processes button Close
  void btnCloseClick(wxCommandEvent& event);

  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(dlgInvalidFiles)  
};
//---------------------------------------------------------------------------

#endif  // INC_DLGINVALIDFILES_HPP
