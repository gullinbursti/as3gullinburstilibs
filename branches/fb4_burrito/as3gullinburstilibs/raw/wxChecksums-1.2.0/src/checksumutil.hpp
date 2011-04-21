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
 * \file checksumutil.hpp
 * Utility classes to compute and verify the checksums.
 */

#ifndef INC_CHECKSUMUTIL_HPP
#define INC_CHECKSUMUTIL_HPP

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

#include <wx/stream.h>
#include <wx/wfstream.h>

#include "checksum.hpp"
//---------------------------------------------------------------------------


// Displays the progression of the process of computing of a checksum.
class ChecksumProgress;


/**
 * Calculates a checksum. Provides an interface for showing the progression.
 *
 * Don't pass this class by value and don't use the assignment operator on it.
 *
 * Please note that all the pointers passed to this class are not freed, it is
 * the responsability to the users of this class to free them.
 */
class ChecksumCalculator
{
 public:
  /// States that can be returned by the calculate or the check method.
  enum State
  {
    Ok = 0,            // Checksum has been calculated (and corresponds for the check method).
    Invalid,           // Checksum has been verified and not corresponds.
    ReadError,         // Error while reading the stream.
    FileNotFound,      // The file has been not found.
    CantOpenFile,      // Can't open the stream.
    CanceledByUser     // User has canceled the calculation.
  };

 protected:
  ArrayChecksum checksumCalc;  ///< Checksum's instance use to calculate the checksums.
  ChecksumProgress* progress;  ///< The progress handler used to show the progression.
  size_t bufferSize;           ///< The size of the buffer to use for reading in the input stream.

  // Default constructor.
  ChecksumCalculator();

  // Constructor with a checksum instance to use and an optional progress handler.  
  ChecksumCalculator(Checksum* checksum, ChecksumProgress* progressHandler = NULL);

  // Gets the size of the buffer to use for reading in the input stream.
  size_t getBufferSize() const;
  
  // Sets the size of the buffer to use for reading in the input stream.
  size_t setBufferSize(const size_t bufSize);

 public:
  // Accessors
  // Gets the checksum's instance use to calculate the checksums.
  Checksum* getChecksum() const;
  
  // Sets the checksum's instance use to calculate the checksums.
  Checksum* setChecksum(Checksum* checksum);

  // Gets the progress handler used to show the progression.
  ChecksumProgress* getChecksumProgress() const;
  
  // Sets the progress handler used to show the progression.
  ChecksumProgress* setChecksumProgress(ChecksumProgress* progressHandler);


  // Operations
  // Calculates the checksum from the given stream.
  State calculate(wxInputStream& in, wxString& sumValue);

  // Calculates the checksums from the given stream.
  State calculate(wxInputStream& in, const ArrayChecksum& checksums,
                  wxArrayString& sumValues);

  // Checks the checksum from the given stream.
  State check(wxInputStream& in, const wxString& value);
};
//---------------------------------------------------------------------------


/**
 * Computes a checksum from a file.
 *
 * Please note that all the pointers passed to this class are not freed, it is
 * the responsability to the users of this class to free them.
 */
class ChecksumFileCalculator : public ChecksumCalculator
{
 public:
  /// Default constructor.
  ChecksumFileCalculator();

  /**
   * Constructor with a checksum instance to use and an optional progress handler.
   *
   * @param  checksum         Adress of a Checksum instance class to use for calculating the checksums.
   * @param  progressHandler  Adress of a ChecksumProgress instance class to show the progress (could be <CODE>NULL</CODE>).
   */
  ChecksumFileCalculator(Checksum* checksum, ChecksumProgress* progressHandler = NULL);

 protected:
  // Initialize the buffer size for reading files.
  void initBufferSize();

  // Get a wxFileInputStream for reading the file.
  wxFileInputStream* getFileInputStream(const wxString& fileName, State& state);

 public:
  // Operations
  // Calculates the checksum from the given file.
  State calculate(const wxString& fileName, wxString& sumValue);

  // Calculates the checksums from the given file.
  State calculate(const wxString& fileName, const ArrayChecksum& checksums,
                  wxArrayString& sumValues);

  // Checks the checksum from the given file.
  State check(const wxString& fileName, const wxString& value);
};
//---------------------------------------------------------------------------


/**
 * Displays the progression of the process of computing of a checksum.
 */
class ChecksumProgress
{
 public:
  /// Destructor.
  virtual ~ChecksumProgress() {}
  
  /**
   * Updates the progress dialog of the computing of a checksum.
   *
   * @param  read      Number of bytes read.
   * @param  canceled  Set it to <CODE>true</CODE> if the user want to cancel
   *                   the calculation. The caller should call it with its value
   *                   set to <CODE>false</CODE>.
   */
  virtual void update(size_t read, bool& canceled) = 0;
};
//---------------------------------------------------------------------------


#endif  // INC_CHECKSUMUTIL_HPP
