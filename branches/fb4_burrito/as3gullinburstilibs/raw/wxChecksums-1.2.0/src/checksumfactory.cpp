/*
 * wxChecksums
 * Written by Julien Couot.
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
 * \file checksumfactory.cpp
 * Utility classes to compute and verify the checksums.
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

#include "checksumfactory.hpp"
#include "checksum.hpp"
#include "sumfile.hpp"
#include "md5file.hpp"
#include "sfvfile.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


//###########################################################################
// SumFileFactory::SumFileEntry members
//###########################################################################

/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void SumFileFactory::SumFileEntry::clone(const SumFileEntry& source)
{
  if (this != &source)
  {
    this->fnctGetSumFile = source.fnctGetSumFile;
    this->name = source.name;
    this->descr = source.descr;
    this->fileExt = source.fileExt;
  }
}
//---------------------------------------------------------------------------




//###########################################################################
// SumFileFactory members
//###########################################################################

// Static attributes of the SumFileFactory class
SumFileFactory::SumFileEntries SumFileFactory::sumFilesTypes;
//---------------------------------------------------------------------------


/**
 * Initializes the static members of the class.
 *
 * The name the type of the checksums' file should be the same as the one
 * returned by <CODE>checksums_file_type::getFileType()</CODE>.
 */
void SumFileFactory::initialize()
{
  sumFilesTypes[SumFileFactory::ftSFV] = SumFileEntry(SFVFile::getNewInstance, wxT("SFV"), _("SFV checksums' file"), wxT("sfv"));
  sumFilesTypes[SumFileFactory::ftMD5] = SumFileEntry(MD5File::getNewInstance, wxT("MD5"), _("MD5 checksums' file"), wxT("md5"));
}
//---------------------------------------------------------------------------


/**
 * Gets all the identifers of the available checksums' file types.
 *
 * @return All the identifers of the available checksums' file types.
 */
wxArrayInt SumFileFactory::getAvailableSumFiles()
{
  wxArrayInt res;
  
  const SumFileEntries& sft = sumFilesTypes;
  for (SumFileEntries::const_iterator it = sft.begin(); it != sft.end(); it++)
    res.Add(it->first);

  return res;
}
//---------------------------------------------------------------------------


/**
 * Gets the number of available identifers of checksums' file types.
 *
 * @return The number of available identifers of checksums' file types.
 */
int SumFileFactory::getSumFilesCount()
{
  return sumFilesTypes.size();
}
//---------------------------------------------------------------------------


/**
 * Returns <CODE>true</CODE> if the given identifer of checksums' file type
 * exists.
 *
 * @return <CODE>true</CODE> if the given identifer of checksums' file type
 *         exists, <CODE>false</CODE> otherwise.
 */
bool SumFileFactory::exists(const int sumFileType)
{
  const SumFileEntries& sft = sumFilesTypes;
  SumFileEntries::const_iterator it = sft.find(sumFileType);
  
  return (it != sft.end());
}
//---------------------------------------------------------------------------


/**
 * Gives a pointer on a new instance of the specified checksums' file type.
 *
 * The caller is responsible of the deletion of the instance with the
 * <CODE>delete</CODE> operator.
 *
 * @param  sumFileType  Type of the checksums' file of which the caller want a
 *                      new instance.
 * @return A pointer on a new instance of the specified checksums' file type or
 *         <CODE>NULL</CODE> if the specified checksums' file type is invalid.
 */
SumFile* SumFileFactory::getSumFileNewInstance(int sumFileType)
{
  if (exists(sumFileType))
    return sumFilesTypes[sumFileType].fnctGetSumFile();
  else
    return NULL;
}
//---------------------------------------------------------------------------


/**
 * Gives the name of the specified checksums' file type.
 *
 * @param  sumFileType  Type of the checksums' file of which the caller want the
 *                      name.
 * @return The name of the specified checksums' file type or an empty string
 *         if the specified checksums' file type is invalid.
 */
wxString SumFileFactory::getSumFileName(const int sumFileType)
{
  if (exists(sumFileType))
    return sumFilesTypes[sumFileType].name;
  else
    return wxEmptyString;
}
//---------------------------------------------------------------------------


/**
 * Gives the description of the specified checksums' file type.
 *
 * @param  sumFileType  Type of the checksums' file of which the caller want the
 *                      description.
 * @return The description of the specified checksums' file type or an empty
 *         string if the specified checksums' file type is invalid.
 */
wxString SumFileFactory::getSumFileDescription(const int sumFileType)
{
  if (exists(sumFileType))
    return sumFilesTypes[sumFileType].descr;
  else
    return wxEmptyString;
}
//---------------------------------------------------------------------------


/**
 * Gives the file's extension of the specified checksums' file type.
 *
 * @param  sumFileType  Type of the checksums' file of which the caller want the
 *                      file's extension.
 * @return The file's extension of the specified checksums' file type or an
 *         empty string if the specified checksums' file type is invalid.
 */
wxString SumFileFactory::getSumFileExtension(const int sumFileType)
{
  if (exists(sumFileType))
    return sumFilesTypes[sumFileType].fileExt;
  else
    return wxEmptyString;
}
//---------------------------------------------------------------------------

