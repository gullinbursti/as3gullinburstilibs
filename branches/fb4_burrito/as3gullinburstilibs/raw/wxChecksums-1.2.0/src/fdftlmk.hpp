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
 * \file fdftlmk.hpp
 * Files dialog filter maker class.
 */

#ifndef INC_FDFTLMK_HPP
#define INC_FDFTLMK_HPP

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
#include <wx/filename.h>
//---------------------------------------------------------------------------


/**
 * Creates filters for the <CODE>wxFileDialog</CODE> class.
 *
 * - Add the filters with the AddFilter() method.
 * - Get the filter string with the GetFilters() method.
 */
class wxFileDialogFilterMaker
{
 protected: 
  wxArrayString descrs;   ///< Descriptions of the files types
  wxArrayString filters;  ///< Filters

  // Clones the source instance in this instance.
  void clone(const wxFileDialogFilterMaker& source);

 public:
  // Constructor.
  wxFileDialogFilterMaker();
  
  // Copy constructor.
  wxFileDialogFilterMaker(const wxFileDialogFilterMaker& source);

  // Assignment operator.
  wxFileDialogFilterMaker& operator=(const wxFileDialogFilterMaker& source);

  // Adds a filter.
  void AddFilter(const wxString& descr, const wxString& filter);

  // Gets a string that contains the filters for a wxFileDialog instance.
  wxString GetFilters(const wxPathFormat format = wxPATH_NATIVE,
                      const bool addFiltersInDescriptions = true) const;
};
//---------------------------------------------------------------------------

#endif  // INC_FDFTLMK_HPP
