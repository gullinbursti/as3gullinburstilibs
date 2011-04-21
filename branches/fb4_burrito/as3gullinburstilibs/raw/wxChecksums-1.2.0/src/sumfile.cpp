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
 * \file sumfile.cpp
 * Classes that encapsulate sums files.
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

#include <wx/txtstrm.h>
#include <wx/wfstream.h>
#include "sumfile.hpp"

// Include the Windows API header at the end prevents some problems that can
// occur at the linking procedure.
#if defined(__WXMSW__)
#include <windows.h>
#include <winnls.h>
#include <winuser.h>
#endif   // __WXMSW__

#include "compat.hpp"
//---------------------------------------------------------------------------

/// The C++ standard namespace.
using namespace std;


//###########################################################################
// ChecksumData members
//###########################################################################

/**
 * Default constructor.
 */
ChecksumData::ChecksumData()
{
  setState(NotVerified);
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void ChecksumData::clone(const ChecksumData& source)
{
  if (this != &source)
  {
    this->fileName = source.fileName;
    this->sum = source.sum;
    this->state = source.state;
  }
}
//---------------------------------------------------------------------------


/**
 * Copy constructor.
 *
 * @param  source  Source instance.
 */
ChecksumData::ChecksumData(const ChecksumData& source)
{
  clone(source);
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  source  Source instance.
 * @return A reference on the instance.
 */
ChecksumData& ChecksumData::operator=(const ChecksumData& source)
{
  clone(source);
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Constructs a new instance from a file name and a checksum value.
 *
 * @param  fn      The file name.
 * @param  strSum  The checksum value in a string.
 * @param  st      The state of the checksum.
 */
ChecksumData::ChecksumData(const wxFileName& fn, const wxString& strSum,
                           const State st)
{
  setFileName(fn);
  setChecksum(strSum);
  setState(st);
}
//---------------------------------------------------------------------------
  

/**
 * Constructs a new instance from a file name and a checksum value.
 *
 * @param  fn      The string that contains the file name.
 * @param  strSum  The checksum value in a string.
 * @param  st      The state of the checksum.
 */
ChecksumData::ChecksumData(const wxString& fn, const wxString& strSum,
                           const State st)
{
  setFileName(fn);
  setChecksum(strSum);
  setState(st);
}
//---------------------------------------------------------------------------


/**
 * Gets the file name.
 *
 * @return The file name.
 */
wxFileName ChecksumData::getFileName() const
{
  return fileName;
}
//---------------------------------------------------------------------------


/**
 * Sets the file name.
 *
 * @param  fn  The new file name.
 */
void ChecksumData::setFileName(const wxFileName& fn)
{
  fileName = fn;
}
//---------------------------------------------------------------------------


/**
 * Sets the file name.
 *
 * @param  fn  The string that contains the new file name.
 */
void ChecksumData::setFileName(const wxString& fn)
{
  fileName = fn;
}
//---------------------------------------------------------------------------
  

/**
 * Gets the checksum.
 *
 * @return A string that contains the checksum.
 */
wxString ChecksumData::getChecksum() const
{
  return sum;
}
//---------------------------------------------------------------------------


/**
 * Sets the checksum.
 *
 * @param  strSum  The string that contains the checksum.
 */
void ChecksumData::setChecksum(const wxString& strSum)
{
  sum = strSum;
}
//---------------------------------------------------------------------------


/**
 * Gets the state of the checksum.
 *
 * @return The state of the checksum.
 */
ChecksumData::State ChecksumData::getState() const
{
  return state;
}
//---------------------------------------------------------------------------
  

/**
 * Sets the state of the checksum.
 *
 * @param  newState  The new state of the checksum.
 */
void ChecksumData::setState(const ChecksumData::State newState)
{
  switch (newState)
  {
    case NotVerified :
    case Verified :
    case Invalid :
    case NotFound :
      state = newState;
      break;
    default :
      state = NotVerified;
  }
}
//---------------------------------------------------------------------------



//###########################################################################
// ChecksumData members
//###########################################################################

// Static attributes of the SumFile class.
// Value for unique identifiers generation.
long SumFile::idGen = 0L;
//---------------------------------------------------------------------------


/**
 * Default constructor.
 */
SumFile::SumFile()
{
  setModified(false);
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * Don't forget to call this method when cloning inherited classes.
 *
 * @param  source  Source instance.
 */
void SumFile::clone(const SumFile& source)
{
  if (this != &source)
  {
    this->checksums = source.checksums;
    this->modified = source.modified;
  }
}
//---------------------------------------------------------------------------


/**
 * Copy constructor.
 *
 * @param  source  Source instance.
 */
SumFile::SumFile(const SumFile& source)
{
  clone(source);
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  source  Source instance.
 * @return A reference on the instance.
 */
SumFile& SumFile::operator=(const SumFile& source)
{
  clone(source);
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Gets a new unique identifier.
 *
 * @return A new unique identifier.
 */
long SumFile::getID()
{
  return idGen++;
}
//---------------------------------------------------------------------------


/**
 * Resets the sum file.
 *
 * Clears all the checksums in the file and sets the "modified" state to
 * <CODE>false</CODE>.
 */
void SumFile::reset()
{
  checksums.clear();
  setModified(false);
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the checksum file.
 *
 * @return The name of the checksum file. Empty for none.
 */
wxString SumFile::getFileName() const
{
  return fileName;
}
//---------------------------------------------------------------------------


/**
 * Sets the name of the checksum file.
 *
 * @param  newFileName  Name of the new file name of the checksum file.
 * @remarks Provide an empty string for none.
 */
void SumFile::setFileName(const wxString& newFileName)
{
  fileName = newFileName;
}
//---------------------------------------------------------------------------


/**
 * Indicates whether the file has been modified.
 *
 * @return <CODE>true</CODE> if the file has been modified, <CODE>false</CODE>
 *         otherwise.
 */
bool SumFile::getModified() const
{
  return modified;
}
//---------------------------------------------------------------------------


/**
 * Sets the "modified" state of the file.
 *
 * @param  newModifiedState  The new "modified" state.
 */
void SumFile::setModified(const bool newModifiedState)
{
  modified = newModifiedState;
}
//---------------------------------------------------------------------------


/**
 * Gets all the keys of the checksums data.
 *
 * @param  keys  The array that will contain the keys of the checksums data.
 *               The array will be erased before storing the keys.
 */
void SumFile::getChecksumDataKeys(MChecksumDataKeys& keys) const
{
  keys.Clear();
  size_t s = checksums.size();
  if (s > 0)
  {
    keys.Alloc(s);
    for (MChecksumData::const_iterator it = checksums.begin(); it != checksums.end(); it++)
      keys.Add(it->first);
  }
}
//---------------------------------------------------------------------------


/**
 * Returns the number of checksum data in file.
 *
 * @return The number of checksum data in file.
 */
size_t SumFile::getChecksumDataCount() const
{
  return checksums.size();
}
//---------------------------------------------------------------------------


/**
 * Returns the checksum data of the given key.
 *
 * @param  key The key whose associated checksum data is to be returned.
 * @return The checksum data associated at the given key.
 *         If <CODE>key</CODE> doesn't exist, an empty checksum data is
 *         returned.
 */
ChecksumData SumFile::getChecksumData(const long key) const
{
  ChecksumData csd;
  getChecksumData(key, csd);
  return csd;
}
//---------------------------------------------------------------------------

 
/**
 * Gets the checksum data of the given key.
 *
 * @param  key           The key whose associated checksum data is to be
 *                       returned.
 * @param  checksumData  The instance of ChecksumData where the checksum data
 *                       will be stored. If <CODE>key</CODE> doesn't exist,
 *                       an empty checksum data is given.
 */
void SumFile::getChecksumData(const long key, ChecksumData& checksumData) const
{
  MChecksumData::const_iterator it = checksums.find(key);
  if (it == checksums.end())
    checksumData = ChecksumData();
  else
    checksumData = it->second;
}
//---------------------------------------------------------------------------


/**
 * Sets the checksum data of the given key.
 *
 * After setting the checksum data, the state of the file is "modified".
 *
 * @param  key           The position of the checksum data.
 * @param  checksumData  The new value for the checksum data.
 * @return If <CODE>index</CODE> is out of bounds, returns <CODE>false</CODE>,
 *         <CODE>true</CODE> otherwise.
 */
bool SumFile::setChecksumData(const long key, const ChecksumData& checksumData)
{
  MChecksumData::iterator it = checksums.find(key);
  if (it == checksums.end())
    return false;
  else
  {
    it->second = checksumData;
    setModified(true);
    return true;
  }
}
//---------------------------------------------------------------------------


/**
 * Sets the checksum state of the given key.
 *
 * After setting the checksum data, the state of the file is unchanged.
 *
 * @param  key    The position of the checksum data.
 * @param  state  The new state of the checksum.
 * @return If <CODE>index</CODE> is out of bounds, returns <CODE>false</CODE>,
 *         <CODE>true</CODE> otherwise.
 */
bool SumFile::setChecksumState(const long key, const ChecksumData::State state)
{
  MChecksumData::iterator it = checksums.find(key);
  if (it == checksums.end())
    return false;
  else
  {
    it->second.setState(state);
    return true;
  }
}
//---------------------------------------------------------------------------


/**
 * Adds a checksum data in the file.
 *
 * After setting the checksum data, the state of the file is "modified".
 *
 * @param  checksumData  The value of the checksum data to add.
 * @return The key of the added checksum data.
 */
long SumFile::addChecksumData(const ChecksumData& checksumData)
{
  long id = getID();
  checksums[id] = checksumData;
  setModified(true);
  return id;
}
//---------------------------------------------------------------------------


/**
 * Removes a checksum data in the file.
 *
 * After setting the checksum data, the state of the file is "modified".
 *
 * @param  key  The key of the checksum data to remove.
 * @return <CODE>true</CODE> if the checksum data has been removed successfully,
 *         <CODE>false</CODE> otherwise.
 */
bool SumFile::removeChecksumData(const long key)
{
  if (checksums.erase(key) > 0)
  {
    modified = true;
    return true;
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Returns an iterator pointing at the first element of the checksums data.
 *
 * @return An iterator pointing at the first element of the checksums data.
 */
MChecksumData::const_iterator SumFile::getChecksumDataBegin() const
{
  return checksums.begin();
}
//---------------------------------------------------------------------------


/**
 * Returns an iterator pointing at the one-after-the-last element of the checksums data.
 *
 * @return An iterator pointing at the one-after-the-last element of the checksums data.
 */
MChecksumData::const_iterator SumFile::getChecksumDataEnd() const
{
  return checksums.end();
}
//---------------------------------------------------------------------------


/**
 * Returns an iterator pointing at the first element of the checksums data.
 *
 * For internal use only.
 *
 * @return An iterator pointing at the first element of the checksums data.
 */
MChecksumData::iterator SumFile::getChecksumDataBeginI()
{
  return checksums.begin();
}
//---------------------------------------------------------------------------


/**
 * Returns an iterator pointing at the one-after-the-last element of the checksums data.
 *
 * For internal use only.
 *
 * @return An iterator pointing at the one-after-the-last element of the checksums data.
 */
MChecksumData::iterator SumFile::getChecksumDataEndI()
{
  return checksums.end();
}
//---------------------------------------------------------------------------


/**
 * Gets the path format that is used in the given file.
 *
 * @param  fileName        The file name of which we want to know the path
 *                         format.
 * @param  commentChars    Characters that indicate a line of comments.
 * @param  maxLinesToRead  Number of lines of text to read before determine
 *                         which path format has been used in
 *                         <CODE>fileName</CODE>.
 * @return The path format that is used in the given file.
 */
wxPathFormat SumFile::getPathFormat(const wxFileName& fileName, const wxString& commentChars, const unsigned int maxLinesToRead) const
{
  // Reads the lines
  wxFileInputStream input(fileName.GetFullPath());
  wxTextInputStream text(input);
  wxString     line;            // line of text
  size_t       l;               // size of the line
  size_t       i;               // counter
  bool         isComment;       // the line is a comment ?
  unsigned int nbLines = 0;     // count the number of lines in the file
  unsigned int pathUnix = 0;    // counter of unix path separator.
  unsigned int pathWindows = 0; // counter of windows path separator.
  unsigned int pathMac = 0;     // counter of mac path separator.
  wxPathFormat pf;
  const unsigned int MAX_LINES = (maxLinesToRead < UINT_MAX) ? maxLinesToRead : 1000;  // maximal number of lines to read

  line = text.ReadLine();
  while (!input.Eof() && nbLines <= MAX_LINES)
  {
    line.Trim(false).Trim(true);
    l = line.size();
    isComment = false;

    if (l > 0)
    // Checks if the line is a comment
    {
      i = 0;
      wxChar first = line.GetChar(0);
      while (!isComment && i < commentChars.Length())
      {
        if (first == commentChars[i])
          isComment = true;
        i++;
      }
    }
    
    if (!isComment)
    {
      for (i = 0; i < l; i++)
      {
        switch (line[i])
        {
          case wxT('\\') :
            pathWindows++;
            break;
          case wxT('/') :
            pathUnix++;
            break;
          case wxT(':') :
            if (i == 1)  // could be a Windows volume
            {
              if (line.GetChar(0) == wxT(':'))  // must be a Mac path separator
                pathMac++;
            }
            else
              pathMac++;
            break;
        }
      }
      nbLines++;  // don't count the line if its a comment
    }

    line = text.ReadLine();
  }

  if (((pathWindows == pathUnix) && (pathWindows > 0) && (pathUnix > 0)) ||
      ((pathWindows == pathMac) && (pathWindows > 0) && (pathMac > 0)) ||
      ((pathUnix == pathMac) && (pathUnix > 0) && (pathMac > 0)))
  // Don't know which to use.
    pf = wxPATH_NATIVE;
  else
  {
    unsigned int m = pathWindows;
    if (pathUnix > m) m = pathUnix;
    if (pathMac > m) m = pathMac;
    
    if (m == 0)
    // Don't know which to use.
      pf = wxPATH_NATIVE;
    
    if (pathWindows == m)
      pf = wxPATH_WIN;
    else if (pathUnix == m)
      pf = wxPATH_UNIX;
    else if (pathMac == m)
      pf = wxPATH_MAC;
    else  // Stupid
      pf = wxPATH_NATIVE;
  }

  return pf;
}
//---------------------------------------------------------------------------
