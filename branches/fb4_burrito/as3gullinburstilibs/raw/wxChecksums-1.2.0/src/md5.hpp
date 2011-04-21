/*
 * MD5
 * Written by Julien Couot.
 * Original C version written by Ulrich Drepper.
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
 * \file md5.hpp
 * Compute md5.
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
 * Computes the MD5 checksum from a byte stream.
 *
 * This class is a rewrite in C++ of the md5 checksum computing algorithm
 * present in the GNU coreutils. Please see the <A HREF="http://www.gnu.org/">
 * GNU projet website</A> for more informations.
 *
 * Using this class in very simple:<BR>
 * Use the @link update(const wxByte*, unsigned int) update @endlink
 * method to provide to the class the bytes for computing the checksum.
 * 
 * The MD5 checksum value can be gotten by two ways:
 * <UL>
 * <LI>The @link getValue(void*) const getValue @endlink method which puts the
 *     MD5 checksum value in an array of 16 bytes.</LI>
 * <LI>The @link getValue(const bool) const getValue @endlink method which
 *     returns the MD5 checksum value in a string.</LI>
 * </UL>
 * The MD5 checksum computing can be reseted by the @link reset() reset @endlink
 * method.
 */
class MD5 : public Checksum
{
 protected:
  // Change the following types if needed.
//  typedef  unsigned long      md5_uint32_t;  ///< unsigned 4 bytes integer.
//  typedef  unsigned short     md5_uint16_t;  ///< unsigned 2 bytes integer.
//  typedef  unsigned char      md5_uint8_t;   ///< unsigned 1 byte integer.
//  typedef  unsigned long int  md5_uintptr_t; ///< unsigned 4 bytes integer.
  
  // State of computation between the single steps.
  wxUint32 A_;  ///< First part of the state of computation.
  wxUint32 B_;  ///< Second part of the state of computation.
  wxUint32 C_;  ///< Third part of the state of computation.
  wxUint32 D_;  ///< Fourth part of the state of computation.

  wxUint32 total[2];     ///< Number of bits mod 2^64.
  wxUint32 buflen;       ///< Current size of the input buffer.
  wxByte   ibuffer[128]; ///< Input buffer.

  /**
   * The bytes used to pad the buffer to the next 64-byte boundary (RFC 1321,
   * 3.1: Step 1).
   */
  static const wxByte fillbuf[64];

 public:
  /**
   * Default constructor.
   */
  MD5();

  /**
   * Resets the MD5 checksum to initial state of computation.
   */
  void reset();

  /**
   * Returns the MD5 checksum value in the first 16 bytes of the given adress.
   *
   * @param   buffer  The buffer where the MD5 checksum value will be stored.
   * @return  The adress of the buffer.
   * @remarks On some systems it is required that <CODE>buffer</CODE> is
   *          correctly aligned for a 32 bits value.
   * @remarks The memory for the 16 bytes must have been allocated before calling
   *          this method.
   */
  void* getValue(void* buffer) const;

  /**
   * Returns the MD5 checksum value in a string.
   *
   * @param  hexInUpperCase  If <CODE>true</CODE> the hexadecimal letters will
   *                         be in uppercase.
   * @return The current checksum value.
   */
  wxString getValue(const bool hexInUpperCase = false) const;

  /**
   * Updates the MD5 checksum with specified array of bytes.
   *
   * @param  buf  The byte array to update the MD5 checksum with.
   * @param  len  The number of bytes to use for the update.
   */
  void update(const wxByte* buf, unsigned int len);

 protected:
  /**
   * Process the remaining bytes in the internal buffer and the usual
   * prolog according to the standard.
   */
  void finish();

  /**
   * Process <i>len</i> bytes of <i>buf</i>, accumulating context in
   * <i>this</i>.
   * It is assumed that <CODE>len % 64 == 0</CODE>.
   *
   * @param  buf  The buffer to process.
   * @param  len  The number of bytes to process.
   */
  void process_block(const void* buf, size_t len);
};
//---------------------------------------------------------------------------
