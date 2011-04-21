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
 * \file cksums.cpp
 * Application definition body.
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

#include <wx/cmdline.h>
#include <wx/config.h>
#include <wx/fileconf.h>

#include "cksums.hpp"
#include "appprefs.hpp"
#include "bytedisp.hpp"
#include "checksumfactory.hpp"
#include "cmdlnopt.hpp"
#include "comdefs.hpp"
#include "frmSums.hpp"
#include "language.hpp"
#include "osdep.hpp"
#include "utils.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;

IMPLEMENT_APP(CkSumsApp)
//---------------------------------------------------------------------------


/**
 * Application initialization.
 *
 * This method is called on application startup.
 * If <CODE>false</CODE> is return the application stops immediatly.
 *
 * @return  <CODE>true</CODE> if initialization was successfully done.
 *          <CODE>false</CODE> otherwise.
 */
bool CkSumsApp::OnInit()
{
  // Sets the application name.
  SetAppName(wxT(APP_NAME));

  // Don't create a configuration object on demand (with wxConfigBase::Get method)
  wxConfig::DontCreateOnDemand();

  // Creates a new configuration file object. It will be deleted by wxWidgets.
  wxFileConfig* config = new wxFileConfig(wxT(APP_NAME), wxT(APP_AUTHOR),
                                          AppPrefs::getConfigPathName(),
                                          wxT(""), wxCONFIG_USE_LOCAL_FILE);
  wxConfigBase* oldCfg = wxConfig::Set(config);
  if (oldCfg != NULL)
    delete oldCfg;

  // Sets a new instance of the application preferences.
  //AppPrefs::set(new AppPrefs());  // Automatic now

  // Initializes the locale
  InitLocale();

  // Initializes the BytesDisplayer class
  BytesDisplayer::initStatic();
  
  // Initializes the SumFileFactory class
  SumFileFactory::initialize();
  
  // Call the OnInit() of the superclass to parse the command line.
  bool cont = wxApp::OnInit();

  if (cont)
  {
    bool error, warning, close;
    frmSums* frame = new frmSums(_("wxChecksums"));
    SetTopWindow(frame);
    frame->initializeFromCmdLine(error, warning);
    close = frame->closeAfterInitFromCmdLine(error, warning);
    frame->Show(!close);
    if (close)
    {
      wxCloseEvent e(wxEVT_CLOSE_WINDOW);
      e.SetCanVeto(false);
      frame->AddPendingEvent(e);
    }
  }

  // We don't need the command line options, clean-up the memory.
  CmdLineOptions::cleanup();
  
  if (!cont)
    // Clear the resources created in OnInit().
    CleanUpAppResources();

  return cont;
}
//---------------------------------------------------------------------------


/**
 * Application cleanup method.
 *
 * Provide this member function for any processing which needs to be done as
 * the application is about to exit. <CODE>OnExit</CODE> is called after
 * destroying all application windows and controls, but before wxWidgets
 * cleanup.
 *
 * @return  the application return code.
 */
int CkSumsApp::OnExit()
{
  CleanUpAppResources();

  return 0;
}
//---------------------------------------------------------------------------


/**
 * Cleans up the ressources taken by the instance.
 *
 * Call it before quitting the application.
 */
void CkSumsApp::CleanUpAppResources()
{
/*  if (instanceChecker != NULL)
    delete instanceChecker; */

  // Clean-up the global preferences.
  AppPrefs::cleanupGlobal();

  // Deletes the configuration object.
  wxConfigBase* oldCfg = wxConfig::Set(NULL);
  if (oldCfg != NULL)
    delete oldCfg;
}
//---------------------------------------------------------------------------


/**
 * Adds all supported options to the given parser.
 * 
 * Called from <CODE>wxApp::OnInit</CODE> and may be used to initialize the
 * parser with the command line options for this application. The base class
 * versions adds support for a few standard options only.
 *
 * @param  parser  The command line parser which be used to parse the command
 *                 line.
 */
void CkSumsApp::OnInitCmdLine(wxCmdLineParser& parser)
{
  // Call the superclass OnInitCmdLine() to add "--help" and specific platform
  // options.
  wxApp::OnInitCmdLine(parser);

  // Add the logo
  parser.SetLogo(::getAppName() + wxT("\n"));

  // Add command line options
  parser.AddSwitch(wxT("V"), wxT("version"), _("show version information"));
  parser.AddSwitch(wxT("v"), wxT("verify"), _("verify sums against given list"));
  parser.AddOption(wxT("a"), wxT("append"), _("append files to a checksums' file"), wxCMD_LINE_VAL_STRING);
  parser.AddOption(wxT("c"), wxT("create"), _("create a checksums' file"), wxCMD_LINE_VAL_STRING);
  parser.AddOption(wxT("ct"), wxT("create-type"), _("type of the checksums' file to create"), wxCMD_LINE_VAL_STRING);
  parser.AddOption(wxT("fl"), wxT("files-list"), _("list(s) of files"), wxCMD_LINE_VAL_STRING);
  parser.AddSwitch(wxString(), wxT("delete-temp-list"), _("delete temporary lists of files"));
  parser.AddParam(_("file(s)"), wxCMD_LINE_VAL_STRING, wxCMD_LINE_PARAM_OPTIONAL | wxCMD_LINE_PARAM_MULTIPLE);
}
//---------------------------------------------------------------------------


/**
 * Called after successfully parsing the command line.
 *
 * @param  parser  The command line parser which was used to parse the command
 *                 line.
 * @return <CODE>true</CODE> to continue normal execution or <CODE>false</CODE>
 *         to return <CODE>false</CODE> from <CODE>wxApp::OnInit</CODE> thus
 *         terminating the program.
 */
bool CkSumsApp::OnCmdLineParsed(wxCmdLineParser& parser)
{
  // Process the standard command line options and ignore if it fails
  wxApp::OnCmdLineParsed(parser);

  // Initializes the CmdLineOptions class
  return CmdLineOptions::init(parser);

//  return true;  // never abort the program.
}
//---------------------------------------------------------------------------


/**
 * Called if <CODE>-h</CODE> or <CODE>--help</CODE> option was specified.
 *
 * Called by <CODE>wxApp::OnInit</CODE> when the help option <CODE>-h</CODE> or 
 * <CODE>--help</CODE> was specified on the command line.
 * The processing of <CODE>-h</CODE> and <CODE>--help</CODE> is made by
 * <CODE>wxApp::OnInitCmdLine</CODE> which is called by 
 * <CODE>CkSumsApp::OnInitCmdLine</CODE>.
 *
 * @param  parser  The command line parser which was used to parse the command
 *                 line.
 * @return <CODE>true</CODE> to continue normal execution or <CODE>false</CODE>
 *         to return <CODE>false</CODE> from <CODE>wxApp::OnInit</CODE> thus
 *         terminating the program.
 */
bool CkSumsApp::OnCmdLineHelp(wxCmdLineParser& parser)
{
  return wxApp::OnCmdLineHelp(parser);

/*  #ifdef __WXMSW__
  return true;  // on windows never abort the program.
  #endif // __WXMSW__
  return false; */
}
//---------------------------------------------------------------------------


/**
 * Called when command line parsing fails.
 *
 * @param  parser  The command line parser which was used to parse the command
 *                 line.
 * @return <CODE>true</CODE> to continue normal execution or <CODE>false</CODE>
 *         to return <CODE>false</CODE> from <CODE>wxApp::OnInit</CODE> thus
 *         terminating the program. */
bool CkSumsApp::OnCmdLineError(wxCmdLineParser& parser)
{
  return wxApp::OnCmdLineError(parser);  // Don't print the usage

  //return true;  // never abort the program.
}
//---------------------------------------------------------------------------


/**
 * Initializes the locale
 */
void CkSumsApp::InitLocale()
{
  wxString locName = AppPrefs::get()->readString(prLANGUAGE_NAME);
  bool     canAddCatalog = true;  // add the catalogs ?

  #if defined(__WXMSW__)
  // Add the path of the application executable to the list of path to browse
  // to find the catalog files.
  appLocale.AddCatalogLookupPathPrefix(::getAppPath().GetPath(wxPATH_GET_VOLUME));
  #endif   // __WXMSW__

  appLocale.AddCatalogLookupPathPrefix(wxT("."));

  Languages langs;
  canAddCatalog = langs.setLocale(appLocale);
  
  // Adds the language catalogs
  if (canAddCatalog)
    appLocale.AddCatalog(wxT("cksums"));
}
//---------------------------------------------------------------------------
