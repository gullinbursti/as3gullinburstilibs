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
 * \file osdep.cpp
 * OS dependant utility functions.
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

// Include the Windows API header at the end prevents some problems that can
// occur at the linking procedure.
#if defined(__WXMSW__)
#include <windows.h>
#include <winbase.h>
#include <winnls.h>
#include <winuser.h>
#include <wx/msw/private.h>
#endif   // __WXMSW__

#include <wx/utils.h>

#include <sys/types.h>
#include <sys/stat.h>

#include "osdep.hpp"
#include "comdefs.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


#if defined(wxC_USE_LARGE_FILES)
// Definitions for the getFileLength64 method
#if defined(__WXMSW__)
  #include <tchar.h>
  #if defined(__BORLANDC__)
    #define  wxCStat64Struct  stati64
    #define  wxCStat64Fnct    _tstati64
  #elif defined(__GNUWIN32__)
    #if defined(_UNICODE)
      #define  _tstati64  _wstati64
    #else
      #define  _tstati64  _stati64
    #endif  // defined(_UNICODE)
    #define  wxCStat64Struct  struct _stati64
    #define  wxCStat64Fnct    _tstati64
  #else // other compilers
    #define  wxCStat64Struct  __stat64
    #define  wxCStat64Fnct    _tstat64
  #endif  // defined(__BORLANDC__)
#else  // other environments
  #define  wxCStat64Struct  struct stat64
  #define  wxCStat64Fnct    stat64
#endif  // defined(__WXMSW__)
#endif  // defined(wxC_USE_LARGE_FILES)
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


/**
 * Gets the length of the specified file.
 *
 * Should not work with large files.
 *
 * @param  fileName  The name of the file of which we want to get the length.
 * @return The length of the specified file or <CODE>wxInvalidOffset</CODE> if
 *         an error has occured.
 */
off_t getFileLength(const wxChar* fileName)
{
  struct stat s;

  if (stat(wxFNCONV(fileName), &s) == -1)
    return wxInvalidOffset;
  else
    return s.st_size;
}
//---------------------------------------------------------------------------


#if defined(wxC_USE_LARGE_FILES)
/**
 * Gets the length of the specified file.
 *
 * The return value is a 64 bit signed integer.
 *
 * @param  fileName  The name of the file of which we want to get the length.
 * @return The length of the specified file or <CODE>wxInvalidOffset</CODE> if
 *         an error has occured.
 */
wxLongLong_t getFileLength64(const wxChar* fileName)
{
  wxCStat64Struct s;
  int res;

  #if defined(__WXMSW__)  // Windows
  res = wxCStat64Fnct(fileName, &s);
  #else  // others OS
  res = wxCStat64Fnct(wxFNCONV(fileName), &s);
  #endif  // defined(__WXMSW__)

  if (res == -1)
    return static_cast<wxLongLong_t>(wxInvalidOffset);
  else
    return s.st_size;
}
//---------------------------------------------------------------------------
#endif  // defined(wxC_USE_LARGE_FILES)



/**
 * Gets the absolute paths where the resources of the program can be placed.
 *
 * @return The absolute paths where the resources of the program can be placed.
 */
wxArrayString getResourcesPaths()
{
  wxArrayString paths;
  
  // OS dependant paths
  #ifdef __UNIX__
  // Add some standard ones
  paths.Add(wxString(wxT("/usr/share/")) + wxT(APP_NAME));
  paths.Add(wxString(wxT("/usr/lib/")) + wxT(APP_NAME));
  paths.Add(wxString(wxT("/usr/local/share/")) + wxT(APP_NAME));
  paths.Add(wxString(wxT("/usr/local/lib/")) + wxT(APP_NAME));
  #endif  // __UNIX__

  #ifdef __WXMSW__
  // Path of the executable
  paths.Add(::getAppPath().GetPath(wxPATH_GET_VOLUME));
  #endif  //__WXMSW__

  // Try current directory
  paths.Add(::wxGetCwd());

  return paths;
}
//---------------------------------------------------------------------------


#if defined(__WXMSW__)
/**
 * Get the application (or dll) path.
 *
 * @param  hMod  Handle to the module whose path is being requested.
 * @return The application (or dll) path.
 */
static wxFileName getAppPath(HMODULE hMod)
{
  const int strSize = MAX_PATH;
  wxString str;
  DWORD dw = ::GetModuleFileName(hMod, wxStringBuffer(str, strSize), strSize);

  if (!dw)
  // When does it happen??
  {
    wxFAIL;
    return wxFileName();
  }

  return wxFileName(str);
}
//---------------------------------------------------------------------------


/**
 * Gets the full file name (with path) of the application executable.
 *
 * @return The full file name (with path) of the application executable.
 */
wxFileName getAppPath()
{
  return getAppPath(::GetModuleHandle(NULL));
}
//---------------------------------------------------------------------------


/**
 * Gets the full file name (with path) of the current process.
 *
 * @return The full file name (with path) of the current process.
 */
wxFileName getModulePath()
{
  return getAppPath(::wxGetInstance());
}
//---------------------------------------------------------------------------
#endif   // __WXMSW__



/**
 * Converts an UTF-8 string to the local encoded string.
 *
 * @param  utf8  String encoded in UTF-8.
 * @return The string encoded in local encoding.
 */
wxString UTF8toLocal(const wxString utf8)
{
  wxCSConv conv(wxLocale::GetSystemEncodingName());
  return wxString(utf8.wc_str(wxConvUTF8), conv);
}
//---------------------------------------------------------------------------
