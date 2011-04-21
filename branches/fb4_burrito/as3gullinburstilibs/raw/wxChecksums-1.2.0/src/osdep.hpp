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
 * \file osdep.hpp
 * OS dependant utility functions.
 */


#ifndef INC_OSDEP_HPP
#define INC_OSDEP_HPP

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


// Define the off_t type to use
#if defined(wxC_USE_LARGE_FILES)
  /// Use an 64 bits off_t type.
  typedef  wxLongLong_t  wxCOff_t;
  /// Version of the getFileLength function to use (system ou 64 bits).
  #define  wxCGetFileLength  getFileLength64
#else
  /// Use the system off_t type.
  typedef  off_t  wxCOff_t;
  /// Version of the getFileLength function to use (system ou 64 bits).
  #define  wxCGetFileLength  getFileLength
#endif  // defined(wxC_USE_LARGE_FILES)


// Gets the length of a file
off_t getFileLength(const wxChar* fileName);

#if defined(wxC_USE_LARGE_FILES)
// Gets the length of a file
wxLongLong_t getFileLength64(const wxChar* fileName);
//---------------------------------------------------------------------------
#endif  // defined(wxC_USE_LARGE_FILES)


// Gets the absolute paths where the resources of the program can be placed.
wxArrayString getResourcesPaths();

#if defined(__WXMSW__)
// Gets the file name of the application executable
wxFileName getAppPath();

// Gets the file name of the current module
wxFileName getModulePath();
#endif   // __WXMSW__
//---------------------------------------------------------------------------


// Converts an UTF-8 string to the local encoded string.
wxString UTF8toLocal(const wxString utf8);
//---------------------------------------------------------------------------

#endif  // INC_OSDEP_HPP
