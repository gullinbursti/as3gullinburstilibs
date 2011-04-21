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
 * \file appprefs.hpp
 * Common preferences for the application.
 */

#ifndef INC_APPPREFS_HPP
#define INC_APPPREFS_HPP

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
#include <wx/hashmap.h>
#include <wx/config.h>
//---------------------------------------------------------------------------


/**
 * Encapsulates a preference value.
 *
 * A preference value has a type and can have a corresponding key in the
 * global configuration file (see <CODE>wxConfig::Get()</CODE> in the wxWidgets
 * documentation).
 *
 * The type of the preference is fixed at the construction of the instance and
 * can't be changed. The type is always checked when the value is set or gotten.
 *
 * If a key is specified:
 * <UL>
 *   <LI>At initialization, if the constructor parameter
 *       <CODE>initFromCfgFile</CODE> is <CODE>true</CODE>, then the preference
 *       value is initialized by reading the global configuration file (on
 *       failure the given value is used).</LI>
 *   <LI>When a <CODE>set</CODE> method is called, the preference value is
 *       written in the global configuration file.</LI>
 * </UL>
 *
 * The static <CODE>read</CODE> methods provide facility for reading the complex
 * types that are handled by this class (such as wxRect for example).
 */
class PreferenceValue
{
 protected:
  /// Type of the preference value
  enum PreferenceType
  {
    ptNotDefined = 0,
    ptLong,
    ptString,
    ptDouble,
    ptBoolean,
    ptRect,
    ptSize,
    ptPoint
  };

  /// Value of the preference
  union value_t
  {
    long*     valLong;    ///< Pointer on the long integer type value.
    wxString* valString;  ///< Pointer on the string type value.
    double*   valDouble;  ///< Pointer on the double type value.
    bool*     valBool;    ///< Pointer on the boolean type value.
    wxRect*   valRect;    ///< Pointer on a wxRect instance.
    wxSize*   valSize;    ///< Pointer on a wxSize instance.
    wxPoint*  valPoint;   ///< Pointer on a wxPoint instance.
  };
  
  value_t         _value;      ///< Value of the preference.
  PreferenceType  _valueType;  ///< Type of the preference.
  wxString        _cfgKey;     ///< Corresponding key in the configuration file. Must be empty if this item isn't stored in the configuration file.

 protected:
  // Clones the source instance in this instance.
  void clone(const PreferenceValue& source);

  // Cleans up the memory.
  void cleanup();

 public:
  // Default constructor.
  PreferenceValue();

  // Constructor with a long integer type.
  PreferenceValue(const long value, const wxString& cfgKey = wxEmptyString, const bool initFromCfgFile = true);

  // Constructor with a string type.
  PreferenceValue(const wxString& value, const wxString& cfgKey = wxEmptyString, const bool initFromCfgFile = true);

  // Constructor with a double type.
  PreferenceValue(const double value, const wxString& cfgKey = wxEmptyString, const bool initFromCfgFile = true);

  // Constructor with a boolean type.
  PreferenceValue(const bool value, const wxString& cfgKey = wxEmptyString, const bool initFromCfgFile = true);

  // Constructor with a wxRect type.
  PreferenceValue(const wxRect& value, const wxString& cfgKey = wxEmptyString, const bool initFromCfgFile = true);

  // Constructor with a wxPoint type.
  PreferenceValue(const wxPoint& value, const wxString& cfgKey = wxEmptyString, const bool initFromCfgFile = true);

  // Constructor with a wxSize type.
  PreferenceValue(const wxSize& value, const wxString& cfgKey = wxEmptyString, const bool initFromCfgFile = true);

  // Copy constructor.
  PreferenceValue(const PreferenceValue& source);

  // Assignment operator.
  PreferenceValue& operator=(const PreferenceValue& source);
  
  // Destructor.
  ~PreferenceValue();
  
  // Gets the key of the preference in the configuration file.
  wxString getConfigKey() const;
  
  // Gets a long integer value.
  bool get(long& value) const;

  // Sets a long integer value.
  bool set(const long newValue);

  // Gets a string value.
  bool get(wxString& value) const;

  // Sets a string value.
  bool set(const wxString& newValue);

  // Gets a double value.
  bool get(double& value) const;

  // Sets a string value.
  bool set(const double newValue);

  // Gets a boolean value.
  bool get(bool& value) const;

  // Sets a boolean value.
  bool set(const bool newValue);

  // Gets a wxRect value.
  bool get(wxRect& value) const;

  // Sets a wxRect value.
  bool set(const wxRect& newValue);

  // Gets a wxPoint value.
  bool get(wxPoint& value) const;

  // Sets a wxPoint value.
  bool set(const wxPoint& newValue);

  // Gets a wxSize value.
  bool get(wxSize& value) const;

  // Sets a wxSize value.
  bool set(const wxSize& newValue);
  
  // Reads a wxRect value from the configuration file.
  static bool read(const wxString& key, wxRect* r, wxConfigBase* cfg = NULL);
  
  // Reads a wxRect value from the configuration file.
  static wxRect read(const wxString& key, const wxRect& def, wxConfigBase* cfg = NULL);

  // Reads a wxPoint value from the configuration file.
  static bool read(const wxString& key, wxPoint* r, wxConfigBase* cfg = NULL);
  
  // Reads a wxPoint value from the configuration file.
  static wxPoint read(const wxString& key, const wxPoint& def, wxConfigBase* cfg = NULL);

  // Reads a wxSize value from the configuration file.
  static bool read(const wxString& key, wxSize* r, wxConfigBase* cfg = NULL);
  
  // Reads a wxSize value from the configuration file.
  static wxSize read(const wxString& key, const wxSize& def, wxConfigBase* cfg = NULL);
};
//---------------------------------------------------------------------------


/// A hash map type with integer keys and PreferenceValue values.
WX_DECLARE_HASH_MAP(int, PreferenceValue, wxIntegerHash, wxIntegerEqual, HashPrefs);
//---------------------------------------------------------------------------


/**
 * Manages the application preferences.
 *
 * You can't create directly an instance of this class. In order to get one, 
 * use the method <CODE>get()</CODE>. Use the method
 * <CODE>cleanupGlobal()</CODE> at the end of the program to clean up the
 * memory.
 *
 * <B>Don't</B> use the method <CODE>get()</CODE> (and more generally don't
 * create an instance of AppPrefs) before setting a correct global configuration
 * file (see <CODE>wxConfig</CODE> in the wxWidgets documentation).
 *
 * Use the methods <CODE>read</CODE> and <CODE>write</CODE> to get and set the
 * values of the preferences.
 */
class AppPrefs
{
 protected: 
  HashPrefs prefs;  ///< Hashmap that contains the data of preferences.

  // Clones the source instance in this instance.
  void clone(const AppPrefs& source);

  // Inits the instance.
  void init();

  // Constructor.
  AppPrefs();

  // Copy constructor.
  AppPrefs(const AppPrefs& source);

  // Assignment operator.
  AppPrefs& operator=(const AppPrefs& source);

 public:
  // Gets the key of the preference in the configuration file.
  wxString getConfigKey(const int key) const;

  // Reads a string from the key.
  bool read(const int key, wxString& str) const;

  // Reads a string from the key.
  wxString readString(const int key, const wxString& def = wxEmptyString) const;

  // Reads a long integer value from the key.
  bool read(const int key, long& l) const;

  // Reads a long integer value from the key.
  long readLong(const int key, const long def = -1L) const;

  // Reads a double value from the key.
  bool read(const int key, double& d) const;

  // Reads a double value from the key.
  double readDouble(const int key, const double def = -1.0) const;

  // Reads a boolean value from the key.
  bool read(const int key, bool& b) const;

  // Reads a boolean value from the key.
  bool readBool(const int key, const bool def = false) const;

  // Reads a wxRect value from the key.
  bool read(const int key, wxRect& r) const;

  // Reads a wxRect value from the key.
  wxRect readRect(const int key, const wxRect& def = wxRect(0, 0, 0, 0)) const;

  // Reads a wxPoint value from the key.
  bool read(const int key, wxPoint& p) const;

  // Reads a wxPoint value from the key.
  wxPoint readPoint(const int key, const wxPoint& def = wxPoint(0, 0)) const;

  // Reads a wxSize value from the key.
  bool read(const int key, wxSize& s) const;

  // Reads a wxSize value from the key.
  wxSize readSize(const int key, const wxSize& def = wxSize(0, 0)) const;

  // Write a string in the preference given by the key.
  bool write(const int key, const wxString& str);

  // Write a long integer value in the preference given by the key.
  bool write(const int key, const long l);

  // Write a double value in the preference given by the key.
  bool write(const int key, const double d);

  // Write a boolean value in the preference given by the key.
  bool write(const int key, const bool b);

  // Write a wxRect value in the preference given by the key.
  bool write(const int key, const wxRect& r);

  // Write a wxPoint value in the preference given by the key.
  bool write(const int key, const wxPoint& p);

  // Write a wxSize value in the preference given by the key.
  bool write(const int key, const wxSize& s);

 // Static attributes and methods.
 protected:
  static AppPrefs* global;  ///< Global preferences.
  static wxString configDir;  ///< Full name of the directory which contains the application's preferences.
  static wxString configFileName;  ///< Name of the file which contains the application preferences.

  // Gets the full name of the directory where the preferences of the application are stored.
  static wxString getConfigDir();

  // Gets the name of the file which contains the application's preferences.
  static wxString getConfigFileName();

  // Gets the name of the file which contains the application's languages settings.
  static wxString getLanguagesFileName();

  // Gets the name of the directory which contains the application's preferences.
  static wxString getConfigDirName();

  // Sets the global preferences.
  static AppPrefs* set(AppPrefs* pAppPrefs);

 public:
  // Gets a pointer on the global preferences.
  static AppPrefs* get();
  
  // Cleans up the global instance.
  static void cleanupGlobal();

  // Gets the full path of the file which contains the application's preferences.
  static wxString getConfigPathName();

  // Gets the full path of the file which contains the application's languages settings.
  static wxString getLanguagesPathName();

  // Gets the default rects of the main window
  static wxRect getDefaultMainWindowRect();
  
  // Gets the directory where the user stores its documents.
  static wxString getUserDocumentsDirName();
};
//---------------------------------------------------------------------------


/// Preferences keys
enum PreferencesKeys
{
  prGUI_MAIN_SAVE_WINDOW_POSITION = 100,
  prGUI_MAIN_SAVE_WINDOW_SIZE,
  prGUI_MAIN_WINDOW_POSITION,
  prGUI_MAIN_WINDOW_SIZE,
  prGUI_MAIN_SHOW_TOOLBAR,
  prGUI_MAIN_SHOW_STATUSBAR,
  prGUI_MAIN_SUMS_SAVECOLUMNTOSORT,
  prGUI_MAIN_SUMS_COLUMNTOSORT,
  prGUI_MAIN_SUMS_COLUMNSORTORDER,
  prGUI_MAIN_SUMS_SAVECOLUMNSWIDTHS,
  prGUI_MAIN_SUMS_COL_FILENAME_WIDTH,
  prGUI_MAIN_SUMS_COL_DIRECTORY_WIDTH,
  prGUI_MAIN_SUMS_COL_CHECKSUM_WIDTH,
  prGUI_MAIN_SUMS_COL_STATE_WIDTH,
  prGUI_MAIN_SUMS_COL_FIRST,
  prGUI_MAIN_SUMS_COL_SECOND,
  prGUI_MAIN_SUMS_COL_THIRD,
  prGUI_MAIN_SUMS_COL_FOURTH,
  prGUI_MAIN_SUMS_DIRSINABSOLUTEPATH,
  prGUI_MAIN_SUMS_UPPERCASE,
  prGUI_MAIN_SUMS_HRULES,
  prGUI_MAIN_SUMS_VRULES,
  prGUI_MAIN_LAST_DIRECTORY,
  prGUI_CONF_WINDOW_SIZE,
  prGUI_CONF_SASH_POSITION,
  prGUI_NEWFILE_LAST_DIRECTORY,
  prGUI_NEWFILE_LAST_FILETYPE,
  prGUI_AUTO_CHECK_ON_OPEN,
  prGUI_DLG_SUMUP_CHECK,
  prGUI_WARN_ON_INVALID_WHEN_SAVING,
  prGUI_CLN_VERIFY_DONT_SHOW_GUI,
  prGUI_CLN_APPEND_SHOW_GUI,
  prGUI_CLN_CREATE_SHOW_GUI,
  prLANGUAGE_NAME,
  prSFV_READ_PATH_SEPARATOR,
  prSFV_WRITE_GEN_AND_DATE,
  prSFV_IDENTIFY_AS,
  prSFV_WRITE_FILE_SIZE_AND_DATE,
  prSFV_WRITE_PATH_SEPARATOR,
  prSFV_WRITE_EOL,
  prMD5_READ_PATH_SEPARATOR,
  prMD5_WRITE_GEN_AND_DATE,
  prMD5_WRITE_FILE_SIZE_AND_DATE,
  prMD5_WRITE_PATH_SEPARATOR,
  prMD5_WRITE_EOL,
  prMC_WINDOW_SIZE,
  prMC_GLOBAL_SUMMARY,
  prMC_CHECKSUMS_FILE_SUMMARY,
  prMC_FILE_STATE,
  prMC_NO_CORRECT_FILE_STATE,
  prMC_NORMAL_COLOUR,
  prMC_SUCCESS_COLOUR,
  prMC_WARNING_COLOUR,
  prMC_ERROR_COLOUR,
  prBC_WINDOW_SIZE,
  prBC_OVERWRITE_WHEN_CKFILE_EXISTS,
  prBC_REPLACE_FILE_EXTENSION,
  prBC_VERBOSITY_LEVEL,
  prBC_NORMAL_COLOUR,
  prBC_SUCCESS_COLOUR,
  prBC_WARNING_COLOUR,
  prBC_ERROR_COLOUR,
  prENGINE_READ_BUFFER
};
//---------------------------------------------------------------------------


#endif  // #define INC_APPPREFS_HPP
