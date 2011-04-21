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
 * \file appprefs.cpp
 * Common preferences for the application.
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

#include <wx/file.h>
#include <wx/filename.h>
#include <wx/config.h>
#include <wx/fileconf.h>
#include <wx/tokenzr.h>
#include <wx/txtstrm.h>

#ifdef __WINDOWS__
#include <windows.h>
#include <shlobj.h>

#if defined(__CYGWIN__) || defined(__MINGW32__)
// My version of Cygwin doesn't know these constants for the SHGetFolderPath
// API call.
#define  SHGFP_TYPE_CURRENT  0
#define  SHGFP_TYPE_DEFAULT  1
#endif  // __CYGWIN__
#endif  // __WINDOWS__

#include "appprefs.hpp"
#include "comdefs.hpp"
#include "cmdlnopt.hpp"
#include "osdep.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------

/// The C++ standard namespace.
using namespace std;


//###########################################################################
// Useful fonctions
//###########################################################################

static wxString addPathSeparatorAtEnd(wxString dirName);
static bool dirExists(const wxString& dirName, bool create);
#if defined(__WINDOWS__)
static wxString getFolderPath(int folder);
#endif // defined(__WINDOWS__)
//---------------------------------------------------------------------------


//###########################################################################
// Preference value members
//###########################################################################


/**
 * Default constructor.
 */
PreferenceValue::PreferenceValue()
{
  _valueType = ptNotDefined;
  _value.valLong = NULL;
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void PreferenceValue::clone(const PreferenceValue& source)
{
  if (this != &source)
  {
    // Cleans up memory.
    cleanup();

    // Copies data from the source instance.
    this->_valueType = source._valueType;
    switch (_valueType)
    {
      case ptLong :
        _value.valLong = new long(*(source._value.valLong));
        break;
      case ptString :
        _value.valString = new wxString(*(source._value.valString));
        break;
      case ptDouble :
        _value.valDouble = new double(*(source._value.valDouble));
        break;
      case ptBoolean :
        _value.valBool = new bool(*(source._value.valBool));
        break;
      case ptRect :
        _value.valRect = new wxRect(*(source._value.valRect));
        break;
      case ptPoint :
        _value.valPoint = new wxPoint(*(source._value.valPoint));
        break;
      case ptSize :
        _value.valSize = new wxSize(*(source._value.valSize));
        break;
      default :
        _value.valLong = NULL;
    }
    this->_cfgKey = source._cfgKey;
  }
}
//---------------------------------------------------------------------------


/**
 * Copy constructor.
 *
 * @param  source  Source instance.
 */
PreferenceValue::PreferenceValue(const PreferenceValue& source)
{
  _valueType = ptNotDefined;
  _value.valLong = NULL;
  clone(source);
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  source  Source instance.
 * @return A reference on the instance.
 */
PreferenceValue& PreferenceValue::operator=(const PreferenceValue& source)
{
  clone(source);
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Constructor with a long integer type.
 *
 * @param  value    The value of long integer type.
 * @param  cfgKey   Corresponding key in the configuration file. Must be empty
 *                  if this item isn't stored in the configuration file.
 * @param  initFromCfgFile  If <CODE>true</CODE> and if a key was given, tries
 *                          first to initialize the value from the configuration
 *                          file.
 */
PreferenceValue::PreferenceValue(const long value, const wxString& cfgKey, const bool initFromCfgFile)
{
  _valueType = ptLong;
  _value.valLong = new long(value);
  _cfgKey = cfgKey;
  
  if (!cfgKey.empty() && initFromCfgFile)
    wxConfig::Get()->Read(cfgKey, _value.valLong);
}
//---------------------------------------------------------------------------


/**
 * Constructor with a string type.
 *
 * @param  value    The value of string type.
 * @param  cfgKey   Corresponding key in the configuration file. Must be empty
 *                  if this item isn't stored in the configuration file.
 * @param  initFromCfgFile  If <CODE>true</CODE> and if a key was given, tries
 *                          first to initialize the value from the configuration
 *                          file. */
PreferenceValue::PreferenceValue(const wxString& value, const wxString& cfgKey, const bool initFromCfgFile)
{
  _valueType = ptString;
  _value.valString = new wxString(value);
  _cfgKey = cfgKey;

  if (!cfgKey.empty() && initFromCfgFile)
    wxConfig::Get()->Read(cfgKey, _value.valString);
}
//---------------------------------------------------------------------------


/**
 * Constructor with a double type.
 *
 * @param  value    The value of double type.
 * @param  cfgKey   Corresponding key in the configuration file. Must be empty
 *                  if this item isn't stored in the configuration file.
 * @param  initFromCfgFile  If <CODE>true</CODE> and if a key was given, tries
 *                          first to initialize the value from the configuration
 *                          file. */
PreferenceValue::PreferenceValue(const double value, const wxString& cfgKey, const bool initFromCfgFile)
{
  _valueType = ptDouble;
  _value.valDouble = new double(value);
  _cfgKey = cfgKey;

  if (!cfgKey.empty() && initFromCfgFile)
    wxConfig::Get()->Read(cfgKey, _value.valDouble);
}
//---------------------------------------------------------------------------


/**
 * Constructor with a boolean type.
 *
 * @param  value    The value of boolean type.
 * @param  cfgKey   Corresponding key in the configuration file. Must be empty
 *                  if this item isn't stored in the configuration file.
 * @param  initFromCfgFile  If <CODE>true</CODE> and if a key was given, tries
 *                          first to initialize the value from the configuration
 *                          file. */
PreferenceValue::PreferenceValue(const bool value, const wxString& cfgKey, const bool initFromCfgFile)
{
  _valueType = ptBoolean;
  _value.valBool = new bool(value);
  _cfgKey = cfgKey;

  if (!cfgKey.empty() && initFromCfgFile)
    wxConfig::Get()->Read(cfgKey, _value.valBool);
}
//---------------------------------------------------------------------------


/**
 * Constructor with a wxRect type.
 *
 * @param  value    The value of wxRect type.
 * @param  cfgKey   Corresponding key in the configuration file. Must be empty
 *                  if this item isn't stored in the configuration file.
 * @param  initFromCfgFile  If <CODE>true</CODE> and if a key was given, tries
 *                          first to initialize the value from the configuration
 *                          file. */
PreferenceValue::PreferenceValue(const wxRect& value, const wxString& cfgKey, const bool initFromCfgFile)
{
  _valueType = ptRect;
  _value.valRect = new wxRect(value);
  _cfgKey = cfgKey;

  if (!cfgKey.empty() && initFromCfgFile)
    read(cfgKey, _value.valRect);
}
//---------------------------------------------------------------------------


/**
 * Constructor with a wxPoint type.
 *
 * @param  value    The value of wxPoint type.
 * @param  cfgKey   Corresponding key in the configuration file. Must be empty
 *                  if this item isn't stored in the configuration file.
 * @param  initFromCfgFile  If <CODE>true</CODE> and if a key was given, tries
 *                          first to initialize the value from the configuration
 *                          file. */
PreferenceValue::PreferenceValue(const wxPoint& value, const wxString& cfgKey, const bool initFromCfgFile)
{
  _valueType = ptPoint;
  _value.valPoint = new wxPoint(value);
  _cfgKey = cfgKey;

  if (!cfgKey.empty() && initFromCfgFile)
    read(cfgKey, _value.valPoint);
}
//---------------------------------------------------------------------------


/**
 * Constructor with a wxSize type.
 *
 * @param  value    The value of wxSize type.
 * @param  cfgKey   Corresponding key in the configuration file. Must be empty
 *                  if this item isn't stored in the configuration file.
 * @param  initFromCfgFile  If <CODE>true</CODE> and if a key was given, tries
 *                          first to initialize the value from the configuration
 *                          file. */
PreferenceValue::PreferenceValue(const wxSize& value, const wxString& cfgKey, const bool initFromCfgFile)
{
  _valueType = ptSize;
  _value.valSize = new wxSize(value);
  _cfgKey = cfgKey;

  if (!cfgKey.empty() && initFromCfgFile)
    read(cfgKey, _value.valSize);
}
//---------------------------------------------------------------------------


/**
 * Destructor.
 */
PreferenceValue::~PreferenceValue()
{
  cleanup();
}
//---------------------------------------------------------------------------


/**
 * Cleans up the memory.
 */
void PreferenceValue::cleanup()
{
  switch (_valueType)
  {
    case ptLong :
      delete _value.valLong;
      break;
    case ptString :
      delete _value.valString;
      break;
    case ptDouble :
      delete _value.valDouble;
      break;
    case ptBoolean :
      delete _value.valBool;
      break;
    case ptRect :
      delete _value.valRect;
      break;
    case ptPoint :
      delete _value.valPoint;
      break;
    case ptSize :
      delete _value.valSize;
      break;
  }
  _valueType = ptNotDefined;
}
//---------------------------------------------------------------------------


/**
 * Gets the key of the preference in the configuration file.
 *
 * @return The key of the preference in the configuration file or an empty
 *         string if there is no key.
 */
wxString PreferenceValue::getConfigKey() const
{
  return _cfgKey;
}
//---------------------------------------------------------------------------


/**
 * Gets a long integer value.
 *
 * @param  value  A long integer where the preference value will be stored.
 * @return <CODE>true</CODE> if the preference value is an long integer,
 *         <CODE>false</CODE> otherwise.
 */
bool PreferenceValue::get(long& value) const
{
  if (_valueType == ptLong)
  {
    value = *(_value.valLong);
    return true;
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Sets a long integer value.
 *
 * @param  newValue  The new value of the preference. If the preference has a
 *                   corresponding key in the configuration file, the value
 *                   will be written in the configuration file.
 * @return <CODE>true</CODE> if the type of the preference is a long integer and
 *         if the value has been successfully written in the configuration file
 *         (if needed), <CODE>false</CODE> otherwise.
 * @remark The configuration file is given by the static method
 *         <CODE>wxConfig::Get()</CODE>.
 */
bool PreferenceValue::set(const long newValue)
{
  if (_valueType == ptLong)
  {
    *(_value.valLong) = newValue;
    if (_cfgKey.empty())
      return true;
    else
      return wxConfig::Get()->Write(_cfgKey, newValue);
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Gets a string value.
 *
 * @param  value  A string where the preference value will be stored.
 * @return <CODE>true</CODE> if the preference value is a string,
 *         <CODE>false</CODE> otherwise.
 */
bool PreferenceValue::get(wxString& value) const
{
  if (_valueType == ptString)
  {
    value = *(_value.valString);
    return true;
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Sets a string value.
 *
 * @param  newValue  The new value of the preference. If the preference has a
 *                   corresponding key in the configuration file, the value
 *                   will be written in the configuration file.
 * @return <CODE>true</CODE> if the type of the preference is a string and
 *         if the value has been successfully written in the configuration file
 *         (if needed), <CODE>false</CODE> otherwise.
 * @remark The configuration file is given by the static method
 *         <CODE>wxConfig::Get()</CODE>.
 */
bool PreferenceValue::set(const wxString& newValue)
{
  if (_valueType == ptString)
  {
    *(_value.valString) = newValue;
    if (_cfgKey.empty())
      return true;
    else
      return wxConfig::Get()->Write(_cfgKey, newValue);
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Gets a double value.
 *
 * @param  value  A double where the preference value will be stored.
 * @return <CODE>true</CODE> if the preference value is a double,
 *         <CODE>false</CODE> otherwise.
 */
bool PreferenceValue::get(double& value) const
{
  if (_valueType == ptDouble)
  {
    value = *(_value.valDouble);
    return true;
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Sets a string value.
 *
 * @param  newValue  The new value of the preference. If the preference has a
 *                   corresponding key in the configuration file, the value
 *                   will be written in the configuration file.
 * @return <CODE>true</CODE> if the type of the preference is a double and
 *         if the value has been successfully written in the configuration file
 *         (if needed), <CODE>false</CODE> otherwise.
 * @remark The configuration file is given by the static method
 *         <CODE>wxConfig::Get()</CODE>.
 */
bool PreferenceValue::set(const double newValue)
{
  if (_valueType == ptDouble)
  {
    *(_value.valDouble) = newValue;
    if (_cfgKey.empty())
      return true;
    else
      return wxConfig::Get()->Write(_cfgKey, newValue);
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Gets a boolean value.
 *
 * @param  value  A boolean where the preference value will be stored.
 * @return <CODE>true</CODE> if the preference value is a boolean,
 *         <CODE>false</CODE> otherwise.
 */
bool PreferenceValue::get(bool& value) const
{
  if (_valueType == ptBoolean)
  {
    value = *(_value.valBool);
    return true;
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Sets a boolean value.
 *
 * @param  newValue  The new value of the preference. If the preference has a
 *                   corresponding key in the configuration file, the value
 *                   will be written in the configuration file.
 * @return <CODE>true</CODE> if the type of the preference is a boolean and
 *         if the value has been successfully written in the configuration file
 *         (if needed), <CODE>false</CODE> otherwise.
 * @remark The configuration file is given by the static method
 *         <CODE>wxConfig::Get()</CODE>.
 */
bool PreferenceValue::set(const bool newValue)
{
  if (_valueType == ptBoolean)
  {
    *(_value.valBool) = newValue;
    if (_cfgKey.empty())
      return true;
    else
      return wxConfig::Get()->Write(_cfgKey, newValue);
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Gets a wxRect value.
 *
 * @param  value  A wxRect instance where the preference value will be stored.
 * @return <CODE>true</CODE> if the preference value is a wxRect,
 *         <CODE>false</CODE> otherwise.
 */
bool PreferenceValue::get(wxRect& value) const
{
  if (_valueType == ptRect)
  {
    value = *(_value.valRect);
    return true;
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Sets a wxRect value.
 *
 * @param  newValue  The new value of the preference. If the preference has a
 *                   corresponding key in the configuration file, the value
 *                   will be written in the configuration file.
 * @return <CODE>true</CODE> if the type of the preference is a wxRect and
 *         if the value has been successfully written in the configuration file
 *         (if needed), <CODE>false</CODE> otherwise.
 * @remark The configuration file is given by the static method
 *         <CODE>wxConfig::Get()</CODE>.
 */
bool PreferenceValue::set(const wxRect& newValue)
{
  if (_valueType == ptRect)
  {
    *(_value.valRect) = newValue;
    if (_cfgKey.empty())
      return true;
    else
    {
      wxString r;
      r.Printf(wxT("%d,%d,%d,%d"), newValue.GetX(), newValue.GetY(),
                                   newValue.GetWidth(), newValue.GetHeight());
      return wxConfig::Get()->Write(_cfgKey, r);
    }
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Gets a wxPoint value.
 *
 * @param  value  A wxPoint instance where the preference value will be stored.
 * @return <CODE>true</CODE> if the preference value is a wxPoint,
 *         <CODE>false</CODE> otherwise.
 */
bool PreferenceValue::get(wxPoint& value) const
{
  if (_valueType == ptPoint)
  {
    value = *(_value.valPoint);
    return true;
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Sets a wxPoint value.
 *
 * @param  newValue  The new value of the preference. If the preference has a
 *                   corresponding key in the configuration file, the value
 *                   will be written in the configuration file.
 * @return <CODE>true</CODE> if the type of the preference is a wxPoint and
 *         if the value has been successfully written in the configuration file
 *         (if needed), <CODE>false</CODE> otherwise.
 * @remark The configuration file is given by the static method
 *         <CODE>wxConfig::Get()</CODE>.
 */
bool PreferenceValue::set(const wxPoint& newValue)
{
  if (_valueType == ptPoint)
  {
    *(_value.valPoint) = newValue;
    if (_cfgKey.empty())
      return true;
    else
    {
      wxString r;
      r.Printf(wxT("%d,%d"), newValue.x, newValue.y);
      return wxConfig::Get()->Write(_cfgKey, r);
    }
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Gets a wxSize value.
 *
 * @param  value  A wxSize instance where the preference value will be stored.
 * @return <CODE>true</CODE> if the preference value is a wxSize,
 *         <CODE>false</CODE> otherwise.
 */
bool PreferenceValue::get(wxSize& value) const
{
  if (_valueType == ptSize)
  {
    value = *(_value.valSize);
    return true;
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Sets a wxSize value.
 *
 * @param  newValue  The new value of the preference. If the preference has a
 *                   corresponding key in the configuration file, the value
 *                   will be written in the configuration file.
 * @return <CODE>true</CODE> if the type of the preference is a wxSize and
 *         if the value has been successfully written in the configuration file
 *         (if needed), <CODE>false</CODE> otherwise.
 * @remark The configuration file is given by the static method
 *         <CODE>wxConfig::Get()</CODE>.
 */
bool PreferenceValue::set(const wxSize& newValue)
{
  if (_valueType == ptSize)
  {
    *(_value.valSize) = newValue;
    if (_cfgKey.empty())
      return true;
    else
    {
      wxString r;
      r.Printf(wxT("%d,%d"), newValue.GetWidth(), newValue.GetHeight());
      return wxConfig::Get()->Write(_cfgKey, r);
    }
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/**
 * Reads a wxRect value from the configuration file.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  r    A pointer on the wxRect in which the value will be stored.
 * @param  cfg  A pointer on the configuration instance from which the value
 *              must be read. If <CODE>NULL</CODE>, the global configuration
 *              instance (given by <CODE>wxConfig::Get()</CODE>) will be used.
 * @return <CODE>true</CODE> if the value was read, <CODE>false</CODE>
 *         otherwise. If the key was not found, <CODE>r</CODE> is not changed.
 */
bool PreferenceValue::read(const wxString& key, wxRect* r, wxConfigBase* cfg)
{
  // Gets the configuration object instance.
  wxConfigBase* c = (cfg != NULL) ? cfg : wxConfig::Get();
  
  // Gets the rects from the configuration file.
  wxString res = c->Read(key, wxEmptyString);
  if (res.empty())
    return false;
  else
  {
    // Reads the tokens and converts them in integers values.
    wxStringTokenizer st(res, wxT(","));
    if (st.CountTokens() != 4)
      return false;
    else
    {
      bool ok = true;
      int res[4];
      int i = 0;
      long l;
      while (ok && st.HasMoreTokens())
      {
        wxString s = st.GetNextToken();
        if (s.ToLong(&l))
          res[i++] = static_cast<int>(l);  // res[i++] : ugly !  ^^;
        else
          ok = false;
      }
      if (ok)
      {
        r->SetX(res[0]);
        r->SetY(res[1]);
        r->SetWidth(res[2]);
        r->SetHeight(res[3]);
      }
      return ok;
    }
  }
}
//---------------------------------------------------------------------------  


/**
 * Reads a wxRect value from the configuration file.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  def  The default value to return if the value can't be read.
 * @param  cfg  A pointer on the configuration instance from which the value
 *              must be read. If <CODE>NULL</CODE>, the global configuration
 *              instance (given by <CODE>wxConfig::Get()</CODE>) will be used.
 * @return The value corresponding to the key or the default value if the value
 *         hasn't been read successfully.
 */
wxRect PreferenceValue::read(const wxString& key, const wxRect& def, wxConfigBase* cfg)
{
  wxRect r;
  
  if (read(key, &r, cfg))
    return r;
  else
    return def;
}
//---------------------------------------------------------------------------


/**
 * Reads a wxPoint value from the configuration file.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  r    A pointer on the wxPoint in which the value will be stored.
 * @param  cfg  A pointer on the configuration instance from which the value
 *              must be read. If <CODE>NULL</CODE>, the global configuration
 *              instance (given by <CODE>wxConfig::Get()</CODE>) will be used.
 * @return <CODE>true</CODE> if the value was read, <CODE>false</CODE>
 *         otherwise. If the key was not found, <CODE>r</CODE> is not changed.
 */
bool PreferenceValue::read(const wxString& key, wxPoint* r, wxConfigBase* cfg)
{
  // Gets the configuration object instance.
  wxConfigBase* c = (cfg != NULL) ? cfg : wxConfig::Get();
  
  // Gets the point from the configuration file.
  wxString res = c->Read(key, wxEmptyString);
  if (res.empty())
    return false;
  else
  {
    // Reads the tokens and converts them in integers values.
    wxStringTokenizer st(res, wxT(","));
    if (st.CountTokens() != 2)
      return false;
    else
    {
      bool ok = true;
      int res[2];
      int i = 0;
      long l;
      while (ok && st.HasMoreTokens())
      {
        wxString s = st.GetNextToken();
        if (s.ToLong(&l))
          res[i++] = static_cast<int>(l);  // res[i++] : ugly !  ^^;
        else
          ok = false;
      }
      if (ok)
      {
        r->x = res[0];
        r->y = res[1];
      }
      return ok;
    }
  }
}
//---------------------------------------------------------------------------  


/**
 * Reads a wxPoint value from the configuration file.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  def  The default value to return if the value can't be read.
 * @param  cfg  A pointer on the configuration instance from which the value
 *              must be read. If <CODE>NULL</CODE>, the global configuration
 *              instance (given by <CODE>wxConfig::Get()</CODE>) will be used.
 * @return The value corresponding to the key or the default value if the value
 *         hasn't been read successfully.
 */
wxPoint PreferenceValue::read(const wxString& key, const wxPoint& def, wxConfigBase* cfg)
{
  wxPoint r;
  
  if (read(key, &r, cfg))
    return r;
  else
    return def;
}
//---------------------------------------------------------------------------


/**
 * Reads a wxSize value from the configuration file.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  r    A pointer on the wxSize in which the value will be stored.
 * @param  cfg  A pointer on the configuration instance from which the value
 *              must be read. If <CODE>NULL</CODE>, the global configuration
 *              instance (given by <CODE>wxConfig::Get()</CODE>) will be used.
 * @return <CODE>true</CODE> if the value was read, <CODE>false</CODE>
 *         otherwise. If the key was not found, <CODE>r</CODE> is not changed.
 */
bool PreferenceValue::read(const wxString& key, wxSize* r, wxConfigBase* cfg)
{
  // Gets the configuration object instance.
  wxConfigBase* c = (cfg != NULL) ? cfg : wxConfig::Get();
  
  // Gets the size from the configuration file.
  wxString res = c->Read(key, wxEmptyString);
  if (res.empty())
    return false;
  else
  {
    // Reads the tokens and converts them in integers values.
    wxStringTokenizer st(res, wxT(","));
    if (st.CountTokens() != 2)
      return false;
    else
    {
      bool ok = true;
      int res[2];
      int i = 0;
      long l;
      while (ok && st.HasMoreTokens())
      {
        wxString s = st.GetNextToken();
        if (s.ToLong(&l))
          res[i++] = static_cast<int>(l);  // res[i++] : ugly !  ^^;
        else
          ok = false;
      }
      if (ok)
      {
        r->SetWidth(res[0]);
        r->SetHeight(res[1]);
      }
      return ok;
    }
  }
}
//---------------------------------------------------------------------------  


/**
 * Reads a wxSize value from the configuration file.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  def  The default value to return if the value can't be read.
 * @param  cfg  A pointer on the configuration instance from which the value
 *              must be read. If <CODE>NULL</CODE>, the global configuration
 *              instance (given by <CODE>wxConfig::Get()</CODE>) will be used.
 * @return The value corresponding to the key or the default value if the value
 *         hasn't been read successfully.
 */
wxSize PreferenceValue::read(const wxString& key, const wxSize& def, wxConfigBase* cfg)
{
  wxSize r;
  
  if (read(key, &r, cfg))
    return r;
  else
    return def;
}
//---------------------------------------------------------------------------



//###########################################################################
// AppPrefs members
//###########################################################################

// Static attributes of the AppPrefs class
AppPrefs* AppPrefs::global = NULL;
wxString  AppPrefs::configDir;
wxString  AppPrefs::configFileName;
//---------------------------------------------------------------------------


/**
 * Default constructor.
 */
AppPrefs::AppPrefs()
{
  init();
}
//---------------------------------------------------------------------------


/**
 * Inits the instance.
 *
 * This method creates the preferences that will be valid and associates to them
 * an unique integer key.
 *
 * The preferences values are read from the configuration file if it's
 * available, else default values are used.
 */
void AppPrefs::init()
{
  wxString path;
  
  // GUI preferences
  // Configuration dialog preferencies
  prefs.insert(HashPrefs::value_type(prGUI_CONF_WINDOW_SIZE, PreferenceValue(wxSize(-1, -1), wxT("GUI/ConfigDlg/WindowSize"))));
  prefs.insert(HashPrefs::value_type(prGUI_CONF_SASH_POSITION, PreferenceValue(100L, wxT("GUI/ConfigDlg/SashPosition"))));

  // Main window
  path = wxT("GUI/Main/");
  wxRect r = getDefaultMainWindowRect();
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SAVE_WINDOW_POSITION, PreferenceValue(true, path + wxT("SaveWindowPosition"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SAVE_WINDOW_SIZE, PreferenceValue(true, path + wxT("SaveWindowSize"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_WINDOW_POSITION, PreferenceValue(wxPoint(r.GetX(), r.GetY()), path + wxT("WindowPosition"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_WINDOW_SIZE, PreferenceValue(wxSize(r.GetWidth(), r.GetHeight()), path + wxT("WindowSize"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SHOW_TOOLBAR, PreferenceValue(true, path + wxT("ShowToolbar"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SHOW_STATUSBAR, PreferenceValue(true, path + wxT("ShowStatusbar"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_LAST_DIRECTORY, PreferenceValue(wxString(), path + wxT("LastDirectory"))));

  // Checksums list
  path = wxT("GUI/Main/ChecksumsList/");
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_SAVECOLUMNTOSORT, PreferenceValue(false, path + wxT("SaveColumnToSort"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_COLUMNTOSORT, PreferenceValue(0L, path + wxT("ColumnToSort"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_COLUMNSORTORDER, PreferenceValue(0L, path + wxT("SaveColumnSortOrder"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_SAVECOLUMNSWIDTHS, PreferenceValue(true, path + wxT("SaveColumnsWidths"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_DIRSINABSOLUTEPATH, PreferenceValue(false, path + wxT("DirsInAbsolutePath"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_UPPERCASE, PreferenceValue(true, path + wxT("Uppercase"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_HRULES, PreferenceValue(false, path + wxT("HRules"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_VRULES, PreferenceValue(false, path + wxT("VRules"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_COL_FILENAME_WIDTH, PreferenceValue(150L, path + wxT("ColumnWidthFileName"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_COL_DIRECTORY_WIDTH, PreferenceValue(150L, path + wxT("ColumnWidthDirectory"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_COL_CHECKSUM_WIDTH, PreferenceValue(150L, path + wxT("ColumnWidthChecksumValue"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_COL_STATE_WIDTH, PreferenceValue(150L, path + wxT("ColumnWidthState"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_COL_FIRST, PreferenceValue(0L, path + wxT("ColumnFirst"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_COL_SECOND, PreferenceValue(1L, path + wxT("ColumnSecond"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_COL_THIRD, PreferenceValue(2L, path + wxT("ColumnThird"))));
  prefs.insert(HashPrefs::value_type(prGUI_MAIN_SUMS_COL_FOURTH, PreferenceValue(3L, path + wxT("ColumnFourth"))));

  // New files
  prefs.insert(HashPrefs::value_type(prGUI_NEWFILE_LAST_DIRECTORY, PreferenceValue(wxString(), wxT("GUI/NewFile/LastDirectory"))));
  prefs.insert(HashPrefs::value_type(prGUI_NEWFILE_LAST_FILETYPE, PreferenceValue(0L, wxT("GUI/NewFile/LastFileType"))));

  // GUI behavior
  path = wxT("GUI/Behavior/");
  prefs.insert(HashPrefs::value_type(prGUI_AUTO_CHECK_ON_OPEN, PreferenceValue(true, path + wxT("AutoCheckOnOpen"))));
  prefs.insert(HashPrefs::value_type(prGUI_DLG_SUMUP_CHECK, PreferenceValue(false, path + wxT("DlgSumUpCheck"))));
  prefs.insert(HashPrefs::value_type(prGUI_WARN_ON_INVALID_WHEN_SAVING,PreferenceValue(true, path + wxT("WarnOnInvalidWhenSaving"))));

  // Command line options
  path = wxT("GUI/CommandLine/");
  prefs.insert(HashPrefs::value_type(prGUI_CLN_VERIFY_DONT_SHOW_GUI, PreferenceValue(false, path + wxT("DontShowWhenAllCorrect"))));
  prefs.insert(HashPrefs::value_type(prGUI_CLN_APPEND_SHOW_GUI, PreferenceValue(static_cast<long>(clgOnWarning), path + wxT("AppendShowGUI"))));
  prefs.insert(HashPrefs::value_type(prGUI_CLN_CREATE_SHOW_GUI, PreferenceValue(static_cast<long>(clgOnWarning), path + wxT("CreateShowGUI"))));

  // SFV files
  path = wxT("ChecksumsFiles/SFV/");
  prefs.insert(HashPrefs::value_type(prSFV_READ_PATH_SEPARATOR, PreferenceValue(static_cast<long>(wxPATH_NATIVE), path + wxT("ReadPathSeparator"))));
  prefs.insert(HashPrefs::value_type(prSFV_WRITE_GEN_AND_DATE, PreferenceValue(true, path + wxT("WriteGeneratorAndDate"))));
  prefs.insert(HashPrefs::value_type(prSFV_IDENTIFY_AS, PreferenceValue(wxString(), path + wxT("IdentifyAs/Generator"))));
  prefs.insert(HashPrefs::value_type(prSFV_WRITE_FILE_SIZE_AND_DATE, PreferenceValue(true, path + wxT("WriteFileSizeAndDate"))));
  prefs.insert(HashPrefs::value_type(prSFV_WRITE_PATH_SEPARATOR, PreferenceValue(static_cast<long>(wxPATH_WIN), path + wxT("WritePathSeparator"))));
  prefs.insert(HashPrefs::value_type(prSFV_WRITE_EOL, PreferenceValue(static_cast<long>(wxEOL_DOS), path + wxT("WriteEndOfLine"))));

  // MD5 files
  path = wxT("ChecksumsFiles/MD5/");
  prefs.insert(HashPrefs::value_type(prMD5_READ_PATH_SEPARATOR, PreferenceValue(static_cast<long>(wxPATH_NATIVE), path + wxT("ReadPathSeparator"))));
  prefs.insert(HashPrefs::value_type(prMD5_WRITE_GEN_AND_DATE, PreferenceValue(false, path + wxT("WriteGeneratorAndDate"))));
  prefs.insert(HashPrefs::value_type(prMD5_WRITE_FILE_SIZE_AND_DATE, PreferenceValue(false, path + wxT("WriteFileSizeAndDate"))));
  prefs.insert(HashPrefs::value_type(prMD5_WRITE_PATH_SEPARATOR, PreferenceValue(static_cast<long>(wxPATH_UNIX), path + wxT("WritePathSeparator"))));
  prefs.insert(HashPrefs::value_type(prMD5_WRITE_EOL, PreferenceValue(static_cast<long>(wxEOL_UNIX), path + wxT("WriteEndOfLine"))));

  // Engine preferences
  prefs.insert(HashPrefs::value_type(prENGINE_READ_BUFFER, PreferenceValue(0xFFFFL, wxT("Engine/ReadBuffer"))));

  // Language preferences
  prefs.insert(HashPrefs::value_type(prLANGUAGE_NAME, PreferenceValue(wxString(), wxT("Language/Name"))));

  // Multi-check preferences
  path = wxT("GUI/MultiCheck/");
  prefs.insert(HashPrefs::value_type(prMC_WINDOW_SIZE, PreferenceValue(wxSize(-1, -1), path + wxT("WindowSize"))));
  prefs.insert(HashPrefs::value_type(prMC_GLOBAL_SUMMARY, PreferenceValue(true, path + wxT("GlobalSummary"))));
  prefs.insert(HashPrefs::value_type(prMC_CHECKSUMS_FILE_SUMMARY, PreferenceValue(true, path + wxT("ChecksumsFileSummary"))));
  prefs.insert(HashPrefs::value_type(prMC_FILE_STATE, PreferenceValue(false, path + wxT("FileState"))));
  prefs.insert(HashPrefs::value_type(prMC_NO_CORRECT_FILE_STATE, PreferenceValue(true, path + wxT("NoCorrectFileState"))));
  prefs.insert(HashPrefs::value_type(prMC_NORMAL_COLOUR, PreferenceValue(0x000000L, path + wxT("NormalColour"))));
  prefs.insert(HashPrefs::value_type(prMC_SUCCESS_COLOUR, PreferenceValue(0x008000L, path + wxT("SuccessColour"))));
  prefs.insert(HashPrefs::value_type(prMC_WARNING_COLOUR, PreferenceValue(0xFF8000L, path + wxT("WarningColour"))));
  prefs.insert(HashPrefs::value_type(prMC_ERROR_COLOUR, PreferenceValue(0x800000L, path + wxT("ErrorColour"))));


  // Batch creation preferences
  path = wxT("GUI/BatchCreation/");
  prefs.insert(HashPrefs::value_type(prBC_WINDOW_SIZE, PreferenceValue(wxSize(-1, -1), path + wxT("WindowSize"))));
  prefs.insert(HashPrefs::value_type(prBC_OVERWRITE_WHEN_CKFILE_EXISTS, PreferenceValue(false, path + wxT("OvrCkFileWhenItExists"))));
  prefs.insert(HashPrefs::value_type(prBC_REPLACE_FILE_EXTENSION, PreferenceValue(true, path + wxT("ReplaceExtension"))));
  prefs.insert(HashPrefs::value_type(prBC_VERBOSITY_LEVEL, PreferenceValue(2L, path + wxT("VerbosityLevel"))));
  prefs.insert(HashPrefs::value_type(prBC_NORMAL_COLOUR, PreferenceValue(0x000000L, path + wxT("NormalColour"))));
  prefs.insert(HashPrefs::value_type(prBC_SUCCESS_COLOUR, PreferenceValue(0x008000L, path + wxT("SuccessColour"))));
  prefs.insert(HashPrefs::value_type(prBC_WARNING_COLOUR, PreferenceValue(0xFF8000L, path + wxT("WarningColour"))));
  prefs.insert(HashPrefs::value_type(prBC_ERROR_COLOUR, PreferenceValue(0x800000L, path + wxT("ErrorColour"))));
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void AppPrefs::clone(const AppPrefs& source)
{
  if (this != &source)
    this->prefs = source.prefs;
}
//---------------------------------------------------------------------------


/**
 * Copy constructor.
 *
 * @param  source  Source instance.
 */
AppPrefs::AppPrefs(const AppPrefs& source)
{
  clone(source);
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  source  Source instance.
 */
AppPrefs& AppPrefs::operator=(const AppPrefs& source)
{
  clone(source);
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Gets the key of the preference in the configuration file.
 *
 * @param  key  The key whose configuration key in the configuration file is to
 *              be returned.
 * @return The key of the preference in the configuration file or an empty
 *         string if there is no key.
 */
wxString AppPrefs::getConfigKey(const int key) const
{
  wxString res;

  HashPrefs::const_iterator it = prefs.find(key);
  if (it != prefs.end())
    res = it->second.getConfigKey();

  return res;
}
//---------------------------------------------------------------------------


/**
 * Reads a string from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  str  The string in which the value will be stored.
 * @return <CODE>true</CODE> if the value was read, <CODE>false</CODE>
 *         otherwise. If the key was not found, <CODE>str</CODE> is not changed.
 */
bool AppPrefs::read(const int key, wxString& str) const
{
  HashPrefs::const_iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.get(str);
}
//---------------------------------------------------------------------------


/**
 * Reads a string from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  def  The default value to return if the value can't be read.
 * @return The value corresponding to the key or the default value if the value
 *         hasn't been read successfully.
 */
wxString AppPrefs::readString(const int key, const wxString& def) const
{
  wxString res;
  
  if (read(key, res))
    return res;
  else
    return def;
}
//---------------------------------------------------------------------------


/**
 * Reads a long integer value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  l    The long integer in which the value will be stored.
 * @return <CODE>true</CODE> if the value was read, <CODE>false</CODE>
 *         otherwise. If the key was not found, <CODE>l</CODE> is not changed.
 */
bool AppPrefs::read(const int key, long& l) const
{
  HashPrefs::const_iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.get(l);
}
//---------------------------------------------------------------------------


/**
 * Reads a long integer value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  def  The default value to return if the value can't be read.
 * @return The value corresponding to the key or the default value if the value
 *         hasn't been read successfully.
 */
long AppPrefs::readLong(const int key, const long def) const
{
  long res;
  
  if (read(key, res))
    return res;
  else
    return def;
}
//---------------------------------------------------------------------------


/**
 * Reads a double value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  d    The double in which the value will be stored.
 * @return <CODE>true</CODE> if the value was read, <CODE>false</CODE>
 *         otherwise. If the key was not found, <CODE>d</CODE> is not changed.
 */
bool AppPrefs::read(const int key, double& d) const
{
  HashPrefs::const_iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.get(d);
}
//---------------------------------------------------------------------------


/**
 * Reads a double value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  def  The default value to return if the value can't be read.
 * @return The value corresponding to the key or the default value if the value
 *         hasn't been read successfully.
 */
double AppPrefs::readDouble(const int key, const double def) const
{
  double res;
  
  if (read(key, res))
    return res;
  else
    return def;
}
//---------------------------------------------------------------------------


/**
 * Reads a boolean value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  b    The boolean in which the value will be stored.
 * @return <CODE>true</CODE> if the value was read, <CODE>false</CODE>
 *         otherwise. If the key was not found, <CODE>b</CODE> is not changed.
 */
bool AppPrefs::read(const int key, bool& b) const
{
  HashPrefs::const_iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.get(b);
}
//---------------------------------------------------------------------------


/**
 * Reads a boolean value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  def  The default value to return if the value can't be read.
 * @return The value corresponding to the key or the default value if the value
 *         hasn't been read successfully.
 */
bool AppPrefs::readBool(const int key, const bool def) const
{
  bool res;
  
  if (read(key, res))
    return res;
  else
    return def;
}
//---------------------------------------------------------------------------


/**
 * Reads a wxRect value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  r    The wxRect in which the value will be stored.
 * @return <CODE>true</CODE> if the value was read, <CODE>false</CODE>
 *         otherwise. If the key was not found, <CODE>r</CODE> is not changed.
 */
bool AppPrefs::read(const int key, wxRect& r) const
{
  HashPrefs::const_iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.get(r);
}
//---------------------------------------------------------------------------


/**
 * Reads a wxRect value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  def  The default value to return if the value can't be read.
 * @return The value corresponding to the key or the default value if the value
 *         hasn't been read successfully.
 */
wxRect AppPrefs::readRect(const int key, const wxRect& def) const
{
  wxRect res;
  
  if (read(key, res))
    return res;
  else
    return def;
}
//---------------------------------------------------------------------------


/**
 * Reads a wxPoint value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  p    The wxPoint in which the value will be stored.
 * @return <CODE>true</CODE> if the value was read, <CODE>false</CODE>
 *         otherwise. If the key was not found, <CODE>r</CODE> is not changed.
 */
bool AppPrefs::read(const int key, wxPoint& p) const
{
  HashPrefs::const_iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.get(p);
}
//---------------------------------------------------------------------------


/**
 * Reads a wxPoint value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  def  The default value to return if the value can't be read.
 * @return The value corresponding to the key or the default value if the value
 *         hasn't been read successfully.
 */
wxPoint AppPrefs::readPoint(const int key, const wxPoint& def) const
{
  wxPoint res;
  
  if (read(key, res))
    return res;
  else
    return def;
}
//---------------------------------------------------------------------------


/**
 * Reads a wxSize value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  s    The wxSize in which the value will be stored.
 * @return <CODE>true</CODE> if the value was read, <CODE>false</CODE>
 *         otherwise. If the key was not found, <CODE>r</CODE> is not changed.
 */
bool AppPrefs::read(const int key, wxSize& s) const
{
  HashPrefs::const_iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.get(s);
}
//---------------------------------------------------------------------------


/**
 * Reads a wxSize value from the key.
 *
 * @param  key  The key whose associated value is to be returned.
 * @param  def  The default value to return if the value can't be read.
 * @return The value corresponding to the key or the default value if the value
 *         hasn't been read successfully.
 */
wxSize AppPrefs::readSize(const int key, const wxSize& def) const
{
  wxSize res;
  
  if (read(key, res))
    return res;
  else
    return def;
}
//---------------------------------------------------------------------------


/**
 * Write a string in the preference given by the key.
 *
 * @param  key  The key of the preference where the value will be stored.
 * @param  str  The value to store.
 * @return <CODE>true</CODE> if the value has been stored successfully,
 *         <CODE>false</CODE> otherwise.
 */
bool AppPrefs::write(const int key, const wxString& str)
{
  HashPrefs::iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.set(str);
}
//---------------------------------------------------------------------------


/**
 * Write a long integer value in the preference given by the key.
 *
 * @param  key  The key of the preference where the value will be stored.
 * @param  l    The value to store.
 * @return <CODE>true</CODE> if the value has been stored successfully,
 *         <CODE>false</CODE> otherwise.
 */
bool AppPrefs::write(const int key, const long l)
{
  HashPrefs::iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.set(l);
}
//---------------------------------------------------------------------------


/**
 * Write a double value in the preference given by the key.
 *
 * @param  key  The key of the preference where the value will be stored.
 * @param  d    The value to store.
 * @return <CODE>true</CODE> if the value has been stored successfully,
 *         <CODE>false</CODE> otherwise.
 */
bool AppPrefs::write(const int key, const double d)
{
  HashPrefs::iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.set(d);
}
//---------------------------------------------------------------------------


/**
 * Write a boolean value in the preference given by the key.
 *
 * @param  key  The key of the preference where the value will be stored.
 * @param  b    The value to store.
 * @return <CODE>true</CODE> if the value has been stored successfully,
 *         <CODE>false</CODE> otherwise.
 */
bool AppPrefs::write(const int key, const bool b)
{
  HashPrefs::iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.set(b);
}
//---------------------------------------------------------------------------


/**
 * Write a wxRect value in the preference given by the key.
 *
 * @param  key  The key of the preference where the value will be stored.
 * @param  r    The value to store.
 * @return <CODE>true</CODE> if the value has been stored successfully,
 *         <CODE>false</CODE> otherwise.
 */
bool AppPrefs::write(const int key, const wxRect& r)
{
  HashPrefs::iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.set(r);
}
//---------------------------------------------------------------------------


/**
 * Write a wxPoint value in the preference given by the key.
 *
 * @param  key  The key of the preference where the value will be stored.
 * @param  p    The value to store.
 * @return <CODE>true</CODE> if the value has been stored successfully,
 *         <CODE>false</CODE> otherwise.
 */
bool AppPrefs::write(const int key, const wxPoint& p)
{
  HashPrefs::iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.set(p);
}
//---------------------------------------------------------------------------


/**
 * Write a wxSize value in the preference given by the key.
 *
 * @param  key  The key of the preference where the value will be stored.
 * @param  s    The value to store.
 * @return <CODE>true</CODE> if the value has been stored successfully,
 *         <CODE>false</CODE> otherwise.
 */
bool AppPrefs::write(const int key, const wxSize& s)
{
  HashPrefs::iterator it = prefs.find(key);
  if (it == prefs.end())
    return false;
  else
    return it->second.set(s);
}
//---------------------------------------------------------------------------


/**
 * Gets a pointer on the global preferences.
 *
 * If no global instance of the class AppPrefs exists, a new instance is
 * created.
 *
 * @return A pointer on the global preferences.
 */
AppPrefs* AppPrefs::get()
{
  if (global == NULL)
    global = new AppPrefs();

  return global;
}
//---------------------------------------------------------------------------


/**
 * Sets the global preferences.
 *
 * @param  pAppPrefs  A pointer on the new global preferences.
 * @return A pointer on the old global preferences or <CODE>NULL</CODE> if
 *         there wasn't global preferences.
 */
AppPrefs* AppPrefs::set(AppPrefs* pAppPrefs)
{
  AppPrefs* old = global;
  global = pAppPrefs;
  return old;
}
//---------------------------------------------------------------------------


/**
 * Cleans up the global instance.
 *
 * Use the <CODE>delete</CODE> operator to delete the memory taken by the
 * global instance of <CODE>AppPrefs</CODE>.
 *
 * It is safe to call this static method if no global preferences have been
 * set.
 */
void AppPrefs::cleanupGlobal()
{
  AppPrefs* old = set(NULL);
  if (old != NULL)
    delete old;
}
//---------------------------------------------------------------------------


/**
 * Gets the full name of the directory where the preferences of the application are stored.
 *
 * @return A string that contains the directory where the preferences of the
 *         application are stored.
 */
wxString AppPrefs::getConfigDir()
{
  if (!configDir.empty())
    return configDir;

  wxString path;
  wxString configDirName;
  #if defined(__UNIX__) && !defined(__WINDOWS__)
    configDirName = wxT('.') + getConfigDirName();
  #else
    configDirName = getConfigDirName();
  #endif  // __UNIX__

  #ifdef  __WINDOWS__
  // Try special directories
  if (!(path = getFolderPath(CSIDL_COMMON_APPDATA)).empty())
  {
    path = addPathSeparatorAtEnd(path) + configDirName;
    // Tests if the configuration files are present and readeable/writeable.
    if (!(wxFile::Access(addPathSeparatorAtEnd(path) + getConfigFileName(), wxFile::read) &&
        wxFile::Access(addPathSeparatorAtEnd(path) + getConfigFileName(), wxFile::write)))
      path.clear();
  }

  if (path.empty())
  {
    path = getFolderPath(CSIDL_APPDATA);
    if (!dirExists(path, false))
      path.clear();
    else
    {
      path = addPathSeparatorAtEnd(path) + configDirName;
      if (!dirExists(path, true))
        path.clear();
    }
  }
  
  if (path.empty())
  {
    path = getFolderPath(CSIDL_LOCAL_APPDATA);
    if (!dirExists(path, false))
      path.clear();
    else
    {
      path = addPathSeparatorAtEnd(path) + configDirName;
      if (!dirExists(path, true))
        path.clear();
    }
  }
  #endif

  // Try the HOME environnement variable
  if (path.empty())
    if (::wxGetEnv(wxT("HOME"), &path))
    {
      path = addPathSeparatorAtEnd(path) + configDirName;
      if (!dirExists(path, true))
        path.clear();
    }

  if (!path.empty())
    configDir = path;

  return configDir;
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the file which contains the application's preferences.
 *
 * @return A string that contains the name of the file which contains the
 *         application's preferences.
 */
wxString AppPrefs::getConfigFileName()
{
  if (configFileName.empty())
    configFileName = wxString(wxT(APP_NAME)) + wxT(".ini");

  return configFileName;
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the file which contains the application's languages
 * settings.
 *
 * @return A string that contains the name of the file which contains the
 *         application's languages settings.
 */
wxString AppPrefs::getLanguagesFileName()
{
  return wxT("languages.ini");
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the directory which contains the application's preferences.
 *
 * @return A string that contains the name of the directory which contains the
 *         application's preferences.
 */
wxString AppPrefs::getConfigDirName()
{
  return wxString(wxT(APP_NAME));
}
//---------------------------------------------------------------------------


/**
 * Gets the full path of the file which contains the application's preferences.
 *
 * @return A string that contains the full path name of the file which contains
 *         the application's preferences.
 */
wxString AppPrefs::getConfigPathName()
{
  return addPathSeparatorAtEnd(getConfigDir()) + getConfigFileName();
}
//---------------------------------------------------------------------------


/**
 * Gets the full path of the file which contains the application's languages
 * settings.
 *
 * @return A string that contains the full path name of the file which contains
 *         the application's languages settings.
 */
wxString AppPrefs::getLanguagesPathName()
{
  wxString res;
  size_t i;

  // Gets the standard paths where the file of application's languages settings
  // could be found.
  wxString langIni = getLanguagesFileName();
  wxArrayString paths = ::getResourcesPaths();

  // Add the name of the file of the application's languages settings on each
  // paths of the possible paths.
  for (i = 0; i < paths.GetCount(); i++)
  {
    wxFileName fn(paths[i], langIni);
    paths[i] = fn.GetFullPath();
  }

  wxString langsRC;
  if (::wxGetEnv(wxT("WXCKSUMS_LANGS_RC"), &langsRC))
  // Adds the full path of the file of the application's languages settings at
  // the beginning of the array.
    paths.Insert(langsRC, 0);

  i = 0;
  while (res.IsEmpty() && i < paths.GetCount())
  {
    if (wxFile::Access(paths[i], wxFile::read))
      res = paths[i];
    else
      i++;
  }
  
  return res;
}
//---------------------------------------------------------------------------


/**
 * Gets the default rects of the main window.
 *
 * @return The default rects of the main window.
 */
wxRect AppPrefs::getDefaultMainWindowRect()
{
  int    h, w;
  wxRect r;

  // Sets the default size of the window (5/8 of the screen)
  ::wxDisplaySize(&w, &h);
  r.SetWidth(static_cast<int>(w * 0.625));
  r.SetHeight(static_cast<int>(h * 0.625));
  r.SetX((w - r.GetWidth()) / 2);
  r.SetY((h - r.GetHeight()) / 2);
  
  return r;
}
//---------------------------------------------------------------------------


/**
 * Gets the directory where the user stores its documents.
 *
 * This method looks for the <CODE>HOME</CODE> environment variable.
 * On Windows only it looks for the <CODE>My Documents</CODE> directory.
 *
 * @return  The directory where the user stores its documents or an empty string
 *          if this directory cannot be found.
 */
wxString AppPrefs::getUserDocumentsDirName()
{
  wxString path;
  
  // Try the HOME environnement variable
  if (::wxGetEnv(wxT("HOME"), &path))
    if (::wxDirExists(path))
      return path;

  #ifdef __WINDOWS__
  path = getFolderPath(CSIDL_PERSONAL);
  if (::wxDirExists(path))
    return path;
  #endif  // __WINDOWS__

  return wxEmptyString;
}
//---------------------------------------------------------------------------


//###########################################################################
// Useful fonctions
//###########################################################################

/**
 * Adds a path separator at the end of the directory name if it's not already
 * present.
 *
 * If the directory name is empty, the path separator isn't added.
 *
 * @param  dirName  Name of the directory where the path separator will be added.
 * @return The name of the directory with a path separator at the end.
 */
static wxString addPathSeparatorAtEnd(wxString dirName)
{
  if (dirName.empty())
    return dirName;

  wxChar pathSep = wxFileName::GetPathSeparator();
  if (dirName[dirName.size() - 1] != pathSep)
    dirName += pathSep;

  return dirName;
}
//---------------------------------------------------------------------------


/**
 * Indicates if the specified directory exists.
 *
 * @param  dirName  Name of the directory to test the existance.
 * @param  create   If the directory doesn't exist, try to create it.
 * @return <CODE>true</CODE> if the directory exists,
 *         <CODE>false</CODE> otherwise.
 * @note   The algorithm of creation of directory of this fonction is dumb.
 *         It just tries to create the full directory name.<BR>
 *         For example, if only the <I>C:\\Program Files\\MyApp</I> directory
 *         exists, and the <I>C:\\Program Files\\MyApp\\Config\\6.0</I> directory
 *         is tested for existance and creation, this fonction will try to
 *         create the <I>C:\\Program Files\\MyApp\\Config\\6.0</I> directory and
 *         not the <I>C:\\Program Files\\MyApp\\Config</I> directory and next
 *         <I>C:\\Program Files\\MyApp\\Config\\6.0</I>.
 */
static bool dirExists(const wxString& dirName, bool create)
{
  if (wxDirExists(dirName))
    return true;
  else
    if (create)
      if (wxFileExists(dirName))
        return false;
      else
        return wxMkdir(dirName);
    else
      return false;
}
//---------------------------------------------------------------------------


#ifdef __WINDOWS__
/**
 * Takes the CSIDL of a folder and returns the pathname (Windows only).
 *
 * @param  folder  A CSIDL value that identifies the folder whose path is to be
 *                 retrieved. Only real folders are valid. If a virtual folder
 *                 is specified, this function will fail.
 * @return A string which contains the pathname on success. An empty string
 *         otherwise.
 */
static wxString getFolderPath(int folder)
{
  TCHAR szPath[MAX_PATH];
  wxString res;

  if (SUCCEEDED(SHGetFolderPath(NULL, folder, NULL, SHGFP_TYPE_CURRENT, szPath)))
    res = szPath;
    
  return res;
}
//---------------------------------------------------------------------------
#endif  // __WINDOWS__
