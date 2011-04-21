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
 * \file cksums.hpp
 * Application definition.
 */


#ifndef INC_CKSUMS_HPP
#define INC_CKSUMS_HPP


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
//#include <wx/snglinst.h>
//---------------------------------------------------------------------------


/**
 * The application class. Needed by wxWidgets.
 *
 * wxWidgets defines the <CODE>main</CODE> fonction.
 */
class CkSumsApp : public wxApp
{
 public:
  // Application initialization.
  virtual bool OnInit();
  
  // Application cleanup method.
  virtual int OnExit();

  // this one is called from OnInit() to add all supported options
  // to the given parser
  virtual void OnInitCmdLine(wxCmdLineParser& parser);

  // called after successfully parsing the command line, return TRUE
  // to continue and FALSE to exit
  virtual bool OnCmdLineParsed(wxCmdLineParser& parser);

  // called if "--help" option was specified, return TRUE to continue
  // and FALSE to exit
  virtual bool OnCmdLineHelp(wxCmdLineParser& parser);

  // called if incorrect command line options were given, return
  // FALSE to abort and TRUE to continue
  virtual bool OnCmdLineError(wxCmdLineParser& parser);

  // Initializes the locale
  void InitLocale();
  
  // Cleans up the resources taken by the instance.
  void CleanUpAppResources();

 protected:
  wxLocale appLocale;  ///< The application's locale.
};
//---------------------------------------------------------------------------

DECLARE_APP(CkSumsApp)
//---------------------------------------------------------------------------


/**
 * \mainpage
 * \section description Description
 *
 * wxChecksums is a program that computes and verifies checksums.
 *
 * This documention is for programmers only. If you want to know how use
 * wxChecksums see the manual.
 *
 * \section license License
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


#endif  // INC_CKSUMS_HPP
