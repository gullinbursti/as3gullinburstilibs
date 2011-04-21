/*
 * Checksum
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
 * \file checksum.hpp
 * Interface for classes that compute checksums.
 */

#ifndef INC_CHECKSUM_HPP
#define INC_CHECKSUM_HPP

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
//---------------------------------------------------------------------------


/**
 * Computes a checksum from a byte stream.
 *
 * Using this class in very simple:<BR>
 * Use the @link update(const wxByte* buf, unsigned int len) update @endlink
 * method to provide to the class the bytes for computing the checksum.
 * 
 * The checksum value can be gotten by the @link getValue(const bool) const
 * getValue @endlink method which puts the checksum value in a string.
 *
 * The checksum computing can be reseted by the @link reset() reset @endlink
 * method.
 */
class Checksum
{
 public:
  /**
   * Resets the checksum to initial value.
   */
  virtual void reset() = 0;

  /**
   * Returns the checksum value in a string.
   *
   * @param  hexInUpperCase  If <CODE>true</CODE> the hexadecimal letters will
   *                         be in uppercase.
   * @return The current checksum value.
   */
  virtual wxString getValue(const bool hexInUpperCase = false) const = 0;
  
  /**
   * Updates the checksum with specified array of bytes.
   *
   * @param  buf  The byte array to update the checksum with.
   * @param  len  The number of bytes to use for the update.
   */
  virtual void update(const wxByte* buf, unsigned int len) = 0;
};
//---------------------------------------------------------------------------

/// A dynamic array of checksums.
WX_DEFINE_ARRAY(Checksum*, ArrayChecksum);
//---------------------------------------------------------------------------

#endif  // INC_CHECKSUM_HPP
