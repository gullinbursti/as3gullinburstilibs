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
 * \file sfvfile.hpp
 * Classes that encapsulate SFV files.
 */


#ifndef INC_SFVFILE_HPP
#define INC_SFVFILE_HPP


//---------------------------------------------------------------------------
#include "sumfile.hpp"
//---------------------------------------------------------------------------


/**
 * A SFV file.
 */
class SFVFile : public SumFile
{
 private:
  // Copy constructor.
  SFVFile(const SFVFile& source);

  // Assignment operator.
  virtual SFVFile& operator=(const SFVFile& source);

 protected:
  // Clones the source instance in this instance.
  void clone(const SFVFile& source);

 public:
  // Default constructor.
  SFVFile();

  // Returns an instance of a class that permits to compute the CRC-32 value.
  Checksum* getChecksumCalculator() const;

  // Returns the type of the file.
  virtual wxString getFileType() const;

  // Reads the checksums from a file.
  bool read(const wxFileName& fileName);
  
  // Writes the checksums in a file.
  bool write(const wxFileName& fileName);
  
  // Indicates if the given checksum is valid.
  static bool IsValidChecksum(const wxString& checksum);

  // Gets a new instance of this class.
  static SumFile* getNewInstance();
};
//---------------------------------------------------------------------------


#endif  // INC_SFVFILE_HPP

