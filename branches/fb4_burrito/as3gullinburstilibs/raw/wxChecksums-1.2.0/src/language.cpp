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
 * \file language.cpp
 * Manages the languages that the application knows.
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

#include <wx/config.h>
#include <wx/fileconf.h>
#include <wx/tokenzr.h>

#include "language.hpp"
#include "appprefs.hpp"
#include "comdefs.hpp"
#include "osdep.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------

/// The C++ standard namespace.
using namespace std;


//###########################################################################
// Languages::Language value members
//###########################################################################

/**
 * Constructor.
 *
 * @param  langName   Name of the language.
 * @param  langNameTranslated  Name of the language (translated).
 * @param  shortName  Short name of the language.
 * @param  id         wxWidgets identifier of the language.
 * @param  locName    Name of the locale (dependant compiler). If empty, the
 *                    wxWidgets identifier will be used to set the locale,
 *                    else it is this locale name that will be used.
 * @param  translatorLat  Name of the translator (in latin-1 characters).
 * @param  translatorLocale  Name of the translator (in UTF-8 charset).
 */
Languages::Language::Language(const wxString& langName,
                              const wxString& langNameTranslated,
                              const wxString& shortName,
                              const int id, const wxString& locName,
                              const wxString& translatorLat,
                              const wxString& translatorLocale)
{
  name = langName;
  nameTranslated = langNameTranslated;
  shorts.Add(shortName);
  ids.Add(id);
  localeName = locName;
  translator = translatorLat;
  translatorLoc = translatorLocale;
}
//---------------------------------------------------------------------------

    
/**
 * Constructor.
 *
 * Caller must provide one or more short names and one or more language ids.
 * This is <b>not</b> verified by this constructor.
 *
 * @param  langName    Name of the language.
 * @param  langNameTranslated  Name of the language (translated).
 * @param  shortNames  Short names of the language.
 * @param  id          wxWidgets identifiers of the language.
 * @param  locName     Name of the locale (dependant compiler). If empty, the
 *                     wxWidgets identifier will be used to set the locale,
 *                     else it is this locale name that will be used.
 * @param  translatorLat  Name of the translator (in latin-1 characters).
 * @param  translatorLocale  Name of the translator (in UTF-8 charset).
 */
Languages::Language::Language(const wxString& langName,
                              const wxString& langNameTranslated,
                              const wxArrayString& shortNames,
                              const wxArrayInt& id,
                              const wxString& locName,
                              const wxString& translatorLat,
                              const wxString& translatorLocale)
{
  name = langName;
  nameTranslated = langNameTranslated;
  shorts = shortNames;
  ids = id;
  localeName = locName;
  translator = translatorLat;
  translatorLoc = translatorLocale;
}
//---------------------------------------------------------------------------


/**
 * Changes the locale of the application with the given language.
 *
 * The locale is changed only if the given language id is present in this
 * language instance.
 *
 * @param  loc       The locale to change.
 * @param  language  Identifier of the language.
 * @return <CODE>true</CODE> if the locale has been changed, <CODE>false</CODE>
 *         otherwise.
 */
bool Languages::Language::setLocale(wxLocale& loc, const int language) const
{
  bool localeHasChanged = false;

  if (ids.Index(language) != wxNOT_FOUND)
  {
    if (localeName.IsEmpty())
      loc.Init(ids[0]);
    else
      loc.Init(name, shorts[0], localeName);

    localeHasChanged = true;
  }

  return localeHasChanged;
}
//---------------------------------------------------------------------------


/**
 * Changes the locale of the application with the given language.
 *
 * The locale is changed only if the given short name is present in this
 * language instance.
 *
 * @param  loc        The locale to change.
 * @param  shortName  Short name of the language.
 * @return <CODE>true</CODE> if the locale has been changed, <CODE>false</CODE>
 *         otherwise.
 */
bool Languages::Language::setLocale(wxLocale& loc, const wxString& shortName) const
{
  bool localeHasChanged = false;

  if (shorts.Index(shortName, false) != wxNOT_FOUND)
  {
    if (localeName.IsEmpty())
      loc.Init(ids[0]);
    else
      loc.Init(name, shorts[0], localeName);
  
    localeHasChanged = true;
  }

  return localeHasChanged;
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the language.
 *
 * @return  The name of the language.
 */
wxString Languages::Language::getName() const
{
  return name;
}
//---------------------------------------------------------------------------


/**
 * Gets the translated name of the language.
 *
 * @return  The translated name of the language.
 */
wxString Languages::Language::getTranslatedName() const
{
  return nameTranslated;
}
//---------------------------------------------------------------------------


/**
 * Gets the language shorts names.
 *
 * @return  The language shorts names.
 */
wxArrayString Languages::Language::getShortNames() const
{
  return shorts;
}
//---------------------------------------------------------------------------

    
/**
 * Gets the main language short name.
 *
 * @return  The main language short name.
 */
wxString Languages::Language::getShortName() const
{
  return shorts[0];
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the translator (in latin-1 characters).
 *
 * @return  The name of the translator (in latin-1 characters).
 */
wxString Languages::Language::getTranslatorName() const
{
  return translator;
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the translator in the language.
 *
 * @return  The name of the translator in the language.
 */
wxString Languages::Language::getTranslatorNameInLocale() const
{
  return translatorLoc;
}
//---------------------------------------------------------------------------




//###########################################################################
// Misc functions declarations
//###########################################################################

// Returns the wxWidgets language identifier from a language name.
static int getLanguageIdentifier(const wxString langName);




//###########################################################################
// Languages value members
//###########################################################################


// Static attributes of the Languages class
const int Languages::LANGUAGE_UNKNOW = -1;
//---------------------------------------------------------------------------



/**
 * Default constructor.
 *
 * For adding a language:
 * - Add the language in <CODE>cmplLangs[]</CODE>.
 * - Use the Add() method to add the language at the end of the method.
 */
Languages::Languages()
{
  // For more information on the Borland C specifics, see the informations
  // at the end of language.cpp.
  #ifdef __BORLANDC__
  CreateLanguagesDB();
  #endif  // __BORLANDC__
  
  if (!readLanguagesSettings(AppPrefs::getLanguagesPathName()))
  {
    #if defined(__BORLANDC__)
    const wxString cmplLang(wxT("english"));
    #else  // Others compilers
    const wxString cmplLang;
    #endif  // defined(__BORLANDC__)

    languages.Add(new Language(wxT("English"), wxT("English"), wxT("en"),
               wxLANGUAGE_ENGLISH, cmplLang, wxT(APP_AUTHOR), wxT(APP_AUTHOR)));
  }
}
//---------------------------------------------------------------------------


/**
 * Destructor.
 */
Languages::~Languages()
{
  WX_CLEAR_ARRAY(languages);

  // For more information on the Borland C specifics, see the informations
  // at the end of language.cpp.
  #ifdef __BORLANDC__
  DestroyLanguagesDB();
  #endif  // __BORLANDC__
}
//---------------------------------------------------------------------------


/**
 * Changes the locale of the application.
 *
 * @param  loc  The locale to change.
 * @return <CODE>true</CODE> if the locale has been changed, <CODE>false</CODE>
 *         otherwise.
 */
bool Languages::setLocale(wxLocale& loc) const
{
  wxString locName = AppPrefs::get()->readString(prLANGUAGE_NAME);

  bool localeHasChanged = false;

  if (!locName.IsEmpty())
  {
    size_t i = 0;
    size_t c = languages.GetCount();
    while (!localeHasChanged && i < c)
    {
      localeHasChanged = languages[i]->setLocale(loc, locName);
      i++;
    }
  }

  if (!localeHasChanged)
    localeHasChanged = setLocale(loc, wxLocale::GetSystemLanguage());

  return localeHasChanged;
}
//---------------------------------------------------------------------------


/**
 * Changes the locale of the application with the given language.
 *
 * @param  loc       The locale to change.
 * @param  language  Identifier of the language.
 * @return <CODE>true</CODE> if the locale has been changed, <CODE>false</CODE>
 *         otherwise.
 */
bool Languages::setLocale(wxLocale& loc, const int language) const
{
  bool localeHasChanged = false;

  size_t i = 0;
  size_t c = languages.GetCount();
  while (!localeHasChanged && i < c)
  {
    localeHasChanged = languages[i]->setLocale(loc, language);
    i++;
  }

  return localeHasChanged;
}
//---------------------------------------------------------------------------


/**
 * Gets the number of available languages.
 *
 * @return  The number of available languages.
 */
int Languages::getLanguagesCount() const
{
  return static_cast<int>(languages.GetCount());
}
//---------------------------------------------------------------------------


/**
 * Gets the language name at the given index.
 *
 * @param  index  The index of the wanted language's name.
 * @return The language name at the given index or an empty string if the
 *         given index is invalid.
 */
wxString Languages::getLanguageName(int index) const
{
  if (index < 0 || index >= getLanguagesCount())
    return wxEmptyString;

  return languages[index]->getName();
}
//---------------------------------------------------------------------------


/**
 * Gets the language translated name at the given index.
 *
 * @param  index  The index of the wanted translated language's name.
 * @return The language translated name at the given index or an empty string
 *         if the given index is invalid.
 */
wxString Languages::getLanguageTranslatedName(const int index) const
{
  if (index < 0 || index >= getLanguagesCount())
    return wxEmptyString;

  return languages[index]->getTranslatedName();
}
//---------------------------------------------------------------------------


/**
 * Gets the language short name at the given index.
 *
 * @param  index  The index of the wanted language's short name.
 * @return The language short name at the given index or an empty string if the
 *         given index is invalid.
 */
wxString Languages::getLanguageShortName(const int index) const
{
  if (index < 0 || index >= getLanguagesCount())
    return wxEmptyString;

  return languages[index]->getShortName();
}
//---------------------------------------------------------------------------


/**
 * Gets the index of language with the given short name.
 *
 * @param  shortName  A short name of the wanted language's index.
 * @return The index of language with the given short name or
 *         <CODE>Languages::LANGUAGE_UNKNOW</CODE> if the short name doesn't
 *         correspond to a known language.
 */
int Languages::getLanguageIndexByShortName(const wxString& shortName) const
{
  int    idx = Languages::LANGUAGE_UNKNOW;
  size_t i = 0;
  size_t s = languages.GetCount();
  wxArrayString shorts;
  size_t j;  

  while (idx == Languages::LANGUAGE_UNKNOW && i < s)
  {
    shorts = languages[i]->getShortNames();
    j = shorts.Index(shortName, false);
    if (j != wxNOT_FOUND)
      idx = i;
    else
      i++;
  }

  return idx;
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the translator (in latin-1 characters) at the given index.
 *
 * @param  index  The index of the language of the wanted translator's name.
 * @return The name of the translator of the language at the given index or an
 *         empty string if the given index is invalid.
 */
wxString Languages::getLanguageTranslatorName(const int index) const
{
  if (index < 0 || index >= getLanguagesCount())
    return wxEmptyString;

  return languages[index]->getTranslatorName();
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the translator in the language at the given index.
 *
 * @param  index  The index of the language of the wanted translator's name.
 * @return The name of the translator of the language at the given index or an
 *         empty string if the given index is invalid.
 */
wxString Languages::getLanguageTranslatorNameInLocale(const int index) const
{
  if (index < 0 || index >= getLanguagesCount())
    return wxEmptyString;

  return languages[index]->getTranslatorNameInLocale();
}
//---------------------------------------------------------------------------


/**
 * Reads languages settings from a configuration file.
 *
 * @param  langFileIni  Name of the the application's languages settings to use.
 * @return <CODE>true</CODE> if at least one language definition has been read,
 *         <CODE>false</CODE> otherwise.
 */
bool Languages::readLanguagesSettings(const wxString& langFileIni)
{
  wxFileConfig config(wxT(APP_NAME), wxT(APP_AUTHOR), langFileIni,
                      wxEmptyString, wxCONFIG_USE_LOCAL_FILE);
  long idxGrp;
  wxString grpName;
  bool continueGrp;
  bool localeRead = false;

  continueGrp = config.GetFirstGroup(grpName, idxGrp);
  while (continueGrp)
  {
    wxString      name;    // Name of the language
    wxString      nameTranslated;  // Name of the language (translated)
    wxArrayString shorts;  // Short names that can be used for the language
    wxArrayInt    ids;     // Identifiers for the languages
    wxString      localeName;  // Name of the locale (compiler dependant)
    wxString      translator;  // Name of the translator (in latin-1 characters)
    wxString      translatorLoc;  // Name of the translator (in UTF-8 charset)
    wxString      line;  // temporary line of text.

    // Name of the language
    name = ::UTF8toLocal(grpName.Strip(wxString::both));

    //  Name of the language (translated)
    nameTranslated = ::UTF8toLocal(config.Read(grpName + wxT("/NameInLocale"), name).Strip(wxString::both));

    // Short names that can be used for the language
    if (config.Read(grpName + wxT("/ShortName"), &line))
      shorts.Add(::UTF8toLocal(line.Strip(wxString::both)));
    if (config.Read(grpName + wxT("/AltShorts"), &line))
    {
      wxStringTokenizer tkz(line, wxT(","), wxTOKEN_STRTOK);
      while (tkz.HasMoreTokens())
      {
        wxString token = tkz.GetNextToken().Strip(wxString::both);
        if (shorts.Index(token, false) == wxNOT_FOUND)
          shorts.Add(token);
      }
    }

    // Get the languages identifiers
    int id = ::getLanguageIdentifier(name);
    if (id != wxLANGUAGE_UNKNOWN)
      ids.Add(id);
    if (config.Read(grpName + wxT("/AltNames"), &line))
    {
      wxStringTokenizer tkz(line, wxT(","), wxTOKEN_STRTOK);
      while (tkz.HasMoreTokens())
      {
        id = ::getLanguageIdentifier(tkz.GetNextToken().Strip(wxString::both));
        if (id != wxLANGUAGE_UNKNOWN)
          ids.Add(id);
      }
    }

    // Name of the translator (in latin-1 characters)
    translator = ::UTF8toLocal(config.Read(grpName + wxT("/Translator"), _("Unknow")).Strip(wxString::both));

    // Name of the translator (in UTF-8 charset)
    translatorLoc = ::UTF8toLocal(config.Read(grpName + wxT("/TranslatorLocale"), translator).Strip(wxString::both));

    // Name of the locale (compiler dependant)
    #ifdef __BORLANDC__
    localeName = config.Read(grpName + wxT("/BorlandC"), wxEmptyString);
    #else
    localeName.Empty();
    #endif  // __BORLANDC__

    if (!name.IsEmpty() && !shorts.IsEmpty() && !ids.IsEmpty())
    {
      languages.Add(new Language(name, nameTranslated, shorts, ids, localeName,
                                 translator, translatorLoc));
      localeRead = true;
    }

    continueGrp = config.GetNextGroup(grpName, idxGrp);
  }

  return localeRead;
}
//---------------------------------------------------------------------------



//###########################################################################
// Misc functions body
//###########################################################################

/**
 * Returns the wxWidgets language identifier from a language name.
 *
 * @param  langName  Name of the language which the identifier must be returned.
 * @return The wxWidgets of the given language or
 *         <CODE>wxLANGUAGE_UNKNOWN</CODE> if the language is unknown.
 */
static int getLanguageIdentifier(const wxString langName)
{
  int res = wxLANGUAGE_UNKNOWN;

  const wxLanguageInfo* li;
  bool found = false;
  int i = wxLANGUAGE_DEFAULT;

  // Parse all languages predefined in wxWidgets
  while (!found && i < wxLANGUAGE_USER_DEFINED)
  {
    #ifdef __BORLANDC__
    li = Languages::GetLanguageInfo(i);
    #else
    li = wxLocale::GetLanguageInfo(i);
    #endif  // __BORLANDC__
    if (li != NULL)
      if (langName.CmpNoCase(li->Description) == 0)
      {
        res = li->Language;
        found = true;
      }

    i++;
  }

  return res;
}
//---------------------------------------------------------------------------



//###########################################################################
// Borland C specific part of the Languages class
//###########################################################################

#ifdef __BORLANDC__

// Static attributes of the Languages class
Languages::ArrayLanguageInfo Languages::lngInfos;

/**
 * Gets a pointer to <CODE>wxLanguageInfo</CODE> structure containing
 * information about the given language.
 *
 * Note that even if the returned pointer is valid, the caller should not
 * delete it.
 *
 * @param  lang  Identifier of the language on which the caller want information.
 * @return A pointer to <CODE>wxLanguageInfo</CODE> structure containing
 *         information about the given language or </CODE>NULL</CODE> if this
 *         language is unknown.
 */
const wxLanguageInfo* Languages::GetLanguageInfo(int lang)
{
  size_t i = 0;
  size_t s = lngInfos.GetCount();
  wxLanguageInfo* res = NULL;

  while (res == NULL && i < s)
    if (lngInfos[i]->Language == lang)
    {
      res = lngInfos[i];
    }
   else
     i++;

  return res;
}
//---------------------------------------------------------------------------


// ----------------------------------------------------------------------------
// default languages table & initialization
// ----------------------------------------------------------------------------

// Code taken from intl.cpp from wxWidgets 2.4.2


// --- --- --- generated code begins here --- --- ---

// This table is generated by misc/languages/genlang.py
// When making changes, please put them into misc/languages/langtabl.txt

#if !defined(__WIN32__) || defined(__WXMICROWIN__)

#define SETWINLANG(info,lang,sublang)

#else

#define SETWINLANG(info,lang,sublang) \
    info->WinLang = lang; info->WinSublang = sublang;

#ifndef LANG_AFRIKAANS
#define LANG_AFRIKAANS (0)
#endif
#ifndef LANG_ALBANIAN
#define LANG_ALBANIAN (0)
#endif
#ifndef LANG_ARABIC
#define LANG_ARABIC (0)
#endif
#ifndef LANG_ARMENIAN
#define LANG_ARMENIAN (0)
#endif
#ifndef LANG_ASSAMESE
#define LANG_ASSAMESE (0)
#endif
#ifndef LANG_AZERI
#define LANG_AZERI (0)
#endif
#ifndef LANG_BASQUE
#define LANG_BASQUE (0)
#endif
#ifndef LANG_BELARUSIAN
#define LANG_BELARUSIAN (0)
#endif
#ifndef LANG_BENGALI
#define LANG_BENGALI (0)
#endif
#ifndef LANG_BULGARIAN
#define LANG_BULGARIAN (0)
#endif
#ifndef LANG_CATALAN
#define LANG_CATALAN (0)
#endif
#ifndef LANG_CHINESE
#define LANG_CHINESE (0)
#endif
#ifndef LANG_CROATIAN
#define LANG_CROATIAN (0)
#endif
#ifndef LANG_CZECH
#define LANG_CZECH (0)
#endif
#ifndef LANG_DANISH
#define LANG_DANISH (0)
#endif
#ifndef LANG_DUTCH
#define LANG_DUTCH (0)
#endif
#ifndef LANG_ENGLISH
#define LANG_ENGLISH (0)
#endif
#ifndef LANG_ESTONIAN
#define LANG_ESTONIAN (0)
#endif
#ifndef LANG_FAEROESE
#define LANG_FAEROESE (0)
#endif
#ifndef LANG_FARSI
#define LANG_FARSI (0)
#endif
#ifndef LANG_FINNISH
#define LANG_FINNISH (0)
#endif
#ifndef LANG_FRENCH
#define LANG_FRENCH (0)
#endif
#ifndef LANG_GEORGIAN
#define LANG_GEORGIAN (0)
#endif
#ifndef LANG_GERMAN
#define LANG_GERMAN (0)
#endif
#ifndef LANG_GREEK
#define LANG_GREEK (0)
#endif
#ifndef LANG_GUJARATI
#define LANG_GUJARATI (0)
#endif
#ifndef LANG_HEBREW
#define LANG_HEBREW (0)
#endif
#ifndef LANG_HINDI
#define LANG_HINDI (0)
#endif
#ifndef LANG_HUNGARIAN
#define LANG_HUNGARIAN (0)
#endif
#ifndef LANG_ICELANDIC
#define LANG_ICELANDIC (0)
#endif
#ifndef LANG_INDONESIAN
#define LANG_INDONESIAN (0)
#endif
#ifndef LANG_ITALIAN
#define LANG_ITALIAN (0)
#endif
#ifndef LANG_JAPANESE
#define LANG_JAPANESE (0)
#endif
#ifndef LANG_KANNADA
#define LANG_KANNADA (0)
#endif
#ifndef LANG_KASHMIRI
#define LANG_KASHMIRI (0)
#endif
#ifndef LANG_KAZAK
#define LANG_KAZAK (0)
#endif
#ifndef LANG_KONKANI
#define LANG_KONKANI (0)
#endif
#ifndef LANG_KOREAN
#define LANG_KOREAN (0)
#endif
#ifndef LANG_LATVIAN
#define LANG_LATVIAN (0)
#endif
#ifndef LANG_LITHUANIAN
#define LANG_LITHUANIAN (0)
#endif
#ifndef LANG_MACEDONIAN
#define LANG_MACEDONIAN (0)
#endif
#ifndef LANG_MALAY
#define LANG_MALAY (0)
#endif
#ifndef LANG_MALAYALAM
#define LANG_MALAYALAM (0)
#endif
#ifndef LANG_MANIPURI
#define LANG_MANIPURI (0)
#endif
#ifndef LANG_MARATHI
#define LANG_MARATHI (0)
#endif
#ifndef LANG_NEPALI
#define LANG_NEPALI (0)
#endif
#ifndef LANG_NORWEGIAN
#define LANG_NORWEGIAN (0)
#endif
#ifndef LANG_ORIYA
#define LANG_ORIYA (0)
#endif
#ifndef LANG_POLISH
#define LANG_POLISH (0)
#endif
#ifndef LANG_PORTUGUESE
#define LANG_PORTUGUESE (0)
#endif
#ifndef LANG_PUNJABI
#define LANG_PUNJABI (0)
#endif
#ifndef LANG_ROMANIAN
#define LANG_ROMANIAN (0)
#endif
#ifndef LANG_RUSSIAN
#define LANG_RUSSIAN (0)
#endif
#ifndef LANG_SANSKRIT
#define LANG_SANSKRIT (0)
#endif
#ifndef LANG_SERBIAN
#define LANG_SERBIAN (0)
#endif
#ifndef LANG_SINDHI
#define LANG_SINDHI (0)
#endif
#ifndef LANG_SLOVAK
#define LANG_SLOVAK (0)
#endif
#ifndef LANG_SLOVENIAN
#define LANG_SLOVENIAN (0)
#endif
#ifndef LANG_SPANISH
#define LANG_SPANISH (0)
#endif
#ifndef LANG_SWAHILI
#define LANG_SWAHILI (0)
#endif
#ifndef LANG_SWEDISH
#define LANG_SWEDISH (0)
#endif
#ifndef LANG_TAMIL
#define LANG_TAMIL (0)
#endif
#ifndef LANG_TATAR
#define LANG_TATAR (0)
#endif
#ifndef LANG_TELUGU
#define LANG_TELUGU (0)
#endif
#ifndef LANG_THAI
#define LANG_THAI (0)
#endif
#ifndef LANG_TURKISH
#define LANG_TURKISH (0)
#endif
#ifndef LANG_UKRAINIAN
#define LANG_UKRAINIAN (0)
#endif
#ifndef LANG_URDU
#define LANG_URDU (0)
#endif
#ifndef LANG_UZBEK
#define LANG_UZBEK (0)
#endif
#ifndef LANG_VIETNAMESE
#define LANG_VIETNAMESE (0)
#endif
#ifndef SUBLANG_ARABIC_ALGERIA
#define SUBLANG_ARABIC_ALGERIA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_BAHRAIN
#define SUBLANG_ARABIC_BAHRAIN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_EGYPT
#define SUBLANG_ARABIC_EGYPT SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_IRAQ
#define SUBLANG_ARABIC_IRAQ SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_JORDAN
#define SUBLANG_ARABIC_JORDAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_KUWAIT
#define SUBLANG_ARABIC_KUWAIT SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_LEBANON
#define SUBLANG_ARABIC_LEBANON SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_LIBYA
#define SUBLANG_ARABIC_LIBYA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_MOROCCO
#define SUBLANG_ARABIC_MOROCCO SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_OMAN
#define SUBLANG_ARABIC_OMAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_QATAR
#define SUBLANG_ARABIC_QATAR SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_SAUDI_ARABIA
#define SUBLANG_ARABIC_SAUDI_ARABIA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_SYRIA
#define SUBLANG_ARABIC_SYRIA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_TUNISIA
#define SUBLANG_ARABIC_TUNISIA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_UAE
#define SUBLANG_ARABIC_UAE SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ARABIC_YEMEN
#define SUBLANG_ARABIC_YEMEN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_AZERI_CYRILLIC
#define SUBLANG_AZERI_CYRILLIC SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_AZERI_LATIN
#define SUBLANG_AZERI_LATIN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_CHINESE_SIMPLIFIED
#define SUBLANG_CHINESE_SIMPLIFIED SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_CHINESE_TRADITIONAL
#define SUBLANG_CHINESE_TRADITIONAL SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_CHINESE_HONGKONG
#define SUBLANG_CHINESE_HONGKONG SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_CHINESE_MACAU
#define SUBLANG_CHINESE_MACAU SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_CHINESE_SINGAPORE
#define SUBLANG_CHINESE_SINGAPORE SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_DUTCH
#define SUBLANG_DUTCH SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_DUTCH_BELGIAN
#define SUBLANG_DUTCH_BELGIAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_UK
#define SUBLANG_ENGLISH_UK SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_US
#define SUBLANG_ENGLISH_US SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_AUS
#define SUBLANG_ENGLISH_AUS SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_BELIZE
#define SUBLANG_ENGLISH_BELIZE SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_CAN
#define SUBLANG_ENGLISH_CAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_CARIBBEAN
#define SUBLANG_ENGLISH_CARIBBEAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_EIRE
#define SUBLANG_ENGLISH_EIRE SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_JAMAICA
#define SUBLANG_ENGLISH_JAMAICA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_NZ
#define SUBLANG_ENGLISH_NZ SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_PHILIPPINES
#define SUBLANG_ENGLISH_PHILIPPINES SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_SOUTH_AFRICA
#define SUBLANG_ENGLISH_SOUTH_AFRICA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_TRINIDAD
#define SUBLANG_ENGLISH_TRINIDAD SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ENGLISH_ZIMBABWE
#define SUBLANG_ENGLISH_ZIMBABWE SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_FRENCH
#define SUBLANG_FRENCH SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_FRENCH_BELGIAN
#define SUBLANG_FRENCH_BELGIAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_FRENCH_CANADIAN
#define SUBLANG_FRENCH_CANADIAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_FRENCH_LUXEMBOURG
#define SUBLANG_FRENCH_LUXEMBOURG SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_FRENCH_MONACO
#define SUBLANG_FRENCH_MONACO SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_FRENCH_SWISS
#define SUBLANG_FRENCH_SWISS SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_GERMAN
#define SUBLANG_GERMAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_GERMAN_AUSTRIAN
#define SUBLANG_GERMAN_AUSTRIAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_GERMAN_LIECHTENSTEIN
#define SUBLANG_GERMAN_LIECHTENSTEIN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_GERMAN_LUXEMBOURG
#define SUBLANG_GERMAN_LUXEMBOURG SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_GERMAN_SWISS
#define SUBLANG_GERMAN_SWISS SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ITALIAN
#define SUBLANG_ITALIAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_ITALIAN_SWISS
#define SUBLANG_ITALIAN_SWISS SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_KASHMIRI_INDIA
#define SUBLANG_KASHMIRI_INDIA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_KOREAN
#define SUBLANG_KOREAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_LITHUANIAN
#define SUBLANG_LITHUANIAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_MALAY_BRUNEI_DARUSSALAM
#define SUBLANG_MALAY_BRUNEI_DARUSSALAM SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_MALAY_MALAYSIA
#define SUBLANG_MALAY_MALAYSIA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_NEPALI_INDIA
#define SUBLANG_NEPALI_INDIA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_NORWEGIAN_BOKMAL
#define SUBLANG_NORWEGIAN_BOKMAL SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_NORWEGIAN_NYNORSK
#define SUBLANG_NORWEGIAN_NYNORSK SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_PORTUGUESE
#define SUBLANG_PORTUGUESE SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_PORTUGUESE_BRAZILIAN
#define SUBLANG_PORTUGUESE_BRAZILIAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SERBIAN_CYRILLIC
#define SUBLANG_SERBIAN_CYRILLIC SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SERBIAN_LATIN
#define SUBLANG_SERBIAN_LATIN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH
#define SUBLANG_SPANISH SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_ARGENTINA
#define SUBLANG_SPANISH_ARGENTINA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_BOLIVIA
#define SUBLANG_SPANISH_BOLIVIA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_CHILE
#define SUBLANG_SPANISH_CHILE SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_COLOMBIA
#define SUBLANG_SPANISH_COLOMBIA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_COSTA_RICA
#define SUBLANG_SPANISH_COSTA_RICA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_DOMINICAN_REPUBLIC
#define SUBLANG_SPANISH_DOMINICAN_REPUBLIC SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_ECUADOR
#define SUBLANG_SPANISH_ECUADOR SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_EL_SALVADOR
#define SUBLANG_SPANISH_EL_SALVADOR SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_GUATEMALA
#define SUBLANG_SPANISH_GUATEMALA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_HONDURAS
#define SUBLANG_SPANISH_HONDURAS SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_MEXICAN
#define SUBLANG_SPANISH_MEXICAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_MODERN
#define SUBLANG_SPANISH_MODERN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_NICARAGUA
#define SUBLANG_SPANISH_NICARAGUA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_PANAMA
#define SUBLANG_SPANISH_PANAMA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_PARAGUAY
#define SUBLANG_SPANISH_PARAGUAY SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_PERU
#define SUBLANG_SPANISH_PERU SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_PUERTO_RICO
#define SUBLANG_SPANISH_PUERTO_RICO SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_URUGUAY
#define SUBLANG_SPANISH_URUGUAY SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SPANISH_VENEZUELA
#define SUBLANG_SPANISH_VENEZUELA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SWEDISH
#define SUBLANG_SWEDISH SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_SWEDISH_FINLAND
#define SUBLANG_SWEDISH_FINLAND SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_URDU_INDIA
#define SUBLANG_URDU_INDIA SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_URDU_PAKISTAN
#define SUBLANG_URDU_PAKISTAN SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_UZBEK_CYRILLIC
#define SUBLANG_UZBEK_CYRILLIC SUBLANG_DEFAULT
#endif
#ifndef SUBLANG_UZBEK_LATIN
#define SUBLANG_UZBEK_LATIN SUBLANG_DEFAULT
#endif


#endif // __WIN32__

#define LNG(wxlang, canonical, winlang, winsublang, desc) \
    info = new wxLanguageInfo;                            \
    info->Language = wxlang;                              \
    info->CanonicalName = wxT(canonical);                 \
    info->Description = wxT(desc);                        \
    SETWINLANG(info, winlang, winsublang)                 \
    lngInfos.Add(info);


/**
 * Creates on new database of known languages.
 */
void Languages::CreateLanguagesDB()
{
   wxLanguageInfo* info;

   LNG(wxLANGUAGE_ABKHAZIAN,                  "ab"   , 0              , 0                                 , "Abkhazian")
   LNG(wxLANGUAGE_AFAR,                       "aa"   , 0              , 0                                 , "Afar")
   LNG(wxLANGUAGE_AFRIKAANS,                  "af_ZA", LANG_AFRIKAANS , SUBLANG_DEFAULT                   , "Afrikaans")
   LNG(wxLANGUAGE_ALBANIAN,                   "sq_AL", LANG_ALBANIAN  , SUBLANG_DEFAULT                   , "Albanian")
   LNG(wxLANGUAGE_AMHARIC,                    "am"   , 0              , 0                                 , "Amharic")
   LNG(wxLANGUAGE_ARABIC,                     "ar"   , LANG_ARABIC    , SUBLANG_DEFAULT                   , "Arabic")
   LNG(wxLANGUAGE_ARABIC_ALGERIA,             "ar_DZ", LANG_ARABIC    , SUBLANG_ARABIC_ALGERIA            , "Arabic (Algeria)")
   LNG(wxLANGUAGE_ARABIC_BAHRAIN,             "ar_BH", LANG_ARABIC    , SUBLANG_ARABIC_BAHRAIN            , "Arabic (Bahrain)")
   LNG(wxLANGUAGE_ARABIC_EGYPT,               "ar_EG", LANG_ARABIC    , SUBLANG_ARABIC_EGYPT              , "Arabic (Egypt)")
   LNG(wxLANGUAGE_ARABIC_IRAQ,                "ar_IQ", LANG_ARABIC    , SUBLANG_ARABIC_IRAQ               , "Arabic (Iraq)")
   LNG(wxLANGUAGE_ARABIC_JORDAN,              "ar_JO", LANG_ARABIC    , SUBLANG_ARABIC_JORDAN             , "Arabic (Jordan)")
   LNG(wxLANGUAGE_ARABIC_KUWAIT,              "ar_KW", LANG_ARABIC    , SUBLANG_ARABIC_KUWAIT             , "Arabic (Kuwait)")
   LNG(wxLANGUAGE_ARABIC_LEBANON,             "ar_LB", LANG_ARABIC    , SUBLANG_ARABIC_LEBANON            , "Arabic (Lebanon)")
   LNG(wxLANGUAGE_ARABIC_LIBYA,               "ar_LY", LANG_ARABIC    , SUBLANG_ARABIC_LIBYA              , "Arabic (Libya)")
   LNG(wxLANGUAGE_ARABIC_MOROCCO,             "ar_MA", LANG_ARABIC    , SUBLANG_ARABIC_MOROCCO            , "Arabic (Morocco)")
   LNG(wxLANGUAGE_ARABIC_OMAN,                "ar_OM", LANG_ARABIC    , SUBLANG_ARABIC_OMAN               , "Arabic (Oman)")
   LNG(wxLANGUAGE_ARABIC_QATAR,               "ar_QA", LANG_ARABIC    , SUBLANG_ARABIC_QATAR              , "Arabic (Qatar)")
   LNG(wxLANGUAGE_ARABIC_SAUDI_ARABIA,        "ar_SA", LANG_ARABIC    , SUBLANG_ARABIC_SAUDI_ARABIA       , "Arabic (Saudi Arabia)")
   LNG(wxLANGUAGE_ARABIC_SUDAN,               "ar_SD", 0              , 0                                 , "Arabic (Sudan)")
   LNG(wxLANGUAGE_ARABIC_SYRIA,               "ar_SY", LANG_ARABIC    , SUBLANG_ARABIC_SYRIA              , "Arabic (Syria)")
   LNG(wxLANGUAGE_ARABIC_TUNISIA,             "ar_TN", LANG_ARABIC    , SUBLANG_ARABIC_TUNISIA            , "Arabic (Tunisia)")
   LNG(wxLANGUAGE_ARABIC_UAE,                 "ar_AE", LANG_ARABIC    , SUBLANG_ARABIC_UAE                , "Arabic (Uae)")
   LNG(wxLANGUAGE_ARABIC_YEMEN,               "ar_YE", LANG_ARABIC    , SUBLANG_ARABIC_YEMEN              , "Arabic (Yemen)")
   LNG(wxLANGUAGE_ARMENIAN,                   "hy"   , LANG_ARMENIAN  , SUBLANG_DEFAULT                   , "Armenian")
   LNG(wxLANGUAGE_ASSAMESE,                   "as"   , LANG_ASSAMESE  , SUBLANG_DEFAULT                   , "Assamese")
   LNG(wxLANGUAGE_AYMARA,                     "ay"   , 0              , 0                                 , "Aymara")
   LNG(wxLANGUAGE_AZERI,                      "az"   , LANG_AZERI     , SUBLANG_DEFAULT                   , "Azeri")
   LNG(wxLANGUAGE_AZERI_CYRILLIC,             "az"   , LANG_AZERI     , SUBLANG_AZERI_CYRILLIC            , "Azeri (Cyrillic)")
   LNG(wxLANGUAGE_AZERI_LATIN,                "az"   , LANG_AZERI     , SUBLANG_AZERI_LATIN               , "Azeri (Latin)")
   LNG(wxLANGUAGE_BASHKIR,                    "ba"   , 0              , 0                                 , "Bashkir")
   LNG(wxLANGUAGE_BASQUE,                     "eu_ES", LANG_BASQUE    , SUBLANG_DEFAULT                   , "Basque")
   LNG(wxLANGUAGE_BELARUSIAN,                 "be_BY", LANG_BELARUSIAN, SUBLANG_DEFAULT                   , "Belarusian")
   LNG(wxLANGUAGE_BENGALI,                    "bn"   , LANG_BENGALI   , SUBLANG_DEFAULT                   , "Bengali")
   LNG(wxLANGUAGE_BHUTANI,                    "dz"   , 0              , 0                                 , "Bhutani")
   LNG(wxLANGUAGE_BIHARI,                     "bh"   , 0              , 0                                 , "Bihari")
   LNG(wxLANGUAGE_BISLAMA,                    "bi"   , 0              , 0                                 , "Bislama")
   LNG(wxLANGUAGE_BRETON,                     "br"   , 0              , 0                                 , "Breton")
   LNG(wxLANGUAGE_BULGARIAN,                  "bg_BG", LANG_BULGARIAN , SUBLANG_DEFAULT                   , "Bulgarian")
   LNG(wxLANGUAGE_BURMESE,                    "my"   , 0              , 0                                 , "Burmese")
   LNG(wxLANGUAGE_CAMBODIAN,                  "km"   , 0              , 0                                 , "Cambodian")
   LNG(wxLANGUAGE_CATALAN,                    "ca_ES", LANG_CATALAN   , SUBLANG_DEFAULT                   , "Catalan")
   LNG(wxLANGUAGE_CHINESE,                    "zh_CN", LANG_CHINESE   , SUBLANG_DEFAULT                   , "Chinese")
   LNG(wxLANGUAGE_CHINESE_SIMPLIFIED,         "zh_CN", LANG_CHINESE   , SUBLANG_CHINESE_SIMPLIFIED        , "Chinese (Simplified)")
   LNG(wxLANGUAGE_CHINESE_TRADITIONAL,        "zh_TW", LANG_CHINESE   , SUBLANG_CHINESE_TRADITIONAL       , "Chinese (Traditional)")
   LNG(wxLANGUAGE_CHINESE_HONGKONG,           "zh_HK", LANG_CHINESE   , SUBLANG_CHINESE_HONGKONG          , "Chinese (Hongkong)")
   LNG(wxLANGUAGE_CHINESE_MACAU,              "zh_MO", LANG_CHINESE   , SUBLANG_CHINESE_MACAU             , "Chinese (Macau)")
   LNG(wxLANGUAGE_CHINESE_SINGAPORE,          "zh_SG", LANG_CHINESE   , SUBLANG_CHINESE_SINGAPORE         , "Chinese (Singapore)")
   LNG(wxLANGUAGE_CHINESE_TAIWAN,             "zh_TW", LANG_CHINESE   , SUBLANG_CHINESE_TRADITIONAL       , "Chinese (Taiwan)")
   LNG(wxLANGUAGE_CORSICAN,                   "co"   , 0              , 0                                 , "Corsican")
   LNG(wxLANGUAGE_CROATIAN,                   "hr_HR", LANG_CROATIAN  , SUBLANG_DEFAULT                   , "Croatian")
   LNG(wxLANGUAGE_CZECH,                      "cs_CZ", LANG_CZECH     , SUBLANG_DEFAULT                   , "Czech")
   LNG(wxLANGUAGE_DANISH,                     "da_DK", LANG_DANISH    , SUBLANG_DEFAULT                   , "Danish")
   LNG(wxLANGUAGE_DUTCH,                      "nl_NL", LANG_DUTCH     , SUBLANG_DUTCH                     , "Dutch")
   LNG(wxLANGUAGE_DUTCH_BELGIAN,              "nl_BE", LANG_DUTCH     , SUBLANG_DUTCH_BELGIAN             , "Dutch (Belgian)")
   LNG(wxLANGUAGE_ENGLISH,                    "en_GB", LANG_ENGLISH   , SUBLANG_ENGLISH_UK                , "English")
   LNG(wxLANGUAGE_ENGLISH_UK,                 "en_GB", LANG_ENGLISH   , SUBLANG_ENGLISH_UK                , "English (U.K.)")
   LNG(wxLANGUAGE_ENGLISH_US,                 "en_US", LANG_ENGLISH   , SUBLANG_ENGLISH_US                , "English (U.S.)")
   LNG(wxLANGUAGE_ENGLISH_AUSTRALIA,          "en_AU", LANG_ENGLISH   , SUBLANG_ENGLISH_AUS               , "English (Australia)")
   LNG(wxLANGUAGE_ENGLISH_BELIZE,             "en_BZ", LANG_ENGLISH   , SUBLANG_ENGLISH_BELIZE            , "English (Belize)")
   LNG(wxLANGUAGE_ENGLISH_BOTSWANA,           "en_BW", 0              , 0                                 , "English (Botswana)")
   LNG(wxLANGUAGE_ENGLISH_CANADA,             "en_CA", LANG_ENGLISH   , SUBLANG_ENGLISH_CAN               , "English (Canada)")
   LNG(wxLANGUAGE_ENGLISH_CARIBBEAN,          "en_CB", LANG_ENGLISH   , SUBLANG_ENGLISH_CARIBBEAN         , "English (Caribbean)")
   LNG(wxLANGUAGE_ENGLISH_DENMARK,            "en_DK", 0              , 0                                 , "English (Denmark)")
   LNG(wxLANGUAGE_ENGLISH_EIRE,               "en_IE", LANG_ENGLISH   , SUBLANG_ENGLISH_EIRE              , "English (Eire)")
   LNG(wxLANGUAGE_ENGLISH_JAMAICA,            "en_JM", LANG_ENGLISH   , SUBLANG_ENGLISH_JAMAICA           , "English (Jamaica)")
   LNG(wxLANGUAGE_ENGLISH_NEW_ZEALAND,        "en_NZ", LANG_ENGLISH   , SUBLANG_ENGLISH_NZ                , "English (New Zealand)")
   LNG(wxLANGUAGE_ENGLISH_PHILIPPINES,        "en_PH", LANG_ENGLISH   , SUBLANG_ENGLISH_PHILIPPINES       , "English (Philippines)")
   LNG(wxLANGUAGE_ENGLISH_SOUTH_AFRICA,       "en_ZA", LANG_ENGLISH   , SUBLANG_ENGLISH_SOUTH_AFRICA      , "English (South Africa)")
   LNG(wxLANGUAGE_ENGLISH_TRINIDAD,           "en_TT", LANG_ENGLISH   , SUBLANG_ENGLISH_TRINIDAD          , "English (Trinidad)")
   LNG(wxLANGUAGE_ENGLISH_ZIMBABWE,           "en_ZW", LANG_ENGLISH   , SUBLANG_ENGLISH_ZIMBABWE          , "English (Zimbabwe)")
   LNG(wxLANGUAGE_ESPERANTO,                  "eo"   , 0              , 0                                 , "Esperanto")
   LNG(wxLANGUAGE_ESTONIAN,                   "et_EE", LANG_ESTONIAN  , SUBLANG_DEFAULT                   , "Estonian")
   LNG(wxLANGUAGE_FAEROESE,                   "fo_FO", LANG_FAEROESE  , SUBLANG_DEFAULT                   , "Faeroese")
   LNG(wxLANGUAGE_FARSI,                      "fa_IR", LANG_FARSI     , SUBLANG_DEFAULT                   , "Farsi")
   LNG(wxLANGUAGE_FIJI,                       "fj"   , 0              , 0                                 , "Fiji")
   LNG(wxLANGUAGE_FINNISH,                    "fi_FI", LANG_FINNISH   , SUBLANG_DEFAULT                   , "Finnish")
   LNG(wxLANGUAGE_FRENCH,                     "fr_FR", LANG_FRENCH    , SUBLANG_FRENCH                    , "French")
   LNG(wxLANGUAGE_FRENCH_BELGIAN,             "fr_BE", LANG_FRENCH    , SUBLANG_FRENCH_BELGIAN            , "French (Belgian)")
   LNG(wxLANGUAGE_FRENCH_CANADIAN,            "fr_CA", LANG_FRENCH    , SUBLANG_FRENCH_CANADIAN           , "French (Canadian)")
   LNG(wxLANGUAGE_FRENCH_LUXEMBOURG,          "fr_LU", LANG_FRENCH    , SUBLANG_FRENCH_LUXEMBOURG         , "French (Luxembourg)")
   LNG(wxLANGUAGE_FRENCH_MONACO,              "fr_MC", LANG_FRENCH    , SUBLANG_FRENCH_MONACO             , "French (Monaco)")
   LNG(wxLANGUAGE_FRENCH_SWISS,               "fr_CH", LANG_FRENCH    , SUBLANG_FRENCH_SWISS              , "French (Swiss)")
   LNG(wxLANGUAGE_FRISIAN,                    "fy"   , 0              , 0                                 , "Frisian")
   LNG(wxLANGUAGE_GALICIAN,                   "gl_ES", 0              , 0                                 , "Galician")
   LNG(wxLANGUAGE_GEORGIAN,                   "ka"   , LANG_GEORGIAN  , SUBLANG_DEFAULT                   , "Georgian")
   LNG(wxLANGUAGE_GERMAN,                     "de_DE", LANG_GERMAN    , SUBLANG_GERMAN                    , "German")
   LNG(wxLANGUAGE_GERMAN_AUSTRIAN,            "de_AT", LANG_GERMAN    , SUBLANG_GERMAN_AUSTRIAN           , "German (Austrian)")
   LNG(wxLANGUAGE_GERMAN_BELGIUM,             "de_BE", 0              , 0                                 , "German (Belgium)")
   LNG(wxLANGUAGE_GERMAN_LIECHTENSTEIN,       "de_LI", LANG_GERMAN    , SUBLANG_GERMAN_LIECHTENSTEIN      , "German (Liechtenstein)")
   LNG(wxLANGUAGE_GERMAN_LUXEMBOURG,          "de_LU", LANG_GERMAN    , SUBLANG_GERMAN_LUXEMBOURG         , "German (Luxembourg)")
   LNG(wxLANGUAGE_GERMAN_SWISS,               "de_CH", LANG_GERMAN    , SUBLANG_GERMAN_SWISS              , "German (Swiss)")
   LNG(wxLANGUAGE_GREEK,                      "el_GR", LANG_GREEK     , SUBLANG_DEFAULT                   , "Greek")
   LNG(wxLANGUAGE_GREENLANDIC,                "kl_GL", 0              , 0                                 , "Greenlandic")
   LNG(wxLANGUAGE_GUARANI,                    "gn"   , 0              , 0                                 , "Guarani")
   LNG(wxLANGUAGE_GUJARATI,                   "gu"   , LANG_GUJARATI  , SUBLANG_DEFAULT                   , "Gujarati")
   LNG(wxLANGUAGE_HAUSA,                      "ha"   , 0              , 0                                 , "Hausa")
   LNG(wxLANGUAGE_HEBREW,                     "he_IL", LANG_HEBREW    , SUBLANG_DEFAULT                   , "Hebrew")
   LNG(wxLANGUAGE_HINDI,                      "hi_IN", LANG_HINDI     , SUBLANG_DEFAULT                   , "Hindi")
   LNG(wxLANGUAGE_HUNGARIAN,                  "hu_HU", LANG_HUNGARIAN , SUBLANG_DEFAULT                   , "Hungarian")
   LNG(wxLANGUAGE_ICELANDIC,                  "is_IS", LANG_ICELANDIC , SUBLANG_DEFAULT                   , "Icelandic")
   LNG(wxLANGUAGE_INDONESIAN,                 "id_ID", LANG_INDONESIAN, SUBLANG_DEFAULT                   , "Indonesian")
   LNG(wxLANGUAGE_INTERLINGUA,                "ia"   , 0              , 0                                 , "Interlingua")
   LNG(wxLANGUAGE_INTERLINGUE,                "ie"   , 0              , 0                                 , "Interlingue")
   LNG(wxLANGUAGE_INUKTITUT,                  "iu"   , 0              , 0                                 , "Inuktitut")
   LNG(wxLANGUAGE_INUPIAK,                    "ik"   , 0              , 0                                 , "Inupiak")
   LNG(wxLANGUAGE_IRISH,                      "ga_IE", 0              , 0                                 , "Irish")
   LNG(wxLANGUAGE_ITALIAN,                    "it_IT", LANG_ITALIAN   , SUBLANG_ITALIAN                   , "Italian")
   LNG(wxLANGUAGE_ITALIAN_SWISS,              "it_CH", LANG_ITALIAN   , SUBLANG_ITALIAN_SWISS             , "Italian (Swiss)")
   LNG(wxLANGUAGE_JAPANESE,                   "ja_JP", LANG_JAPANESE  , SUBLANG_DEFAULT                   , "Japanese")
   LNG(wxLANGUAGE_JAVANESE,                   "jw"   , 0              , 0                                 , "Javanese")
   LNG(wxLANGUAGE_KANNADA,                    "kn"   , LANG_KANNADA   , SUBLANG_DEFAULT                   , "Kannada")
   LNG(wxLANGUAGE_KASHMIRI,                   "ks"   , LANG_KASHMIRI  , SUBLANG_DEFAULT                   , "Kashmiri")
   LNG(wxLANGUAGE_KASHMIRI_INDIA,             "ks_IN", LANG_KASHMIRI  , SUBLANG_KASHMIRI_INDIA            , "Kashmiri (India)")
   LNG(wxLANGUAGE_KAZAKH,                     "kk"   , LANG_KAZAK     , SUBLANG_DEFAULT                   , "Kazakh")
   LNG(wxLANGUAGE_KERNEWEK,                   "kw_GB", 0              , 0                                 , "Kernewek")
   LNG(wxLANGUAGE_KINYARWANDA,                "rw"   , 0              , 0                                 , "Kinyarwanda")
   LNG(wxLANGUAGE_KIRGHIZ,                    "ky"   , 0              , 0                                 , "Kirghiz")
   LNG(wxLANGUAGE_KIRUNDI,                    "rn"   , 0              , 0                                 , "Kirundi")
   LNG(wxLANGUAGE_KONKANI,                    ""     , LANG_KONKANI   , SUBLANG_DEFAULT                   , "Konkani")
   LNG(wxLANGUAGE_KOREAN,                     "ko_KR", LANG_KOREAN    , SUBLANG_KOREAN                    , "Korean")
   LNG(wxLANGUAGE_KURDISH,                    "ku"   , 0              , 0                                 , "Kurdish")
   LNG(wxLANGUAGE_LAOTHIAN,                   "lo"   , 0              , 0                                 , "Laothian")
   LNG(wxLANGUAGE_LATIN,                      "la"   , 0              , 0                                 , "Latin")
   LNG(wxLANGUAGE_LATVIAN,                    "lv_LV", LANG_LATVIAN   , SUBLANG_DEFAULT                   , "Latvian")
   LNG(wxLANGUAGE_LINGALA,                    "ln"   , 0              , 0                                 , "Lingala")
   LNG(wxLANGUAGE_LITHUANIAN,                 "lt_LT", LANG_LITHUANIAN, SUBLANG_LITHUANIAN                , "Lithuanian")
   LNG(wxLANGUAGE_MACEDONIAN,                 "mk_MK", LANG_MACEDONIAN, SUBLANG_DEFAULT                   , "Macedonian")
   LNG(wxLANGUAGE_MALAGASY,                   "mg"   , 0              , 0                                 , "Malagasy")
   LNG(wxLANGUAGE_MALAY,                      "ms_MY", LANG_MALAY     , SUBLANG_DEFAULT                   , "Malay")
   LNG(wxLANGUAGE_MALAYALAM,                  "ml"   , LANG_MALAYALAM , SUBLANG_DEFAULT                   , "Malayalam")
   LNG(wxLANGUAGE_MALAY_BRUNEI_DARUSSALAM,    "ms_BN", LANG_MALAY     , SUBLANG_MALAY_BRUNEI_DARUSSALAM   , "Malay (Brunei Darussalam)")
   LNG(wxLANGUAGE_MALAY_MALAYSIA,             "ms_MY", LANG_MALAY     , SUBLANG_MALAY_MALAYSIA            , "Malay (Malaysia)")
   LNG(wxLANGUAGE_MALTESE,                    "mt_MT", 0              , 0                                 , "Maltese")
   LNG(wxLANGUAGE_MANIPURI,                   ""     , LANG_MANIPURI  , SUBLANG_DEFAULT                   , "Manipuri")
   LNG(wxLANGUAGE_MAORI,                      "mi"   , 0              , 0                                 , "Maori")
   LNG(wxLANGUAGE_MARATHI,                    "mr_IN", LANG_MARATHI   , SUBLANG_DEFAULT                   , "Marathi")
   LNG(wxLANGUAGE_MOLDAVIAN,                  "mo"   , 0              , 0                                 , "Moldavian")
   LNG(wxLANGUAGE_MONGOLIAN,                  "mn"   , 0              , 0                                 , "Mongolian")
   LNG(wxLANGUAGE_NAURU,                      "na"   , 0              , 0                                 , "Nauru")
   LNG(wxLANGUAGE_NEPALI,                     "ne"   , LANG_NEPALI    , SUBLANG_DEFAULT                   , "Nepali")
   LNG(wxLANGUAGE_NEPALI_INDIA,               "ne_IN", LANG_NEPALI    , SUBLANG_NEPALI_INDIA              , "Nepali (India)")
   LNG(wxLANGUAGE_NORWEGIAN_BOKMAL,           "nb_NO", LANG_NORWEGIAN , SUBLANG_NORWEGIAN_BOKMAL          , "Norwegian (Bokmal)")
   LNG(wxLANGUAGE_NORWEGIAN_NYNORSK,          "nn_NO", LANG_NORWEGIAN , SUBLANG_NORWEGIAN_NYNORSK         , "Norwegian (Nynorsk)")
   LNG(wxLANGUAGE_OCCITAN,                    "oc"   , 0              , 0                                 , "Occitan")
   LNG(wxLANGUAGE_ORIYA,                      "or"   , LANG_ORIYA     , SUBLANG_DEFAULT                   , "Oriya")
   LNG(wxLANGUAGE_OROMO,                      "om"   , 0              , 0                                 , "(Afan) Oromo")
   LNG(wxLANGUAGE_PASHTO,                     "ps"   , 0              , 0                                 , "Pashto, Pushto")
   LNG(wxLANGUAGE_POLISH,                     "pl_PL", LANG_POLISH    , SUBLANG_DEFAULT                   , "Polish")
   LNG(wxLANGUAGE_PORTUGUESE,                 "pt_PT", LANG_PORTUGUESE, SUBLANG_PORTUGUESE                , "Portuguese")
   LNG(wxLANGUAGE_PORTUGUESE_BRAZILIAN,       "pt_BR", LANG_PORTUGUESE, SUBLANG_PORTUGUESE_BRAZILIAN      , "Portuguese (Brazilian)")
   LNG(wxLANGUAGE_PUNJABI,                    "pa"   , LANG_PUNJABI   , SUBLANG_DEFAULT                   , "Punjabi")
   LNG(wxLANGUAGE_QUECHUA,                    "qu"   , 0              , 0                                 , "Quechua")
   LNG(wxLANGUAGE_RHAETO_ROMANCE,             "rm"   , 0              , 0                                 , "Rhaeto-Romance")
   LNG(wxLANGUAGE_ROMANIAN,                   "ro_RO", LANG_ROMANIAN  , SUBLANG_DEFAULT                   , "Romanian")
   LNG(wxLANGUAGE_RUSSIAN,                    "ru_RU", LANG_RUSSIAN   , SUBLANG_DEFAULT                   , "Russian")
   LNG(wxLANGUAGE_RUSSIAN_UKRAINE,            "ru_UA", 0              , 0                                 , "Russian (Ukraine)")
   LNG(wxLANGUAGE_SAMOAN,                     "sm"   , 0              , 0                                 , "Samoan")
   LNG(wxLANGUAGE_SANGHO,                     "sg"   , 0              , 0                                 , "Sangho")
   LNG(wxLANGUAGE_SANSKRIT,                   "sa"   , LANG_SANSKRIT  , SUBLANG_DEFAULT                   , "Sanskrit")
   LNG(wxLANGUAGE_SCOTS_GAELIC,               "gd"   , 0              , 0                                 , "Scots Gaelic")
   LNG(wxLANGUAGE_SERBIAN,                    "sr_YU", LANG_SERBIAN   , SUBLANG_DEFAULT                   , "Serbian")
   LNG(wxLANGUAGE_SERBIAN_CYRILLIC,           "sr_YU", LANG_SERBIAN   , SUBLANG_SERBIAN_CYRILLIC          , "Serbian (Cyrillic)")
   LNG(wxLANGUAGE_SERBIAN_LATIN,              "sr_YU", LANG_SERBIAN   , SUBLANG_SERBIAN_LATIN             , "Serbian (Latin)")
   LNG(wxLANGUAGE_SERBO_CROATIAN,             "sh"   , 0              , 0                                 , "Serbo-Croatian")
   LNG(wxLANGUAGE_SESOTHO,                    "st"   , 0              , 0                                 , "Sesotho")
   LNG(wxLANGUAGE_SETSWANA,                   "tn"   , 0              , 0                                 , "Setswana")
   LNG(wxLANGUAGE_SHONA,                      "sn"   , 0              , 0                                 , "Shona")
   LNG(wxLANGUAGE_SINDHI,                     "sd"   , LANG_SINDHI    , SUBLANG_DEFAULT                   , "Sindhi")
   LNG(wxLANGUAGE_SINHALESE,                  "si"   , 0              , 0                                 , "Sinhalese")
   LNG(wxLANGUAGE_SISWATI,                    "ss"   , 0              , 0                                 , "Siswati")
   LNG(wxLANGUAGE_SLOVAK,                     "sk_SK", LANG_SLOVAK    , SUBLANG_DEFAULT                   , "Slovak")
   LNG(wxLANGUAGE_SLOVENIAN,                  "sl_SI", LANG_SLOVENIAN , SUBLANG_DEFAULT                   , "Slovenian")
   LNG(wxLANGUAGE_SOMALI,                     "so"   , 0              , 0                                 , "Somali")
   LNG(wxLANGUAGE_SPANISH,                    "es_ES", LANG_SPANISH   , SUBLANG_SPANISH                   , "Spanish")
   LNG(wxLANGUAGE_SPANISH_ARGENTINA,          "es_AR", LANG_SPANISH   , SUBLANG_SPANISH_ARGENTINA         , "Spanish (Argentina)")
   LNG(wxLANGUAGE_SPANISH_BOLIVIA,            "es_BO", LANG_SPANISH   , SUBLANG_SPANISH_BOLIVIA           , "Spanish (Bolivia)")
   LNG(wxLANGUAGE_SPANISH_CHILE,              "es_CL", LANG_SPANISH   , SUBLANG_SPANISH_CHILE             , "Spanish (Chile)")
   LNG(wxLANGUAGE_SPANISH_COLOMBIA,           "es_CO", LANG_SPANISH   , SUBLANG_SPANISH_COLOMBIA          , "Spanish (Colombia)")
   LNG(wxLANGUAGE_SPANISH_COSTA_RICA,         "es_CR", LANG_SPANISH   , SUBLANG_SPANISH_COSTA_RICA        , "Spanish (Costa Rica)")
   LNG(wxLANGUAGE_SPANISH_DOMINICAN_REPUBLIC, "es_DO", LANG_SPANISH   , SUBLANG_SPANISH_DOMINICAN_REPUBLIC, "Spanish (Dominican republic)")
   LNG(wxLANGUAGE_SPANISH_ECUADOR,            "es_EC", LANG_SPANISH   , SUBLANG_SPANISH_ECUADOR           , "Spanish (Ecuador)")
   LNG(wxLANGUAGE_SPANISH_EL_SALVADOR,        "es_SV", LANG_SPANISH   , SUBLANG_SPANISH_EL_SALVADOR       , "Spanish (El Salvador)")
   LNG(wxLANGUAGE_SPANISH_GUATEMALA,          "es_GT", LANG_SPANISH   , SUBLANG_SPANISH_GUATEMALA         , "Spanish (Guatemala)")
   LNG(wxLANGUAGE_SPANISH_HONDURAS,           "es_HN", LANG_SPANISH   , SUBLANG_SPANISH_HONDURAS          , "Spanish (Honduras)")
   LNG(wxLANGUAGE_SPANISH_MEXICAN,            "es_MX", LANG_SPANISH   , SUBLANG_SPANISH_MEXICAN           , "Spanish (Mexican)")
   LNG(wxLANGUAGE_SPANISH_MODERN,             "es_ES", LANG_SPANISH   , SUBLANG_SPANISH_MODERN            , "Spanish (Modern)")
   LNG(wxLANGUAGE_SPANISH_NICARAGUA,          "es_NI", LANG_SPANISH   , SUBLANG_SPANISH_NICARAGUA         , "Spanish (Nicaragua)")
   LNG(wxLANGUAGE_SPANISH_PANAMA,             "es_PA", LANG_SPANISH   , SUBLANG_SPANISH_PANAMA            , "Spanish (Panama)")
   LNG(wxLANGUAGE_SPANISH_PARAGUAY,           "es_PY", LANG_SPANISH   , SUBLANG_SPANISH_PARAGUAY          , "Spanish (Paraguay)")
   LNG(wxLANGUAGE_SPANISH_PERU,               "es_PE", LANG_SPANISH   , SUBLANG_SPANISH_PERU              , "Spanish (Peru)")
   LNG(wxLANGUAGE_SPANISH_PUERTO_RICO,        "es_PR", LANG_SPANISH   , SUBLANG_SPANISH_PUERTO_RICO       , "Spanish (Puerto Rico)")
   LNG(wxLANGUAGE_SPANISH_URUGUAY,            "es_UY", LANG_SPANISH   , SUBLANG_SPANISH_URUGUAY           , "Spanish (Uruguay)")
   LNG(wxLANGUAGE_SPANISH_US,                 "es_US", 0              , 0                                 , "Spanish (U.S.)")
   LNG(wxLANGUAGE_SPANISH_VENEZUELA,          "es_VE", LANG_SPANISH   , SUBLANG_SPANISH_VENEZUELA         , "Spanish (Venezuela)")
   LNG(wxLANGUAGE_SUNDANESE,                  "su"   , 0              , 0                                 , "Sundanese")
   LNG(wxLANGUAGE_SWAHILI,                    "sw_KE", LANG_SWAHILI   , SUBLANG_DEFAULT                   , "Swahili")
   LNG(wxLANGUAGE_SWEDISH,                    "sv_SE", LANG_SWEDISH   , SUBLANG_SWEDISH                   , "Swedish")
   LNG(wxLANGUAGE_SWEDISH_FINLAND,            "sv_FI", LANG_SWEDISH   , SUBLANG_SWEDISH_FINLAND           , "Swedish (Finland)")
   LNG(wxLANGUAGE_TAGALOG,                    "tl"   , 0              , 0                                 , "Tagalog")
   LNG(wxLANGUAGE_TAJIK,                      "tg"   , 0              , 0                                 , "Tajik")
   LNG(wxLANGUAGE_TAMIL,                      "ta"   , LANG_TAMIL     , SUBLANG_DEFAULT                   , "Tamil")
   LNG(wxLANGUAGE_TATAR,                      "tt"   , LANG_TATAR     , SUBLANG_DEFAULT                   , "Tatar")
   LNG(wxLANGUAGE_TELUGU,                     "te"   , LANG_TELUGU    , SUBLANG_DEFAULT                   , "Telugu")
   LNG(wxLANGUAGE_THAI,                       "th_TH", LANG_THAI      , SUBLANG_DEFAULT                   , "Thai")
   LNG(wxLANGUAGE_TIBETAN,                    "bo"   , 0              , 0                                 , "Tibetan")
   LNG(wxLANGUAGE_TIGRINYA,                   "ti"   , 0              , 0                                 , "Tigrinya")
   LNG(wxLANGUAGE_TONGA,                      "to"   , 0              , 0                                 , "Tonga")
   LNG(wxLANGUAGE_TSONGA,                     "ts"   , 0              , 0                                 , "Tsonga")
   LNG(wxLANGUAGE_TURKISH,                    "tr_TR", LANG_TURKISH   , SUBLANG_DEFAULT                   , "Turkish")
   LNG(wxLANGUAGE_TURKMEN,                    "tk"   , 0              , 0                                 , "Turkmen")
   LNG(wxLANGUAGE_TWI,                        "tw"   , 0              , 0                                 , "Twi")
   LNG(wxLANGUAGE_UIGHUR,                     "ug"   , 0              , 0                                 , "Uighur")
   LNG(wxLANGUAGE_UKRAINIAN,                  "uk_UA", LANG_UKRAINIAN , SUBLANG_DEFAULT                   , "Ukrainian")
   LNG(wxLANGUAGE_URDU,                       "ur"   , LANG_URDU      , SUBLANG_DEFAULT                   , "Urdu")
   LNG(wxLANGUAGE_URDU_INDIA,                 "ur_IN", LANG_URDU      , SUBLANG_URDU_INDIA                , "Urdu (India)")
   LNG(wxLANGUAGE_URDU_PAKISTAN,              "ur_PK", LANG_URDU      , SUBLANG_URDU_PAKISTAN             , "Urdu (Pakistan)")
   LNG(wxLANGUAGE_UZBEK,                      "uz"   , LANG_UZBEK     , SUBLANG_DEFAULT                   , "Uzbek")
   LNG(wxLANGUAGE_UZBEK_CYRILLIC,             "uz"   , LANG_UZBEK     , SUBLANG_UZBEK_CYRILLIC            , "Uzbek (Cyrillic)")
   LNG(wxLANGUAGE_UZBEK_LATIN,                "uz"   , LANG_UZBEK     , SUBLANG_UZBEK_LATIN               , "Uzbek (Latin)")
   LNG(wxLANGUAGE_VIETNAMESE,                 "vi_VN", LANG_VIETNAMESE, SUBLANG_DEFAULT                   , "Vietnamese")
   LNG(wxLANGUAGE_VOLAPUK,                    "vo"   , 0              , 0                                 , "Volapuk")
   LNG(wxLANGUAGE_WELSH,                      "cy"   , 0              , 0                                 , "Welsh")
   LNG(wxLANGUAGE_WOLOF,                      "wo"   , 0              , 0                                 , "Wolof")
   LNG(wxLANGUAGE_XHOSA,                      "xh"   , 0              , 0                                 , "Xhosa")
   LNG(wxLANGUAGE_YIDDISH,                    "yi"   , 0              , 0                                 , "Yiddish")
   LNG(wxLANGUAGE_YORUBA,                     "yo"   , 0              , 0                                 , "Yoruba")
   LNG(wxLANGUAGE_ZHUANG,                     "za"   , 0              , 0                                 , "Zhuang")
   LNG(wxLANGUAGE_ZULU,                       "zu"   , 0              , 0                                 , "Zulu")

};
#undef LNG

// --- --- --- generated code ends here --- --- ---


/**
 * Destroys the database of known languages.
 */
void Languages::DestroyLanguagesDB()
{
  WX_CLEAR_ARRAY(lngInfos);
  lngInfos.Shrink();
}


/*
 Borland C specifics.
 --------------------
 
 Up to wxWidgets 2.4.2 (and maybe more), the wxLocale::GetLanguageInfo static
 method doesn't works with Borland C++ (I'm using the 5.5.1 free command line
 compiler).
 
 To resolve the bug(?), I've created a database of languages for Borland
 compilers.
 
 Theses attributes and static methods are defined :
 * static ArrayLanguageInfo lngInfos;
     Array of languages information.

 * static void CreateLanguagesDB();
     Creates the languages database.
 
 * static void DestroyLanguagesDB();
     Destroys the languages database.
 
 * static const wxLanguageInfo* GetLanguageInfo(int lang);
     Do the same as wxLocale::GetLanguageInfo.

 The database is created in the Languages constructor and is destroyed in the
 Languages destructor. So don't use Languages::GetLanguageInfo when no
 Languages instance exists.
 Two instances of Languages at the same time shouldn't exists because the
 first destroyed will destroy the database without the second knows it.
 
 The language database has been taken from wxWidgets 2.4.2. If you compile
 wxChecksums with another release of wxWidgets, please check in intl.cpp of
 wxWidgets if the database has changed.
*/

#endif  // __BORLANDC__

