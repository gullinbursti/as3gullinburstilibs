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
 * \file dlgAbout.hpp
 * About dialog.
 */

#ifndef INC_DLGABOUT_HPP
#define INC_DLGABOUT_HPP

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
 * The about dialog.
 */
class dlgAbout : public wxDialog
{
 public:
  // Creates a new dialog.
  dlgAbout();

  // Creates a new dialog.
  dlgAbout(wxWindow* parent);

  // Destructor.
  virtual ~dlgAbout();

  // Creates and initializes the controls of the dialog.
  void createControls();


 protected:
/*  /// Controls IDs
  enum
  {
    // = wxID_HIGHEST + 1,
  };*/
  
//  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(dlgAbout)  
};
//---------------------------------------------------------------------------

#endif  // INC_DLGABOUT_HPP
