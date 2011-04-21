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
 * \file sumfile.hpp
 * Classes that encapsulate sums files.
 */


#ifndef INC_SUMFILE_HPP
#define INC_SUMFILE_HPP


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
#include <wx/dynarray.h>
#include <wx/filename.h>
#include <wx/hashmap.h>

#include <climits>

#include "checksum.hpp"
//---------------------------------------------------------------------------


/**
 * Data on a checksum.
 */
class ChecksumData
{
 public:
  /// States available for a checksum.
  enum State
  {
    NotVerified = 0,   // Checksum has not been verified.
    Verified,          // Checksum has been verified and corresponds.
    Invalid,           // Checksum has been verified and not corresponds.
    NotFound           // The file has been not found.
  };
 
  /// Number of elements in the state enum.
  #define  CD_STATE_COUNT  4
 
 protected:
  wxFileName fileName;  ///< Name of the file.
  wxString   sum;       ///< String that contains the sum value.
  State      state;     ///< State of the checksum.

  // Clones the source instance in this instance.
  void clone(const ChecksumData& source);

 public:
  // Default constructor.
  ChecksumData();

  // Copy constructor.
  ChecksumData(const ChecksumData& source);

  // Assignment operator.
  ChecksumData& operator=(const ChecksumData& source);

  // Constructor.
  ChecksumData(const wxFileName& fn, const wxString& strSum, const State st = NotVerified);
  
  // Constructor.
  ChecksumData(const wxString& fn, const wxString& strSum, const State st = NotVerified);

  // Gets the file name.
  wxFileName getFileName() const;

  // Sets the file name.
  void setFileName(const wxFileName& fn);

  // Sets the file name.
  void setFileName(const wxString& fn);
  
  // Gets the checksum value.
  wxString getChecksum() const;

  // Sets the checksum value.
  void setChecksum(const wxString& strSum);
  
  // Gets the state of the checksum.
  State getState() const;
  
  // Sets the state of the checksum.
  void setState(const State newState);
};
//---------------------------------------------------------------------------


/// A hash map of checksum data with integer key.
WX_DECLARE_HASH_MAP(long, ChecksumData, wxIntegerHash, wxIntegerEqual, MChecksumData);

/// An array of long values
WX_DEFINE_ARRAY_LONG(long, MChecksumDataKeys);
//---------------------------------------------------------------------------


/**
 * A sum file.
 */
class SumFile
{
 private:
  static long   idGen;      ///< Value for unique identifiers generation.
  MChecksumData checksums;  ///< The checksums that are contained in the file.
  wxString      fileName;   ///< Name of the checksum file. Empty for none.
  bool          modified;   ///< Indicates that the file has been modified.


 protected:
  // Gets a new unique identifier.
  static long getID();

  // Clones the source instance in this instance.
  void clone(const SumFile& source);

 private:
  // Copy constructor.
  SumFile(const SumFile& source);

  // Assignment operator.
  virtual SumFile& operator=(const SumFile& source);

 public:
  // Default constructor.
  SumFile();

  /**
   * Returns an instance of a class that permits to compute the checksum
   * value.
   *
   * The calling function is responsible of the deletion of the instance with
   * the <CODE>delete</CODE> operator.
   *
   * @return An instance of a class that permits to compute the checksum value.
   */
  virtual Checksum* getChecksumCalculator() const = 0;

  /**
   * Returns the type of the file.
   *
   * @return The type of the file.
   */
  virtual wxString getFileType() const = 0;


  /**
   * Reads the checksums from a file.
   *
   * After the reading of the file, the state of the file should be unmodified
   * and on success, the checksum file name must be the given one (absolute
   * path).
   *
   * The paths of the files in the ChecksumData must be relative to the path of 
   * <CODE>fileName</CODE>.
   *
   * @param  fileName  The file name from which the checksums are read.
   * @return <CODE>true</CODE> if the file has been read successfully,
   *         <CODE>false</CODE> otherwise.
   */
  virtual bool read(const wxFileName& fileName) = 0;
  
  /**
   * Writes the checksums in a file.
   *
   * After the writing of the file, the state of the file should be unmodified
   * and the file name must be modified to <CODE>fileName</CODE>.
   * The paths of the files in the ChecksumData must be relative to the path of 
   * <CODE>fileName</CODE>.
   *
   * @param  fileName  The file name in which the checksums are written.
   * @return <CODE>true</CODE> if the checksums have been written successfully,
   *         <CODE>false</CODE> otherwise.
   */
  virtual bool write(const wxFileName& fileName) = 0;
  
  // Resets the sum file.
  virtual void reset();


  // Gets the name of the checksum file. Empty for none.
  wxString getFileName() const;

  // Sets the name of the checksum file. Empty for none.
  void setFileName(const wxString& newFileName);


  // Indicates whether the file has been modified.
  bool getModified() const;

  // Sets the "modified" state of the file.
  void setModified(const bool newModifiedState);


  // Gets all the keys of the checksum data.
  void getChecksumDataKeys(MChecksumDataKeys& keys) const;
  
  // Returns the number of checksum data in file.
  size_t getChecksumDataCount() const;
  
  // Returns the checksum data of the given key.
  ChecksumData getChecksumData(const long key) const;
  
  // Gets the checksum data of the given key.
  void getChecksumData(const long key, ChecksumData& checksumData) const;

  // Sets the checksum data of the given key.
  bool setChecksumData(const long key, const ChecksumData& checksumData);
  
  // Sets the checksum state of the given key.
  bool setChecksumState(const long key, const ChecksumData::State state);

  // Adds a checksum data in the file.
  long addChecksumData(const ChecksumData& checksumData);

  // Removes a checksum data in the file.
  bool removeChecksumData(const long key);


  // Returns an iterator pointing at the first element of the checksums data.
  MChecksumData::const_iterator getChecksumDataBegin() const;

  // Returns an iterator pointing at the one-after-the-last element of the checksums data.
  MChecksumData::const_iterator getChecksumDataEnd() const;
 
 protected:
  // Returns an iterator pointing at the first element of the checksums data.
  MChecksumData::iterator getChecksumDataBeginI();

  // Returns an iterator pointing at the one-after-the-last element of the checksums data.
  MChecksumData::iterator getChecksumDataEndI();
 
 public:
  // Gets the path format that is used in the given file.
  wxPathFormat getPathFormat(const wxFileName& fileName, const wxString& commentChars = wxT(";"), const unsigned int maxLinesToRead = UINT_MAX) const;
};
//---------------------------------------------------------------------------

/// Array of <CODE>SumFile*</CODE>.
WX_DEFINE_ARRAY(SumFile*, ArraySumFile);
//---------------------------------------------------------------------------

#endif  // INC_SUMFILE_HPP

