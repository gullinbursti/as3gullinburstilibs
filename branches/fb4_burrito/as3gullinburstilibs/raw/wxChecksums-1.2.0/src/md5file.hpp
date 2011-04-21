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
 * \file md5file.hpp
 * Classes that encapsulate %MD5 files.
 */


#ifndef INC_MD5FILE_HPP
#define INC_MD5FILE_HPP


//---------------------------------------------------------------------------
#include "sumfile.hpp"
//---------------------------------------------------------------------------


/**
 * A %MD5 file.
 */
class MD5File : public SumFile
{
 private:
  // Copy constructor.
  MD5File(const MD5File& source);

  // Assignment operator.
  virtual MD5File& operator=(const MD5File& source);

 protected:
  // Clones the source instance in this instance.
  void clone(const MD5File& source);

 public:
  // Default constructor.
  MD5File();

  // Returns an instance of a class that permits to compute the MD5 value.
  virtual Checksum* getChecksumCalculator() const;

  // Returns the type of the file.
  virtual wxString getFileType() const;

  // Reads the checksums from a file.
  virtual bool read(const wxFileName& fileName);
  
  // Writes the checksums in a file.
  virtual bool write(const wxFileName& fileName);
  
  // Indicates if the given checksum is valid.
  static bool IsValidChecksum(const wxString& checksum);

  // Gets a new instance of this class.
  static SumFile* getNewInstance();
};
//---------------------------------------------------------------------------


#endif  // INC_MD5FILE_HPP

