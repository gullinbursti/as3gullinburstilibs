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
 * \file dlgConf.cpp
 * Configuration dialog.
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

#include <wx/colordlg.h>
#include <wx/filename.h>
#include <wx/image.h>
#include <wx/notebook.h>
#include <wx/splitter.h>
#include <wx/treectrl.h>
#include <wx/txtstrm.h>
#include <wx/settings.h>

#include "dlgConf.hpp"
#include "cmdlnopt.hpp"
#include "comdefs.hpp"
#include "appprefs.hpp"
#include "language.hpp"
#include "utils.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


// On some plate-forms scrolled window don't refresh correctly.
// Currently it work well only of wxMSW
#if defined(__WXMSW__)
#define  USE_SCROLLEDWINDOW  1
#else
#undef  USE_SCROLLEDWINDOW
#endif  // defined(__WXMSW__)


//###########################################################################
// dlgConfigure::TreePagesItemData methods
//###########################################################################

/**
 * Data for the tree of configuration pages.
 */
class dlgConfigure::TreePagesItemData : public wxTreeItemData
{
 protected:
  TreePagesId pageId;  ///< Identifier of the page.

 public:
  /// Default constructor.
  TreePagesItemData() { }

  /// Constructor with a identifier.
  TreePagesItemData(const TreePagesId id) { SetPageId(id); }

  // Default copy constructor and assignment operator are OK.

  /// Gets the identifier of the page.
  TreePagesId GetPageId() const { return pageId; }
  
  /// Sets the identifier of the page
  void SetPageId(const TreePagesId id) { pageId = id; }
};
//---------------------------------------------------------------------------



//###########################################################################
// Facility functions
//###########################################################################

/**
 * Creates a bitmap of uniform colour for a bitmap button.
 *
 * The size is (3*size_of_char, 1*size_of_char).
 *
 * @param  colour  Colour of the bitmap to create.
 * @param  window  Window from which <CODE>dc</CODE> is taken.
 * @return A bitmap of uniform colour for a bitmap button.
 */
static wxBitmap createBitmapForButton(const wxColour& colour, wxWindow* window)
{
  wxSize size;
  if (window == NULL)
    // Use abitrary size
    size.Set(48, 16);
  else
  {
    wxClientDC dc(window);
    size.Set(dc.GetCharWidth() * 3, dc.GetCharHeight());
  }

  wxImage img(size.GetWidth(), size.GetHeight());
  unsigned char* data = img.GetData();

  unsigned char* p = data;
  int s = size.GetWidth() * size.GetHeight();
  for (int i = 0; i < s; i++)
  {
    *p = colour.Red();
    *(p + 1) = colour.Green();
    *(p + 2) = colour.Blue();
    p += 3;
  }
  
  return wxBitmap(img);
}
//---------------------------------------------------------------------------


//###########################################################################
// dlgConfigure methods
//###########################################################################

IMPLEMENT_DYNAMIC_CLASS(dlgConfigure, wxDialog)


/**
 * Creates a new dialog.
 */
dlgConfigure::dlgConfigure() : wxDialog()
{
  createControls();
}
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 *
 * @param  parent  Parent of the dialog.
 */
dlgConfigure::dlgConfigure(wxWindow* parent) :
  wxDialog(parent, -1, _("Settings"), wxDefaultPosition, wxDefaultSize, 
           wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
  createControls();
  
  wxSize s = AppPrefs::get()->readSize(prGUI_CONF_WINDOW_SIZE);
  if (s.GetWidth() < 0 || s.GetHeight() < 0)
  {
    wxClientDC dc(this);
    this->SetSize(dc.GetCharWidth() * 80, dc.GetCharHeight() * 30);
  }
  else
    this->SetSize(s);

  this->Centre();
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the dialog.
 */
void dlgConfigure::createControls()
{
  wxString msg;
  wxPathFormat pf;
  wxEOL eol;


  //-------------------------------------------------------------------------  
  // The splitter
  sptConfigure = new wxSplitterWindow(this, -1, wxDefaultPosition, wxDefaultSize, wxSP_3D);
  sptConfigure->SetMinimumPaneSize(5);


  //-------------------------------------------------------------------------  
  // The tree to select configuration pages.
  long trePagesStyle = wxNO_BORDER | wxTR_HIDE_ROOT | wxTR_HAS_BUTTONS | wxTR_SINGLE;
  #if defined(__WXMSW__)
  trePagesStyle |= wxTR_LINES_AT_ROOT;
  #else
  trePagesStyle |= wxTR_TWIST_BUTTONS | wxTR_NO_LINES;
  #endif  // defined(__WXMSW__)
  trePages = new wxTreeCtrl(sptConfigure, TRE_PAGES, wxDefaultPosition, wxDefaultSize, trePagesStyle);
  wxTreeItemId trePagesRoot = trePages->AddRoot(wxEmptyString);
  wxTreeItemId trePagesInterface = trePages->AppendItem(trePagesRoot, _("Interface")/*, -1, -1, new TreePagesItemData(TpInterface)*/);
  wxTreeItemId trePagesGUIDisplay = trePages->AppendItem(trePagesInterface, _("Display"), -1, -1, new TreePagesItemData(TpDisplay));
  wxTreeItemId trePagesGUIBehavior = trePages->AppendItem(trePagesInterface, _("Behavior"), -1, -1, new TreePagesItemData(TpBehavior));
  wxTreeItemId trePagesGUILanguage = trePages->AppendItem(trePagesInterface, _("Language"), -1, -1, new TreePagesItemData(TpLanguage));
  wxTreeItemId trePagesGUICmdLine = trePages->AppendItem(trePagesInterface, _("Command line"), -1, -1, new TreePagesItemData(TpCmdLine));
  trePages->Expand(trePagesInterface);

  wxTreeItemId trePagesChecksumsFiles = trePages->AppendItem(trePagesRoot, _("Checksums' files")/*, -1, -1, new TreePagesItemData(TpChecksumsFiles)*/);
  wxTreeItemId trePagesCksumsSFV = trePages->AppendItem(trePagesChecksumsFiles, _("SFV files"), -1, -1, new TreePagesItemData(TpSFVFiles));
  wxTreeItemId trePagesCksumsMD5 = trePages->AppendItem(trePagesChecksumsFiles, _("MD5 files"), -1, -1, new TreePagesItemData(TpMD5Files));
  trePages->Expand(trePagesChecksumsFiles);

  wxTreeItemId trePagesTools = trePages->AppendItem(trePagesRoot, _("Tools") /*, -1, -1, new TreePagesItemData(TpTools)*/);
  wxTreeItemId trePagesToolsMultiCheck = trePages->AppendItem(trePagesTools, _("Multiple check"), -1, -1, new TreePagesItemData(TpMultiCheck));
  wxTreeItemId trePagesToolsBatchCreation = trePages->AppendItem(trePagesTools, _("Batch creation"), -1, -1, new TreePagesItemData(TpBatchCreation));
  trePages->Expand(trePagesTools);


  //-------------------------------------------------------------------------  
  // Interface page
  wxScrolledWindow* tabInterface = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabInterface->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
  tabInterface->Hide();

  wxPanel* pnlInterface = makePageTitlePanel(tabInterface, trePages->GetItemText(trePagesInterface), 1);

  // Sizers
  // The panel sizer
  wxBoxSizer* tabInterfaceSizer2 = new wxBoxSizer(wxVERTICAL);
  tabInterface->SetSizer(tabInterfaceSizer2);
  wxBoxSizer* tabInterfaceSizer = new wxBoxSizer(wxVERTICAL);
  tabInterfaceSizer2->Add(tabInterfaceSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabInterfaceSizer->Add(pnlInterface, 0, wxGROW);


  //-------------------------------------------------------------------------  
  // Display page
  wxScrolledWindow* tabDisplay = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabDisplay->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
// This tab is the one displayed by default, don't hide it.
//  tabDisplay->Hide();

  wxPanel* pnlDisplay = makePageTitlePanel(tabDisplay, trePages->GetItemText(trePagesGUIDisplay));

  wxStaticBox* fraWindow = new wxStaticBox(tabDisplay, -1, _("Window:"));
  chkWindowSavePosition = new wxCheckBox(tabDisplay, -1, _("Save and restore the &position of the window"));
  chkWindowSavePosition->SetValue(AppPrefs::get()->readBool(prGUI_MAIN_SAVE_WINDOW_POSITION));
  chkWindowSaveSize = new wxCheckBox(tabDisplay, -1, _("Save and restore the &size of the window"));
  chkWindowSaveSize->SetValue(AppPrefs::get()->readBool(prGUI_MAIN_SAVE_WINDOW_SIZE));

  wxStaticBox* fraSumsHeaders = new wxStaticBox(tabDisplay, -1, _("Headers of the checksums' list:"));
  lstSumsHeaders = new wxListBox(tabDisplay, LST_SUMS_HEADERS, wxDefaultPosition, wxDefaultSize, 0, NULL, wxLB_SINGLE);
  wxButton* btnSumsHeadersUp = new wxButton(tabDisplay, BTN_SUMS_HEADERS_UP, _("&Up"));
  wxButton* btnSumsHeadersDown = new wxButton(tabDisplay, BTN_SUMS_HEADERS_DOWN, _("&Down"));

  wxStaticBox* fraDisplaySums = new wxStaticBox(tabDisplay, -1, _("Checksums' list:"));
  chkSumsSaveColumnToSort = new wxCheckBox(tabDisplay, -1, _("Save the &column to sort (and the order)"));
  chkSumsSaveColumnToSort->SetValue(AppPrefs::get()->readBool(prGUI_MAIN_SUMS_SAVECOLUMNTOSORT));
  chkSumsSaveColumnsWidths = new wxCheckBox(tabDisplay, -1, _("Save the &widths of the columns"));
  chkSumsSaveColumnsWidths->SetValue(AppPrefs::get()->readBool(prGUI_MAIN_SUMS_SAVECOLUMNSWIDTHS));
  chkSumsDirInAbsolutePath = new wxCheckBox(tabDisplay, -1, _("Display the directories in &absolute path"));
  chkSumsDirInAbsolutePath->SetValue(AppPrefs::get()->readBool(prGUI_MAIN_SUMS_DIRSINABSOLUTEPATH));
  wxStaticText* lblSumsValuesCase = new wxStaticText(tabDisplay, -1, _("Show checksums values in:"));
  rbtSumsValuesCaseUpper = new wxRadioButton(tabDisplay, -1, _("upp&ercase"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbtSumsValuesCaseLower = new wxRadioButton(tabDisplay, -1, _("&lowercase"));
  if (AppPrefs::get()->readBool(prGUI_MAIN_SUMS_UPPERCASE)) {
    rbtSumsValuesCaseLower->SetValue(false); rbtSumsValuesCaseUpper->SetValue(true);
  } else {
    rbtSumsValuesCaseUpper->SetValue(false); rbtSumsValuesCaseLower->SetValue(true); }
  chkSumsHRules = new wxCheckBox(tabDisplay, -1, _("Draws light &horizontal rules between rows"));
  chkSumsHRules->SetValue(AppPrefs::get()->readBool(prGUI_MAIN_SUMS_HRULES));
  chkSumsVRules = new wxCheckBox(tabDisplay, -1, _("Draws light &vertical rules between columns"));
  chkSumsVRules->SetValue(AppPrefs::get()->readBool(prGUI_MAIN_SUMS_VRULES));

  // Sizers
  // The panel sizer
  wxBoxSizer* tabDisplaySizer2 = new wxBoxSizer(wxVERTICAL);
  tabDisplay->SetSizer(tabDisplaySizer2);
  wxBoxSizer* tabDisplaySizer = new wxBoxSizer(wxVERTICAL);
  tabDisplaySizer2->Add(tabDisplaySizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabDisplaySizer->Add(pnlDisplay, 0, wxGROW);

  // The 'Window' frame sizer
  wxStaticBoxSizer* fraWindowSizer2 = new wxStaticBoxSizer(fraWindow, wxVERTICAL);
  tabDisplaySizer->Add(fraWindowSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraWindowSizer = new wxBoxSizer(wxVERTICAL);
  fraWindowSizer2->Add(fraWindowSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);
  fraWindowSizer->Add(chkWindowSavePosition);
  fraWindowSizer->Add(chkWindowSaveSize, 0, wxTOP, CONTROL_SPACE / 2);

  // The 'Headers of the checksums' list' frame sizer
  wxStaticBoxSizer* fraSumsHeadersSizer2 = new wxStaticBoxSizer(fraSumsHeaders, wxVERTICAL);
  tabDisplaySizer->Add(fraSumsHeadersSizer2, 1, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraSumsHeadersSizer = new wxBoxSizer(wxVERTICAL);
  fraSumsHeadersSizer2->Add(fraSumsHeadersSizer, 1, wxALL | wxGROW, CONTROL_SPACE / 2);

  // The list and buttons sizer
  wxBoxSizer* SumsHeadersSizer = new wxBoxSizer(wxHORIZONTAL);
  fraSumsHeadersSizer->Add(SumsHeadersSizer, 1, wxGROW);
  SumsHeadersSizer->Add(lstSumsHeaders, 1, wxGROW);
  wxBoxSizer* SumsHeadersButtonsSizer = new wxBoxSizer(wxVERTICAL);
  SumsHeadersSizer->Add(SumsHeadersButtonsSizer, 0, wxLEFT, CONTROL_SPACE);
  SumsHeadersButtonsSizer->Add(btnSumsHeadersUp);
  SumsHeadersButtonsSizer->Add(btnSumsHeadersDown, 0, wxTOP, CONTROL_SPACE);

  // The 'Checksums' list' frame sizer
  wxStaticBoxSizer* fraDisplaySumsSizer2 = new wxStaticBoxSizer(fraDisplaySums, wxVERTICAL);
  tabDisplaySizer->Add(fraDisplaySumsSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraDisplaySumsSizer = new wxBoxSizer(wxVERTICAL);
  fraDisplaySumsSizer2->Add(fraDisplaySumsSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  // Display directories in absolute path
  fraDisplaySumsSizer->Add(chkSumsSaveColumnToSort, 0);
  fraDisplaySumsSizer->Add(chkSumsSaveColumnsWidths, 0, wxTOP, CONTROL_SPACE / 2);
  fraDisplaySumsSizer->Add(chkSumsDirInAbsolutePath, 0, wxTOP, CONTROL_SPACE / 2);
  
  // Case of the checksums values
  wxBoxSizer* SumsCaseSizer = new wxBoxSizer(wxHORIZONTAL);
  fraDisplaySumsSizer->Add(SumsCaseSizer, 0, wxTOP, CONTROL_SPACE / 2);
  SumsCaseSizer->Add(lblSumsValuesCase, 0, wxALIGN_CENTER_VERTICAL);
  SumsCaseSizer->Add(rbtSumsValuesCaseUpper, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  SumsCaseSizer->Add(rbtSumsValuesCaseLower, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);

  // Sums list rules bitween rows and columns.
  fraDisplaySumsSizer->Add(chkSumsHRules, 0, wxTOP, CONTROL_SPACE / 2);
  fraDisplaySumsSizer->Add(chkSumsVRules, 0, wxTOP, CONTROL_SPACE / 2);


  //-------------------------------------------------------------------------  
  // Behavior page
  wxScrolledWindow* tabBehavior = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabBehavior->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
  tabBehavior->Hide();

  wxPanel* pnlBehavior = makePageTitlePanel(tabBehavior, trePages->GetItemText(trePagesGUIBehavior));
  
  chkAutoCheckOnOpen = new wxCheckBox(tabBehavior, -1, _("&Checks automatically the checksums file when opening it"));
  chkAutoCheckOnOpen->SetValue(AppPrefs::get()->readBool(prGUI_AUTO_CHECK_ON_OPEN));
  chkDlgSumUpCheck = new wxCheckBox(tabBehavior, -1, _("&Opens a dialog box to sum up the check"));
  chkDlgSumUpCheck->SetValue(AppPrefs::get()->readBool(prGUI_DLG_SUMUP_CHECK));
  chkWarnOnInvalidWhenSaving = new wxCheckBox(tabBehavior, -1, _("&Displays a warning if the state of all the files is not 'OK' when saving a checksums file"));
  chkWarnOnInvalidWhenSaving->SetValue(AppPrefs::get()->readBool(prGUI_WARN_ON_INVALID_WHEN_SAVING));

  // Behavior page sizer
  // The panel sizer
  wxBoxSizer* tabBehaviorSizer2 = new wxBoxSizer(wxVERTICAL);
  tabBehavior->SetSizer(tabBehaviorSizer2);
  wxBoxSizer* tabBehaviorSizer = new wxBoxSizer(wxVERTICAL);
  tabBehaviorSizer2->Add(tabBehaviorSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabBehaviorSizer->Add(pnlBehavior, 0, wxGROW);

  tabBehaviorSizer->Add(chkAutoCheckOnOpen, 0, wxTOP, CONTROL_SPACE);
  tabBehaviorSizer->Add(chkDlgSumUpCheck, 0, wxTOP, CONTROL_SPACE / 2);
  tabBehaviorSizer->Add(chkWarnOnInvalidWhenSaving, 0, wxTOP, CONTROL_SPACE / 2);


  //-------------------------------------------------------------------------  
  // Language page
  wxScrolledWindow* tabLanguage = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabLanguage->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
  tabLanguage->Hide();

  wxPanel* pnlLanguage = makePageTitlePanel(tabLanguage, trePages->GetItemText(trePagesGUILanguage));

  wxStaticText* lblLanguage = new wxStaticText(tabLanguage, -1, wxString::Format(_("Select the &language that %s should use:"), wxT(APP_NAME)));
  lstLanguages = new wxListBox(tabLanguage, -1, wxDefaultPosition, wxDefaultSize, 0, NULL, wxLB_SINGLE);
  lstLanguages->Append(_("Language of the system (if available)"), reinterpret_cast<void*>(Languages::LANGUAGE_UNKNOW));
  int i;
  Languages languages;
  for (i = 0; i < languages.getLanguagesCount(); i++)
  {
    if (languages.getLanguageName(i) == languages.getLanguageTranslatedName(i))
      msg = languages.getLanguageName(i);
    else
      msg = languages.getLanguageName(i) + wxT(" / ") + languages.getLanguageTranslatedName(i);
    lstLanguages->Append(msg, reinterpret_cast<void*>(i));
  }
  wxStaticText* lblLanguageRestart = new wxStaticText(tabLanguage, -1, _("Note: Changes you made for the language won't take effect before the next restart."));
  i = languages.getLanguageIndexByShortName(AppPrefs::get()->readString(prLANGUAGE_NAME));
  if (i == Languages::LANGUAGE_UNKNOW)
    lstLanguages->SetSelection(0, true);
  else
    lstLanguages->SetSelection(i + 1, true);

  // Language tab sizer
  // The panel sizer
  wxBoxSizer* tabLanguageSizer2 = new wxBoxSizer(wxVERTICAL);
  tabLanguage->SetSizer(tabLanguageSizer2);
  wxBoxSizer* tabLanguageSizer = new wxBoxSizer(wxVERTICAL);
  tabLanguageSizer2->Add(tabLanguageSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabLanguageSizer->Add(pnlLanguage, 0, wxGROW);

  tabLanguageSizer->Add(lblLanguage, 0, wxTOP, CONTROL_SPACE);
  tabLanguageSizer->Add(lstLanguages, 1, wxGROW);
  tabLanguageSizer->Add(lblLanguageRestart, 0, wxTOP, CONTROL_SPACE);


  //-------------------------------------------------------------------------  
  // Command line page
  wxScrolledWindow* tabCmdLine = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabCmdLine->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
  tabCmdLine->Hide();

  wxPanel* pnlCmdLine = makePageTitlePanel(tabCmdLine, trePages->GetItemText(trePagesGUICmdLine));

  wxStaticBox* fraCLnVerify = new wxStaticBox(tabCmdLine, -1, _("When verifying a checksums' file:"));
  chkCLnVerifyDontShowGUI = new wxCheckBox(tabCmdLine, -1, _("&Don't show the GUI if all the checksums are correct"));
  chkCLnVerifyDontShowGUI->SetValue(AppPrefs::get()->readBool(prGUI_CLN_VERIFY_DONT_SHOW_GUI));
  
  wxStaticBox* fraCLnAppend = new wxStaticBox(tabCmdLine, -1, _("When adding files to a checksums' file:"));
  rbxCLnAppendNeverShowGUI = new wxRadioButton(tabCmdLine, -1, _("&Never show the GUI"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxCLnAppendShowGUIOnError = new wxRadioButton(tabCmdLine, -1, _("Show the GUI on &errors"));
  rbxCLnAppendShowGUIOnWarning = new wxRadioButton(tabCmdLine, -1, _("Show the GUI on errors or &warnings"));
  rbxCLnAppendAlwaysGUI = new wxRadioButton(tabCmdLine, -1, _("&Always show the GUI"));
  switch (static_cast<DisplayGUI>(AppPrefs::get()->readLong(prGUI_CLN_APPEND_SHOW_GUI)))
  {
    case clgNever :      rbxCLnAppendNeverShowGUI->SetValue(true); break;
    case clgOnError :    rbxCLnAppendShowGUIOnError->SetValue(true); break;
    case clgAlways :     rbxCLnAppendAlwaysGUI->SetValue(true); break;
    case clgOnWarning :  
    default :  rbxCLnAppendShowGUIOnWarning->SetValue(true); break;
  }

  wxStaticBox* fraCLnCreate = new wxStaticBox(tabCmdLine, -1, _("When creating a checksums' file:"));
  rbxCLnCreateNeverShowGUI = new wxRadioButton(tabCmdLine, -1, _("Ne&ver show the GUI"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxCLnCreateShowGUIOnError = new wxRadioButton(tabCmdLine, -1, _("Show the GUI on e&rrors"));
  rbxCLnCreateShowGUIOnWarning = new wxRadioButton(tabCmdLine, -1, _("Show the GUI on errors or warnin&gs"));
  rbxCLnCreateAlwaysGUI = new wxRadioButton(tabCmdLine, -1, _("Alwa&ys show the GUI"));
  switch (static_cast<DisplayGUI>(AppPrefs::get()->readLong(prGUI_CLN_CREATE_SHOW_GUI)))
  {
    case clgNever :     rbxCLnCreateNeverShowGUI->SetValue(true); break;
    case clgOnError :   rbxCLnCreateShowGUIOnError->SetValue(true); break;
    case clgAlways :    rbxCLnCreateAlwaysGUI->SetValue(true); break;
    case clgOnWarning :  
    default :  rbxCLnCreateShowGUIOnWarning->SetValue(true); break;
  }
  
  wxStaticText* lblCLnWarning = new wxStaticText(tabCmdLine, -1, _("Note: Error and warning messages are always displayed."));

  // Command line tab sizer
  // The panel sizer
  wxBoxSizer* tabCmdLineSizer2 = new wxBoxSizer(wxVERTICAL);
  tabCmdLine->SetSizer(tabCmdLineSizer2);
  wxBoxSizer* tabCmdLineSizer = new wxBoxSizer(wxVERTICAL);
  tabCmdLineSizer2->Add(tabCmdLineSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabCmdLineSizer->Add(pnlCmdLine, 0, wxGROW);

  // The 'When verifying a checksums' file:' frame sizer
  wxStaticBoxSizer* fraCLnVerifySizer2 = new wxStaticBoxSizer(fraCLnVerify, wxVERTICAL);
  tabCmdLineSizer->Add(fraCLnVerifySizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraCLnVerifySizer = new wxBoxSizer(wxVERTICAL);
  fraCLnVerifySizer2->Add(fraCLnVerifySizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);
  
  fraCLnVerifySizer->Add(chkCLnVerifyDontShowGUI, 0);

  // The 'When appending files to a checksums' file:' frame sizer
  wxStaticBoxSizer* fraCLnAppendSizer2 = new wxStaticBoxSizer(fraCLnAppend, wxVERTICAL);
  tabCmdLineSizer->Add(fraCLnAppendSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraCLnAppendSizer = new wxBoxSizer(wxVERTICAL);
  fraCLnAppendSizer2->Add(fraCLnAppendSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraCLnAppendSizer->Add(rbxCLnAppendNeverShowGUI, 0, wxALIGN_CENTER_VERTICAL);
  fraCLnAppendSizer->Add(rbxCLnAppendShowGUIOnError, 0, wxTOP, CONTROL_SPACE / 2);
  fraCLnAppendSizer->Add(rbxCLnAppendShowGUIOnWarning, 0, wxTOP, CONTROL_SPACE / 2);
  fraCLnAppendSizer->Add(rbxCLnAppendAlwaysGUI, 0, wxTOP, CONTROL_SPACE / 2);

  // The 'When creating a checksums' file:' frame sizer
  wxStaticBoxSizer* fraCLnCreateSizer2 = new wxStaticBoxSizer(fraCLnCreate, wxVERTICAL);
  tabCmdLineSizer->Add(fraCLnCreateSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraCLnCreateSizer = new wxBoxSizer(wxVERTICAL);
  fraCLnCreateSizer2->Add(fraCLnCreateSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraCLnCreateSizer->Add(rbxCLnCreateNeverShowGUI, 0, wxALIGN_CENTER_VERTICAL);
  fraCLnCreateSizer->Add(rbxCLnCreateShowGUIOnError, 0, wxTOP, CONTROL_SPACE / 2);
  fraCLnCreateSizer->Add(rbxCLnCreateShowGUIOnWarning, 0, wxTOP, CONTROL_SPACE / 2);
  fraCLnCreateSizer->Add(rbxCLnCreateAlwaysGUI, 0, wxTOP, CONTROL_SPACE / 2);
  
  tabCmdLineSizer->Add(lblCLnWarning, 0, wxTOP, CONTROL_SPACE);


  //-------------------------------------------------------------------------  
  // Checksums' files page
  wxScrolledWindow* tabChecksumsFiles = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabChecksumsFiles->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
  tabChecksumsFiles->Hide();

  wxPanel* pnlChecksumsFiles = makePageTitlePanel(tabChecksumsFiles, trePages->GetItemText(trePagesChecksumsFiles), 1);

  // Sizers
  // The panel sizer
  wxBoxSizer* tabChecksumsFilesSizer2 = new wxBoxSizer(wxVERTICAL);
  tabChecksumsFiles->SetSizer(tabChecksumsFilesSizer2);
  wxBoxSizer* tabChecksumsFilesSizer = new wxBoxSizer(wxVERTICAL);
  tabChecksumsFilesSizer2->Add(tabChecksumsFilesSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabChecksumsFilesSizer->Add(pnlChecksumsFiles, 0, wxGROW);


  //-------------------------------------------------------------------------  
  // SFV files page
  wxScrolledWindow* tabSFV = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabSFV->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
  tabSFV->Hide();

  wxPanel* pnlSFV = makePageTitlePanel(tabSFV, trePages->GetItemText(trePagesCksumsSFV));

  // Paths separators on reading
  wxStaticBox* fraSFVPathSepRead = new wxStaticBox(tabSFV, -1, _("Path separator on reading SFV files:"));
  rbxSFVPathSepReadAuto = new wxRadioButton(tabSFV, -1, _("&Automatic recognition"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxSFVPathSepReadUnix = new wxRadioButton(tabSFV, -1, _("&Unix: '/'"));
  rbxSFVPathSepReadWindows = new wxRadioButton(tabSFV, -1, _("&Windows: '\\'"));
  rbxSFVPathSepReadMAC = new wxRadioButton(tabSFV, -1, _("&Macintosh: ':'"));
  pf = static_cast<wxPathFormat>(AppPrefs::get()->readLong(prSFV_READ_PATH_SEPARATOR));
  switch (pf)
  {
    case wxPATH_UNIX :   rbxSFVPathSepReadUnix->SetValue(true); break;
    case wxPATH_WIN :    rbxSFVPathSepReadWindows->SetValue(true); break;
    case wxPATH_MAC :    rbxSFVPathSepReadMAC->SetValue(true); break;
    default :            rbxSFVPathSepReadAuto->SetValue(true); /* wxPATH_NATIVE */
  }

  // Parameters for saving
  wxStaticBox* fraSFVSaving = new wxStaticBox(tabSFV, -1, _("Saving SFV files:"));
  chkSFVSaveGenerator = new wxCheckBox(tabSFV, -1, _("Save the &name of the generator and the date of creation in the comments"));
  chkSFVSaveGenerator->SetValue(AppPrefs::get()->readBool(prSFV_WRITE_GEN_AND_DATE));
  wxStaticText* lblSFVIdentifyAs = new wxStaticText(tabSFV, -1, _("Identi&fy as:"));
  cboSFVIdentifyAs = new wxChoice(tabSFV, CBO_SFV_IDENTIFY_AS, wxDefaultPosition, wxSize(chkSFVSaveGenerator->GetSize().GetWidth() / 2, -1));
  chkSFVSaveFilesInfo = new wxCheckBox(tabSFV, -1, _("Save the size and the modification &date of the files in the comments"));
  chkSFVSaveFilesInfo->SetValue(AppPrefs::get()->readBool(prSFV_WRITE_FILE_SIZE_AND_DATE));

  wxStaticText* lblSFVPathSepWrite = new wxStaticText(tabSFV, -1, _("Use the following path sepator:"));
  rbxSFVPathSepWriteSystem = new wxRadioButton(tabSFV, -1, wxString::Format(_("S&ystem default: '%c'"), wxFileName::GetPathSeparator()), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxSFVPathSepWriteUnix = new wxRadioButton(tabSFV, -1, _("Un&ix: '/'"));
  rbxSFVPathSepWriteWindows = new wxRadioButton(tabSFV, -1, _("Wind&ows: '\\'"));
  rbxSFVPathSepWriteMAC = new wxRadioButton(tabSFV, -1, _("Macin&tosh: ':'"));
  pf = static_cast<wxPathFormat>(AppPrefs::get()->readLong(prSFV_WRITE_PATH_SEPARATOR));
  switch (pf)
  {
    case wxPATH_UNIX :   rbxSFVPathSepWriteUnix->SetValue(true); break;
    case wxPATH_WIN :    rbxSFVPathSepWriteWindows->SetValue(true); break;
    case wxPATH_MAC :    rbxSFVPathSepWriteMAC->SetValue(true); break;
    default :            rbxSFVPathSepWriteSystem->SetValue(true); /* wxPATH_NATIVE */
  }

  wxStaticText* lblSFVEOLWrite = new wxStaticText(tabSFV, -1, _("Use the following end of line:"));
  rbxSFVEOLWriteSystem = new wxRadioButton(tabSFV, -1, _("Syst&em native"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxSFVEOLWriteUnix = new wxRadioButton(tabSFV, -1, _("Uni&x"));
  rbxSFVEOLWriteWindows = new wxRadioButton(tabSFV, -1, _("Window&s"));
  rbxSFVEOLWriteMAC = new wxRadioButton(tabSFV, -1, _("Macintos&h"));
  eol = static_cast<wxEOL>(AppPrefs::get()->readLong(prSFV_WRITE_EOL));
  switch (eol)
  {
    case wxEOL_UNIX : rbxSFVEOLWriteUnix->SetValue(true); break;
    case wxEOL_DOS  : rbxSFVEOLWriteWindows->SetValue(true); break;
    case wxEOL_MAC  : rbxSFVEOLWriteMAC->SetValue(true); break;
    default :         rbxSFVEOLWriteSystem->SetValue(true);
  }

  // SFV tab sizer
  // The panel sizer
  wxBoxSizer* tabSFVSizer2 = new wxBoxSizer(wxVERTICAL);
  tabSFV->SetSizer(tabSFVSizer2);
  wxBoxSizer* tabSFVSizer = new wxBoxSizer(wxVERTICAL);
  tabSFVSizer2->Add(tabSFVSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabSFVSizer->Add(pnlSFV, 0, wxGROW);

  // The 'Path separator on reading SFV files:' frame sizer
  wxStaticBoxSizer* fraSFVPathSepReadSizer2 = new wxStaticBoxSizer(fraSFVPathSepRead, wxVERTICAL);
  tabSFVSizer->Add(fraSFVPathSepReadSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraSFVPathSepReadSizer = new wxBoxSizer(wxHORIZONTAL);
  fraSFVPathSepReadSizer2->Add(fraSFVPathSepReadSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);
  
  fraSFVPathSepReadSizer->Add(rbxSFVPathSepReadAuto, 0, wxALIGN_CENTER_VERTICAL);
  fraSFVPathSepReadSizer->Add(rbxSFVPathSepReadUnix, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  fraSFVPathSepReadSizer->Add(rbxSFVPathSepReadWindows, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  fraSFVPathSepReadSizer->Add(rbxSFVPathSepReadMAC, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);

  // The 'Saving:' frame sizer
  wxStaticBoxSizer* fraSFVSavingSizer2 = new wxStaticBoxSizer(fraSFVSaving, wxVERTICAL);
  tabSFVSizer->Add(fraSFVSavingSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraSFVSavingSizer = new wxBoxSizer(wxVERTICAL);
  fraSFVSavingSizer2->Add(fraSFVSavingSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraSFVSavingSizer->Add(chkSFVSaveGenerator);
  wxBoxSizer* SFVIdentAsSizer = new wxBoxSizer(wxHORIZONTAL);
  SFVIdentAsSizer->Add(lblSFVIdentifyAs, 0, wxLEFT | wxALIGN_CENTER_VERTICAL, CONTROL_SPACE * 2);
  SFVIdentAsSizer->Add(cboSFVIdentifyAs, 0, wxLEFT | wxALIGN_CENTER_VERTICAL, CONTROL_SPACE / 2);
  fraSFVSavingSizer->Add(SFVIdentAsSizer, 1, wxTOP | wxGROW | wxALIGN_CENTER_VERTICAL, CONTROL_SPACE / 2);
  fraSFVSavingSizer->Add(chkSFVSaveFilesInfo, 0, wxTOP, CONTROL_SPACE / 2);

  fraSFVSavingSizer->Add(lblSFVPathSepWrite, 0, wxTOP, CONTROL_SPACE);
  wxBoxSizer* SFVPathWriteSizer = new wxBoxSizer(wxHORIZONTAL);
  fraSFVSavingSizer->Add(SFVPathWriteSizer, 0);
  SFVPathWriteSizer->Add(rbxSFVPathSepWriteSystem, 0, wxALIGN_CENTER_VERTICAL);
  SFVPathWriteSizer->Add(rbxSFVPathSepWriteUnix, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  SFVPathWriteSizer->Add(rbxSFVPathSepWriteWindows, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  SFVPathWriteSizer->Add(rbxSFVPathSepWriteMAC, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);

  fraSFVSavingSizer->Add(lblSFVEOLWrite, 0, wxTOP, CONTROL_SPACE);
  wxBoxSizer* SFVEOLWriteSizer = new wxBoxSizer(wxHORIZONTAL);
  fraSFVSavingSizer->Add(SFVEOLWriteSizer, 0);
  SFVEOLWriteSizer->Add(rbxSFVEOLWriteSystem, 0, wxALIGN_CENTER_VERTICAL);
  SFVEOLWriteSizer->Add(rbxSFVEOLWriteUnix, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  SFVEOLWriteSizer->Add(rbxSFVEOLWriteWindows, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  SFVEOLWriteSizer->Add(rbxSFVEOLWriteMAC, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);


  //-------------------------------------------------------------------------  
  // MD5 files page
  wxScrolledWindow* tabMD5 = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabMD5->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
  tabMD5->Hide();

  wxPanel* pnlMD5 = makePageTitlePanel(tabMD5, trePages->GetItemText(trePagesCksumsMD5));

  // Paths separators on reading
  wxStaticBox* fraMD5PathSepRead = new wxStaticBox(tabMD5, -1, _("Path separator on reading MD5 files:"));
  rbxMD5PathSepReadAuto = new wxRadioButton(tabMD5, -1, _("&Automatic recognition"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxMD5PathSepReadUnix = new wxRadioButton(tabMD5, -1, _("&Unix: '/'"));
  rbxMD5PathSepReadWindows = new wxRadioButton(tabMD5, -1, _("&Windows: '\\'"));
  rbxMD5PathSepReadMAC = new wxRadioButton(tabMD5, -1, _("&Macintosh: ':'"));
  pf = static_cast<wxPathFormat>(AppPrefs::get()->readLong(prMD5_READ_PATH_SEPARATOR));
  switch (pf)
  {
    case wxPATH_UNIX :   rbxMD5PathSepReadUnix->SetValue(true); break;
    case wxPATH_WIN :    rbxMD5PathSepReadWindows->SetValue(true); break;
    case wxPATH_MAC :    rbxMD5PathSepReadMAC->SetValue(true); break;
    default :            rbxMD5PathSepReadAuto->SetValue(true); /* wxPATH_NATIVE */
  }

  // Parameters for saving
  wxStaticBox* fraMD5Saving = new wxStaticBox(tabMD5, -1, _("Saving MD5 files:"));
  chkMD5SaveGenerator = new wxCheckBox(tabMD5, -1, _("Save the &name of the generator and the date of creation in the comments"));
  chkMD5SaveGenerator->SetValue(AppPrefs::get()->readBool(prMD5_WRITE_GEN_AND_DATE));
  chkMD5SaveFilesInfo = new wxCheckBox(tabMD5, -1, _("Save the size and the modification &date of the files in the comments"));
  chkMD5SaveFilesInfo->SetValue(AppPrefs::get()->readBool(prMD5_WRITE_FILE_SIZE_AND_DATE));

  wxStaticText* lblMD5PathSepWrite = new wxStaticText(tabMD5, -1, _("Use the following path sepator:"));
  rbxMD5PathSepWriteSystem = new wxRadioButton(tabMD5, -1, wxString::Format(_("S&ystem default: '%c'"), wxFileName::GetPathSeparator()), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxMD5PathSepWriteUnix = new wxRadioButton(tabMD5, -1, _("Un&ix: '/'"));
  rbxMD5PathSepWriteWindows = new wxRadioButton(tabMD5, -1, _("Wind&ows: '\\'"));
  rbxMD5PathSepWriteMAC = new wxRadioButton(tabMD5, -1, _("Macin&tosh: ':'"));
  pf = static_cast<wxPathFormat>(AppPrefs::get()->readLong(prMD5_WRITE_PATH_SEPARATOR));
  switch (pf)
  {
    case wxPATH_UNIX :   rbxMD5PathSepWriteUnix->SetValue(true); break;
    case wxPATH_WIN :    rbxMD5PathSepWriteWindows->SetValue(true); break;
    case wxPATH_MAC :    rbxMD5PathSepWriteMAC->SetValue(true); break;
    default :            rbxMD5PathSepWriteSystem->SetValue(true); /* wxPATH_NATIVE */
  }

  wxStaticText* lblMD5EOLWrite = new wxStaticText(tabMD5, -1, _("Use the following end of line:"));
  rbxMD5EOLWriteSystem = new wxRadioButton(tabMD5, -1, _("Syst&em native"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxMD5EOLWriteUnix = new wxRadioButton(tabMD5, -1, _("Uni&x"));
  rbxMD5EOLWriteWindows = new wxRadioButton(tabMD5, -1, _("Window&s"));
  rbxMD5EOLWriteMAC = new wxRadioButton(tabMD5, -1, _("Macintos&h"));
  eol = static_cast<wxEOL>(AppPrefs::get()->readLong(prMD5_WRITE_EOL));
  switch (eol)
  {
    case wxEOL_UNIX : rbxMD5EOLWriteUnix->SetValue(true); break;
    case wxEOL_DOS  : rbxMD5EOLWriteWindows->SetValue(true); break;
    case wxEOL_MAC  : rbxMD5EOLWriteMAC->SetValue(true); break;
    default :         rbxMD5EOLWriteSystem->SetValue(true);
  }

  // MD5 tab sizer
  // The panel sizer
  wxBoxSizer* tabMD5Sizer2 = new wxBoxSizer(wxVERTICAL);
  tabMD5->SetSizer(tabMD5Sizer2);
  wxBoxSizer* tabMD5Sizer = new wxBoxSizer(wxVERTICAL);
  tabMD5Sizer2->Add(tabMD5Sizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabMD5Sizer->Add(pnlMD5, 0, wxGROW);

  // The 'Path separator on reading MD5 files:' frame sizer
  wxStaticBoxSizer* fraMD5PathSepReadSizer2 = new wxStaticBoxSizer(fraMD5PathSepRead, wxVERTICAL);
  tabMD5Sizer->Add(fraMD5PathSepReadSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraMD5PathSepReadSizer = new wxBoxSizer(wxHORIZONTAL);
  fraMD5PathSepReadSizer2->Add(fraMD5PathSepReadSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);
  
  fraMD5PathSepReadSizer->Add(rbxMD5PathSepReadAuto, 0, wxALIGN_CENTER_VERTICAL);
  fraMD5PathSepReadSizer->Add(rbxMD5PathSepReadUnix, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  fraMD5PathSepReadSizer->Add(rbxMD5PathSepReadWindows, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  fraMD5PathSepReadSizer->Add(rbxMD5PathSepReadMAC, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);

  // The 'Saving:' frame sizer
  wxStaticBoxSizer* fraMD5SavingSizer2 = new wxStaticBoxSizer(fraMD5Saving, wxVERTICAL);
  tabMD5Sizer->Add(fraMD5SavingSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraMD5SavingSizer = new wxBoxSizer(wxVERTICAL);
  fraMD5SavingSizer2->Add(fraMD5SavingSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraMD5SavingSizer->Add(chkMD5SaveGenerator);
  fraMD5SavingSizer->Add(chkMD5SaveFilesInfo, 0, wxTOP, CONTROL_SPACE / 2);
  
  fraMD5SavingSizer->Add(lblMD5PathSepWrite, 0, wxTOP, CONTROL_SPACE);
  wxBoxSizer* MD5PathWriteSizer = new wxBoxSizer(wxHORIZONTAL);
  fraMD5SavingSizer->Add(MD5PathWriteSizer, 0);
  MD5PathWriteSizer->Add(rbxMD5PathSepWriteSystem, 0, wxALIGN_CENTER_VERTICAL);
  MD5PathWriteSizer->Add(rbxMD5PathSepWriteUnix, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  MD5PathWriteSizer->Add(rbxMD5PathSepWriteWindows, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  MD5PathWriteSizer->Add(rbxMD5PathSepWriteMAC, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);

  fraMD5SavingSizer->Add(lblMD5EOLWrite, 0, wxTOP, CONTROL_SPACE);
  wxBoxSizer* MD5EOLWriteSizer = new wxBoxSizer(wxHORIZONTAL);
  fraMD5SavingSizer->Add(MD5EOLWriteSizer, 0);
  MD5EOLWriteSizer->Add(rbxMD5EOLWriteSystem, 0, wxALIGN_CENTER_VERTICAL);
  MD5EOLWriteSizer->Add(rbxMD5EOLWriteUnix, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  MD5EOLWriteSizer->Add(rbxMD5EOLWriteWindows, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  MD5EOLWriteSizer->Add(rbxMD5EOLWriteMAC, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);


  //-------------------------------------------------------------------------  
  // Tools page
  wxScrolledWindow* tabTools = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabTools->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
  tabTools->Hide();

  wxPanel* pnlTools = makePageTitlePanel(tabTools, trePages->GetItemText(trePagesTools), 1);

  // Sizers
  // The panel sizer
  wxBoxSizer* tabToolsSizer2 = new wxBoxSizer(wxVERTICAL);
  tabTools->SetSizer(tabToolsSizer2);
  wxBoxSizer* tabToolsSizer = new wxBoxSizer(wxVERTICAL);
  tabToolsSizer2->Add(tabToolsSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabToolsSizer->Add(pnlTools, 0, wxGROW);


  //-------------------------------------------------------------------------  
  // Multiple check page
  wxScrolledWindow* tabMultiCheck = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabMultiCheck->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
  tabMultiCheck->Hide();

  wxPanel* pnlMultiCheck = makePageTitlePanel(tabMultiCheck, trePages->GetItemText(trePagesToolsMultiCheck));

  // Results frame.
  wxStaticBox* fraMCDisplayResults = new wxStaticBox(tabMultiCheck, -1, _("Displaying of the results:"));
  chkMCGlobalSummary = new wxCheckBox(tabMultiCheck, -1, _("Display a &global summary"));
  chkMCGlobalSummary->SetValue(AppPrefs::get()->readBool(prMC_GLOBAL_SUMMARY));
  chkMCChecksumsFileSummary = new wxCheckBox(tabMultiCheck, -1, _("Display a summary for each &checksums' file"));
  chkMCChecksumsFileSummary->SetValue(AppPrefs::get()->readBool(prMC_CHECKSUMS_FILE_SUMMARY));
  chkMCNoCorrectFileState = NULL;
  chkMCFileState = new wxCheckBox(tabMultiCheck, CHK_MC_FILE_STATE, _("Display the state of each checked &file"));
  chkMCFileState->SetValue(AppPrefs::get()->readBool(prMC_FILE_STATE));
  chkMCNoCorrectFileState = new wxCheckBox(tabMultiCheck, -1, _("Don't display the state of the c&orrect files"));
  chkMCNoCorrectFileState->SetValue(AppPrefs::get()->readBool(prMC_NO_CORRECT_FILE_STATE));
  chkMCNoCorrectFileState->Enable(chkMCFileState->GetValue());

  // Colors of the text.
  wxStaticBox* fraMCTextColours = new wxStaticBox(tabMultiCheck, -1, _("Text colours:"));
  
  MCNormalColour = ::longTowxColour(AppPrefs::get()->readLong(prMC_NORMAL_COLOUR));
  MCSuccessColour = ::longTowxColour(AppPrefs::get()->readLong(prMC_SUCCESS_COLOUR));
  MCWarningColour = ::longTowxColour(AppPrefs::get()->readLong(prMC_WARNING_COLOUR));
  MCErrorColour = ::longTowxColour(AppPrefs::get()->readLong(prMC_ERROR_COLOUR));

  wxStaticText* lblMCNormalColour = new wxStaticText(tabMultiCheck, -1, _("&Normal:"));
  btnMCNormalColour = new wxBitmapButton(tabMultiCheck, BTN_MC_NORMAL_COLOUR, ::createBitmapForButton(MCNormalColour, lblMCNormalColour));
  wxStaticText* lblMCSuccessColour = new wxStaticText(tabMultiCheck, -1, _("&Success:"));
  btnMCSuccessColour = new wxBitmapButton(tabMultiCheck, BTN_MC_SUCCESS_COLOUR, ::createBitmapForButton(MCSuccessColour, lblMCSuccessColour));
  wxStaticText* lblMCWarningColour = new wxStaticText(tabMultiCheck, -1, _("&Warning:"));
  btnMCWarningColour = new wxBitmapButton(tabMultiCheck, BTN_MC_WARNING_COLOUR, ::createBitmapForButton(MCWarningColour, lblMCWarningColour));
  wxStaticText* lblMCErrorColour = new wxStaticText(tabMultiCheck, -1, _("&Error:"));
  btnMCErrorColour = new wxBitmapButton(tabMultiCheck, BTN_MC_ERROR_COLOUR, ::createBitmapForButton(MCErrorColour, lblMCErrorColour));

  // Multiple check page sizer
  // The panel sizer
  wxBoxSizer* tabMultiCheckSizer2 = new wxBoxSizer(wxVERTICAL);
  tabMultiCheck->SetSizer(tabMultiCheckSizer2);
  wxBoxSizer* tabMultiCheckSizer = new wxBoxSizer(wxVERTICAL);
  tabMultiCheckSizer2->Add(tabMultiCheckSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabMultiCheckSizer->Add(pnlMultiCheck, 0, wxGROW);

  // The 'Displaying of the results:' frame sizer
  wxStaticBoxSizer* fraMCDisplayResultsSizer2 = new wxStaticBoxSizer(fraMCDisplayResults, wxVERTICAL);
  tabMultiCheckSizer->Add(fraMCDisplayResultsSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraMCDisplayResultsSizer = new wxBoxSizer(wxVERTICAL);
  fraMCDisplayResultsSizer2->Add(fraMCDisplayResultsSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraMCDisplayResultsSizer->Add(chkMCGlobalSummary);
  fraMCDisplayResultsSizer->Add(chkMCChecksumsFileSummary, 0, wxTOP, CONTROL_SPACE / 2);
  fraMCDisplayResultsSizer->Add(chkMCFileState, 0, wxTOP, CONTROL_SPACE / 2);
  wxBoxSizer* chkMCNoCorrectFileStateSizer = new wxBoxSizer(wxVERTICAL);
  fraMCDisplayResultsSizer->Add(chkMCNoCorrectFileStateSizer, 0, wxTOP, CONTROL_SPACE / 2);
  chkMCNoCorrectFileStateSizer->Add(chkMCNoCorrectFileState, 0, wxLEFT, (3 * CONTROL_SPACE) / 2);

  // The 'Colours of the text:' frame sizer
  wxStaticBoxSizer* fraMCTextColoursSizer2 = new wxStaticBoxSizer(fraMCTextColours, wxVERTICAL);
  tabMultiCheckSizer->Add(fraMCTextColoursSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxFlexGridSizer* fraMCTextColoursSizer = new wxFlexGridSizer(2, CONTROL_SPACE / 2, CONTROL_SPACE);
  fraMCTextColoursSizer2->Add(fraMCTextColoursSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraMCTextColoursSizer->Add(lblMCNormalColour, 0, wxALIGN_CENTER_VERTICAL);
  fraMCTextColoursSizer->Add(btnMCNormalColour, 0, wxALIGN_CENTER_VERTICAL);
  fraMCTextColoursSizer->Add(lblMCSuccessColour, 0, wxALIGN_CENTER_VERTICAL);
  fraMCTextColoursSizer->Add(btnMCSuccessColour, 0, wxALIGN_CENTER_VERTICAL);
  fraMCTextColoursSizer->Add(lblMCWarningColour, 0, wxALIGN_CENTER_VERTICAL);
  fraMCTextColoursSizer->Add(btnMCWarningColour, 0, wxALIGN_CENTER_VERTICAL);
  fraMCTextColoursSizer->Add(lblMCErrorColour, 0, wxALIGN_CENTER_VERTICAL);
  fraMCTextColoursSizer->Add(btnMCErrorColour, 0, wxALIGN_CENTER_VERTICAL);


  //-------------------------------------------------------------------------  
  // Batch creation page
  wxScrolledWindow* tabBatchCreation = new wxScrolledWindow(sptConfigure);
  #if defined(USE_SCROLLEDWINDOW)
  tabBatchCreation->SetScrollRate(CONTROL_SPACE, CONTROL_SPACE);
  #endif
  tabBatchCreation->Hide();

  wxPanel* pnlBatchCreation = makePageTitlePanel(tabBatchCreation, trePages->GetItemText(trePagesToolsBatchCreation));

  // "When a checksums' file alrealdy exists" frame.
  wxStaticBox* fraBCCkFileExists = new wxStaticBox(tabBatchCreation, -1, _("When a checksums' file alrealdy exists:"));
  rbxBCSkipExistingCkFile = new wxRadioButton(tabBatchCreation, -1, _("S&kip the creation"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxBCOverwriteExistingCkFile = new wxRadioButton(tabBatchCreation, -1, _("&Overwrite it"));
  if (AppPrefs::get()->readBool(prBC_OVERWRITE_WHEN_CKFILE_EXISTS))
    rbxBCOverwriteExistingCkFile->SetValue(true);
  else
    rbxBCSkipExistingCkFile->SetValue(true);
    
  // "Create the name of the checksums' file by:" frame
  wxStaticBox* fraBCChecksumsFileName = new wxStaticBox(tabBatchCreation, -1, _("Create the name of the checksums' file by:"));
  rbxBCReplaceFileExtension = new wxRadioButton(tabBatchCreation, -1, _("&Replacing the extension of the source file with the extension of the type of the checksums' file"), wxDefaultPosition, wxDefaultSize, wxRB_GROUP);
  rbxBCAddFileExtension = new wxRadioButton(tabBatchCreation, -1, _("&Adding the extension of the type of the checksums' file to the name of the source file"));
  if (AppPrefs::get()->readBool(prBC_REPLACE_FILE_EXTENSION))
    rbxBCReplaceFileExtension->SetValue(true);
  else
    rbxBCAddFileExtension->SetValue(true);

  // The "Verbosity level of the report:" frame
  wxStaticBox* fraBCVerbosityLevel = new wxStaticBox(tabBatchCreation, -1, _("Level of &verbosity of the report:"));
  const wxString strVerbosityLevels[] = { _("Errors only"), _("Errors and warnings"), _("Normal"), _("Talkative") };
  cboBCVerbosityLevel = new wxChoice(tabBatchCreation, -1, wxDefaultPosition, wxDefaultSize,
    4, strVerbosityLevels);
  i = static_cast<int>(AppPrefs::get()->readLong(prBC_VERBOSITY_LEVEL));
  if (i < 0 || i > 3) i = 2;  // normal
  cboBCVerbosityLevel->SetSelection(i);

  // Colors of the text.
  wxStaticBox* fraBCTextColours = new wxStaticBox(tabBatchCreation, -1, _("Text colours:"));
  
  BCNormalColour = ::longTowxColour(AppPrefs::get()->readLong(prBC_NORMAL_COLOUR));
  BCSuccessColour = ::longTowxColour(AppPrefs::get()->readLong(prBC_SUCCESS_COLOUR));
  BCWarningColour = ::longTowxColour(AppPrefs::get()->readLong(prBC_WARNING_COLOUR));
  BCErrorColour = ::longTowxColour(AppPrefs::get()->readLong(prBC_ERROR_COLOUR));

  wxStaticText* lblBCNormalColour = new wxStaticText(tabBatchCreation, -1, _("&Normal:"));
  btnBCNormalColour = new wxBitmapButton(tabBatchCreation, BTN_BC_NORMAL_COLOUR, ::createBitmapForButton(BCNormalColour, lblBCNormalColour));
  wxStaticText* lblBCSuccessColour = new wxStaticText(tabBatchCreation, -1, _("&Success:"));
  btnBCSuccessColour = new wxBitmapButton(tabBatchCreation, BTN_BC_SUCCESS_COLOUR, ::createBitmapForButton(BCSuccessColour, lblBCSuccessColour));
  wxStaticText* lblBCWarningColour = new wxStaticText(tabBatchCreation, -1, _("&Warning:"));
  btnBCWarningColour = new wxBitmapButton(tabBatchCreation, BTN_BC_WARNING_COLOUR, ::createBitmapForButton(BCWarningColour, lblBCWarningColour));
  wxStaticText* lblBCErrorColour = new wxStaticText(tabBatchCreation, -1, _("&Error:"));
  btnBCErrorColour = new wxBitmapButton(tabBatchCreation, BTN_BC_ERROR_COLOUR, ::createBitmapForButton(BCErrorColour, lblBCErrorColour));

  // Batch creation page sizer
  // The panel sizer
  wxBoxSizer* tabBatchCreationSizer2 = new wxBoxSizer(wxVERTICAL);
  tabBatchCreation->SetSizer(tabBatchCreationSizer2);
  wxBoxSizer* tabBatchCreationSizer = new wxBoxSizer(wxVERTICAL);
  tabBatchCreationSizer2->Add(tabBatchCreationSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // Title of the page
  tabBatchCreationSizer->Add(pnlBatchCreation, 0, wxGROW);

  // The "When a checksums' file alrealdy exists" frame sizer
  wxStaticBoxSizer* fraBCCkFileExistsSizer2 = new wxStaticBoxSizer(fraBCCkFileExists, wxVERTICAL);
  tabBatchCreationSizer->Add(fraBCCkFileExistsSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraBCCkFileExistsSizer = new wxBoxSizer(wxVERTICAL);
  fraBCCkFileExistsSizer2->Add(fraBCCkFileExistsSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraBCCkFileExistsSizer->Add(rbxBCSkipExistingCkFile);
  fraBCCkFileExistsSizer->Add(rbxBCOverwriteExistingCkFile, 0, wxTOP, CONTROL_SPACE / 2);

  // The "Create the name of the checksums' file by:" frame sizer
  wxStaticBoxSizer* fraBCChecksumsFileNameSizer2 = new wxStaticBoxSizer(fraBCChecksumsFileName, wxVERTICAL);
  tabBatchCreationSizer->Add(fraBCChecksumsFileNameSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraBCChecksumsFileNameSizer = new wxBoxSizer(wxVERTICAL);
  fraBCChecksumsFileNameSizer2->Add(fraBCChecksumsFileNameSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraBCChecksumsFileNameSizer->Add(rbxBCReplaceFileExtension);
  fraBCChecksumsFileNameSizer->Add(rbxBCAddFileExtension, 0, wxTOP, CONTROL_SPACE / 2);

  // The "Verbosity level of the report:" frame sizer
  wxStaticBoxSizer* fraBCVerbosityLevelSizer2 = new wxStaticBoxSizer(fraBCVerbosityLevel, wxVERTICAL);
  tabBatchCreationSizer->Add(fraBCVerbosityLevelSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxBoxSizer* fraBCVerbosityLevelSizer = new wxBoxSizer(wxVERTICAL);
  fraBCVerbosityLevelSizer2->Add(fraBCVerbosityLevelSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraBCVerbosityLevelSizer->Add(cboBCVerbosityLevel);

  // The 'Colours of the text:' frame sizer
  wxStaticBoxSizer* fraBCTextColoursSizer2 = new wxStaticBoxSizer(fraBCTextColours, wxVERTICAL);
  tabBatchCreationSizer->Add(fraBCTextColoursSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);
  wxFlexGridSizer* fraBCTextColoursSizer = new wxFlexGridSizer(2, CONTROL_SPACE / 2, CONTROL_SPACE);
  fraBCTextColoursSizer2->Add(fraBCTextColoursSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraBCTextColoursSizer->Add(lblBCNormalColour, 0, wxALIGN_CENTER_VERTICAL);
  fraBCTextColoursSizer->Add(btnBCNormalColour, 0, wxALIGN_CENTER_VERTICAL);
  fraBCTextColoursSizer->Add(lblBCSuccessColour, 0, wxALIGN_CENTER_VERTICAL);
  fraBCTextColoursSizer->Add(btnBCSuccessColour, 0, wxALIGN_CENTER_VERTICAL);
  fraBCTextColoursSizer->Add(lblBCWarningColour, 0, wxALIGN_CENTER_VERTICAL);
  fraBCTextColoursSizer->Add(btnBCWarningColour, 0, wxALIGN_CENTER_VERTICAL);
  fraBCTextColoursSizer->Add(lblBCErrorColour, 0, wxALIGN_CENTER_VERTICAL);
  fraBCTextColoursSizer->Add(btnBCErrorColour, 0, wxALIGN_CENTER_VERTICAL);


  //-------------------------------------------------------------------------  
  // The validation buttons
  wxButton* btnOK = new wxButton(this, wxID_OK, _("OK"));
  btnOK->SetDefault();
  wxButton* btnCancel = new wxButton(this, wxID_CANCEL, _("Cancel"));;

  // Validation buttons sizer
  wxGridSizer* buttonsSizer = new wxGridSizer(2, 0, 2 * CONTROL_SPACE);
  buttonsSizer->Add(btnOK);
  buttonsSizer->Add(btnCancel);


  //-------------------------------------------------------------------------
  // Dialog sizer
  wxBoxSizer* dlgConfigureSizer2 = new wxBoxSizer(wxVERTICAL);
  this->SetSizer(dlgConfigureSizer2);
  wxBoxSizer* dlgConfigureSizer = new wxBoxSizer(wxVERTICAL);
  dlgConfigureSizer2->Add(dlgConfigureSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  dlgConfigureSizer->Add(sptConfigure, 1, wxALL | wxGROW);
  dlgConfigureSizer->Add(buttonsSizer, 0, wxTOP | wxALIGN_RIGHT, CONTROL_SPACE);

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();

  // Sets the background color
  //this->SetBackgroundColour(a_control->GetBackgroundColour());

  //-------------------------------------------------------------------------
  // Dialog initialization
  // Initializes the spitter.
  sptConfigure->SplitVertically(trePages, tabInterface, AppPrefs::get()->readLong(prGUI_CONF_SASH_POSITION, 100L));
  
  // Initializes the array that make the correspondance between the Page
  // identifiers in the tree and the controls that contains the pages.
  // See dlgConfigure::TreePagesId for the order of insertion.
  pagesArray.Add(tabInterface);
  pagesArray.Add(tabDisplay);
  pagesArray.Add(tabBehavior);
  pagesArray.Add(tabLanguage);
  pagesArray.Add(tabCmdLine);
  pagesArray.Add(tabChecksumsFiles);
  pagesArray.Add(tabSFV);
  pagesArray.Add(tabMD5);
  pagesArray.Add(tabTools);
  pagesArray.Add(tabMultiCheck);
  pagesArray.Add(tabBatchCreation);
  
  // Selected item
  trePages->SelectItem(trePagesGUIDisplay);
  
  // Initializes the selector of client identificator for writing SFV files.
  // The two first items never change. The first is the name of the current
  // version of wxChecksums, the second is an entry to add a personalized one.
  cboSFVIdentifyAs->Append(::getAppName(true));
  cboSFVIdentifyAs->Append(_("Personalized..."));
  wxString s;
  for (i = 1; i <= getSFVGeneratorIdentifierHistoryMaxSize(); i++)
  {
    s = wxConfig::Get()->Read(getSFVGeneratorIdentifierConfigKey(i), wxString());
    if (!s.IsEmpty())
      cboSFVIdentifyAs->Append(s);
  }
  if (AppPrefs::get()->readString(prSFV_IDENTIFY_AS).IsEmpty())
  // Use default identifier
    cboSFVIdentifyAs->SetSelection(0);
  else
    if ((i = cboSFVIdentifyAs->FindString(AppPrefs::get()->readString(prSFV_IDENTIFY_AS))) == -1)
      cboSFVIdentifyAs->SetSelection(0);
    else
      cboSFVIdentifyAs->SetSelection(i);
}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
dlgConfigure::~dlgConfigure()
{
}
//---------------------------------------------------------------------------


/**
 * Event handler for a selection change.
 *
 * @param  event  The event's parameters
 */
void dlgConfigure::trePagesSelChanged(wxTreeEvent& event)
{
  #if defined(__VISUALC__)  // Visual C++ doesn't seem to like this dynamic_cast
  TreePagesItemData* data = (TreePagesItemData*)trePages->GetItemData(event.GetItem());
  #else
  TreePagesItemData* data = dynamic_cast<TreePagesItemData*>(trePages->GetItemData(event.GetItem()));
  #endif
  if (data != NULL)
  {
    int page = data->GetPageId();
    wxScrolledWindow* oldPanel = wxDynamicCast(sptConfigure->GetWindow2(), wxScrolledWindow);
    wxScrolledWindow* newPanel = wxDynamicCast(pagesArray[page], wxScrolledWindow);
    if (oldPanel != newPanel)
    {
      oldPanel->Hide();
      sptConfigure->ReplaceWindow(oldPanel, newPanel);
      newPanel->Show();
    }
  }
  else
    trePages->SelectItem(event.GetOldItem());
}
//---------------------------------------------------------------------------


/**
 * Processes button Up.
 *
 * @param  event  The event's parameters.
 */
void dlgConfigure::btnSumsHeadersUpClick(wxCommandEvent& event)
{
  int sel = lstSumsHeaders->GetSelection();
  if (sel > 0)
  {
    wxString swapText = lstSumsHeaders->GetString(sel);
    void* swapData = lstSumsHeaders->GetClientData(sel);
    lstSumsHeaders->SetString(sel, lstSumsHeaders->GetString(sel - 1));
    lstSumsHeaders->SetClientData(sel, lstSumsHeaders->GetClientData(sel - 1));
    lstSumsHeaders->SetString(sel - 1, swapText);
    lstSumsHeaders->SetClientData(sel - 1, swapData);
    lstSumsHeaders->SetSelection(sel - 1);
  }
}
//---------------------------------------------------------------------------


/**
 * Processes button Down.
 *
 * @param  event  The event's parameters.
 */
void dlgConfigure::btnSumsHeadersDownClick(wxCommandEvent& event)
{
  int sel = lstSumsHeaders->GetSelection();
  if (sel >= 0 && sel < lstSumsHeaders->GetCount() - 1)
  {
    wxString swapText = lstSumsHeaders->GetString(sel);
    void* swapData = lstSumsHeaders->GetClientData(sel);
    lstSumsHeaders->SetString(sel, lstSumsHeaders->GetString(sel + 1));
    lstSumsHeaders->SetClientData(sel, lstSumsHeaders->GetClientData(sel + 1));
    lstSumsHeaders->SetString(sel + 1, swapText);
    lstSumsHeaders->SetClientData(sel + 1, swapData);
    lstSumsHeaders->SetSelection(sel + 1);
  }
}
//---------------------------------------------------------------------------


/**
 * Processes a selection in the choices of SFV generators.
 *
 * @param  event  The event's parameters.
 */
void dlgConfigure::cboSFVIdentifyAsSelect(wxCommandEvent& event)
{
  if (event.GetInt() == 1)
  // Enter a custom identifier
  {
    wxString id = ::wxGetTextFromUser(_("Name of the generator:"), _("Identify as"), ::getAppName(true), this, -1, -1, false);
    if (!id.IsEmpty())
    {
      int sel = addSFVGeneratorIdentifier(id);
      cboSFVIdentifyAs->SetSelection(sel);
    }
    else  // Select the default identifier
      cboSFVIdentifyAs->SetSelection(0);
  }
}
//---------------------------------------------------------------------------


/**
 * Processes check on the <CODE>chkMCFileState</CODE> check box.
 *
 * @param  event  The event's parameters.
 */
void dlgConfigure::chkMCFileStateCheck(wxCommandEvent& event)
{
  if (chkMCNoCorrectFileState != NULL)
    chkMCNoCorrectFileState->Enable(event.IsChecked());
}
//---------------------------------------------------------------------------


/**
 * Processes button for changing colours of the results text of the multiple
 * check dialog.
 *
 * @param  event  The event's parameters.
 */
void dlgConfigure::btnMCColoursClick(wxCommandEvent& event)
{
  wxColour colour, res;

  switch (event.GetId())
  {
    case BTN_MC_NORMAL_COLOUR :  colour = MCNormalColour;  break;
    case BTN_MC_SUCCESS_COLOUR : colour = MCSuccessColour; break;
    case BTN_MC_WARNING_COLOUR : colour = MCWarningColour; break;
    case BTN_MC_ERROR_COLOUR :   colour = MCErrorColour;   break;
    case BTN_BC_NORMAL_COLOUR :  colour = BCNormalColour;  break;
    case BTN_BC_SUCCESS_COLOUR : colour = BCSuccessColour; break;
    case BTN_BC_WARNING_COLOUR : colour = BCWarningColour; break;
    case BTN_BC_ERROR_COLOUR :   colour = BCErrorColour;   break;
    default:
      return;  // problem go away.
  }
  
  res = ::wxGetColourFromUser(this, colour);
  if (res.Ok())
  {
    wxBitmapButton* button;
    switch (event.GetId())
    {
      case BTN_MC_NORMAL_COLOUR :
        MCNormalColour = res;
        button = btnMCNormalColour;
        break;
      case BTN_MC_SUCCESS_COLOUR :
        MCSuccessColour = res;
        button = btnMCSuccessColour;
        break;
      case BTN_MC_WARNING_COLOUR :
        MCWarningColour = res;
        button = btnMCWarningColour;
        break;
      case BTN_MC_ERROR_COLOUR :
        MCErrorColour = res;
        button = btnMCErrorColour;
        break;
      case BTN_BC_NORMAL_COLOUR :
        BCNormalColour = res;
        button = btnBCNormalColour;
        break;
      case BTN_BC_SUCCESS_COLOUR :
        BCSuccessColour = res;
        button = btnBCSuccessColour;
        break;
      case BTN_BC_WARNING_COLOUR :
        BCWarningColour = res;
        button = btnBCWarningColour;
        break;
      case BTN_BC_ERROR_COLOUR :
        BCErrorColour = res;
        button = btnBCErrorColour;
        break;
    }

    button->SetBitmapLabel(::createBitmapForButton(res, button));
  }
}
//---------------------------------------------------------------------------


/**
 * Makes a panel that contains the title of a configuration page.
 *
 * @param  parent  Parent of the panel.
 * @param  title   Title of the page.
 * @param  level   Level of the page (1 or 2).
 * @return A panel that contains the title of a configuration page.
 */
wxPanel* dlgConfigure::makePageTitlePanel(wxWindow* parent, const wxString& title, int const level)
{
  const int fontSize = (level >= 1 && level <= 2) ? 175 - (25 * level) : 125;
  
  wxPanel* pnlTitle = new wxPanel(parent, -1, wxDefaultPosition, wxDefaultSize, wxSUNKEN_BORDER);
  pnlTitle->SetBackgroundColour(wxSystemSettings::GetColour(wxSYS_COLOUR_HIGHLIGHT));

  wxStaticText* lblTitle = new wxStaticText(pnlTitle, -1, title);
  lblTitle->SetBackgroundColour(pnlTitle->GetBackgroundColour());
  lblTitle->SetForegroundColour(wxSystemSettings::GetColour(wxSYS_COLOUR_HIGHLIGHTTEXT));
  wxFont f = lblTitle->GetFont();
  lblTitle->SetFont(wxFont((f.GetPointSize() * fontSize) / 100, f.GetFamily(), f.GetStyle(), wxFONTWEIGHT_BOLD, f.GetUnderlined(), f.GetFaceName(), f.GetDefaultEncoding()));

  wxBoxSizer* titleSizer = new wxBoxSizer(wxVERTICAL);
  titleSizer->Add(lblTitle, 1, wxGROW | wxALL, CONTROL_SPACE / 2);
  pnlTitle->SetSizer(titleSizer);
  pnlTitle->Fit();

  return pnlTitle;
}
//---------------------------------------------------------------------------


/**
 * Adds an item in the choices of the generators identifiers on saving SFV files.
 *
 * @param  identifier  Identifier to add to the list of choices.
 * @return The index where the identifier has been added.
 */
int dlgConfigure::addSFVGeneratorIdentifier(const wxString& identifier)
{
  wxArrayString entries;
  int           index;  // index where the identifier has been added.

  // The two first items never change. The first is the name of the current
  // version of wxChecksums, the second is an entry to add a personalized one.
  entries.Add(cboSFVIdentifyAs->GetString(0));
  entries.Add(cboSFVIdentifyAs->GetString(1));

  // Add the new identifier at the "top" of the choices.
  int i = entries.Index(identifier);
  if (i == wxNOT_FOUND)
  // The identifier is not a "reserved" identifier, adding it.
  {
    entries.Add(identifier);
    index = 2;
  }
  else  // using the default identifier of the application.
    index = 0;

  // Adding the rest of choice control
  wxString toAdd;  // string to add
  for (i = 2; i < cboSFVIdentifyAs->GetCount(); i++)
  {
    toAdd = cboSFVIdentifyAs->GetString(i);
    if (entries.Index(toAdd) == wxNOT_FOUND)
      entries.Add(toAdd);
  }
  
  // Recreates the choice control entries
  cboSFVIdentifyAs->Clear();
  int to = (entries.GetCount() <= getSFVGeneratorIdentifierHistoryMaxSize() + 2) ? entries.GetCount() : getSFVGeneratorIdentifierHistoryMaxSize() + 2;    // + 2 => two first items are always there
  for (i = 0; i < to; i++)
    cboSFVIdentifyAs->Append(entries[i]);
  
  return index;
}
//---------------------------------------------------------------------------


/**
 * Gets the configuration key of the <I>n</I>th generator identifier on saving SFV files.
 *
 * @param  n  The nth history configuration key to get.
 * @return The configuration key of the <I>n</I>th generator identifier on saving SFV files.
 */
wxString dlgConfigure::getSFVGeneratorIdentifierConfigKey(const int n) const
{
  if (n >= 1 && n <= getSFVGeneratorIdentifierHistoryMaxSize())
  {
    wxString rootConfigKey = AppPrefs::get()->getConfigKey(prSFV_WRITE_GEN_AND_DATE).BeforeLast(wxT('/'));
    return rootConfigKey + wxString::Format(wxT("/IdentifyAs/History/Identify%02d"), n);
  }
  else
    return wxEmptyString;
}
//---------------------------------------------------------------------------


/**
 * Gets the maximum size of the history of the generators identifiers on
 * saving SFV files.
 *
 * @return the maximum size of the history of the generators identifiers on
 *         saving SFV files.
 */
int dlgConfigure::getSFVGeneratorIdentifierHistoryMaxSize() const
{
  return 16;
}
//---------------------------------------------------------------------------



BEGIN_EVENT_TABLE(dlgConfigure, wxDialog)
  EVT_BUTTON(BTN_SUMS_HEADERS_UP, dlgConfigure::btnSumsHeadersUpClick)
  EVT_BUTTON(BTN_SUMS_HEADERS_DOWN, dlgConfigure::btnSumsHeadersDownClick)
  EVT_CHOICE(CBO_SFV_IDENTIFY_AS, dlgConfigure::cboSFVIdentifyAsSelect)
  EVT_CHECKBOX(CHK_MC_FILE_STATE, dlgConfigure::chkMCFileStateCheck)
  EVT_BUTTON(BTN_MC_NORMAL_COLOUR, dlgConfigure::btnMCColoursClick)
  EVT_BUTTON(BTN_MC_SUCCESS_COLOUR, dlgConfigure::btnMCColoursClick)
  EVT_BUTTON(BTN_MC_WARNING_COLOUR, dlgConfigure::btnMCColoursClick)
  EVT_BUTTON(BTN_MC_ERROR_COLOUR, dlgConfigure::btnMCColoursClick)
  EVT_BUTTON(BTN_BC_NORMAL_COLOUR, dlgConfigure::btnMCColoursClick)
  EVT_BUTTON(BTN_BC_SUCCESS_COLOUR, dlgConfigure::btnMCColoursClick)
  EVT_BUTTON(BTN_BC_WARNING_COLOUR, dlgConfigure::btnMCColoursClick)
  EVT_BUTTON(BTN_BC_ERROR_COLOUR, dlgConfigure::btnMCColoursClick)
  EVT_TREE_SEL_CHANGED(TRE_PAGES, dlgConfigure::trePagesSelChanged)
END_EVENT_TABLE()
//---------------------------------------------------------------------------
