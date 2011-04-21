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
 * \file checksumutil.cpp
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

#include "checksumutil.hpp"
#include "appprefs.hpp"
#include "comdefs.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


//###########################################################################
// ChecksumCalculator members
//###########################################################################

/**
 * Default constructor.
 */
ChecksumCalculator::ChecksumCalculator()
{
  checksumCalc.Add(NULL);
  checksumCalc.Shrink();
  //setChecksum(NULL);
  setChecksumProgress(NULL);
  setBufferSize(512);
}
//---------------------------------------------------------------------------


/**
 * Constructor with a checksum instance to use and an optional progress handler.
 *
 * @param  checksum         Adress of a Checksum instance class to use for calculating the checksums.
 * @param  progressHandler  Adress of a ChecksumProgress instance class to show the progress (could be <CODE>NULL</CODE>).
 */
ChecksumCalculator::ChecksumCalculator(Checksum* checksum, ChecksumProgress* progressHandler)
{
  checksumCalc.Add(checksum);
  checksumCalc.Shrink();
  //setChecksum(checksum);
  setChecksumProgress(progressHandler);
  setBufferSize(512);
}
//---------------------------------------------------------------------------


/**
 * Gets the size of the buffer to use for reading in the input stream.
 *
 * @return The size of buffer to use for reading in the input stream.
 */
size_t ChecksumCalculator::getBufferSize() const
{
  return bufferSize;
}
//---------------------------------------------------------------------------


/**
 * Sets the size of the buffer to use for reading in the input stream.
 *
 * @param  bufSize  The new size of the buffer to use for reading in the input stream.
 * @return The old size of the buffer to use for reading in the input stream.
 */
size_t ChecksumCalculator::setBufferSize(const size_t bufSize)
{
  size_t old = bufferSize;
  bufferSize = bufSize;
  return old;
}
//---------------------------------------------------------------------------


/**
 * Gets the checksum's instance use to calculate the checksums.
 *
 * @return The checksum's instance use to calculate the checksums.
 */
Checksum* ChecksumCalculator::getChecksum() const
{
  return checksumCalc[0];
}
//---------------------------------------------------------------------------

  
/**
 * Sets the checksum's instance use to calculate the checksums.
 *
 * @param  checksum  The checksum's instance which will be used to calculate the checksums.
 * @return The old checksum's instance use to calculate the checksums.
 */
Checksum* ChecksumCalculator::setChecksum(Checksum* checksum)
{
  Checksum* old = getChecksum();
  checksumCalc[0] = checksum;
  return old;
} 
//---------------------------------------------------------------------------


/**
 * Gets the progress handler used to show the progression.
 *
 * @return The progress handler used to show the progression.
 */
ChecksumProgress* ChecksumCalculator::getChecksumProgress() const
{
  return progress;
}
//---------------------------------------------------------------------------
  

/**
 * Sets the progress handler used to show the progression.
 *
 * @param  progressHandler  The new progress handler which wiil be used to show the progression.
 * @return The old progress handler used to show the progression.
 */
ChecksumProgress* ChecksumCalculator::setChecksumProgress(ChecksumProgress* progressHandler)
{
  ChecksumProgress* old = getChecksumProgress();
  progress = progressHandler;
  return old;
}
//---------------------------------------------------------------------------


/**
 * Calculates the checksum from the given stream.
 *
 * @param  in        Input stream from which the data will be extracted to
 *                   compute the checksum. The data are extracted until the end
 *                   of the stream is reached.
 * @param  sumValue  The calculated value of the checksum from the input stream.
 * @return <UL>
 *           <LI><CODE>Ok</CODE> if the checksum has been successfully calculated.</Li>
 *           <LI><CODE>ReadError</CODE> if a read error has occured.</LI>
 *           <LI><CODE>Canceled</CODE> if the user has canceled the calculation.</LI>
 *         </UL>
 */
ChecksumCalculator::State ChecksumCalculator::calculate(wxInputStream& in, wxString& sumValue)
{
  wxArrayString sumValues;
  State res = calculate(in, checksumCalc, sumValues);
  if (!sumValues.IsEmpty())
    sumValue = sumValues[0];
  return res;
}
//---------------------------------------------------------------------------


/**
 * Calculates the checksums from the given stream.
 *
 * @param  in         Input stream from which the data will be extracted to
 *                    compute the checksum. The data are extracted until the end
 *                    of the stream is reached.
 * @param  checksums  Array of checksums to calculate.
 * @param  sumValues  The calculated values of the checksums from the input
 *                    stream. The array is erased first before adding results.
 *                    On success <CODE>ArrayChecksum.GetCount() == sumValues.GetCount()</CODE>,
 *                    on failure, <CODE>sumValues</CODE> should be empty.
 * @return <UL>
 *           <LI><CODE>Ok</CODE> if the checksum has been successfully calculated.</Li>
 *           <LI><CODE>ReadError</CODE> if a read error has occured.</LI>
 *           <LI><CODE>Canceled</CODE> if the user has canceled the calculation.</LI>
 *         </UL>
 */
ChecksumCalculator::State ChecksumCalculator::calculate(wxInputStream& in,
                                                 const ArrayChecksum& checksums,
                                                       wxArrayString& sumValues)
{
  // Check if the input stream is valid.
  if (!in.IsOk())
    return ReadError;
  
  // Check if at least a checksum instance is OK.
  bool aInstanceOK = false;
  size_t i = 0;
  size_t s = checksums.GetCount();
  while (!aInstanceOK && i < s)
    if (checksums[i] != NULL)
      aInstanceOK = true;
    else
      i++;
  if (!aInstanceOK)
    return ReadError;
  
  // Initializes the buffer.
  const size_t bufSize = getBufferSize();
  wxByte* buff = new wxByte[bufSize];

  // Calculating the checksum.
  ChecksumProgress* p = getChecksumProgress();
  bool canceled = false;
  size_t read;
  wxStreamError lastError = wxSTREAM_NO_ERROR;
  s = checksums.GetCount();
  for (i = 0; i < s; i++)
    if (checksums[i] != NULL)
      checksums[i]->reset();
  while (!canceled && !in.Eof() && lastError == wxSTREAM_NO_ERROR)
  {
    in.Read(buff, bufSize);
    read = in.LastRead();
    if (read > 0 && read <= bufSize)
    {
      for (i = 0; i < s; i++)
        if (checksums[i] != NULL)
          checksums[i]->update(buff, read);
      if (p != NULL)
        p->update(read, canceled);
    }
    lastError = in.GetLastError();
  }

  // Cleans-up the memory
  delete[] buff;
  
  if (canceled)
    return CanceledByUser;
  
  if (lastError != wxSTREAM_NO_ERROR && lastError != wxSTREAM_EOF)
    return ReadError;
    
  sumValues.Empty();
  for (i = 0; i < s; i++)
    if (checksums[i] != NULL)
      sumValues.Add(checksums[i]->getValue());
    else
      sumValues.Add(wxEmptyString);

  return Ok;
}
//---------------------------------------------------------------------------


/**
 * Checks the checksum from the given stream.
 *
 * @param  in     Input stream from which the data will be extracted to
 *                compute the checksum. The data are extracted until the end
 *                of the stream is reached.
 * @param  value  The value of the checksum which will be compared with the
 *                value that will be calculated.
 * @return <UL>
 *           <LI><CODE>Ok</CODE> if the checksum has been successfully
 *             calculated and if the two sums are equals.</LI>
 *           <LI><CODE>Invalid</CODE> if the checksum has been successfully
 *             calculated and if the two sums are not equals.</LI>
 *           <LI><CODE>ReadError</CODE> if a read error has occured.</LI>
 *           <LI><CODE>Canceled</CODE> if the user has canceled the calculation.</LI>
 *         </UL>
 */
ChecksumCalculator::State ChecksumCalculator::check(wxInputStream& in, const wxString& value)
{
  wxString calcSum;
  
  State res = calculate(in, calcSum);
  if (res == Ok)
  {
    if (calcSum.CmpNoCase(value) == 0)
      return Ok;
    else
      return Invalid;
  }

  return res;
}
//---------------------------------------------------------------------------




//###########################################################################
// ChecksumFileCalculator members
//###########################################################################


/**
 * Default constructor.
 */
ChecksumFileCalculator::ChecksumFileCalculator() : ChecksumCalculator()
{
  initBufferSize();
}
//---------------------------------------------------------------------------


/**
 * Constructor with a checksum instance to use and an optional progress handler.
 *
 * @param  checksum         Adress of a Checksum instance class to use for calculating the checksums.
 * @param  progressHandler  Adress of a ChecksumProgress instance class to show the progress (could be <CODE>NULL</CODE>).
 */
ChecksumFileCalculator::ChecksumFileCalculator(Checksum* checksum,
                                           ChecksumProgress* progressHandler) :
                                  ChecksumCalculator(checksum, progressHandler)
{
  initBufferSize();
}
//---------------------------------------------------------------------------


/**
 * Initializes the buffer size for reading files.
 */
void ChecksumFileCalculator::initBufferSize()
{
  size_t buffsize = AppPrefs::get()->readLong(prENGINE_READ_BUFFER);  // buffer length
  if (buffsize <= 0 || buffsize > MAX_BUFF_SIZE)
  // Sets a reasonable value for the buffer.
    buffsize = DEF_BUFF_SIZE;
  setBufferSize(buffsize);
}
//---------------------------------------------------------------------------


/**
 * Gets a wxFileInputStream for reading the file.
 *
 * @param  fileName  Name of the file from which the input stream will be get.
 * @param  state     After the returning the value of this parameter can be:
 *                   <UL>
 *                     <LI><CODE>Ok</CODE> if the input stream has been
 *                       successfully created.</LI>
 *                     <LI><CODE>FileNotFound</CODE> if the file can't be
 *                       found.</LI>
 *                     <LI><CODE>CantOpenFile</CODE> if the file exists, but
 *                       can't be opened.</LI>
 *                     <LI><CODE>Canceled</CODE> if the user has canceled the
 *                       calculation.</LI>
 *                   </UL>
 * @return A pointer to the input created from the file name or
 *         <CODE>NULL</CODE> if an error has occured. The caller is responsible
 *         of freeing the memory with the <CODE>delete</CODE> operator.
 */
wxFileInputStream* ChecksumFileCalculator::getFileInputStream(const wxString& fileName, State& state)
{
  wxFileInputStream* in = new wxFileInputStream(fileName);
  if (!in->Ok() || !in->IsOk())
  {
    delete in;
    if (::wxFileExists(fileName))
      state = CantOpenFile;
    else
      state = FileNotFound;
    return (wxFileInputStream*)NULL;
  }
  else
  {
    state = Ok;
    return in;
  }
}
//---------------------------------------------------------------------------


/**
 * Calculates the checksum from the given file.
 *
 * @param  fileName  Name of the file from which the data will be extracted to
 *                   compute the checksum. The data are extracted until the end
 *                   of the file is reached.
 * @param  sumValue  The calculated value of the checksum from the input stream.
 * @return <UL>
 *           <LI><CODE>Ok</CODE> if the checksum has been successfully calculated.</Li>
 *           <LI><CODE>ReadError</CODE> if a read error has occured.</LI>
 *           <LI><CODE>FileNotFound</CODE> if the file doesn't exist.</LI>
 *           <LI><CODE>CantOpenFile</CODE> if the file can't be opened.</LI>
 *           <LI><CODE>Canceled</CODE> if the user has canceled the calculation.</LI>
 *         </UL>
 */
ChecksumFileCalculator::State ChecksumFileCalculator::calculate(const wxString& fileName, wxString& sumValue)
{
  State state;
  wxFileInputStream* in = getFileInputStream(fileName, state);
  if (in == NULL)
    return state;
  
  state = ChecksumCalculator::calculate(*in, sumValue);
  delete in;
  return state;
}
//---------------------------------------------------------------------------


/**
 * Calculates the checksums from the given file.
 *
 * @param  fileName   Name of the file from which the data will be extracted to
 *                    compute the checksum. The data are extracted until the end
 *                    of the file is reached.
 * @param  checksums  Array of checksums to calculate.
 * @param  sumValues  The calculated values of the checksums from the input
 *                    stream. The array is erased first before adding results.
 *                    On success <CODE>ArrayChecksum.GetCount() == sumValues.GetCount()</CODE>,
 *                    on failure, <CODE>sumValues</CODE> should be empty.
 * @return <UL>
 *           <LI><CODE>Ok</CODE> if the checksum has been successfully calculated.</Li>
 *           <LI><CODE>ReadError</CODE> if a read error has occured.</LI>
 *           <LI><CODE>FileNotFound</CODE> if the file doesn't exist.</LI>
 *           <LI><CODE>CantOpenFile</CODE> if the file can't be opened.</LI>
 *           <LI><CODE>Canceled</CODE> if the user has canceled the calculation.</LI>
 *         </UL>
 */
ChecksumCalculator::State ChecksumFileCalculator::calculate(const wxString& fileName,
                                                 const ArrayChecksum& checksums,
                                                       wxArrayString& sumValues)
{
  State state;
  wxFileInputStream* in = getFileInputStream(fileName, state);
  if (in == NULL)
    return state;
  
  state = ChecksumCalculator::calculate(*in, checksums, sumValues);
  delete in;
  return state;
}
//---------------------------------------------------------------------------


/**
 * Checks the checksum from the given file.
 *
 * @param  fileName  Name of the file from which the data will be extracted to
 *                   compute the checksum. The data are extracted until the end
 *                   of the file is reached.
 * @param  value  The value of the checksum which will be compared with the
 *                value that will be calculated.
 * @return <UL>
 *           <LI><CODE>Ok</CODE> if the checksum has been successfully
 *             calculated and if the two sums are equals.</LI>
 *           <LI><CODE>Invalid</CODE> if the checksum has been successfully
 *             calculated and if the two sums are not equals.</LI>
 *           <LI><CODE>ReadError</CODE> if a read error has occured.</LI>
 *           <LI><CODE>FileNotFound</CODE> if the file doesn't exist.</LI>
 *           <LI><CODE>CantOpenFile</CODE> if the file can't be opened.</LI>
 *         </UL>
 */
ChecksumFileCalculator::State ChecksumFileCalculator::check(const wxString& fileName, const wxString& value)
{
  State state;
  wxFileInputStream* in = getFileInputStream(fileName, state);
  if (in == NULL)
    return state;
  
  state = ChecksumCalculator::check(*in, value);
  delete in;
  return state;
}
//---------------------------------------------------------------------------
