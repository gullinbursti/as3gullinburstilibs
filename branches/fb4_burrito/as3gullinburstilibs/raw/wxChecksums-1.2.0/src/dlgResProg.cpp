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
 * \file dlgResProg.cpp
 * Template for progress dialogs which display textual informations.
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

#include "dlgResProg.hpp"
#include "comdefs.hpp"
#include "utils.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


IMPLEMENT_DYNAMIC_CLASS(dlgResultsProgress, wxDialog)


/**
 * Creates a new dialog.
 */
dlgResultsProgress::dlgResultsProgress() : wxDialog()
{
  winDisabler = NULL;
  createControls();
}
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 *
 * @param  parent  Parent of the dialog.
 * @param  id      An identifier for the dialog. A value of <CODE>-1</CODE> is
 *                 taken to mean a default.
 * @param  title   The title of the dialog.
 * @param  pos     The dialog position. A value of <CODE>(-1, -1)</CODE>
 *                 indicates a default position, chosen by either the windowing
 *                 system or wxWidgets, depending on platform.
 * @param  size    The dialog size. A value of <CODE>(-1, -1)</CODE> indicates a
 *                 default size, chosen by either the windowing system or
 *                 wxWidgets, depending on platform.
 * @param  style   The window style. See wxDialog's documentation.
 * @param  name    Used to associate a name with the window, allowing the
 *                 application user to set Motif resource values for individual
 *                 dialog boxes.
 */
dlgResultsProgress::dlgResultsProgress(wxWindow* parent, wxWindowID id,
                                       const wxString& title, const wxPoint& pos,
                                       const wxSize& size,
                                       long  style,
                                       const wxString& name) :
                             wxDialog(parent, id, title, pos, size, style, name)
{
  // Dialog may disappear at any moment, let the others know about it.
  SetExtraStyle(GetExtraStyle() | wxWS_EX_TRANSIENT);

  // Disable all others windows.
  winDisabler = new wxWindowDisabler(this);

  // Set the dialog state.
  setState(running);

  // Set the last inserted item.
  lastInsertedPos = 0L;
  lastInsertedWidth = 0L;

  createControls();
  Fit();
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the dialog.
 */
void dlgResultsProgress::createControls()
{
  // Creates the controls
  txtResults = new wxTextCtrl(this, TXT_RESULTS, wxEmptyString, wxDefaultPosition, wxDefaultSize,
                              wxTE_DONTWRAP | wxTE_MULTILINE | wxTE_READONLY | wxTE_RICH2);

  wxClientDC dc(txtResults);
  wxSize labelSize(dc.GetCharWidth() * 20, -1);

  btnPause = new wxButton(this, BTN_PAUSE, _("&Pause"));
  btnPause->SetDefault();
  btnCancel = new wxButton(this, wxID_CANCEL, _("&Cancel"));

  //-------------------------------------------------------------------------
  // Creates the dialog sizers

  // Dialog sizer
  wxBoxSizer* dlgResultsProgressSizer2 = new wxBoxSizer(wxVERTICAL);
  this->SetSizer(dlgResultsProgressSizer2);
  wxBoxSizer* dlgResultsProgressSizer = new wxBoxSizer(wxVERTICAL);
  dlgResultsProgressSizer2->Add(dlgResultsProgressSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // List of results
  dlgResultsProgressSizer->Add(txtResults, 1, wxGROW);
  
  // Information section
  infoSizer = new wxBoxSizer(wxVERTICAL);
  dlgResultsProgressSizer->Add(infoSizer, 0, wxGROW);

  // Validation buttons sizer
  wxGridSizer* buttonsSizer = new wxGridSizer(2, 0, 2 * CONTROL_SPACE);
  buttonsSizer->Add(btnPause);
  buttonsSizer->Add(btnCancel);
  dlgResultsProgressSizer->Add(buttonsSizer, 0, wxTOP | wxALIGN_RIGHT, (3 * CONTROL_SPACE) / 2);
}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
dlgResultsProgress::~dlgResultsProgress()
{
  reenableOtherWindows();
}
//---------------------------------------------------------------------------


/**
 * Hides or shows the dialog.
 *
 * @param  show  If <CODE>TRUE</CODE>, the dialog box is shown and brought to
 *               the front; otherwise the box is hidden.
 */
bool dlgResultsProgress::Show(bool show)
{
  // Reenable other windows before hiding this one because otherwise
  // Windows wouldn't give the focus back to the window which had
  // been previously focused because it would still be disabled
  if (!show)
    reenableOtherWindows();

  return wxDialog::Show(show);
}
//---------------------------------------------------------------------------


/**
 * Processes button Cancel.
 *
 * @param  event  The event's parameters
 */
void dlgResultsProgress::btnCancelClick(wxCommandEvent& event)
{
  if (getState() == finished)
  {
    // this means that the count down is already finished and we're being
    // shown as a modal dialog - so just let the default handler do the job
    event.Skip();
  }
  else
  {
    // request to cancel was received
    setState(canceled);

    // update the button state immediately so that the user knows that the
    // request has been noticed
    btnCancel->Disable();
    btnPause->Disable();
  }
}
//---------------------------------------------------------------------------


/**
 * Processes button Pause.
 *
 * @param  event  The event's parameters
 */
void dlgResultsProgress::btnPauseClick(wxCommandEvent& event)
{
  switch (getState())
  {
    case running :
      btnPause->SetLabel(_("C&ontinue"));
      setState(paused);
      break;
    case paused :
      btnPause->SetLabel(_("&Pause"));
      setState(running);
      break;
  }
  wxYield();
  #ifdef __WXMAC__
  MacUpdateImmediately();
  #endif
}
//---------------------------------------------------------------------------


/**
 * Event handler to respond to system close events.
 *
 * @param  event  event parameters.
 */
void dlgResultsProgress::FrameClose(wxCloseEvent& event)
{
  if (getState() == finished)
  // let the default handler close the window as we already terminated
    event.Skip();
  else
    setState(canceled);
}
//---------------------------------------------------------------------------


/**
 * Reenables the others windows.
 *
 * Must be called to reenable the other windows temporarily disabled while
 * the dialog was shown.
 */
void dlgResultsProgress::reenableOtherWindows()
{
  if (winDisabler != NULL)
  {
    delete winDisabler;
    winDisabler = NULL;
  }
}
//---------------------------------------------------------------------------


/**
 * Says to the dialog that the process is finished.
 *
 * Sets the state to "finished" and change the caption of the <I>Cancel</I>
 * button to "Close".
 */
void dlgResultsProgress::Finished()
{
  setState(finished);

  btnCancel->SetLabel(_("&Close"));
  btnPause->Disable();
  wxYield();
  #ifdef __WXMAC__
  MacUpdateImmediately();
  #endif
  ShowModal();
}
//---------------------------------------------------------------------------


/**
 * Gets the dialog state.
 *
 * @return The dialog state.
 */
dlgResultsProgress::State dlgResultsProgress::getState() const
{
  return state;
}
//---------------------------------------------------------------------------


/**
 * Sets the dialog state.
 *
 * @param  newState The new dialog state.
 */
void dlgResultsProgress::setState(State newState)
{
  switch (newState)
  {
    case running :
    case paused :
    case canceled :
      state = newState;
      break;
    default :
      state = finished;
  }
}
//---------------------------------------------------------------------------


/**
 * Refreshes the dialog.
 *
 * Should be called on each update of a control on the dialog.
 */
void dlgResultsProgress::refreshDialog()
{
  // Update the display (especially on X, GTK)
  wxYield();

  #ifdef __WXMAC__
  MacUpdateImmediately();
  #endif
}
//---------------------------------------------------------------------------


/**
 * Adds a line to the results.
 *
 * @param  text         Line of text to add.
 * @param  indentation  Indentation of the text.
 * @param  colour       Colour of the text.
 */
void dlgResultsProgress::addResultLine(const wxString& text, const unsigned int indentation, const wxColour& colour)
{
  wxString indent;
  for (unsigned int i = 0; i < indentation; i++)
    indent += wxT("\t");

  lastInsertedPos += lastInsertedWidth;
  lastInsertedWidth = indent.size() + text.size();

  txtResults->Freeze();
  txtResults->SetDefaultStyle(colour);
  txtResults->AppendText(indent + text);
  txtResults->Thaw();

  // Update the display (especially on X, GTK)
  wxYield();

  #ifdef __WXMAC__
  MacUpdateImmediately();
  #endif
}
//---------------------------------------------------------------------------


/**
 * Replace the last inserted result line.
 *
 * @param  text         Line of text to add.
 * @param  indentation  Indentation of the text.
 * @param  colour       Colour of the text.
 */
void dlgResultsProgress::replaceLastResultLine(const wxString& text, const unsigned int indentation, const wxColour& colour)
{
  if (lastInsertedWidth > 0)
  {
    wxString indent;
    for (unsigned int i = 0; i < indentation; i++)
      indent += wxT("\t");

    // Don't use wxTextCtrl::Replace because it don't use the style on Windows.
    txtResults->Freeze();
    txtResults->Remove(lastInsertedPos, lastInsertedPos + lastInsertedWidth);
    txtResults->SetDefaultStyle(colour);
    txtResults->AppendText(indent + text);
    txtResults->Thaw();

    lastInsertedWidth = indent.size() + text.size();

    // Update the display (especially on X, GTK)
    wxYield();

    #ifdef __WXMAC__
    MacUpdateImmediately();
    #endif
  }
}
//---------------------------------------------------------------------------


/**
 * Remove the last inserted result line.
 */
void dlgResultsProgress::removeLastResultLine()
{
  if (lastInsertedWidth > 0)
  {
    txtResults->Freeze();
    txtResults->Remove(lastInsertedPos, lastInsertedPos + lastInsertedWidth);
    txtResults->Thaw();

    lastInsertedWidth = 0L;

    // Update the display (especially on X, GTK)
    wxYield();

    #ifdef __WXMAC__
    MacUpdateImmediately();
    #endif
  }
}
//---------------------------------------------------------------------------


/**
 * Says if the process can continue.
 *
 * If the state of the dialog is <I>canceled</I> or <I>finished</I> the
 * checking can't continue.
 *
 * @return <CODE>true</CODE> if the state of the dialog is <I>running</I> or
 *         <I>paused</I>, <CODE>false</CODE> otherwise.
 */
bool dlgResultsProgress::canContinue() const
{
  bool res;

  switch (getState())
  {
    case running :
    case paused :
      res = true;
      break;
    default :
      res = false;
  }
  
  return res;
}
//---------------------------------------------------------------------------


/**
 * Gets a colour from the preferences.
 *
 * @param  pk  Preference key from which the colour is get.
 * @return A colour from the preferences.
 */
wxColour dlgResultsProgress::getColour(PreferencesKeys pk)
{
  long r = AppPrefs::get()->readLong(pk, -1);
  
  if (r == -1)
    return wxColour();
  else
    return ::longTowxColour(r);
}
//---------------------------------------------------------------------------



BEGIN_EVENT_TABLE(dlgResultsProgress, wxDialog)
  EVT_BUTTON(wxID_CANCEL, dlgResultsProgress::btnCancelClick)
  EVT_BUTTON(BTN_PAUSE, dlgResultsProgress::btnPauseClick)
  EVT_CLOSE(dlgResultsProgress::FrameClose)
END_EVENT_TABLE()
//---------------------------------------------------------------------------
