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
 * \file dlgAbout.cpp
 * About dialog.
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

#include <wx/notebook.h>

#include "dlgAbout.hpp"
#include "frmSums.hpp"
#include "appprefs.hpp"
#include "comdefs.hpp"
#include "language.hpp"
#include "licence.hpp"
#include "utils.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


IMPLEMENT_DYNAMIC_CLASS(dlgAbout, wxDialog)


/**
 * Creates a new dialog.
 */
dlgAbout::dlgAbout() : wxDialog()
{
  createControls();
}
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 *
 * @param  parent  Parent of the dialog.
 */
dlgAbout::dlgAbout(wxWindow* parent) :
  wxDialog(parent, -1, wxEmptyString, wxDefaultPosition, wxDefaultSize, 
           wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
  createControls();

/*  int w, h;
  ::wxDisplaySize(&w, &h);*/
  if (parent != NULL)
  {
    wxSize s = parent->GetSize();
    this->SetSize((s.GetWidth() * 9) / 10, (s.GetHeight() * 2) / 3);
  }
  Centre();
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the dialog.
 */
void dlgAbout::createControls()
{
  // Sets the dialog title
  this->SetTitle(wxString::Format(_("About %s"), wxT(APP_NAME)));

  // The application icon and name
  wxStaticBitmap* imgAppIcon;
  frmSums* parent = wxDynamicCast(this->GetParent(), frmSums);
  if (parent != NULL)
    imgAppIcon = new wxStaticBitmap(this, -1, parent->GetIcon());
  else
    imgAppIcon = new wxStaticBitmap(this, -1, wxNullBitmap);
  wxStaticText* lblAppName = new wxStaticText(this, -1, ::getAppName());
  wxFont f = lblAppName->GetFont();
  lblAppName->SetFont(wxFont((f.GetPointSize() * 125) / 100, f.GetFamily(), f.GetStyle(), f.GetWeight(), f.GetUnderlined(), f.GetFaceName(), f.GetDefaultEncoding()));

  // The notebook
  wxNotebook* pgcAbout = new wxNotebook(this, -1);

  // About page
  wxPanel* tabAbout = new wxPanel(pgcAbout);
  pgcAbout->AddPage(tabAbout, _("About"), true);
  wxStaticText* lblAppDesc = new wxStaticText(tabAbout, -1, _("Computes and verifies checksums"));
  wxStaticText* lblAppCopyright = new wxStaticText(tabAbout, -1, wxString::Format(_("Copyright (c) %s %s"), wxT(APP_DEV_DATES), wxT(APP_AUTHOR)));

  // Author page
  wxPanel* tabAuthors = new wxPanel(pgcAbout);
  pgcAbout->AddPage(tabAuthors, _("Author"), false);
  wxTextCtrl* txtAuthors = new wxTextCtrl(tabAuthors, -1, wxString(wxT(APP_AUTHOR)) + wxString(wxT(" <jcouot@users.sourceforge.net>\n\t")) + _("Programmer & documentation"), wxDefaultPosition, wxDefaultSize, wxTE_MULTILINE | wxTE_READONLY);

  // Translations page
  wxPanel* tabTranslations = new wxPanel(pgcAbout);
  pgcAbout->AddPage(tabTranslations, _("Translations"), false);
  wxTextCtrl* txtTranslations = new wxTextCtrl(tabTranslations, -1, wxEmptyString, wxDefaultPosition, wxDefaultSize, wxTE_MULTILINE | wxTE_READONLY);
  Languages languages;
  int i;
  for (i = 0; i < languages.getLanguagesCount(); i++)
  {
    txtTranslations->AppendText(languages.getLanguageShortName(i) + wxT('\t') + languages.getLanguageTranslatorName(i));
    if (languages.getLanguageTranslatorName(i) != languages.getLanguageTranslatorNameInLocale(i))
      txtTranslations->AppendText(wxT(" (") + languages.getLanguageTranslatorNameInLocale(i) + wxT(')'));
    txtTranslations->AppendText(wxT("\n"));
  }

  // Licence agreement page
  wxPanel* tabLicence = new wxPanel(pgcAbout);
  pgcAbout->AddPage(tabLicence, _("Licence agreement"));
  wxTextCtrl* txtLicence = new wxTextCtrl(tabLicence, -1, wxString(_("This program is distributed under the terms of the GPL v2.")) + wxString(wxT("\n\n")) + ::getGPLLicenceText(), wxDefaultPosition, wxDefaultSize, wxTE_MULTILINE | wxTE_READONLY);
  #if defined(__WXMSW__)
  txtLicence->SetFont(wxSystemSettings::GetFont(wxSYS_ANSI_FIXED_FONT));
  #else
  txtLicence->SetFont(wxFont(txtLicence->GetFont().GetPointSize(), wxFONTFAMILY_MODERN, wxFONTSTYLE_NORMAL, wxFONTWEIGHT_NORMAL));
  #endif  // defined(__WXMSW__)
  
  // Misc information page
  wxPanel* tabMiscInfo = new wxPanel(pgcAbout);
  pgcAbout->AddPage(tabMiscInfo, _("Misc information"));
  wxTextCtrl* txtMiscInfo = new wxTextCtrl(tabMiscInfo, -1, wxEmptyString, wxDefaultPosition, wxDefaultSize, wxTE_MULTILINE | wxTE_READONLY);
  wxString star = wxT("* ");
  txtMiscInfo->AppendText(wxString::Format(star + _("Built with wxWidgets %d.%d.%d."), wxMAJOR_VERSION, wxMINOR_VERSION, wxRELEASE_NUMBER));
  #if defined(wxC_USE_LARGE_FILES)
  txtMiscInfo->AppendText(wxString(wxT("\n")) + star + _("Large files support enabled."));
  #else
  txtMiscInfo->AppendText(wxString(wxT("\n")) + star + _("Large files support disabled."));
  #endif  // defined(wxC_USE_LARGE_FILES)

  // The validation buttons
  wxButton* btnClose = new wxButton(this, wxID_CANCEL, _("&Close"));


  //-------------------------------------------------------------------------
  // Creates the dialog sizer

  // The icon and the name of the application.
  wxBoxSizer* appIconAndNameSizer = new wxBoxSizer(wxHORIZONTAL);
  appIconAndNameSizer->Add(imgAppIcon, 0, wxALIGN_CENTER_VERTICAL);
  appIconAndNameSizer->Add(lblAppName, 0, wxALIGN_CENTER_VERTICAL | wxLEFT, CONTROL_SPACE);
  
  // Notebook control sizer
  //wxNotebookSizer* pgcAboutSizer = new wxNotebookSizer(pgcAbout);

  // About tab sizer
  // The panel sizer
  wxBoxSizer* tabAboutSizer2 = new wxBoxSizer(wxVERTICAL);
  tabAbout->SetSizer(tabAboutSizer2);
  wxBoxSizer* tabAboutSizer = new wxBoxSizer(wxVERTICAL);
  tabAboutSizer2->Add(tabAboutSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  tabAboutSizer->Add(lblAppDesc);
  tabAboutSizer->Add(lblAppCopyright, 0, wxTOP, CONTROL_SPACE);


  // Translations tab sizer
  // The panel sizer
  wxBoxSizer* tabTranslationsSizer2 = new wxBoxSizer(wxVERTICAL);
  tabTranslations->SetSizer(tabTranslationsSizer2);
  wxBoxSizer* tabTranslationsSizer = new wxBoxSizer(wxVERTICAL);
  tabTranslationsSizer2->Add(tabTranslationsSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  tabTranslationsSizer->Add(txtTranslations, 1, wxGROW);


  // Licence agreement tab sizer
  // The panel sizer
  wxBoxSizer* tabAuthorsSizer2 = new wxBoxSizer(wxVERTICAL);
  tabAuthors->SetSizer(tabAuthorsSizer2);
  wxBoxSizer* tabAuthorsSizer = new wxBoxSizer(wxVERTICAL);
  tabAuthorsSizer2->Add(tabAuthorsSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  tabAuthorsSizer->Add(txtAuthors, 1, wxGROW);


  // Licence agreement tab sizer
  // The panel sizer
  wxBoxSizer* tabLicenceSizer2 = new wxBoxSizer(wxVERTICAL);
  tabLicence->SetSizer(tabLicenceSizer2);
  wxBoxSizer* tabLicenceSizer = new wxBoxSizer(wxVERTICAL);
  tabLicenceSizer2->Add(tabLicenceSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  tabLicenceSizer->Add(txtLicence, 1, wxGROW);


  // Licence agreement tab sizer
  // The panel sizer
  wxBoxSizer* tabMiscInfoSizer2 = new wxBoxSizer(wxVERTICAL);
  tabMiscInfo->SetSizer(tabMiscInfoSizer2);
  wxBoxSizer* tabMiscInfoSizer = new wxBoxSizer(wxVERTICAL);
  tabMiscInfoSizer2->Add(tabMiscInfoSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  tabMiscInfoSizer->Add(txtMiscInfo, 1, wxGROW);


  // Dialog sizer
  wxBoxSizer* dlgAboutSizer2 = new wxBoxSizer(wxVERTICAL);
  this->SetSizer(dlgAboutSizer2);
  wxBoxSizer* dlgAboutSizer = new wxBoxSizer(wxVERTICAL);
  dlgAboutSizer2->Add(dlgAboutSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  dlgAboutSizer->Add(appIconAndNameSizer);
  dlgAboutSizer->Add(pgcAbout, 1, wxGROW | wxTOP, CONTROL_SPACE);
  dlgAboutSizer->Add(btnClose, 0, wxTOP | wxALIGN_RIGHT, CONTROL_SPACE);

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();

  // Sets the background color
  //this->SetBackgroundColour(a_control->GetBackgroundColour());
}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
dlgAbout::~dlgAbout()
{
}
//---------------------------------------------------------------------------



/*BEGIN_EVENT_TABLE(dlgAbout, wxDialog)
END_EVENT_TABLE()*/
//---------------------------------------------------------------------------
