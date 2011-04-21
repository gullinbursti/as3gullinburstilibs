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
 * \file fileutil.cpp
 * File utilities.
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
#include <wx/filename.h>

#include "fileutil.hpp"
#include "checksumfactory.hpp"
#include "fdftlmk.hpp"
#include "sumfile.hpp"
#include "md5file.hpp"
#include "sfvfile.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


/**
 * Gets a filter for the known types of checksums' files.
 *
 * - First entry contains all known types of checksums' files.
 * - Next entries are all the known types listed in the order defined in the
 *   <CODE>SumFileFactory::SumFileType</CODE> enumeration.
 * - Last entry is all the files.
 *
 * @return A filter for the known types of checksums' files.
 */
wxFileDialogFilterMaker getFilterForKnownTypesOfChecksumsFiles()
{
  wxFileDialogFilterMaker fltMaker;
  fltMaker.AddFilter(_("Known checksums files"), wxT("sfv|md5"));
  for (int i = 0; i < SumFileFactory::getSumFilesCount(); i++)
    fltMaker.AddFilter(SumFileFactory::getSumFileDescription(i), SumFileFactory::getSumFileExtension(i));
  fltMaker.AddFilter(_("All the files"), wxT("*"));
  
  return fltMaker;
}
//---------------------------------------------------------------------------


/**
 * Opens and read the given checksum file.
 *
 * This function tries to choose the checksum file format with :
 * - The file extension first.
 * - The order of priority next (tries all the known formats).
 *
 * The caller must delete the returned object with the operator
 * <CODE>delete</CODE>.
 *
 * @param  fileName  Name of the file to open.
 * @return A pointer on the checksum file that is been read or
 *         <CODE>NULL</CODE> on failure. The caller must delete the returned
 *         object with the operator <CODE>delete</CODE>.
 */
SumFile* openChecksumFile(const wxFileName& fileName)
{
  if (::wxDirExists(fileName.GetFullPath()))
  // File is a directory, bye.
    return NULL;

  bool hasTrySFV = false;
  bool hasTryMD5 = false;
  wxString ext = fileName.GetExt();

  if (ext.CmpNoCase(wxT("sfv")) == 0)
  {
    hasTrySFV = true;
    SFVFile* f = new SFVFile();
    if (f->read(fileName))
      return f;
    else
      delete f;
  }
  else if (ext.CmpNoCase(wxT("md5")) == 0)
  {
    hasTryMD5 = true;
    MD5File* f = new MD5File();
    if (f->read(fileName))
      return f;
    else
      delete f;
  }

  if (!hasTryMD5)
  {
    hasTryMD5 = true;
    MD5File* f = new MD5File();
    if (f->read(fileName))
      return f;
    else
      delete f;
  }
  
  if (!hasTrySFV)
  {
    hasTrySFV = true;
    SFVFile* f = new SFVFile();
    if (f->read(fileName))
      return f;
    else
      delete f;
  }

  return NULL;
}
//---------------------------------------------------------------------------
