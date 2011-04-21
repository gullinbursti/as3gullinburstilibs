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
 * \file language.hpp
 * Manages the languages that the application knows.
 */


#ifndef INC_LANGUAGE_HPP
#define INC_LANGUAGE_HPP


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
 * Manages available languages for the application.
 *
 * Never pass an instance of this class by value, always pass by reference or
 * by adress.
 *
 * For adding a language, see the comments of the default constructor.
 */
class Languages
{
 public:
  static const int LANGUAGE_UNKNOW;  ///< Identifier for an unknown language.

 protected:
  /**
   * Entry of the language list.
   *
   * Never pass an instance of this class by value, always pass by reference or
   * by adress.
   */
  class Language
  {
   protected:
    wxString      name;    ///< Name of the language.
    wxString      nameTranslated;  ///< Name of the language (translated).
    wxArrayString shorts;  ///< Short names that can be used for the language.
    wxArrayInt    ids;     ///< Identifiers for the languages.
    wxString      localeName;  ///< Name of the locale (compiler dependant).
    wxString      translator;  ///< Name of the translator (in latin-1 characters).
    wxString      translatorLoc; ///< Name of the translator (in UTF-8 charset).

   private:
    /// Default constructor.
    Language() {};

   public:
    // Constructor
    Language(const wxString& langName, const wxString& langNameTranslated,
             const wxString& shortName, const int id, const wxString& locName,
             const wxString& translatorLat, const wxString& translatorLocale);
    
    // Other constructor
    Language(const wxString& langName, const wxString& langNameTranslated,
             const wxArrayString& shortNames, const wxArrayInt& id,
             const wxString& locName, const wxString& translatorLat,
             const wxString& translatorLocale);

    // Sets the given locale with the given language
    bool setLocale(wxLocale& loc, const int language) const;

    // Sets the given locale with the given short name
    bool setLocale(wxLocale& loc, const wxString& shortName) const;
    
    // Gets the name of the language.
    wxString getName() const;

    // Gets the translated name of the language.
    wxString getTranslatedName() const;

    // Gets the language shorts names.
    wxArrayString getShortNames() const;
    
    // Gets the main language short name.
    wxString getShortName() const;

    // Gets the name of the translator (in latin-1 characters).
    wxString getTranslatorName() const;

    // Gets the name of the translator in the language.
    wxString getTranslatorNameInLocale() const;
  };

  /// List of languages.
  WX_DEFINE_ARRAY(Language*, LanguagesList);

  LanguagesList languages;  ///< List of languages.

 public:
  // Default constructor
  Languages();

  // Destructor
  ~Languages();

  // Sets the given locale
  bool setLocale(wxLocale& loc) const;

  // Sets the given locale and force the language
  bool setLocale(wxLocale& loc, const int language) const;

  // Gets the number of available languages
  int getLanguagesCount() const;

  // Gets the language name at the given index
  wxString getLanguageName(const int index) const;

  // Gets the language translated name at the given index
  wxString getLanguageTranslatedName(const int index) const;

  // Gets the language short name at the given index
  wxString getLanguageShortName(const int index) const;
  
  // Gets the index of language with the given short name
  int getLanguageIndexByShortName(const wxString& shortName) const;

  // Gets the name of the translator (in latin-1 characters) at the given index
  wxString getLanguageTranslatorName(const int index) const;

  // Gets the name of the translator in the language at the given index
  wxString getLanguageTranslatorNameInLocale(const int index) const;
  
 protected:
  // Reads languages settings from a configuration file.
  bool readLanguagesSettings(const wxString& langFileIni);


  // For more information on the Borland C specifics, see the informations
  // at the end of language.cpp.
  #ifdef __BORLANDC__
 protected:
  /// Array of language info
  WX_DEFINE_ARRAY(wxLanguageInfo*, ArrayLanguageInfo);

  static ArrayLanguageInfo lngInfos;

  static void CreateLanguagesDB();
  static void DestroyLanguagesDB();
 public:
  static const wxLanguageInfo* GetLanguageInfo(int lang);
  #endif  // __BORLANDC__
};
//---------------------------------------------------------------------------


#endif  // INC_LANGUAGE_HPP
