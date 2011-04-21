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
 * \file md5.cpp
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

#include "md5.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------

/// The C++ standard namespace.
using namespace std;
//---------------------------------------------------------------------------


// This array contains the bytes used to pad the buffer to the next
// 64-byte boundary.  (RFC 1321, 3.1: Step 1)
const wxByte MD5::fillbuf[64] = {
  0x80, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
//---------------------------------------------------------------------------


/*
 * Default constructor.
 */
MD5::MD5()
{
  reset();
}
//---------------------------------------------------------------------------


/*
 * Resets the MD5 checksum to initial value.
 */
void MD5::reset()
{
  A_ = 0x67452301;
  B_ = 0xefcdab89;
  C_ = 0x98badcfe;
  D_ = 0x10325476;

  total[0] = 0;
  total[1] = 0;
  buflen = 0;
}
//---------------------------------------------------------------------------


/*
 * Process the remaining bytes in the internal buffer and the usual
 * prolog according to the standard.
 */
void MD5::finish()
{
  // Take yet unprocessed bytes into account.
  wxUint32 bytes = buflen;
  size_t pad;

  // Now count remaining bytes.
  total[0] += bytes;
  if (total[0] < bytes)
    ++total[1];

  pad = bytes >= 56 ? 64 + 56 - bytes : 56 - bytes;
  memcpy(&ibuffer[bytes], fillbuf, pad);

  // Put the 64-bit file length in *bits* at the end of the buffer.
  *reinterpret_cast<wxUint32*>(&ibuffer[bytes + pad]) = wxUINT32_SWAP_ON_BE(total[0] << 3);
  *reinterpret_cast<wxUint32*>(&ibuffer[bytes + pad + 4]) = wxUINT32_SWAP_ON_BE((total[1] << 3) | (total[0] >> 29));

  /* Process last bytes.  */
  process_block(ibuffer, bytes + pad + 8);
}
//---------------------------------------------------------------------------


/*
 * Updates the MD5 checksum with specified array of bytes.
 */
void MD5::update(const wxByte* buf, unsigned int len)
{
  // When we already have some bits in our internal buffer concatenate both
  // inputs first.
  if (buflen != 0)
  {
    size_t left_over = buflen;
    size_t add = (128 - left_over > len) ? len : 128 - left_over;

    memcpy(&ibuffer[left_over], buf, add);
    buflen += add;

    if (buflen > 64)
	{
	  process_block(ibuffer, buflen & ~63);

	  buflen &= 63;
	  // The regions in the following copy operation cannot overlap.
	  memcpy(ibuffer, &ibuffer[(left_over + add) & ~63], buflen);
	}

    buf = static_cast<const wxByte*>(buf) + add;
    len -= add;
  }

  /* Process available complete blocks.  */
  if (len >= 64)
  {
    #if !_STRING_ARCH_unaligned
    // To check alignment gcc has an appropriate operator.  Other compilers
    // don't.
      #if __GNUC__ >= 2
        #define UNALIGNED_P(p) (((wxUint32) p) % __alignof__(wxUint32) != 0)
      #else
        #define UNALIGNED_P(p) (((wxUint32) p) % sizeof(wxUint32) != 0)
      #endif  // __GNUC__ >= 2

    if (UNALIGNED_P(buf))
      while (len > 64)
      {
        process_block(memcpy(ibuffer, buf, 64), 64);
        buf = static_cast<const wxByte*>(buf) + 64;
        len -= 64;
      }
    else
    #endif // !_STRING_ARCH_unaligned
    {
      process_block(buf, len & ~63);
      buf = static_cast<const wxByte*>(buf) + (len & ~63);
      len &= 63;
    }
  }

  // Move remaining bytes in internal buffer.
  if (len > 0)
  {
    size_t left_over = buflen;

    memcpy(&ibuffer[left_over], buf, len);
    left_over += len;
    if (left_over >= 64)
    {
      process_block(ibuffer, 64);
      left_over -= 64;
      memcpy(ibuffer, &ibuffer[64], left_over);
    }
    buflen = left_over;
  }
}
//---------------------------------------------------------------------------


// These are the four functions used in the four steps of the MD5 algorithm
// and defined in the RFC 1321.  The first function is a little bit optimized
// (as found in Colin Plumbs public domain implementation).
// #define FF(b, c, d) ((b & c) | (~b & d))
#define FF(b, c, d) (d ^ (b & (c ^ d)))  ///< First fonction of the MD5 algorithm.
#define FG(b, c, d) FF (d, b, c)         ///< Second fonction of the MD5 algorithm.
#define FH(b, c, d) (b ^ c ^ d)          ///< Third fonction of the MD5 algorithm.
#define FI(b, c, d) (c ^ (b | ~d))       ///< Fourth fonction of the MD5 algorithm.

// The following is from gnupg-1.0.2's cipher/bithelp.h.
/// Rotate a 32 bit integer by n bytes.
#define rol(x,n) ( ((x) << (n)) | ((x) >> (32-(n))) )

/*
 * Process [len] bytes of [buf], accumulating context in [this].
 * It is assumed that len % 64 == 0.
 */
void MD5::process_block(const void* buf, size_t len)
{
  wxUint32 correct_words[16];
  const wxUint32* words = static_cast<const wxUint32*>(buf);
  size_t nwords = len / sizeof(wxUint32);
  const wxUint32* endp = words + nwords;
  wxUint32 A = A_;
  wxUint32 B = B_;
  wxUint32 C = C_;
  wxUint32 D = D_;
  
  // First increment the byte count.  RFC 1321 specifies the possible length of
  // the file up to 2^64 bits.  Here we only compute the number of bytes.  Do a
  // double word increment.
  total[0] += len;
  if (total[0] < len)
    ++total[1];

  // Process all bytes in the buffer with 64 bytes in each round of the loop.
  while (words < endp)
  {
    wxUint32* cwp = correct_words;
    wxUint32  A_save = A;
    wxUint32  B_save = B;
    wxUint32  C_save = C;
    wxUint32  D_save = D;

    // First round: using the given function, the context and a constant the
    // next context is computed.  Because the algorithms processing unit is a
    // 32-bit word and it is determined to work on words in little endian byte
    // order we perhaps have to change the byte order before the computation.
    // To reduce the work for the next steps we store the swapped words in the
    // array CORRECT_WORDS.
    #define OP(a, b, c, d, s, T) \
            do \
            { \
              a += FF(b, c, d) + (*cwp++ = wxUINT32_SWAP_ON_BE(*words)) + T; \
              ++words; \
              a = rol(a, s); \
              a += b; \
            } \
            while (0)
    
    // Before we start, one word to the strange constants.
	// They are defined in RFC 1321 as
    //
	// T[i] = (int) (4294967296.0 * fabs (sin (i))), i=1..64, or
    // perl -e 'foreach(1..64){printf "0x%08x\n", int (4294967296 * abs (sin $_))}'

    // Round 1.
    OP(A, B, C, D,  7, 0xd76aa478);
    OP(D, A, B, C, 12, 0xe8c7b756);
    OP(C, D, A, B, 17, 0x242070db);
    OP(B, C, D, A, 22, 0xc1bdceee);
    OP(A, B, C, D,  7, 0xf57c0faf);
    OP(D, A, B, C, 12, 0x4787c62a);
    OP(C, D, A, B, 17, 0xa8304613);
    OP(B, C, D, A, 22, 0xfd469501);
    OP(A, B, C, D,  7, 0x698098d8);
    OP(D, A, B, C, 12, 0x8b44f7af);
    OP(C, D, A, B, 17, 0xffff5bb1);
    OP(B, C, D, A, 22, 0x895cd7be);
    OP(A, B, C, D,  7, 0x6b901122);
    OP(D, A, B, C, 12, 0xfd987193);
    OP(C, D, A, B, 17, 0xa679438e);
    OP(B, C, D, A, 22, 0x49b40821);

    // For the second to fourth round we have the possibly swapped words
    // in CORRECT_WORDS.  Redefine the macro to take an additional first
    // argument specifying the function to use.
    #undef OP
    /// Operation for computing the MD5 checksum.
    #define OP(f, a, b, c, d, k, s, T) \
            do \
            { \
              a += f (b, c, d) + correct_words[k] + T; \
              a = rol (a, s); \
              a += b; \
            } \
            while (0)

    // Round 2.
    OP(FG, A, B, C, D,  1,  5, 0xf61e2562);
    OP(FG, D, A, B, C,  6,  9, 0xc040b340);
    OP(FG, C, D, A, B, 11, 14, 0x265e5a51);
    OP(FG, B, C, D, A,  0, 20, 0xe9b6c7aa);
    OP(FG, A, B, C, D,  5,  5, 0xd62f105d);
    OP(FG, D, A, B, C, 10,  9, 0x02441453);
    OP(FG, C, D, A, B, 15, 14, 0xd8a1e681);
    OP(FG, B, C, D, A,  4, 20, 0xe7d3fbc8);
    OP(FG, A, B, C, D,  9,  5, 0x21e1cde6);
    OP(FG, D, A, B, C, 14,  9, 0xc33707d6);
    OP(FG, C, D, A, B,  3, 14, 0xf4d50d87);
    OP(FG, B, C, D, A,  8, 20, 0x455a14ed);
    OP(FG, A, B, C, D, 13,  5, 0xa9e3e905);
    OP(FG, D, A, B, C,  2,  9, 0xfcefa3f8);
    OP(FG, C, D, A, B,  7, 14, 0x676f02d9);
    OP(FG, B, C, D, A, 12, 20, 0x8d2a4c8a);

    // Round 3.
    OP(FH, A, B, C, D,  5,  4, 0xfffa3942);
    OP(FH, D, A, B, C,  8, 11, 0x8771f681);
    OP(FH, C, D, A, B, 11, 16, 0x6d9d6122);
    OP(FH, B, C, D, A, 14, 23, 0xfde5380c);
    OP(FH, A, B, C, D,  1,  4, 0xa4beea44);
    OP(FH, D, A, B, C,  4, 11, 0x4bdecfa9);
    OP(FH, C, D, A, B,  7, 16, 0xf6bb4b60);
    OP(FH, B, C, D, A, 10, 23, 0xbebfbc70);
    OP(FH, A, B, C, D, 13,  4, 0x289b7ec6);
    OP(FH, D, A, B, C,  0, 11, 0xeaa127fa);
    OP(FH, C, D, A, B,  3, 16, 0xd4ef3085);
    OP(FH, B, C, D, A,  6, 23, 0x04881d05);
    OP(FH, A, B, C, D,  9,  4, 0xd9d4d039);
    OP(FH, D, A, B, C, 12, 11, 0xe6db99e5);
    OP(FH, C, D, A, B, 15, 16, 0x1fa27cf8);
    OP(FH, B, C, D, A,  2, 23, 0xc4ac5665);

    // Round 4.
    OP(FI, A, B, C, D,  0,  6, 0xf4292244);
    OP(FI, D, A, B, C,  7, 10, 0x432aff97);
    OP(FI, C, D, A, B, 14, 15, 0xab9423a7);
    OP(FI, B, C, D, A,  5, 21, 0xfc93a039);
    OP(FI, A, B, C, D, 12,  6, 0x655b59c3);
    OP(FI, D, A, B, C,  3, 10, 0x8f0ccc92);
    OP(FI, C, D, A, B, 10, 15, 0xffeff47d);
    OP(FI, B, C, D, A,  1, 21, 0x85845dd1);
    OP(FI, A, B, C, D,  8,  6, 0x6fa87e4f);
    OP(FI, D, A, B, C, 15, 10, 0xfe2ce6e0);
    OP(FI, C, D, A, B,  6, 15, 0xa3014314);
    OP(FI, B, C, D, A, 13, 21, 0x4e0811a1);
    OP(FI, A, B, C, D,  4,  6, 0xf7537e82);
    OP(FI, D, A, B, C, 11, 10, 0xbd3af235);
    OP(FI, C, D, A, B,  2, 15, 0x2ad7d2bb);
    OP(FI, B, C, D, A,  9, 21, 0xeb86d391);

    // Add the starting values of the context.
    A += A_save;
    B += B_save;
    C += C_save;
    D += D_save;
  }
  
  /* Put checksum in the local context.  */
  A_ = A;
  B_ = B;
  C_ = C;
  D_ = D;
}
//---------------------------------------------------------------------------


/*
 * Returns the MD5 checksum value in the first 16 bytes of the given adress.
 */
void* MD5::getValue(void* buffer) const
{
  MD5 md5(*this);
  md5.finish();
  
  (reinterpret_cast<wxUint32*>(buffer))[0] = wxUINT32_SWAP_ON_BE(md5.A_);
  (reinterpret_cast<wxUint32*>(buffer))[1] = wxUINT32_SWAP_ON_BE(md5.B_);
  (reinterpret_cast<wxUint32*>(buffer))[2] = wxUINT32_SWAP_ON_BE(md5.C_);
  (reinterpret_cast<wxUint32*>(buffer))[3] = wxUINT32_SWAP_ON_BE(md5.D_);
  
  return buffer;
}
//---------------------------------------------------------------------------


/*
 * Returns the MD5 checksum value.
 */
wxString MD5::getValue(const bool hexInUpperCase) const
{
  wxByte   b[16];
  wxString s;
  wxString h;
//  char   s[33];
//  char   h[5];
  
  // Sets the pattern for sprintf
  if (hexInUpperCase)
    h = wxT("%02X");
  else
    h = wxT("%02x");

  // Puts the MD5 checksum value in the buffer.
  getValue(b);

  // Puts the MD5 checksum in a string
  for (int i = 0; i < 16; i++)
    s += wxString::Format(h, static_cast<unsigned int>(b[i]));

  return s;
}
//---------------------------------------------------------------------------
