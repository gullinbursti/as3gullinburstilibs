/*
 * CRC32
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
 * \file crc32.hpp
 * Compute crc32.
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
#include "checksum.hpp"
//---------------------------------------------------------------------------


/**
 * Computes the CRC-32 from a byte stream.
 *
 * This class is writen with the code found in
 * <A HREF="http://www.fodder.org/cksfv/">cksfv</A> and
 * <A HREF="http://www.gzip.org/zlib/">zlib</A> code.
 *
 * Using this class in very simple:<BR>
 * Use the @link update(const wxByte* buf, unsigned int len) update @endlink
 * method to provide to the class the bytes for computing the checksum.
 * 
 * The CRC-32 checksum value can be gotten by the @link getValue(const bool) const
 * getValue @endlink method which puts the CRC32 checksum value in a
 * unsigned 32 bits integer.
 *
 * The CRC32 checksum computing can be reseted by the @link reset() reset
 * @endlink method.
 */
class CRC32 : public Checksum
{
 protected:
  /// Table used to compute the CRC32 value.
  static const wxUint32 crc_table[256];

  /// The current CRC32 value.
  wxUint32 crc32;

 public:
  /**
   * Default constructor.
   */
  CRC32();

  /**
   * Resets the CRC32 to initial value.
   */
  void reset();

  /**
   * Returns the CRC32 value.
   *
   * @return The current checksum value.
   */
  wxUint32 getUint32Value() const;

  /**
   * Returns the CRC32 value in a string.
   *
   * @param  hexInUpperCase  If <CODE>true</CODE> the hexadecimal letters will
   *                         be in uppercase.
   * @return The current CRC32 value.
   */
  wxString getValue(const bool hexInUpperCase = false) const;

  /**
   * Updates the CRC32 with specified array of bytes.
   *
   * @param  buf  The byte array to update the CRC32 with.
   * @param  len  The number of bytes to use for the update.
   */
  void update(const wxByte* buf, unsigned int len);
};
//---------------------------------------------------------------------------
