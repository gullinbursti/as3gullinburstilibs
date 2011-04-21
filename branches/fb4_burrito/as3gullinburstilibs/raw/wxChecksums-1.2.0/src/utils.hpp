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
 * \file utils.hpp
 * Various utility functions.
 */


#ifndef INC_UTILS_HPP
#define INC_UTILS_HPP

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

#include "bytedisp.hpp"
//---------------------------------------------------------------------------


// Compares two file names.
int compareFileName(const wxString& fn1, const wxString& fn2);
//---------------------------------------------------------------------------


// Find all the files in the subdirectories from a list of files and directories
bool getFilesInSubdirectories(const wxArrayString& lFiles, wxArrayString& res,
                              BytesDisplayer& filesSize,
                              const wxString& matchPattern = wxEmptyString,
                              unsigned int maxDepth = 0);
//---------------------------------------------------------------------------


// Gets the application's name
wxString getAppName(bool addVersion = true);
//---------------------------------------------------------------------------


// Convert a wxColour value to a long value.
long wxColourToLong(const wxColour& value);

// Convert a long value to a wxColour value.
wxColour longTowxColour(long value);
//---------------------------------------------------------------------------


// Convert the specified character to the lower case.
void ToLower(wxString& s, size_t idx);

// Convert the specified character to the upper case.
void ToUpper(wxString& s, size_t idx);

// Get the given token with all the possible cases. Result is added to tk.
void GetAllTokenCases(wxString token, wxArrayString& tk, size_t p = 0);
//---------------------------------------------------------------------------


#endif  // INC_UTILS_HPP
