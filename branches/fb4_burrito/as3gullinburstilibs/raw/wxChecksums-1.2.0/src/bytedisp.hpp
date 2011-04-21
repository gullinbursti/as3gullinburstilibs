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
 * \file bytedisp.hpp
 * Smart byte displayer.
 */

#ifndef INC_BYTEDISP_HPP
#define INC_BYTEDISP_HPP

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
 * Displays a byte size in a range of [1,1024[ with a suffix.
 *
 * <B>Important:</B> Call initStatic() (only once is needed) before using this
 * class. It is needed for i18n.
 *
 * The suffix could be:
 * <table border="1">
 * <tr><td>Name</td><td>Abbr</td><td>Factor</td></tr>
 * <tr><td>kilo</td><td>K</td><td>2<sup>10</sup> = 1024</td></tr>
 * <tr><td>mega</td><td>M</td><td>2<sup>20</sup> = 1&nbsp;048&nbsp;576</td></tr>
 * <tr><td>giga</td><td>G</td><td>2<sup>30</sup> = 1&nbsp;073&nbsp;741&nbsp;824</td></tr>
 * <tr><td>tera</td><td>T</td><td>2<sup>40</sup> = 1&nbsp;099&nbsp;511&nbsp;627&nbsp;776</td></tr>
 * <tr><td>peta</td><td>P</td><td>2<sup>50</sup> = 1&nbsp;125&nbsp;899&nbsp;906&nbsp;842&nbsp;624</td></tr>
 * <tr><td>exa</td><td>E</td><td>2<sup>60</sup> = 1&nbsp;152&nbsp;921&nbsp;504&nbsp;606&nbsp;846&nbsp;976</td></tr>
 * <tr><td>zetta</td><td>Z</td><td>2<sup>70</sup> = 1&nbsp;180&nbsp;591&nbsp;620&nbsp;717&nbsp;411&nbsp;303&nbsp;424</td></tr>
 * <tr><td>yotta</td><td>Y</td><td>2<sup>80</sup> = 1&nbsp;208&nbsp;925&nbsp;819&nbsp;614&nbsp;629&nbsp;174&nbsp;706&nbsp;176</td></tr>
 * </table>
 * Source: <A HREF="http://www.wikipedia.org/">Wikipedia</A>.
 *
 * This class manages only positives integers and should not be used for precise
 * work with sizes since it uses internally doubles values. Use it only for
 * display sizes in xB.
 */
class BytesDisplayer
{
 public:
  /// List of the units.
  enum Units
  {
    byte = 0,
    kilo,
    mega,
    giga,
    tera,
    peta,
    exa,
    zetta,
    yotta
  };

  /// Units format types
  enum UnitsFormat
  {
    None,
    Short,
    Long
  };

 protected:
  // These static arrays should be work with the Units enum.
  static wxString long_units[9];  ///< Name of the units (long format).
  static wxString short_units[9]; ///< Name of the units (short format).

  /// Internal type of size values.
  typedef  double  bytesize_type;

  bytesize_type size;  ///< Value of the size.
  Units  unit;  ///< Current unit.

  // Clones the source instance in this instance.
  void clone(const BytesDisplayer& source);

  // Normalizes the value.
  void normalize();

 public:
  // Initializes the static part of the class.
  static void initStatic();

  // Constructor.
  BytesDisplayer();

  // Copy constructor.
  BytesDisplayer(const BytesDisplayer& source);

  // Assignment operator.
  BytesDisplayer& operator=(const BytesDisplayer& source);

  // Assignment operator.
  BytesDisplayer& operator=(const double value);
  
  // Assignment operator.
  BytesDisplayer& operator=(const long value);

  // Assignment operator.
  BytesDisplayer& operator=(const unsigned long value);

  // Constructor with a double size.
  BytesDisplayer(const double value);

  // Constructor with a long size.
  BytesDisplayer(const long value);

  // Constructor with a long size.
  BytesDisplayer(const unsigned long value);

  // Operator +=
  BytesDisplayer& operator+=(const BytesDisplayer& a);
  
  // Gets the size as a double.
  double toDouble(const Units u = byte) const;
  
  // Gets the size as a string.
  wxString toString(const Units u, const UnitsFormat uf = Short) const;

  // Gets the size as a string.
  wxString toString(const UnitsFormat uf = Short) const;
};
//---------------------------------------------------------------------------

#endif  // INC_BYTEDISP_HPP
