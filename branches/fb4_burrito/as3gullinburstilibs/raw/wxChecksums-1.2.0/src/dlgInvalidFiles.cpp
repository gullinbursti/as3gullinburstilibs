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
 * \file dlgInvalidFiles.cpp
 * Invalid files dialog.
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

#include <wx/busyinfo.h>
#include <wx/filename.h>
#include <wx/listctrl.h>

#include "dlgInvalidFiles.hpp"
#include "comdefs.hpp"
#include "utils.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


//###########################################################################
// dlgInvalidFiles methods
//###########################################################################

IMPLEMENT_DYNAMIC_CLASS(dlgInvalidFiles, wxDialog)


/**
 * Creates a new dialog.
 */
dlgInvalidFiles::dlgInvalidFiles() : wxDialog()
{
  createControls(wxEmptyString, InvalidFilesContainer());
}
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 *
 * @param  parent  Parent of the dialog.
 * @param  title   Title of the window.
 * @param  msg     Message to display.
 * @param  files   Invalid files and reason.
 */
dlgInvalidFiles::dlgInvalidFiles(wxWindow* parent, const wxString& title,
                                 const wxString& msg,
                                 const InvalidFilesContainer& files) :
  wxDialog(parent, -1, title, wxDefaultPosition, wxDefaultSize, 
           wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
  createControls(msg, files);
 
  int w, h;
  ::wxDisplaySize(&w, &h);
  SetSize((w * 2) / 3, (h * 2) / 3);
  Centre();
}
//---------------------------------------------------------------------------


/**
 * List compare function.
 *
 * <B>Warning &nbsp;:</B> this is a quick&dirty fonction, where a pointer
 * on a wxListView class is passed in a parameter with the long type.
 *
 * @param  item1     data on the first item.
 * @param  item2     data on the second item.
 * @param  sortData  Not used
 */
static int wxCALLBACK ListCompareFnct(long item1, long item2, long sortData)
{
  int res;

  // Gets the checksum data of the items
  wxFileName fn1 = *reinterpret_cast<const wxString*>(item1);
  wxFileName fn2 = *reinterpret_cast<const wxString*>(item2);

  ::wxYield();
  res = ::compareFileName(fn1.GetPath(wxPATH_GET_VOLUME), fn2.GetPath(wxPATH_GET_VOLUME));
  if (res == 0)
    res = ::compareFileName(fn1.GetFullName(), fn2.GetFullName());

  return res;
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the dialog.
 */
void dlgInvalidFiles::createControls(const wxString& msg,
                                     const InvalidFilesContainer& files)
{
  // Creates the control
  wxStaticText* lblMessage = new wxStaticText(this, -1, msg);
  wxListView* lwvFiles = new wxListView(this, -1, wxDefaultPosition,
                                        wxDefaultSize,
                                        wxLC_REPORT | wxLC_HRULES);
  wxButton* btnClose = new wxButton(this, BTN_CLOSE, _("&Close"));
  btnClose->SetDefault();

  // Add columns to the listview
  lwvFiles->InsertColumn(0, _("File name"));
  lwvFiles->InsertColumn(1, _("Reason"));
  
  // Add items to the listview
  long p = 0;
  for (InvalidFilesContainer::const_iterator it = files.begin(); it != files.end(); it++, p++)
  {
    lwvFiles->InsertItem(p, it->first);
    lwvFiles->SetItem(p, 1, it->second);
    lwvFiles->SetItemData(p, reinterpret_cast<long>(&(it->first)));
  }

  // Set the columns width
  lwvFiles->SetColumnWidth(0, wxLIST_AUTOSIZE);
  lwvFiles->SetColumnWidth(1, wxLIST_AUTOSIZE);

  // Sort the list
  {
    wxWindowDisabler disableAll;
    wxBusyInfo wait(_("Please wait..."));
    lwvFiles->SortItems(ListCompareFnct, 0);
  }


  //-------------------------------------------------------------------------
  // Creates the dialog sizer

  // Dialog sizer
  wxBoxSizer* dlgInvalidFilesSizer2 = new wxBoxSizer(wxVERTICAL);
  this->SetSizer(dlgInvalidFilesSizer2);
  wxBoxSizer* dlgInvalidFilesSizer = new wxBoxSizer(wxVERTICAL);
  dlgInvalidFilesSizer2->Add(dlgInvalidFilesSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  dlgInvalidFilesSizer->Add(lblMessage, 0, wxALIGN_LEFT);
  dlgInvalidFilesSizer->Add(lwvFiles, 1, wxGROW | wxTOP, CONTROL_SPACE);
  dlgInvalidFilesSizer->Add(btnClose, 0, wxTOP | wxALIGN_RIGHT, CONTROL_SPACE);

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();

  // Sets the background color
  //this->SetBackgroundColour(a_control->GetBackgroundColour()); */
}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
dlgInvalidFiles::~dlgInvalidFiles()
{
}
//---------------------------------------------------------------------------


/**
 * Processes button Close.
 *
 * @param  event  The event's parameters
 */
void dlgInvalidFiles::btnCloseClick(wxCommandEvent& event)
{
  if (this->IsModal())
    this->EndModal(wxID_OK);
  else
  {
    this->SetReturnCode(wxID_OK);
    this->Show(false);
  }
}
//---------------------------------------------------------------------------



BEGIN_EVENT_TABLE(dlgInvalidFiles, wxDialog)
  EVT_BUTTON(BTN_CLOSE, dlgInvalidFiles::btnCloseClick)
END_EVENT_TABLE()
//---------------------------------------------------------------------------
