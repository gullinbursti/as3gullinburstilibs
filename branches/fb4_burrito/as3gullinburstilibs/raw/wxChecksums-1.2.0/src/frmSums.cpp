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
 * \file frmSums.cpp
 * Application's main window body.
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
#include <wx/filename.h>
#include <wx/txtstrm.h>

#include "frmSums.hpp"
#include "dlgAbout.hpp"
#include "dlgBatchCreate.hpp"
#include "dlgBatchCreateConf.hpp"
#include "dlgConf.hpp"
#include "dlgMultiCheck.hpp"
#include "dlgMultiCheckConf.hpp"
#include "dlgNewFile.hpp"
#include "appprefs.hpp"
#include "checksumfactory.hpp"
#include "cmdlnopt.hpp"
#include "comdefs.hpp"
#include "fdftlmk.hpp"
#include "fileutil.hpp"
#include "language.hpp"
#include "sfvfile.hpp"
#include "md5file.hpp"
#include "utils.hpp"

#if !defined(__WXMSW__)
#include "bitmaps/icon_app_checksums.xpm"
#endif  // !defined(__WXMSW__)

// On Windows, set the bitmaps in the menus make the item accelerator doesn't
// work...
// See also addMenuItemWithBitmap(...).
//#if !defined(__WXMSW__)
#include "bitmaps/hi16_action_filenew.xpm"
#include "bitmaps/hi16_action_fileopen.xpm"
#include "bitmaps/hi16_action_filesave.xpm"
#include "bitmaps/hi16_action_filesaveas.xpm"
#include "bitmaps/hi16_action_fileclose.xpm"
#include "bitmaps/hi16_action_exit.xpm"
#include "bitmaps/hi16_action_fileadd.xpm"
#include "bitmaps/hi16_action_directoryadd.xpm"
#include "bitmaps/hi16_action_addmatchingfiles.xpm"
#include "bitmaps/hi16_action_fileremove.xpm"
#include "bitmaps/hi16_action_check.xpm"
#include "bitmaps/hi16_action_recompute.xpm"
#include "bitmaps/hi16_action_configure.xpm"
#include "bitmaps/hi16_action_helpabout.xpm"
//#endif  // !defined(__WXMSW__)

#include "bitmaps/hi22_action_filenew.xpm"
#include "bitmaps/hi22_action_fileopen.xpm"
#include "bitmaps/hi22_action_filesave.xpm"
#include "bitmaps/hi22_action_fileadd.xpm"
#include "bitmaps/hi22_action_directoryadd.xpm"
#include "bitmaps/hi22_action_addmatchingfiles.xpm"
#include "bitmaps/hi22_action_fileremove.xpm"
#include "bitmaps/hi22_action_check.xpm"
#include "bitmaps/hi22_action_recompute.xpm"
#include "bitmaps/hi22_action_configure.xpm"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;

/// The style of the main window. 
#define  frmSUMS_STYLE  wxDEFAULT_FRAME_STYLE
//#define  frmSUMS_STYLE  wxWANTS_CHARS | wxMINIMIZE_BOX | wxMAXIMIZE_BOX | wxSYSTEM_MENU | wxCAPTION | wxRESIZE_BORDER



//###########################################################################
// Useful fonctions
//###########################################################################

/**
 * Adds a menu item with a bitmap to a menu.
 *
 * @param  parentMenu  Menu that the menu item belongs to.
 * @param  id          Identifier for this menu item.
 * @param  text        Text for the menu item, as shown on the menu. An
 *                     accelerator key can be specified using the ampersand '&'
 *                     character. In order to embed an ampersand character in
 *                     the menu item text, the ampersand must be doubled.
 * @param  bitmap      The bitmap for the menu item.
 * @param  helpString  Optional help string that will be shown on the status
 *                     bar.
 * @param  kind        May be <CODE>wxITEM_SEPARATOR</CODE>,
 *                     <CODE>wxITEM_NORMAL</CODE>, <CODE>wxITEM_CHECK</CODE> or
 *                     <CODE>wxITEM_RADIO</CODE>.
 * @param  subMenu     If non-NULL, indicates that the menu item is a submenu.
 */
static void addMenuItemWithBitmap(wxMenu* parentMenu, int id,
                           const wxString& text,
                           const wxBitmap& bitmap,
                           const wxString& helpString = wxEmptyString,
                           wxItemKind kind = wxITEM_NORMAL,
                           wxMenu* subMenu = NULL)
{
  wxMenuItem* menuItem;
  menuItem = new wxMenuItem(parentMenu, id, text, helpString, kind, subMenu);
#if !defined(__WXMSW__)
  menuItem->SetBitmap(bitmap);
#endif  // !defined(__WXMSW__)
  parentMenu->Append(menuItem);
}
//---------------------------------------------------------------------------



//###########################################################################
// frmSums methods
//###########################################################################

IMPLEMENT_DYNAMIC_CLASS(frmSums, wxFrame)

// Static attributes of the frmSums class
// The maximum size of a toolbar button.
const int frmSums::TOOL_BITMAP_SIZE = 24;


/**
 * Creates a new frame.
 */
frmSums::frmSums() : wxFrame()
{
  createControls();
}
//---------------------------------------------------------------------------


/**
 * Creates a new frame.
 *
 * @param  title   the window's title.
 * @param  xpos    the horizontal position of the window.
 * @param  ypos    the vertical position of the window.
 * @param  width   the witdh of the window.
 * @param  height  the height of the window.
 */
frmSums::frmSums(const wxChar* title, int xpos, int ypos, int width, int height) :
  wxFrame((wxFrame*)NULL, -1, title, wxPoint(xpos, ypos), wxSize(width, height), frmSUMS_STYLE)
{
  createControls();
}
//---------------------------------------------------------------------------


/**
 * Creates a new frame.
 * Use system defaults for the position and the size of the window.
 *
 * @param  title   the window's title.
 */
frmSums::frmSums(const wxChar* title) :
  wxFrame((wxFrame*)NULL, -1, title, wxDefaultPosition, wxDefaultSize, frmSUMS_STYLE)
{
  createControls();
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the frame.
 */
void frmSums::createControls()
{
  // Sets the frame icon
  this->SetIcon(wxICON(icon_app_checksums));


  // Creates the status bar
  createStatusbar();

  // Creates the menus
  wxMenuItem* menuItem;
  wxMenuBar* menuBar = new wxMenuBar(wxMB_DOCKABLE);
  SetMenuBar(menuBar);

  // Menu "File"
  wxMenu* mnuFile = new wxMenu(wxMENU_TEAROFF);
  menuBar->Append(mnuFile, _("&File"));
  // File->New item
  addMenuItemWithBitmap(mnuFile, ITM_FILE_NEW, _("&New...\tCtrl+N"),
                        wxBitmap(hi16_action_filenew_xpm), 
                        _("Creates a new checksum file."));
  // File->Open item
  addMenuItemWithBitmap(mnuFile, ITM_FILE_OPEN, _("&Open...\tCtrl+O"), 
                        wxBitmap(hi16_action_fileopen_xpm), 
                        _("Opens a checksum file."));
  // File->Open recent menu
  mnuOpenRecent = new wxMenu(wxMENU_TEAROFF);
  mnuFile->Append(MNU_FILE_OPENRECENT, _("Open &recent"), mnuOpenRecent);
  // A separator
  mnuFile->AppendSeparator();
  // File->Save item
  addMenuItemWithBitmap(mnuFile, ITM_FILE_SAVE, _("&Save\tCtrl+S"), 
                        wxBitmap(hi16_action_filesave_xpm), 
                        _("Saves the checksum file."));
  // File->Save as item
  addMenuItemWithBitmap(mnuFile, ITM_FILE_SAVEAS, _("Save &as..."), 
                        wxBitmap(hi16_action_filesaveas_xpm), 
                        _("Saves the checksum file in another file."));
  // A separator
  mnuFile->AppendSeparator();
  // File->Close item
  addMenuItemWithBitmap(mnuFile, ITM_FILE_CLOSE, _("&Close\tCtrl+W"), 
                        wxBitmap(hi16_action_fileclose_xpm), 
                        _("Closes the checksum file."));
  // A separator
  mnuFile->AppendSeparator();
  // File->Quit item
  addMenuItemWithBitmap(mnuFile, ITM_FILE_QUIT, _("&Quit\tCtrl+Q"), 
                        wxBitmap(hi16_action_exit_xpm), 
                        wxString::Format(_("Quit %s."), wxT(APP_NAME)));

  // Menu "Sums"
  wxMenu* mnuSums = new wxMenu(wxMENU_TEAROFF);
  menuBar->Append(mnuSums, _("&Sums"));
  // Sums->Add files item
  addMenuItemWithBitmap(mnuSums, ITM_SUMS_ADDFILES, _("Add &files...\tInsert"), 
                        wxBitmap(hi16_action_fileadd_xpm), 
                        _("Add files to the checksum file."));
  // Sums->Add directories item
  addMenuItemWithBitmap(mnuSums, ITM_SUMS_ADDDIRECTORIES, _("Add &directories...\tCtrl+D"), 
                        wxBitmap(hi16_action_directoryadd_xpm), 
                        _("Add directories to the checksum file."));
  // Sums->Add Add matching files item
  addMenuItemWithBitmap(mnuSums, ITM_SUMS_ADDMATCHINGFILES, _("Add &matching files...\tShift+Insert"),
                        wxBitmap(hi16_action_addmatchingfiles_xpm), 
                        _("Select some files from a matching pattern and add them to the to the checksum file."));
  // Sums->Add files item
  addMenuItemWithBitmap(mnuSums, ITM_SUMS_REMOVE, _("&Remove\tDelete"), 
                        wxBitmap(hi16_action_fileremove_xpm), 
                        _("Remove the selected checksums from the checksum file."));
  // A separator
  mnuSums->AppendSeparator();
  // Sums->Check item
  addMenuItemWithBitmap(mnuSums, ITM_SUMS_CHECK, _("&Check\tCtrl+C"), 
                        wxBitmap(hi16_action_check_xpm), 
                        _("Checks the selected files or all files if none is selected."));
  // Sums->Recompute item
  addMenuItemWithBitmap(mnuSums, ITM_SUMS_RECOMPUTE, _("Re&compute\tCtrl+R"),
                        wxBitmap(hi16_action_recompute_xpm), 
                        _("Recompute the checksums of the selected files."));
  // A separator
  mnuSums->AppendSeparator();
  // Sums->Sort by iter
  wxMenu* mnuSortBy = new wxMenu(wxMENU_TEAROFF);
  mnuSortBy->AppendRadioItem(ITM_SUMS_SORTBY_FILENAME, _("File &name"), _("Sort the checksums' list by file name."));
  mnuSortBy->AppendRadioItem(ITM_SUMS_SORTBY_DIRECTORY, _("&Directory"), _("Sort the checksums' list by directory."));
  mnuSortBy->AppendRadioItem(ITM_SUMS_SORTBY_CHECKSUMVALUE, _("Checksum &value"), _("Sort the checksums' list by value."));
  mnuSortBy->AppendRadioItem(ITM_SUMS_SORTBY_STATE, _("&State"), _("Sort the checksums' list by state."));
  #if defined(__WXGTK__)
  // This solves a problem with the radio item groups
  mnuSortBy->Append(ITM_SUMS_SORTBY_SEPARATOR1, wxEmptyString, wxEmptyString, wxITEM_SEPARATOR);
  #else
  mnuSortBy->AppendSeparator();
  #endif  //  defined(__WXGTK__)
  mnuSortBy->AppendRadioItem(ITM_SUMS_SORTBY_ASCENDING, _("&Ascending order"), _("Sort the checksums' list in ascending order."));
  mnuSortBy->AppendRadioItem(ITM_SUMS_SORTBY_DESCENDING, _("D&escending order"), _("Sort the checksums' list in descending order."));
  mnuSortBy->AppendRadioItem(ITM_SUMS_SORTBY_NONE, _("D&on't sort"), _("Don't sort the checksums' list."));
  mnuSums->Append(ITM_SUMS_SORTBY, _("&Sort by"), mnuSortBy);
  // Sums->Select all item
  mnuSums->Append(ITM_SUMS_SELECTALL, _("Select &all\tCtrl+A"), _("Selects all the files."));
  // Sums->Invert the selection item
  mnuSums->Append(ITM_SUMS_INVERTSELECTION, _("&Invert selection\tCtrl+I"), _("Selects non-selected files and deselects selected files."));

  // Menu "Tools"
  wxMenu* mnuTools = new wxMenu(wxMENU_TEAROFF);
  menuBar->Append(mnuTools, _("&Tools"));
  mnuTools->Append(ITM_TOOLS_CHECK_MULTIPLE, _("Check &multiple checksums' files...\tCtrl+M"), _("Checks several checksums' files at the same time."));
  mnuTools->Append(ITM_TOOLS_BATCH_CREATION, _("&Batch creation of checksums' files...\tCtrl+B"), _("Creates one checksums' file for each file selected in the following dialog."));
  mnuTools->AppendSeparator();
// TODO: find an elegant way to show and hide the toolbar and statusbar
  // Tools->Show toolbar
//  mnuTools->Append(ITM_TOOLS_SHOW_TOOLBAR, _("Show &toolbar"), _("Shows or hides the toolbar"), wxITEM_CHECK);
  // Tools->Show statusbar
//  mnuTools->Append(ITM_TOOLS_SHOW_STATUSBAR, _("Show &statusbar"), _("Shows or hides the statusbar"), wxITEM_CHECK);
  // A separator
//  mnuTools->AppendSeparator();
  // Tools->Configure
  addMenuItemWithBitmap(mnuTools, ITM_TOOLS_CONFIGURE, wxString::Format(_("&Configure %s..."), wxT(APP_NAME)), 
                        wxBitmap(hi16_action_configure_xpm), 
                        wxString::Format(_("Sets the parameters of %s."), wxT(APP_NAME)));

  // Menu "Help"
  wxMenu* mnuHelp = new wxMenu(wxMENU_TEAROFF);
  menuBar->Append(mnuHelp, _("&Help"));
  // Help->About
  addMenuItemWithBitmap(mnuHelp, ITM_HELP_ABOUT, wxString::Format(_("&About %s..."), wxT(APP_NAME)), 
                        wxBitmap(hi16_action_helpabout_xpm), 
                        wxString::Format(_("Displays information about %s."), wxT(APP_NAME)));


  // Creates the tools bar
  createToolbar();

  // Creates the list
  long lvwSumsStyle = wxLC_REPORT;
  if (AppPrefs::get()->readBool(prGUI_MAIN_SUMS_HRULES))
    lvwSumsStyle |= wxLC_HRULES;
  if (AppPrefs::get()->readBool(prGUI_MAIN_SUMS_VRULES))
    lvwSumsStyle |= wxLC_VRULES;
  lvwSums = new ChecksumsListView(this, LVW_SUMS, NULL, wxDefaultPosition,
                                  wxDefaultSize, lvwSumsStyle);

  //-------------------------------------------------------------------------
  // Creates the frame sizer

  // Frame sizer
  wxBoxSizer* frmSumsSizer = new wxBoxSizer(wxVERTICAL);
  frmSumsSizer->Add(lvwSums, 1, wxALL | wxGROW, 0);
  this->SetSizer(frmSumsSizer);

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();

  // Sets the background color
  //this->SetBackgroundColour(a_control->GetBackgroundColour());
  
  // Init some controls
  // This frame title
  updateTitle();
  // Position and size of the main window.
  wxRect  r = AppPrefs::getDefaultMainWindowRect();
  wxPoint p;
  wxSize  s;

  if (AppPrefs::get()->readBool(prGUI_MAIN_SAVE_WINDOW_POSITION))
    p = AppPrefs::get()->readPoint(prGUI_MAIN_WINDOW_POSITION);
  else
    p = wxPoint(r.GetX(), r.GetY());
  this->Move(p);
  
  if (AppPrefs::get()->readBool(prGUI_MAIN_SAVE_WINDOW_SIZE))
    s = AppPrefs::get()->readSize(prGUI_MAIN_WINDOW_SIZE);
  else
    s = wxSize(r.GetWidth(), r.GetHeight());
  this->SetSize(s);

  // Init the checkables menus
  mnuTools->Check(ITM_TOOLS_SHOW_TOOLBAR, AppPrefs::get()->readBool(prGUI_MAIN_SHOW_TOOLBAR));
  tlbTools->Show(AppPrefs::get()->readBool(prGUI_MAIN_SHOW_TOOLBAR));
  mnuTools->Check(ITM_TOOLS_SHOW_STATUSBAR, AppPrefs::get()->readBool(prGUI_MAIN_SHOW_STATUSBAR));
  stbStatus->Show(AppPrefs::get()->readBool(prGUI_MAIN_SHOW_STATUSBAR));
  
  // Sets the checksums list defaults
  lvwSums->SetColumnWidth(0, AppPrefs::get()->readLong(prGUI_MAIN_SUMS_COL_FILENAME_WIDTH));
  lvwSums->SetColumnWidth(1, AppPrefs::get()->readLong(prGUI_MAIN_SUMS_COL_DIRECTORY_WIDTH));
  lvwSums->SetColumnWidth(2, AppPrefs::get()->readLong(prGUI_MAIN_SUMS_COL_CHECKSUM_WIDTH));
  lvwSums->SetColumnWidth(3, AppPrefs::get()->readLong(prGUI_MAIN_SUMS_COL_STATE_WIDTH));
  ChecksumsListView::Columns cols[LVW_SUMS_NBCOLS];
  cols[0] = static_cast<ChecksumsListView::Columns>(AppPrefs::get()->readLong(prGUI_MAIN_SUMS_COL_FIRST));
  cols[1] = static_cast<ChecksumsListView::Columns>(AppPrefs::get()->readLong(prGUI_MAIN_SUMS_COL_SECOND));
  cols[2] = static_cast<ChecksumsListView::Columns>(AppPrefs::get()->readLong(prGUI_MAIN_SUMS_COL_THIRD));
  cols[3] = static_cast<ChecksumsListView::Columns>(AppPrefs::get()->readLong(prGUI_MAIN_SUMS_COL_FOURTH));
  lvwSums->setColumns(cols);
  
  // Sets the column to short and the column order
  lvwSums->setColumnToSort(static_cast<int>(AppPrefs::get()->readLong(prGUI_MAIN_SUMS_COLUMNTOSORT)), static_cast<ChecksumsListView::SortOrder>(AppPrefs::get()->readLong(prGUI_MAIN_SUMS_COLUMNSORTORDER)));
  itmSumsSortByUpdate();
  
  // Reads the recently open files.
  initializeOpenRecent();
}
//---------------------------------------------------------------------------


/**
 * Creates the tools bar.
 */
void frmSums::createToolbar()
{
  tlbTools = CreateToolBar(/*wxNO_BORDER |*/ wxHORIZONTAL | wxTB_FLAT | wxTB_DOCKABLE);
  tlbTools->SetToolBitmapSize(wxSize(TOOL_BITMAP_SIZE, TOOL_BITMAP_SIZE));
  tlbTools->AddTool(ITM_FILE_NEW, _("New"), wxBitmap(hi22_action_filenew_xpm), wxNullBitmap,
                    wxITEM_NORMAL, _("New"), _("Creates a new checksum file."));
  tlbTools->AddTool(ITM_FILE_OPEN, _("Open"), wxBitmap(hi22_action_fileopen_xpm), wxNullBitmap,
                    wxITEM_NORMAL, _("Open"), _("Opens a checksum file."));
  tlbTools->AddTool(ITM_FILE_SAVE, _("Save"), wxBitmap(hi22_action_filesave_xpm), wxNullBitmap,
                    wxITEM_NORMAL, _("Save"), _("Saves the checksum file."));
  tlbTools->AddSeparator();
  tlbTools->AddTool(ITM_SUMS_ADDFILES, _("Add files"), wxBitmap(hi22_action_fileadd_xpm), wxNullBitmap,
                    wxITEM_NORMAL, _("Add files"), _("Add files to the checksum file."));
  tlbTools->AddTool(ITM_SUMS_ADDDIRECTORIES, _("Add directories"), wxBitmap(hi22_action_directoryadd_xpm), wxNullBitmap,
                    wxITEM_NORMAL, _("Add directories"), _("Add directories to the checksum file."));
  tlbTools->AddTool(ITM_SUMS_ADDMATCHINGFILES, _("Add matching files"), wxBitmap(hi22_action_addmatchingfiles_xpm), wxNullBitmap,
                    wxITEM_NORMAL, _("Add matching files"), _("Select some files from a matching pattern and add them to the to the checksum file."));
  tlbTools->AddTool(ITM_SUMS_REMOVE, _("Remove checksums"), wxBitmap(hi22_action_fileremove_xpm), wxNullBitmap,
                    wxITEM_NORMAL, _("Remove checksums"), _("Remove the selected checksums from the checksum file."));
  tlbTools->AddSeparator();
  tlbTools->AddTool(ITM_SUMS_CHECK, _("Check"), wxBitmap(hi22_action_check_xpm), wxNullBitmap,
                    wxITEM_NORMAL, _("Check files"), _("Checks the selected files or all files if none is selected."));
  tlbTools->AddTool(ITM_SUMS_RECOMPUTE, _("Recompute"), wxBitmap(hi22_action_recompute_xpm), wxNullBitmap,
                    wxITEM_NORMAL, _("Recompute checksums"), _("Recompute the checksums of the selected files."));
  tlbTools->AddSeparator();
  tlbTools->AddTool(ITM_TOOLS_CONFIGURE, _("Configure"), wxBitmap(hi22_action_configure_xpm), wxNullBitmap,
                    wxITEM_NORMAL, wxString::Format(_("Configure %s"), wxT(APP_NAME)), wxString::Format(_("Sets the parameters of %s."), wxT(APP_NAME)));
  tlbTools->Realize();
}
//---------------------------------------------------------------------------


/**
 * Creates the status bar.
 */
void frmSums::createStatusbar()
{
  int statusWidths[2];
  
  // Creates the status bar
  stbStatus = CreateStatusBar(1, wxST_SIZEGRIP, STB_STATUS);
  stbStatus->SetStatusText(_("Welcome"));
  
  // Sets columns widths
  statusWidths[0] = -1;
  wxClientDC dc(stbStatus);
  statusWidths[1] = dc.GetCharWidth() * 6;
  stbStatus->SetFieldsCount(2, statusWidths);
}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
frmSums::~frmSums()
{
}
//---------------------------------------------------------------------------


/**
 * Initializes some parameters from the command line.
 *
 * Open a file if one has been given in the command line.
 *
 * @param  error    An error has occured during the initialisation from the
 *                  command line parameters.
 * @param  warning  A warning has occured during the initialisation from the
 *                  command line parameters.
 */
void frmSums::initializeFromCmdLine(bool& error, bool& warning)
{
  bool cont = true;  // continue
  error = false;     // no error has occured
  warning = false;   // no warning has occured
  
  if (CmdLineOptions::action == CmdLineOptions::aOpen ||
      CmdLineOptions::action == CmdLineOptions::aVerify)
  {
    // Existance of CmdLineOptions::files[0] should be verified by
    // CmdLineOptions::init(). CmdLineOptions::files[0] is a absolute path.
    if (lvwSums->openChecksumFile(CmdLineOptions::files[0]))
    {
      // Check the file ?
      if (CmdLineOptions::action == CmdLineOptions::aVerify &&
          !AppPrefs::get()->readBool(prGUI_AUTO_CHECK_ON_OPEN))
        lvwSums->check();    
    }
    else  // The checksums' file can't be opened.
      error = true;
  }

  if (CmdLineOptions::action == CmdLineOptions::aCreate ||
      CmdLineOptions::action == CmdLineOptions::aAppend)
  {
    SumFile* sf = NULL;

    // Checks that the checksums file is not a directory.
    if (::wxDirExists(CmdLineOptions::checksumsFileName))
    {
      if (::wxMessageBox(wxString::Format(_("'%s' is a directory.\nThe checksums' file will be not be saved.\nDo you want to continue?"), CmdLineOptions::checksumsFileName.c_str()), wxString::Format(_("Error - %s"), wxT(APP_NAME)), wxYES_NO | wxICON_EXCLAMATION, this) == wxNO)
        cont = false;
      else
        error = true;
    }
    
    if (cont && CmdLineOptions::action == CmdLineOptions::aAppend)
    {
      // Try to open the file.
      sf = ::openChecksumFile(CmdLineOptions::checksumsFileName);
      if (sf == NULL && wxFileName::FileExists(CmdLineOptions::checksumsFileName))
      {
        if (::wxMessageBox(wxString::Format(_("'%s' exists but its format is unknown.\nDo you want to create a new checksums' file with this name and overwrite the existing file?"), CmdLineOptions::checksumsFileName.c_str()), wxString::Format(_("Warning - %s"), wxT(APP_NAME)), wxYES_NO | wxICON_EXCLAMATION, this) == wxNO)
          cont = false;
      }
    }

    if (cont && sf == NULL)
    {
      // Create a new file.
      switch (CmdLineOptions::getchecksumsFileType())
      {
        case CmdLineOptions::cftMD5 : sf = new MD5File(); break;
        case CmdLineOptions::cftSFV :
        default :  // By default create an SFV checksums' file.
          sf = new SFVFile(); break;
      }
    }

    if (cont)
    {
      // Sets the checksums' file informations
      sf->setFileName(CmdLineOptions::checksumsFileName);
      lvwSums->setSumFile(sf);

      // Adds the files to the checksums' file
      lvwSums->addFiles(CmdLineOptions::files);
      this->updateTitle();
      lvwSums->reformat();

      // Try to save the file
      if (!::wxDirExists(CmdLineOptions::checksumsFileName) &&
          lvwSums->getSumFile()->write(CmdLineOptions::checksumsFileName))
      {
        this->updateTitle();
        lvwSums->reformat();
        addFileNameToOpenRecent(CmdLineOptions::checksumsFileName);
      }
      else  // an error has occured
      {
        error = true;
        ::wxMessageBox(_("An error has occurred during the save process of the file."),
                       wxString::Format(_("Error - %s"), wxT(APP_NAME)),
                       wxOK | wxICON_ERROR, this);
        if ((CmdLineOptions::action == CmdLineOptions::aCreate &&
             static_cast<DisplayGUI>(AppPrefs::get()->readLong(prGUI_CLN_CREATE_SHOW_GUI)) == clgNever) ||
            (CmdLineOptions::action == CmdLineOptions::aAppend &&
             static_cast<DisplayGUI>(AppPrefs::get()->readLong(prGUI_CLN_APPEND_SHOW_GUI)) == clgNever))
          // The user doesn't want to see the GUI, we say that the checksums'
          // file is not modified so the FrameClose method won't ask to save the
          // checksums' file.
          lvwSums->getSumFile()->setModified(false);
      }
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Checks if the window should be closed after initialisation from the command
 * line.
 *
 * @param  error    An error has occured during the initialisation from the
 *                  command line parameters.
 * @param  warning  A warning has occured during the initialisation from the
 *                  command line parameters.
 * @return <CODE>true</CODE> if the window should be closed immediatly,
 *         <CODE>false</CODE> otherwise.
 */
bool frmSums::closeAfterInitFromCmdLine(bool error, bool warning)
{
  bool close = false;

  if (CmdLineOptions::action == CmdLineOptions::aVerify)
    if (AppPrefs::get()->readBool(prGUI_CLN_VERIFY_DONT_SHOW_GUI))
      if (error || warning)
        // If an error or a warning has occured, close the window
        close = true;
      else  // if all the checksums are correct, close the window
      {
        wxArrayInt states = lvwSums->getStates(false);
        close = (states.GetCount() > ChecksumData::Verified &&
                 states[ChecksumData::Verified] == lvwSums->GetItemCount());
      }

  if (CmdLineOptions::action == CmdLineOptions::aCreate ||
      CmdLineOptions::action == CmdLineOptions::aAppend)
  {
    DisplayGUI dispOn = static_cast<DisplayGUI>(AppPrefs::get()->readLong((CmdLineOptions::action == CmdLineOptions::aAppend) ? prGUI_CLN_APPEND_SHOW_GUI : prGUI_CLN_CREATE_SHOW_GUI));
    close = ((dispOn == clgNever) ||
             (dispOn == clgOnError && !error) ||
             (dispOn == clgOnWarning && !error && !warning));
  }

  return close;
}
//---------------------------------------------------------------------------


/**
 * Sets the frame title.
 */
void frmSums::updateTitle()
{
  wxString title;
  
  if (lvwSums->getSumFile() != NULL)
  {
    wxFileName fn = lvwSums->getSumFile()->getFileName();
    title += fn.GetFullName() + wxT(' ');
    if (lvwSums->getSumFile()->getModified())
      title += _("(Modified) ");
    title += wxT("- ") + fn.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR);
    title += wxT(" - ");

    // Set the file type in the status bar.
    stbStatus->SetStatusText(lvwSums->getSumFile()->getFileType(), 1);
  }
  else
    stbStatus->SetStatusText(wxString(), 1);
  
  title += wxT(APP_NAME);
  SetTitle(title);
  
}
//---------------------------------------------------------------------------


/**
 * Saves the current ckecksums file.
 *
 * @param  fileName  Name of the file where the checksums will be saved.
 *                   <CODE>fileName</CODE> must have an absolute path (not
 *                   verified by this function).
 * @return <CODE>true</CODE> if the file has been saved successfully in
 *         <CODE>fileName</CODE>, <CODE>false</CODE> otherwise.
 */
bool frmSums::saveChecksumFile(const wxString& fileName)
{
  if (lvwSums->getSumFile() != NULL)
  {
    // Check if all the state of the checksums are 'valid'
    if (AppPrefs::get()->readBool(prGUI_WARN_ON_INVALID_WHEN_SAVING))
    {
      wxArrayInt states = lvwSums->getStates(false);
      if (states[ChecksumData::Verified] != lvwSums->GetItemCount())
        if (::wxMessageBox(_("Some checksums are not valid.\nDo you really wish to save this checksums file?"),
                           wxString::Format(_("Warning - %s"), wxT(APP_NAME)),
                           wxYES_NO | wxCANCEL | wxICON_EXCLAMATION, this) != wxYES)
          // Don't save
          return false;
    }
    
    // Try to save the file
    if (lvwSums->getSumFile()->write(fileName))
    {
      this->updateTitle();
      lvwSums->reformat();
      addFileNameToOpenRecent(fileName);
      return true;
    }
    else  // an error has occured
    {
      ::wxMessageBox(_("An error has occurred during the save process of the file."),
                     wxString::Format(_("Error - %s"), wxT(APP_NAME)),
                     wxOK | wxICON_ERROR, this);
      return false;
    }
  }
  else
    return false;
}
//---------------------------------------------------------------------------


/** 
 * Checks if the current checksums' file has been saved before closing it.
 *
 * @return <UL>
 *           <LI><CODE>wxYES</CODE> if the file wasn't modified or if the
 *             file has been saved successfully.</LI>
 *           <LI><CODE>wxNO</CODE> if the user doesn't want to save the file.
 *           <LI><CODE>wxCANCEL</CODE> if the user want to cancel the process
 *             (ex: closing the file, creating a new file, opening another
 *             file).</LI></UL>
 */
int frmSums::checkFileBeforeClose()
{
  int res = wxYES;

  if (lvwSums->getSumFile() != NULL)
  {
    if (lvwSums->getSumFile()->getModified())
    {
      bool askForSave = true;  // ask the user for saving the file
      while (askForSave)
      {
        askForSave = false;
        switch (::wxMessageBox(_("This checksum file has been modified.\nWould you like to save it?"),
                               wxString::Format(_("Warning - %s"), wxT(APP_NAME)),
                               wxYES_NO | wxCANCEL | wxICON_EXCLAMATION, this))
        {
          case wxYES :
            if (saveChecksumFile(lvwSums->getSumFile()->getFileName()))
              res = wxYES;
            else  // save has failed, re-ask to the user what to do...
              askForSave = true;
            break;
          case wxNO :  // don't save the file and close
            res = wxNO;
            break;
          default :  // wxCANCEL
            res = wxCANCEL;
        }
      }
    }
  }

  return res;  
}
//---------------------------------------------------------------------------


/**
 * Initializes the open recent files.
 *
 * Loads the list from the preferences file and add the entries to the menu.
 */
void frmSums::initializeOpenRecent()
{
  wxString s;
  int l = getOpenRecentHistoryMaxSize();
  for (int i = l - 1; i >= 0; i--)
  {
    wxConfig::Get()->Read(getOpenRecentConfigKey(i), &s, wxEmptyString);
    if (!s.empty())
      addFileNameToOpenRecent(s);
  }
}
//---------------------------------------------------------------------------


/**
 * Adds a name of file to the open recent submenu.
 *
 * If the file is already in the list it is moved on the first position.
 * If the list is full, the most older entry is erased.
 *
 * @param  fileName  Name of the file to be added is the list of files recently
 *                   opened.
 */
void frmSums::addFileNameToOpenRecent(const wxString& fileName)
{
  size_t i, j;

  // Checks if the file name is already present in the list.
  bool found = false;
  i = 0;
  while (!found && i < openRecent.GetCount())
    if (::compareFileName(openRecent[i], fileName) == 0)
      found = true;
    else
      i++;
  
  if (found && i == 0)
  // The file is already present and is in first position. No need to do nothing.
    return;

  if (found)
  // Move the file name to the first position.
    for (j = i; j > 0; j--)
      openRecent[j] = openRecent[j - 1];
  else  // add the name of the file on the first item
  {
    // Check if a new menu entry can be created.
    if (static_cast<int>(openRecent.GetCount()) < getOpenRecentHistoryMaxSize())
      openRecent.Add(wxEmptyString);
    for (j = openRecent.GetCount() - 1; j > 0; j--)
      openRecent[j] = openRecent[j - 1];
  }
  openRecent[0] = fileName;

  // Refresh the menu entries
  int lastItem = ITM_FILE_OPENRECENT1 + mnuOpenRecent->GetMenuItemCount();  
  int curItem = ITM_FILE_OPENRECENT1;
  for (i = 0; i < openRecent.GetCount(); i++)
  {
    if (curItem >= lastItem)
    // Create a menu item
    {
      mnuOpenRecent->Append(lastItem, openRecent[i], _("Open this checksums' file."));
      lastItem++;
    }
    else
      mnuOpenRecent->SetLabel(curItem, openRecent[i]);
    curItem++;
  }
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the file corresponding to the given identifier.
 *
 * @param  id  Idenfier of the menu that contain the file name.
 * @return The name of the file corresponding to the given identifier or an
 *         empty string if the identifier is invalid.
 */
wxString frmSums::getOpenRecentFileName(const int id)
{
  wxString res;
  if (id - ITM_FILE_OPENRECENT1 < static_cast<int>(openRecent.GetCount()))
    res = openRecent[id - ITM_FILE_OPENRECENT1];
  
  return res;
}
//---------------------------------------------------------------------------


/**
 * Gets the configuration key for the last files' names open recently.
 *
 * @param  n  The nth history configuration key to get.
 * @return The configuration key for the last files' names open recently or
 *         an empty string if <CODE>n >= getOpenRecentHistoryMaxSize()</CODE>.
 */
wxString frmSums::getOpenRecentConfigKey(const int n)
{
  wxString res;
  if (n >= 0 && n < getOpenRecentHistoryMaxSize())
    res = wxString::Format(wxT("GUI/Main/History/File%02d"), n);

  return res;
}
//---------------------------------------------------------------------------


/**
 * Gets the number of maximal files in the open recent history.
 *
 * @return The number of maximal files in the open recent history.
 */
inline int frmSums::getOpenRecentHistoryMaxSize()
{
  return 16;
}
//---------------------------------------------------------------------------


/**
 * Processes menu File->New.
 *
 * @param  event  The event's parameters
 */
void frmSums::itmFileNewClick(wxCommandEvent& event)
{
  int res = this->checkFileBeforeClose();

  if (res == wxYES || res == wxNO)
  {
    dlgNewFile dlg(this);
    if (dlg.ShowModal() == wxID_OK)
    {
      // Creates a new file
      SumFile* f;
      switch (dlg.getFileType())
      {
        case dlgNewFile::ftSFV : f = new SFVFile(); break;
        case dlgNewFile::ftMD5 : f = new MD5File(); break;
      }

      f->setFileName(dlg.getFileName());
      lvwSums->setSumFile(f);
      updateTitle();

      // Save the last directory and last file type
      AppPrefs::get()->write(prGUI_NEWFILE_LAST_DIRECTORY, wxFileName(dlg.getFileName()).GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
      AppPrefs::get()->write(prGUI_NEWFILE_LAST_FILETYPE, static_cast<long>(dlg.getFileType()));
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Processes menu File->Open.
 *
 * @param  event  The event's parameters
 */
void frmSums::itmFileOpenClick(wxCommandEvent& event)
{
  int res = this->checkFileBeforeClose();

  if (res == wxYES || res == wxNO)
  {
    wxLogNull      logNo;   // No log

    // Gets the filter for knows types of checksums' files
    wxFileDialogFilterMaker fltMaker = ::getFilterForKnownTypesOfChecksumsFiles();

    // Show the open dialog
    wxFileDialog dlgOpen(this, _("Select the checksums file"),
                         wxEmptyString, wxEmptyString, fltMaker.GetFilters(),
                         wxOPEN | wxFILE_MUST_EXIST, wxDefaultPosition);
    wxString direct = AppPrefs::get()->readString(prGUI_MAIN_LAST_DIRECTORY);
    if (wxFileName::DirExists(direct))
      dlgOpen.SetDirectory(direct);

    if (dlgOpen.ShowModal() == wxID_OK)
    {
      AppPrefs::get()->write(prGUI_MAIN_LAST_DIRECTORY, dlgOpen.GetDirectory());

      lvwSums->openChecksumFile(dlgOpen.GetPath());
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Processes menu File->Open recent.
 *
 * @param  event  The event's parameters
 */
void frmSums::itmFileOpenRecentClick(wxCommandEvent& event)
{
  wxString fileName = getOpenRecentFileName(event.GetId());

  if (lvwSums->getSumFile() != NULL)
    if (::compareFileName(lvwSums->getSumFile()->getFileName(), fileName) == 0)
      if (::wxMessageBox(wxString::Format(_("'%s' is already opened.\nDo you want to reopen it?"), fileName.c_str()),
                        wxString::Format(_("Warning - %s"), wxT(APP_NAME)),
                        wxYES_NO | wxICON_EXCLAMATION, this) == wxNO)
      // Dont reopen the file.
        return;
  
  int res = this->checkFileBeforeClose();

  if (res == wxYES || res == wxNO)
    lvwSums->openChecksumFile(fileName);
}
//---------------------------------------------------------------------------


/**
 * Processes menu File->Save.
 *
 * @param  event  The event's parameters
 */
void frmSums::itmFileSaveClick(wxCommandEvent& event)
{
  if (lvwSums->getSumFile() != NULL)
    if (lvwSums->getSumFile()->getModified())
      this->saveChecksumFile(lvwSums->getSumFile()->getFileName());
}
//---------------------------------------------------------------------------


/**
 * Processes menu File->Save as.
 *
 * @param  event  The event's parameters
 */
void frmSums::itmFileSaveAsClick(wxCommandEvent& event)
{
  if (lvwSums->getSumFile() != NULL)
  {
    wxLogNull logNo;   // No log

    // Gets the filter for knows types of checksums' files
    wxFileDialogFilterMaker fltMaker = ::getFilterForKnownTypesOfChecksumsFiles();

    // Show the save as dialog
    wxFileDialog dlgSave(this, _("Save the checksums file as"),
                         wxEmptyString, wxEmptyString, fltMaker.GetFilters(),
                         wxSAVE | wxOVERWRITE_PROMPT, wxDefaultPosition);
    wxString direct = AppPrefs::get()->readString(prGUI_MAIN_LAST_DIRECTORY);
    if (wxFileName::DirExists(direct))
      dlgSave.SetDirectory(direct);

    int filterIdx = 0;
    int i = 0;
    while (filterIdx == 0 && i < SumFileFactory::getSumFilesCount())
      if (lvwSums->getSumFile()->getFileType().CmpNoCase(SumFileFactory::getSumFileName(i)) == 0)
        filterIdx = i + 1;
      else
        i++;
    dlgSave.SetFilterIndex(filterIdx);

    if (dlgSave.ShowModal() == wxID_OK)
    {
      AppPrefs::get()->write(prGUI_MAIN_LAST_DIRECTORY, dlgSave.GetDirectory());

      if (this->saveChecksumFile(dlgSave.GetPath()))
        updateTitle();
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Processes menu File->Close.
 *
 * @param  event  The event's parameters
 */
void frmSums::itmFileCloseClick(wxCommandEvent& event)
{
  if (lvwSums->getSumFile() != NULL)
  {
    int res = this->checkFileBeforeClose();

    if (res == wxYES || res == wxNO)
      lvwSums->setSumFile(NULL);
  }
  
  // Update the title bar
  this->updateTitle();
}
//---------------------------------------------------------------------------


/**
 * Processes menu File->Quit.
 *
 * @param  event  The event's parameters
 */
void frmSums::itmFileQuitClick(wxCommandEvent& event)
{
  Close();
}
//---------------------------------------------------------------------------


/**
 * Processes menu Sums->Add files...
 *
 * @param  event  The event's parameters
 */
void frmSums::itmSumsAddFilesClick(wxCommandEvent& event)
{
  lvwSums->selectFilesToAdd();
  updateTitle();
}
//---------------------------------------------------------------------------


/**
 * Processes menu Sums->Add directories...
 *
 * @param  event  The event's parameters
 */
void frmSums::itmSumsAddDirectoriesClick(wxCommandEvent& event)
{
  lvwSums->selectDirectoriesToAdd();
  updateTitle();
}
//---------------------------------------------------------------------------


/**
 * Processes menu Sums->Add directories...
 *
 * @param  event  The event's parameters
 */
void frmSums::itmSumsAddMatchingFilesClick(wxCommandEvent& event)
{
  lvwSums->selectMatchingFilesToAdd();
  updateTitle();
}
//---------------------------------------------------------------------------


/**
 * Processes menu Sums->Remove...
 *
 * @param  event  The event's parameters
 */
void frmSums::itmSumsRemoveClick(wxCommandEvent& event)
{
  lvwSums->removeSelectedChecksums();
  updateTitle();
}
//---------------------------------------------------------------------------


/**
 * Processes menu Sums->Check
 *
 * @param  event  The event's parameters
 */
void frmSums::itmSumsCheckClick(wxCommandEvent& event)
{
  lvwSums->check();
  updateTitle();
  //SetStatusText(lvwSums->sumUpStates(lvwSums->GetSelectedItemCount() != 0));
}
//---------------------------------------------------------------------------


/**
 * Processes menu Sums->Recompute
 * 
 * @param  event  The event's parameters
 */
void frmSums::itmSumsRecomputeClick(wxCommandEvent& event)
{
  lvwSums->recompute();
  updateTitle();
}
//---------------------------------------------------------------------------


/**
 * Processes menu Sums->Sort by...
 *
 * @param  event  The event's parameters
 */
void frmSums::itmSumsSortByClick(wxCommandEvent& event)
{
  bool changeColumn = false;
  ChecksumsListView::Columns colToChange;
    
  switch (event.GetId())
  {
    case ITM_SUMS_SORTBY_FILENAME :
      colToChange = ChecksumsListView::FILE_NAME;
      changeColumn = true;
      break;
    case ITM_SUMS_SORTBY_DIRECTORY :
      colToChange = ChecksumsListView::DIRECTORY;
      changeColumn = true;
      break;
    case ITM_SUMS_SORTBY_CHECKSUMVALUE :
      colToChange = ChecksumsListView::CHECKSUM_VALUE;
      changeColumn = true;
      break;
    case ITM_SUMS_SORTBY_STATE :
      colToChange = ChecksumsListView::STATE;
      changeColumn = true;
      break;
    case ITM_SUMS_SORTBY_NONE :
      lvwSums->setSortOrder(ChecksumsListView::NONE);
      break;
    case ITM_SUMS_SORTBY_ASCENDING :
      lvwSums->setSortOrder(ChecksumsListView::ASCENDING);
      break;
    case ITM_SUMS_SORTBY_DESCENDING :
      lvwSums->setSortOrder(ChecksumsListView::DESCENDING);
      break;
  }

  if (changeColumn)
  {
    ChecksumsListView::Columns cols[LVW_SUMS_NBCOLS];
    lvwSums->getColumns(cols);
    int i = 0;
    while (i < LVW_SUMS_NBCOLS)
    {
      if (cols[i] == colToChange)
        lvwSums->setColumnToSort(i);
      i++;
    }
  }

  lvwSums->sort();
}
//---------------------------------------------------------------------------


/**
 * Update the state of the Sort by... submenu.
 *
 * Checks the menus items corresponding to the new sort order and column.
 */
void frmSums::itmSumsSortByUpdate()
{
  wxMenuItem* menuItem = NULL;
  
  // Sort order
  switch (lvwSums->getSortOrder())
  {
    case ChecksumsListView::NONE :
      menuItem = this->GetMenuBar()->FindItem(ITM_SUMS_SORTBY_NONE);
      break;
    case ChecksumsListView::ASCENDING :
      menuItem = this->GetMenuBar()->FindItem(ITM_SUMS_SORTBY_ASCENDING);
      break;
    case ChecksumsListView::DESCENDING :
      menuItem = this->GetMenuBar()->FindItem(ITM_SUMS_SORTBY_DESCENDING);
      break;
  }
  if (menuItem != NULL)
    menuItem->Check(true);

  // Column to short
  menuItem = NULL;
  ChecksumsListView::Columns cols[LVW_SUMS_NBCOLS];
  lvwSums->getColumns(cols);
  int col = lvwSums->getColumnToSort();
  switch (cols[col])
  {
    case ChecksumsListView::FILE_NAME :
      menuItem = this->GetMenuBar()->FindItem(ITM_SUMS_SORTBY_FILENAME);
      break;
    case ChecksumsListView::DIRECTORY :
      menuItem = this->GetMenuBar()->FindItem(ITM_SUMS_SORTBY_DIRECTORY);
      break;
    case ChecksumsListView::CHECKSUM_VALUE :
      menuItem = this->GetMenuBar()->FindItem(ITM_SUMS_SORTBY_CHECKSUMVALUE);
      break;
    case ChecksumsListView::STATE :
      menuItem = this->GetMenuBar()->FindItem(ITM_SUMS_SORTBY_STATE);
      break;
  }
  if (menuItem != NULL)
    menuItem->Check(true);
}


/**
 * Processes menu Sums->Select all
 *
 * @param  event  The event's parameters
 */
void frmSums::itmSumsSelectAllClick(wxCommandEvent& event)
{
  lvwSums->selectAll();
}
//---------------------------------------------------------------------------


/**
 * Processes menu Sums->Invert selection
 *
 * @param  event  The event's parameters
 */
void frmSums::itmSumsInvertSelectionClick(wxCommandEvent& event)
{
  lvwSums->invertSelection();
}
//---------------------------------------------------------------------------


/**
 * Processes menu Tools->Check multiple checksum's files
 *
 * @param  event  The event's parameters
 */
void frmSums::itmToolsCheckMultipleClick(wxCommandEvent& event)
{
  wxArrayString files;

  {
    dlgMultiCheckConf dlgConf(this);
    dlgConf.initialize();
    if (dlgConf.ShowModal() == wxID_OK)
      dlgConf.getFileNames(files);
  }

  if (!files.IsEmpty())
    dlgMultiCheck::checkChecksumsFiles(files, this);
}
//---------------------------------------------------------------------------


/**
 * Processes menu Tools->Batch creation of checksums' files
 *
 * @param  event  The event's parameters
 */
void frmSums::itmToolsBatchCreationClick(wxCommandEvent& event)
{
  wxArrayString files;
  wxArrayInt    ckFileTypes;
  dlgBatchCreation::Options options;

  {
    dlgBatchCreationConf dlgConf(this);
    dlgConf.initialize();
    if (dlgConf.ShowModal() == wxID_OK)
    {
      dlgConf.getFileNames(files);
      ckFileTypes = dlgConf.getChecksumsFileTypeToCreate();
      options = dlgConf.getOptions();
    }
  }

  if (!files.IsEmpty() && !ckFileTypes.IsEmpty())
    dlgBatchCreation::batchCreation(files, options, ckFileTypes, this);
}
//---------------------------------------------------------------------------


/**
 * Processes menu Tools->Show toolbar
 *
 * @param  event  The event's parameters
 */
void frmSums::itmToolsShowToolbarClick(wxCommandEvent& event)
{
  tlbTools->Show(event.IsChecked());
  AppPrefs::get()->write(prGUI_MAIN_SHOW_TOOLBAR, event.IsChecked());

  // TODO: find a better way to refresh the frame...  ^^;;;
  //this->Freeze();
  wxSize s = this->GetSize();
  s.SetWidth(s.GetWidth() + 1);
  this->SetSize(s);
  s.SetWidth(s.GetWidth() - 1);
  this->SetSize(s);
  //this->Thaw();
}
//---------------------------------------------------------------------------


/**
 * Processes menu Tools->Show statusbar
 *
 * @param  event  The event's parameters
 */
void frmSums::itmToolsShowStatusbarClick(wxCommandEvent& event)
{
  stbStatus->Show(event.IsChecked());
  AppPrefs::get()->write(prGUI_MAIN_SHOW_STATUSBAR, event.IsChecked());

  // TODO: find a better way to refresh the frame...  ^^;;;
  //this->Freeze();
  wxSize s = this->GetSize();
  s.SetWidth(s.GetWidth() + 1);
  this->SetSize(s);
  s.SetWidth(s.GetWidth() - 1);
  this->SetSize(s);
  //this->Thaw();
}
//---------------------------------------------------------------------------


/**
 * Processes menu Tools->Configure
 *
 * @param  event  The event's parameters
 */
void frmSums::itmToolsConfigureClick(wxCommandEvent& event)
{
  int i;
  ChecksumsListView::Columns cols[LVW_SUMS_NBCOLS];
  lvwSums->getColumns(cols);

  dlgConfigure d(this);
  for (i = 0; i < LVW_SUMS_NBCOLS; i++)
    d.lstSumsHeaders->Append(ChecksumsListView::getColumnName(cols[i]), reinterpret_cast<void*>(cols[i]));

  if (d.ShowModal() == wxID_OK)
  {
    // Save the position of the splitter's sash
    AppPrefs::get()->write(prGUI_CONF_SASH_POSITION, static_cast<long>(d.sptConfigure->GetSashPosition()));
    
    // Display tab
    AppPrefs::get()->write(prGUI_MAIN_SAVE_WINDOW_POSITION, d.chkWindowSavePosition->GetValue());
    AppPrefs::get()->write(prGUI_MAIN_SAVE_WINDOW_SIZE, d.chkWindowSaveSize->GetValue());
    AppPrefs::get()->write(prGUI_MAIN_SUMS_SAVECOLUMNTOSORT, d.chkSumsSaveColumnToSort->GetValue());
    AppPrefs::get()->write(prGUI_MAIN_SUMS_SAVECOLUMNSWIDTHS, d.chkSumsSaveColumnsWidths->GetValue());
    AppPrefs::get()->write(prGUI_MAIN_SUMS_DIRSINABSOLUTEPATH, d.chkSumsDirInAbsolutePath->GetValue());
    AppPrefs::get()->write(prGUI_MAIN_SUMS_UPPERCASE, d.rbtSumsValuesCaseUpper->GetValue());
    AppPrefs::get()->write(prGUI_MAIN_SUMS_HRULES, d.chkSumsHRules->GetValue());
    AppPrefs::get()->write(prGUI_MAIN_SUMS_VRULES, d.chkSumsVRules->GetValue());

    // Gets the column order
    for (i = 0; i < LVW_SUMS_NBCOLS; i++)
      cols[i] = static_cast<ChecksumsListView::Columns>(reinterpret_cast<int>(d.lstSumsHeaders->GetClientData(i)));
    if (!lvwSums->setColumns(cols))
      lvwSums->reformat();

    // Behavior
    AppPrefs::get()->write(prGUI_AUTO_CHECK_ON_OPEN, d.chkAutoCheckOnOpen->GetValue());
    AppPrefs::get()->write(prGUI_DLG_SUMUP_CHECK, d.chkDlgSumUpCheck->GetValue());
    AppPrefs::get()->write(prGUI_WARN_ON_INVALID_WHEN_SAVING, d.chkWarnOnInvalidWhenSaving->GetValue());

    // Language of the application
    if (d.lstLanguages->GetSelection() >= 0)
    {
      Languages languages;
      AppPrefs::get()->write(prLANGUAGE_NAME, languages.getLanguageShortName(reinterpret_cast<int>(d.lstLanguages->GetClientData(d.lstLanguages->GetSelection()))));
    }

    // Command line
    AppPrefs::get()->write(prGUI_CLN_VERIFY_DONT_SHOW_GUI, d.chkCLnVerifyDontShowGUI->GetValue());
    // Append option
    if (d.rbxCLnAppendNeverShowGUI->GetValue())
      AppPrefs::get()->write(prGUI_CLN_APPEND_SHOW_GUI, static_cast<long>(clgNever));
    else if (d.rbxCLnAppendShowGUIOnError->GetValue())
      AppPrefs::get()->write(prGUI_CLN_APPEND_SHOW_GUI, static_cast<long>(clgOnError));
    else if (d.rbxCLnAppendShowGUIOnWarning->GetValue())
      AppPrefs::get()->write(prGUI_CLN_APPEND_SHOW_GUI, static_cast<long>(clgOnWarning));
    else
      AppPrefs::get()->write(prGUI_CLN_APPEND_SHOW_GUI, static_cast<long>(clgAlways));
    // Create option
    if (d.rbxCLnCreateNeverShowGUI->GetValue())
      AppPrefs::get()->write(prGUI_CLN_CREATE_SHOW_GUI, static_cast<long>(clgNever));
    else if (d.rbxCLnCreateShowGUIOnError->GetValue())
      AppPrefs::get()->write(prGUI_CLN_CREATE_SHOW_GUI, static_cast<long>(clgOnError));
    else if (d.rbxCLnCreateShowGUIOnWarning->GetValue())
      AppPrefs::get()->write(prGUI_CLN_CREATE_SHOW_GUI, static_cast<long>(clgOnWarning));
    else
      AppPrefs::get()->write(prGUI_CLN_CREATE_SHOW_GUI, static_cast<long>(clgAlways));

    // SFV files
    if (d.rbxSFVPathSepReadAuto->GetValue())
      AppPrefs::get()->write(prSFV_READ_PATH_SEPARATOR, static_cast<long>(wxPATH_NATIVE));
    else if (d.rbxSFVPathSepReadUnix->GetValue())
      AppPrefs::get()->write(prSFV_READ_PATH_SEPARATOR, static_cast<long>(wxPATH_UNIX));
    else if (d.rbxSFVPathSepReadWindows->GetValue())
      AppPrefs::get()->write(prSFV_READ_PATH_SEPARATOR, static_cast<long>(wxPATH_WIN));
    else
      AppPrefs::get()->write(prSFV_READ_PATH_SEPARATOR, static_cast<long>(wxPATH_MAC));
    AppPrefs::get()->write(prSFV_WRITE_GEN_AND_DATE, d.chkSFVSaveGenerator->GetValue());
    // Save the generator identificator
    if (d.cboSFVIdentifyAs->GetSelection() == 0)
      AppPrefs::get()->write(prSFV_IDENTIFY_AS, wxString());
    else
      AppPrefs::get()->write(prSFV_IDENTIFY_AS, d.cboSFVIdentifyAs->GetString(d.cboSFVIdentifyAs->GetSelection()));
    // Save the history
    for (i = 2; i < d.getSFVGeneratorIdentifierHistoryMaxSize() + 2; i++)  // + 2 => two first items are always there
      if (i < static_cast<int>(d.cboSFVIdentifyAs->GetCount()))
        wxConfig::Get()->Write(d.getSFVGeneratorIdentifierConfigKey(i - 1), d.cboSFVIdentifyAs->GetString(i));
      else
        wxConfig::Get()->Write(d.getSFVGeneratorIdentifierConfigKey(i - 1), wxString());
    AppPrefs::get()->write(prSFV_WRITE_FILE_SIZE_AND_DATE, d.chkSFVSaveFilesInfo->GetValue());
    if (d.rbxSFVPathSepWriteSystem->GetValue())
      AppPrefs::get()->write(prSFV_WRITE_PATH_SEPARATOR, static_cast<long>(wxPATH_NATIVE));
    else if (d.rbxSFVPathSepWriteUnix->GetValue())
      AppPrefs::get()->write(prSFV_WRITE_PATH_SEPARATOR, static_cast<long>(wxPATH_UNIX));
    else if (d.rbxSFVPathSepWriteWindows->GetValue())
      AppPrefs::get()->write(prSFV_WRITE_PATH_SEPARATOR, static_cast<long>(wxPATH_WIN));
    else
      AppPrefs::get()->write(prSFV_WRITE_PATH_SEPARATOR, static_cast<long>(wxPATH_MAC));
    if (d.rbxSFVEOLWriteWindows->GetValue())
      AppPrefs::get()->write(prSFV_WRITE_EOL, static_cast<long>(wxEOL_DOS));
    else if (d.rbxSFVEOLWriteUnix->GetValue())
      AppPrefs::get()->write(prSFV_WRITE_EOL, static_cast<long>(wxEOL_UNIX));
    else if (d.rbxSFVEOLWriteMAC->GetValue())
      AppPrefs::get()->write(prSFV_WRITE_EOL, static_cast<long>(wxEOL_MAC));
    else
      AppPrefs::get()->write(prSFV_WRITE_EOL, static_cast<long>(wxEOL_NATIVE));

    // MD5 files
    if (d.rbxMD5PathSepReadAuto->GetValue())
      AppPrefs::get()->write(prMD5_READ_PATH_SEPARATOR, static_cast<long>(wxPATH_NATIVE));
    else if (d.rbxMD5PathSepReadUnix->GetValue())
      AppPrefs::get()->write(prMD5_READ_PATH_SEPARATOR, static_cast<long>(wxPATH_UNIX));
    else if (d.rbxMD5PathSepReadWindows->GetValue())
      AppPrefs::get()->write(prMD5_READ_PATH_SEPARATOR, static_cast<long>(wxPATH_WIN));
    else
      AppPrefs::get()->write(prMD5_READ_PATH_SEPARATOR, static_cast<long>(wxPATH_MAC));
    AppPrefs::get()->write(prMD5_WRITE_GEN_AND_DATE, d.chkMD5SaveGenerator->GetValue());
    AppPrefs::get()->write(prMD5_WRITE_FILE_SIZE_AND_DATE, d.chkMD5SaveFilesInfo->GetValue());
    if (d.rbxMD5PathSepWriteSystem->GetValue())
      AppPrefs::get()->write(prMD5_WRITE_PATH_SEPARATOR, static_cast<long>(wxPATH_NATIVE));
    else if (d.rbxMD5PathSepWriteUnix->GetValue())
      AppPrefs::get()->write(prMD5_WRITE_PATH_SEPARATOR, static_cast<long>(wxPATH_UNIX));
    else if (d.rbxMD5PathSepWriteWindows->GetValue())
      AppPrefs::get()->write(prMD5_WRITE_PATH_SEPARATOR, static_cast<long>(wxPATH_WIN));
    else
      AppPrefs::get()->write(prMD5_WRITE_PATH_SEPARATOR, static_cast<long>(wxPATH_MAC));
    if (d.rbxMD5EOLWriteWindows->GetValue())
      AppPrefs::get()->write(prMD5_WRITE_EOL, static_cast<long>(wxEOL_DOS));
    else if (d.rbxMD5EOLWriteUnix->GetValue())
      AppPrefs::get()->write(prMD5_WRITE_EOL, static_cast<long>(wxEOL_UNIX));
    else if (d.rbxMD5EOLWriteMAC->GetValue())
      AppPrefs::get()->write(prMD5_WRITE_EOL, static_cast<long>(wxEOL_MAC));
    else
      AppPrefs::get()->write(prMD5_WRITE_EOL, static_cast<long>(wxEOL_NATIVE));

    // Multi-check tools
    AppPrefs::get()->write(prMC_GLOBAL_SUMMARY, d.chkMCGlobalSummary->GetValue());
    AppPrefs::get()->write(prMC_CHECKSUMS_FILE_SUMMARY, d.chkMCChecksumsFileSummary->GetValue());
    AppPrefs::get()->write(prMC_FILE_STATE, d.chkMCFileState->GetValue());
    AppPrefs::get()->write(prMC_NO_CORRECT_FILE_STATE, d.chkMCNoCorrectFileState->GetValue());
    AppPrefs::get()->write(prMC_NORMAL_COLOUR, ::wxColourToLong(d.MCNormalColour));
    AppPrefs::get()->write(prMC_SUCCESS_COLOUR, ::wxColourToLong(d.MCSuccessColour));
    AppPrefs::get()->write(prMC_WARNING_COLOUR, ::wxColourToLong(d.MCWarningColour));
    AppPrefs::get()->write(prMC_ERROR_COLOUR, ::wxColourToLong(d.MCErrorColour));

    // Batch creation tools
    AppPrefs::get()->write(prBC_OVERWRITE_WHEN_CKFILE_EXISTS, d.rbxBCOverwriteExistingCkFile->GetValue());
    AppPrefs::get()->write(prBC_REPLACE_FILE_EXTENSION, d.rbxBCReplaceFileExtension->GetValue());
    AppPrefs::get()->write(prBC_VERBOSITY_LEVEL, static_cast<long>(d.cboBCVerbosityLevel->GetSelection()));
    AppPrefs::get()->write(prBC_NORMAL_COLOUR, ::wxColourToLong(d.BCNormalColour));
    AppPrefs::get()->write(prBC_SUCCESS_COLOUR, ::wxColourToLong(d.BCSuccessColour));
    AppPrefs::get()->write(prBC_WARNING_COLOUR, ::wxColourToLong(d.BCWarningColour));
    AppPrefs::get()->write(prBC_ERROR_COLOUR, ::wxColourToLong(d.BCErrorColour));

    // Configuration dialog size
    AppPrefs::get()->write(prGUI_CONF_WINDOW_SIZE, d.GetSize());
  }
}
//---------------------------------------------------------------------------


/**
 * Processes menu Help->About
 *
 * @param  event  The event's parameters
 */
void frmSums::itmHelpAboutClick(wxCommandEvent& event)
{
  dlgAbout dlg(this);
  dlg.ShowModal();
}
//---------------------------------------------------------------------------



/**
 * Event handler to respond to system close events.
 *
 * @param  event  event parameters.
 */
void frmSums::FrameClose(wxCloseEvent& event)
{
  bool close = true;

  if (lvwSums->getSumFile() != NULL)
  {
    if (lvwSums->getSumFile()->getModified())
    {
      // Informs the user that the application will be closed whatever the user do
      if (!event.CanVeto())
        ::wxMessageBox(wxString::Format(_("'%s' will be closed even if you choose to cancel.\nIf you want to save the current checksums file, choose 'yes' now."), wxT(APP_NAME)),
                       wxString::Format(_("Warning - %s"), wxT(APP_NAME)),
                       wxOK | wxICON_EXCLAMATION, this);

      int res = this->checkFileBeforeClose();
      if (res == wxCANCEL)
        close = false;
    }
  }

  // Update the title bar
  this->updateTitle();

  if (close || !event.CanVeto())
  {
    // Saves window parameters
    if (AppPrefs::get()->readBool(prGUI_MAIN_SAVE_WINDOW_POSITION))
      AppPrefs::get()->write(prGUI_MAIN_WINDOW_POSITION, this->GetPosition());
    if (AppPrefs::get()->readBool(prGUI_MAIN_SAVE_WINDOW_SIZE))
      AppPrefs::get()->write(prGUI_MAIN_WINDOW_SIZE, this->GetSize());
    if (AppPrefs::get()->readBool(prGUI_MAIN_SUMS_SAVECOLUMNSWIDTHS))
    {
      AppPrefs::get()->write(prGUI_MAIN_SUMS_COL_FILENAME_WIDTH, static_cast<long>(lvwSums->GetColumnWidth(0)));
      AppPrefs::get()->write(prGUI_MAIN_SUMS_COL_DIRECTORY_WIDTH, static_cast<long>(lvwSums->GetColumnWidth(1)));
      AppPrefs::get()->write(prGUI_MAIN_SUMS_COL_CHECKSUM_WIDTH, static_cast<long>(lvwSums->GetColumnWidth(2)));
      AppPrefs::get()->write(prGUI_MAIN_SUMS_COL_STATE_WIDTH, static_cast<long>(lvwSums->GetColumnWidth(3)));
    }
    if (AppPrefs::get()->readBool(prGUI_MAIN_SUMS_SAVECOLUMNTOSORT))
    {
      AppPrefs::get()->write(prGUI_MAIN_SUMS_COLUMNTOSORT, static_cast<long>(lvwSums->getColumnToSort()));
      AppPrefs::get()->write(prGUI_MAIN_SUMS_COLUMNSORTORDER, static_cast<long>(lvwSums->getSortOrder()));
    }

    ChecksumsListView::Columns cols[LVW_SUMS_NBCOLS];
    lvwSums->getColumns(cols);
    AppPrefs::get()->write(prGUI_MAIN_SUMS_COL_FIRST, static_cast<long>(cols[0]));
    AppPrefs::get()->write(prGUI_MAIN_SUMS_COL_SECOND, static_cast<long>(cols[1]));
    AppPrefs::get()->write(prGUI_MAIN_SUMS_COL_THIRD, static_cast<long>(cols[2]));
    AppPrefs::get()->write(prGUI_MAIN_SUMS_COL_FOURTH, static_cast<long>(cols[3]));

    // Save the history
    for (size_t i = 0; i < openRecent.GetCount(); i++)
      wxConfig::Get()->Write(getOpenRecentConfigKey(static_cast<int>(i)), openRecent[i]);

    Destroy();
  }
  else  // cancel the closing of the frame
    event.Veto(true);
}
//---------------------------------------------------------------------------


/**
 * Event handler for a keypressed.
 *
 * @param  event  event parameters.
 */
void frmSums::FrameCharHook(wxKeyEvent& event)
{
  event.Skip();
  return;
#if 0  
  switch (event.GetKeyCode())
  {
    case WXK_ESCAPE :
      // Numeric characters are allowed, so the base class wxTextCtrl
      // is allowed to process the event. This is done using the Skip() method.
      // Do something
      break;
/*    case WXK_RETURN :  // wxEVT_COMMAND_TEXT_ENTER
      // Do something
      break;*/
    default :
      event.Skip();
  }
#endif
}
//---------------------------------------------------------------------------


/**
 * Processes a click on a header of a column of the list of checksums.
 *
 * @param  event  event parameters.
 */
void frmSums::lvwSumsColumnClick(wxListEvent& event)
{
  int col = event.GetColumn();
  int prevCol = lvwSums->getColumnToSort();
  ChecksumsListView::SortOrder sortOrder = lvwSums->getSortOrder();
  
  if (col == prevCol)
  {
    ChecksumsListView::SortOrder newSortOrder;
    newSortOrder = (sortOrder == ChecksumsListView::ASCENDING) ? ChecksumsListView::DESCENDING : ChecksumsListView::ASCENDING;
    lvwSums->setSortOrder(newSortOrder);
  }
  else
    lvwSums->setColumnToSort(col, ChecksumsListView::ASCENDING);

  lvwSums->sort();
  
  // Update the state of the Sort by... submenu.
  itmSumsSortByUpdate();
}
//---------------------------------------------------------------------------


/**
 * Processes the <CODE>EVENT_UPDATE_SUMS_FRAME_TITLE_COMMAND</CODE> event.
 *
 * @param  event  event parameters.
 */
void frmSums::OnUpdateTitle(wxCommandEvent& event)
{
  updateTitle();
}
//---------------------------------------------------------------------------


/**
 * Processes the <CODE>EVENT_UPDATE_SUMS_FRAME_STATUSBAR_COMMAND</CODE> event.
 *
 * The <CODE>m_commandString</CODE> member of the event contains the message
 * to display.
 * The <CODE>m_commandInt</CODE> member of the event contains the status field
 * (starting from zero) to set.
 *
 * @param  event  event parameters.
 */
void frmSums::OnUpdateStatusBar(wxCommandEvent& event)
{
  SetStatusText(event.GetString(), event.GetInt());
}
//---------------------------------------------------------------------------


/**
 * Processes the <CODE>EVENT_OPEN_RECENT_ADD_FILE</CODE> event.
 *
 * The <CODE>m_commandString</CODE> member of the event contains the message
 * to display.
 *
 * @param  event  event parameters.
 */
void frmSums::OnOpenRecentAddFile(wxCommandEvent& event)
{
  addFileNameToOpenRecent(event.GetString());
}
//---------------------------------------------------------------------------



BEGIN_EVENT_TABLE(frmSums, wxFrame)
  EVT_MENU(ITM_FILE_NEW, frmSums::itmFileNewClick)
  EVT_MENU(ITM_FILE_OPEN, frmSums::itmFileOpenClick)
  EVT_MENU_RANGE(ITM_FILE_OPENRECENT1, ITM_FILE_OPENRECENT16, frmSums::itmFileOpenRecentClick)
  EVT_MENU(ITM_FILE_SAVE, frmSums::itmFileSaveClick)
  EVT_MENU(ITM_FILE_SAVEAS, frmSums::itmFileSaveAsClick)
  EVT_MENU(ITM_FILE_CLOSE, frmSums::itmFileCloseClick)
  EVT_MENU(ITM_FILE_QUIT, frmSums::itmFileQuitClick)
  EVT_MENU(ITM_SUMS_ADDFILES, frmSums::itmSumsAddFilesClick)
  EVT_MENU(ITM_SUMS_ADDDIRECTORIES, frmSums::itmSumsAddDirectoriesClick)
  EVT_MENU(ITM_SUMS_ADDMATCHINGFILES, frmSums::itmSumsAddMatchingFilesClick)
  EVT_MENU(ITM_SUMS_REMOVE, frmSums::itmSumsRemoveClick)
  EVT_MENU(ITM_SUMS_CHECK, frmSums::itmSumsCheckClick)
  EVT_MENU(ITM_SUMS_RECOMPUTE, frmSums::itmSumsRecomputeClick)
  EVT_MENU(ITM_SUMS_SORTBY_FILENAME, frmSums::itmSumsSortByClick)
  EVT_MENU(ITM_SUMS_SORTBY_DIRECTORY, frmSums::itmSumsSortByClick)
  EVT_MENU(ITM_SUMS_SORTBY_CHECKSUMVALUE, frmSums::itmSumsSortByClick)
  EVT_MENU(ITM_SUMS_SORTBY_STATE, frmSums::itmSumsSortByClick)
  EVT_MENU(ITM_SUMS_SORTBY_NONE, frmSums::itmSumsSortByClick)
  EVT_MENU(ITM_SUMS_SORTBY_ASCENDING, frmSums::itmSumsSortByClick)
  EVT_MENU(ITM_SUMS_SORTBY_DESCENDING, frmSums::itmSumsSortByClick)
  EVT_MENU(ITM_SUMS_SELECTALL, frmSums::itmSumsSelectAllClick)
  EVT_MENU(ITM_SUMS_INVERTSELECTION, frmSums::itmSumsInvertSelectionClick)
  EVT_MENU(ITM_HELP_ABOUT, frmSums::itmHelpAboutClick)
  EVT_MENU(ITM_TOOLS_CHECK_MULTIPLE, frmSums::itmToolsCheckMultipleClick)
  EVT_MENU(ITM_TOOLS_BATCH_CREATION, frmSums::itmToolsBatchCreationClick)
  EVT_MENU(ITM_TOOLS_SHOW_TOOLBAR, frmSums::itmToolsShowToolbarClick)
  EVT_MENU(ITM_TOOLS_SHOW_STATUSBAR, frmSums::itmToolsShowStatusbarClick)
  EVT_MENU(ITM_TOOLS_CONFIGURE, frmSums::itmToolsConfigureClick)
  EVT_CLOSE(frmSums::FrameClose)
  EVT_LIST_COL_CLICK(LVW_SUMS, frmSums::lvwSumsColumnClick)
  EVT_CUSTOM(EVENT_UPDATE_SUMS_FRAME_TITLE_COMMAND, -1, frmSums::OnUpdateTitle)
  EVT_CUSTOM(EVENT_UPDATE_SUMS_FRAME_STATUSBAR_COMMAND, -1, frmSums::OnUpdateStatusBar)
  EVT_CUSTOM(EVENT_OPEN_RECENT_ADD_FILE, -1, frmSums::OnOpenRecentAddFile)
END_EVENT_TABLE()
//---------------------------------------------------------------------------
