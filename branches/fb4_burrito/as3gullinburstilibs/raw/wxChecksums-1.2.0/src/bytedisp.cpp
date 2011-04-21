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
 * \file bytedisp.cpp
 * Smart byte displayer.
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

#include "bytedisp.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------

/// The C++ standard namespace.
using namespace std;


// Static attributes of the BytesDisplayer class
wxString BytesDisplayer::long_units[9];
wxString BytesDisplayer::short_units[9];

/*
// Don't work with i18n

const wxString BytesDisplayer::long_units[] = { _("byte"), _("kilobyte"),
                                                _("megabyte"), _("gigabyte"),
                                                _("terabyte"), _("petabyte"),
                                                _("exabyte"), _("zettabyte"),
                                                _("yottabyte") };
const wxString BytesDisplayer::short_units[] = { _("B"), _("KB"),
                                                _("MB"), _("GB"),
                                                _("TB"), _("PB"),
                                                _("EB"), _("ZB"),
                                                _("YB") };*/
//---------------------------------------------------------------------------


/**
 * Initializes the static part of the class.
 *
 * Please call this function before the first use of this class.
 */
void BytesDisplayer::initStatic()
{
  long_units[0] = _("byte");
  long_units[1] = _("kilobyte");
  long_units[2] = _("megabyte");
  long_units[3] = _("gigabyte");
  long_units[4] = _("terabyte");
  long_units[5] = _("petabyte");
  long_units[6] = _("exabyte");
  long_units[7] = _("zettabyte");
  long_units[8] = _("yottabyte");
  short_units[0] = _("B");
  short_units[1] = _("KB");
  short_units[2] = _("MB");
  short_units[3] = _("GB");
  short_units[4] = _("TB");
  short_units[5] = _("PB");
  short_units[6] = _("EB");
  short_units[7] = _("ZB");
  short_units[8] = _("YB");
}
//---------------------------------------------------------------------------


/**
 * Default constructor.
 */
BytesDisplayer::BytesDisplayer()
{
  size = 0.0;
  unit = byte;
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void BytesDisplayer::clone(const BytesDisplayer& source)
{
  if (this != &source)
  {
    this->size = source.size;
    this->unit = source.unit;
  }
}
//---------------------------------------------------------------------------


/**
 * Copy constructor.
 *
 * @param  source  Source instance.
 */
BytesDisplayer::BytesDisplayer(const BytesDisplayer& source)
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
BytesDisplayer& BytesDisplayer::operator=(const BytesDisplayer& source)
{
  clone(source);
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  value  The size.
 * @return A reference on the instance.
 */
BytesDisplayer& BytesDisplayer::operator=(const double value)
{
  size = static_cast<bytesize_type>(value);
  unit = byte;
  normalize();
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  value  The size.
 * @return A reference on the instance.
 */
BytesDisplayer& BytesDisplayer::operator=(const long value)
{
  size = static_cast<bytesize_type>(value);
  unit = byte;
  normalize();
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  value  The size.
 * @return A reference on the instance.
 */
BytesDisplayer& BytesDisplayer::operator=(const unsigned long value)
{
  size = static_cast<bytesize_type>(value);
  unit = byte;
  normalize();
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Constructor with a double type.
 *
 * @param  value  The size.
 */
BytesDisplayer::BytesDisplayer(const double value)
{
  size = static_cast<bytesize_type>(value);
  unit = byte;
  normalize();
}
//---------------------------------------------------------------------------


/**
 * Constructor with a long integer type.
 *
 * @param  value  The size.
 */
BytesDisplayer::BytesDisplayer(const long value)
{
  size = static_cast<bytesize_type>(value);
  unit = byte;
  normalize();
}
//---------------------------------------------------------------------------


/**
 * Constructor with a long integer type.
 *
 * @param  value  The size.
 */
BytesDisplayer::BytesDisplayer(const unsigned long value)
{
  size = static_cast<bytesize_type>(value);
  unit = byte;
  normalize();
}
//---------------------------------------------------------------------------


/**
 * Normalizes the value.
 *
 * After calling this function:
 * - If the size is <CODE>&lt; 0</CODE> then the size equals to <CODE>0</CODE>.
 * - If the size is bigger than <CODE>1024</CODE> then the size is bring back
 *   to the interval [1,1024[.
 * - If the size is smaller than <CODE>1</CODE> then the size is bring back
 *   to the interval [1,1024[.
 */
void BytesDisplayer::normalize()
{
  if (size < 0.0)
  {
    size = 0.0;
    unit = byte;
  }
  else if (size >= 1024.0)
  {
    while (size >= 1024.0 && unit != yotta)
    {
      size /= 1024.0;
      unit = static_cast<Units>(static_cast<int>(unit) + 1);
    }
  }
  else if (size < 1.0)
  {
    while (size < 1 && unit != byte)
    {
      size *= 1024.0;
      unit = static_cast<Units>(static_cast<int>(unit) - 1);
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Operator +=
 *
 * @param  a  The value to add.
 * @return A reference on the instance.
 */
BytesDisplayer& BytesDisplayer::operator+=(const BytesDisplayer& a)
{
  bytesize_type val = a.size;
  Units uval = a.unit;
  int direction = (static_cast<int>(unit) < static_cast<int>(uval)) ? -1 : 1;

  while (uval != unit)
  {
    if (direction == -1)
      val *= 1024.0;
    else
      val /= 1024.0;
    uval = static_cast<Units>(static_cast<int>(uval) + direction);
  }

  size += val;
  normalize();

  return *this;
}
//---------------------------------------------------------------------------


/**
 * Gets the size as a double.
 *
 * @param  u   Unit in which the size must be returned.
 * @return  The size as a double.
 */
double BytesDisplayer::toDouble(const Units u) const
{
  double val = static_cast<double>(size);
  Units uval = unit;
  int   direction = (static_cast<int>(u) < static_cast<int>(uval)) ? -1 : 1;
  
  while (uval != u)
  {
    if (direction == -1)
      val *= 1024.0;
    else
      val /= 1024.0;
    uval = static_cast<Units>(static_cast<int>(uval) + direction);
  }

  return val;
}
//---------------------------------------------------------------------------

  
/**
 * Gets the size as a string.
 *
 * @param  u   Unit in which the size must be returned.
 * @param  uf  Format of the unit suffix.
 * @return The size as a string.
 */
wxString BytesDisplayer::toString(const Units u, const UnitsFormat uf) const
{
  double val = toDouble(u);
  wxString res = wxString::Format(wxT("%0.2f"), val);
  switch (uf)
  {
    case None :
      break;
    case Long :
      res += wxT(' ') + long_units[static_cast<int>(u)];
      if (val != 0.0 && val != 1.0)
        res += _("s");
      break;
    default :
      res += wxT(' ') + short_units[static_cast<int>(u)];
  }
  
  return res;
}
//---------------------------------------------------------------------------


/**
 * Gets the size as a string.
 *
 * @param  uf  Format of the unit suffix.
 * @return The size as a string.
 */
wxString BytesDisplayer::toString(const UnitsFormat uf) const
{
  return toString(unit, uf);
}
//---------------------------------------------------------------------------
