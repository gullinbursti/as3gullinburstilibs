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
 * \file dlgMultiCheckConf.hpp
 * Configuration dialog for checking multiple checksums' files.
 */

#ifndef INC_DLGMULTICHECKCONF_HPP
#define INC_DLGMULTICHECKCONF_HPP

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
#include "fdftlmk.hpp"
//---------------------------------------------------------------------------


/**
 * Dialog for choosing multiple checksums' files to check.
 */
class dlgMultiCheckConf : public dlgFilesSelector
{
 public:
  // Creates a new dialog.
  dlgMultiCheckConf();

  // Creates a new dialog.
  dlgMultiCheckConf(wxWindow* parent);

  // Destructor.
  virtual ~dlgMultiCheckConf();

  // Creates and initializes the controls of the dialog.
//  void createControls();


 protected:
//  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(dlgMultiCheckConf)

 public:  
  // Gets the root configuration key for parameters of this dialog
  virtual wxString getRootConfigKey();

 protected:
  // Gets the string for the specified UI element.
  virtual wxString getUIString(UIStrings id);
  
  // Returns a set of filters for the "Add files" dialog.
  virtual wxFileDialogFilterMaker getFiltersForAddFilesDialog();
};
//---------------------------------------------------------------------------

#endif  // INC_DLGMULTICHECKCONF_HPP
