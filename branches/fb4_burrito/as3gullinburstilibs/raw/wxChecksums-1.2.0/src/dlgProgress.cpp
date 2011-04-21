/*
 * wxChecksums
 * Copyright (C) 2003-2004 Julien Couot
 *
 * Based on the wxProgressDialog class provided in wxWidgets written by
 * Karsten Ballüder.
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
 * \file dlgProgress.cpp
 * Progress dialog.
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

#include "dlgProgress.hpp"
#include "comdefs.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


IMPLEMENT_DYNAMIC_CLASS(dlgProgress, wxDialog)


/**
 * Creates and displays dialog, disables event handling for other frames or
 * parent frame to avoid recursion problems.
 *
 * @param  title    Title for window.
 * @param  message  Message to display in window.
 * @param  maximum  Value for status bar, if <CODE><= 0</CODE>, no bar is shown.
 * @param  parent   Window or <CODE>NULL</CODE>.
 * @param  style    Is the bit mask of <CODE>wxPD_XXX</CODE> constants from <CODE>wx/defs.h</CODE>.
 */
dlgProgress::dlgProgress(const wxString& title, const wxString& message,
                         int maximum, wxWindow* parent, int style)
                                                   : wxDialog(parent, -1, title)
{
  // we may disappear at any moment, let the others know about it
  SetExtraStyle(GetExtraStyle() | wxWS_EX_TRANSIENT);

  m_windowStyle |= style;

  bool hasAbortButton = (style & wxPD_CAN_ABORT) != 0;

  #if defined(__WXMSW__) && !defined(__WXUNIVERSAL__)
  // we have to remove the "Close" button from the title bar then as it is
  // confusing to have it - it doesn't work anyhow
  //
  // FIXME: should probably have a (extended?) window style for this
  if (!hasAbortButton)
    EnableCloseButton(FALSE);
  #endif // wxMSW

  state = hasAbortButton ? Continue : Uncancelable;
  this->maximum = maximum;

  #if defined(__WXMSW__) || defined(__WXPM__)
  // We can't have values > 65,536 in the progress control under Windows, so
  // scale everything down
  factor = this->maximum / SHRT_MAX + 1;
  this->maximum /= factor;
  #endif // __WXMSW__

  // Get the top parent window
  ctrParentTop = parent;
  while (ctrParentTop && ctrParentTop->GetParent())
    ctrParentTop = ctrParentTop->GetParent();

  // Create the dialog's controls.
  createControls();

  this->Centre(wxBOTH);

  if (style & wxPD_APP_MODAL)
    winDisabler = new wxWindowDisabler(this);
  else
    if (ctrParentTop)
    {
      ctrParentTop->Enable(FALSE);
      winDisabler = (wxWindowDisabler*)NULL;
    }

  this->Show(true);
  this->Enable(true);

  // Set the current time
  timeStart = ::wxGetCurrentTime();

  // This one can be initialized even if the others are unknown for now.
  if (lblElapsed)
    SetTimeLabel(0, lblElapsed);

  // Update the display (especially on X, GTK)
  wxYield();

  #ifdef __WXMAC__
  MacUpdateImmediately();
  #endif
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the dialog.
 */
void dlgProgress::createControls(const wxString& message)
{
  // Message label
  wxClientDC dc(this);
  wxSize size = wxDefaultSize;
  size.SetHeight(GetCharHeight() * 2);
  lblMessage = new wxStaticText(this, -1, message, wxDefaultPosition, size);

  if (maximum > 0)
    // Note that we can't use wxGA_SMOOTH because it happens to also mean
    // wxDIALOG_MODAL and will cause the dialog to be modal. Have an extra
    // style argument to wxProgressDialog, perhaps.
    gauProgress = new wxGauge(this, -1, maximum, wxDefaultPosition,
                              wxDefaultSize, wxGA_HORIZONTAL);
  else
    gauProgress = (wxGauge*)NULL;

  // Count how many labels we really have for time
  size_t nTimeLabels = 0;

  // Elapsed time
  wxStaticText* lblElapsedTxt;
  if (GetWindowStyle() & wxPD_ELAPSED_TIME)
  {
    lblElapsedTxt = new wxStaticText(this, -1, _("Elapsed time:"));
    lblElapsed = new wxStaticText(this, -1, _("unknown"));
    nTimeLabels++;
  }
  else
  {
    lblElapsedTxt = (wxStaticText*)NULL;
    lblElapsed = (wxStaticText*)NULL;
  }

  // Estimated time
  wxStaticText* lblEstimatedTxt;
  if (GetWindowStyle() & wxPD_ESTIMATED_TIME)
  {
    lblEstimatedTxt = new wxStaticText(this, -1, _("Estimated time:"));
    lblEstimated = new wxStaticText(this, -1, _("unknown"));
    nTimeLabels++;
  }  
  else
  {
    lblEstimatedTxt = (wxStaticText*)NULL;
    lblEstimated = (wxStaticText*)NULL;
  }

  // Remaining time
  wxStaticText* lblRemainingTxt;
  if (GetWindowStyle() & wxPD_REMAINING_TIME)
  {
    lblRemainingTxt = new wxStaticText(this, -1, _("Remaining time:"));
    lblRemaining = new wxStaticText(this, -1, _("unknown"));
    nTimeLabels++;
  }
  else
  {
    lblRemainingTxt = (wxStaticText*)NULL;
    lblRemaining = (wxStaticText*)NULL;
  }

  // Buttons
  btnPause = new wxButton(this, BTN_PAUSE, _("&Pause"));
  btnPause->SetDefault();
  bool hasAbortButton = (GetWindowStyle() & wxPD_CAN_ABORT) != 0;
  btnCancel = new wxButton(this, wxID_CANCEL, _("&Cancel"));
  if (!hasAbortButton)
    btnCancel->Enable(false);

  //-------------------------------------------------------------------------
  // Creates the dialog sizer
  int clientHeight = 0;  // Client height of the dialog

  // Dialog sizer
  wxBoxSizer* dlgProgressSizer2 = new wxBoxSizer(wxVERTICAL);
  this->SetSizer(dlgProgressSizer2);
  wxBoxSizer* dlgProgressSizer = new wxBoxSizer(wxVERTICAL);
  dlgProgressSizer2->Add(dlgProgressSizer, 1, wxALL | wxGROW, CONTROL_SPACE);
  clientHeight += CONTROL_SPACE * 2;

  // Message
  dlgProgressSizer->Add(lblMessage, 0, wxGROW | wxALIGN_LEFT);
  clientHeight += lblMessage->GetSize().GetHeight();

  // Progress gauge
  if (maximum > 0)
  {
    dlgProgressSizer->Add(gauProgress, 0, wxGROW | wxTOP | wxALIGN_LEFT, CONTROL_SPACE / 2);
    clientHeight += gauProgress->GetSize().GetHeight() + CONTROL_SPACE / 2;
  }

  // Progress section
  if (nTimeLabels > 0)
  {
    clientHeight += CONTROL_SPACE;
    wxBoxSizer* timeSizerRight = new wxBoxSizer(wxHORIZONTAL);
    dlgProgressSizer->Add(timeSizerRight, 0, wxTOP | wxALIGN_CENTER_HORIZONTAL, CONTROL_SPACE);
    wxFlexGridSizer* timeSizer = new wxFlexGridSizer(2, CONTROL_SPACE / 2, CONTROL_SPACE);
    timeSizerRight->Add(timeSizer, 0, wxALIGN_RIGHT);
    timeSizer->AddGrowableCol(1);
    if (lblElapsed)
    {
      timeSizer->Add(lblElapsedTxt, 0, wxALIGN_CENTER_VERTICAL | wxALIGN_RIGHT);
      timeSizer->Add(lblElapsed, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
      clientHeight += lblElapsed->GetSize().GetHeight() + CONTROL_SPACE / 2;
    }
    if (lblEstimated)
    {
      timeSizer->Add(lblEstimatedTxt, 0, wxALIGN_CENTER_VERTICAL | wxALIGN_RIGHT);
      timeSizer->Add(lblEstimated, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
      clientHeight += lblEstimated->GetSize().GetHeight() + CONTROL_SPACE / 2;
    }
    if (lblRemaining)
    {
      timeSizer->Add(lblRemainingTxt, 0, wxALIGN_CENTER_VERTICAL | wxALIGN_RIGHT);
      timeSizer->Add(lblRemaining, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
      clientHeight += lblRemaining->GetSize().GetHeight() + CONTROL_SPACE / 2;
    }
  }

  // Validation buttons sizer
  wxGridSizer* buttonsSizer = new wxGridSizer(2, 0, 2 * CONTROL_SPACE);
  buttonsSizer->Add(btnPause);
  buttonsSizer->Add(btnCancel);
  dlgProgressSizer->Add(buttonsSizer, 0, wxTOP | wxALIGN_RIGHT, CONTROL_SPACE);
  clientHeight += CONTROL_SPACE + wxMax(btnPause->GetSize().GetHeight(), btnCancel->GetSize().GetHeight());

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();
  
  // Set the dialog client size
  size.SetHeight(clientHeight);
  size.SetWidth((16 * size.GetHeight()) / 7);
  SetClientSize(size);
}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
dlgProgress::~dlgProgress()
{
  // Normally this should have been already done, but just in case.
  ReenableOtherWindows();
}
//---------------------------------------------------------------------------


/**
 * Reenables the other windows temporarily disabled while the dialog was shown.
 *
 * Must be called to reenable the other windows temporarily disabled while
 * the dialog was shown.
 */
void dlgProgress::ReenableOtherWindows()
{
  if (GetWindowStyle() & wxPD_APP_MODAL)
  {
    delete winDisabler;
    winDisabler = (wxWindowDisabler*)NULL;
  }
  else
    if (ctrParentTop)
      ctrParentTop->Enable(true);
}
//---------------------------------------------------------------------------


/**
 * Update the status bar to the new value.
 *
 * @param  value   New value.
 * @param  newmsg  If used, new message to display.
 * @return <CODE>true</CODE> if <I>Cancel</I> button has not been pressed.
 */
bool dlgProgress::Update(int value, const wxString& newmsg)
{
  wxASSERT_MSG(state != paused, wxT("paused state isn't handled correctly"));
  wxASSERT_MSG(value == -1 || gauProgress, wxT("cannot update non existent dialog"));

  #ifdef __WXMSW__
  value /= factor;
  #endif // __WXMSW__

  wxASSERT_MSG(value <= maximum, wxT("invalid progress value"));

  if (gauProgress && value < maximum)
    gauProgress->SetValue(value + 1);

  if (!newmsg.IsEmpty())
  {
    lblMessage->SetLabel(newmsg);
    wxYield();
  }

  if ((lblElapsed || lblRemaining || lblEstimated) && (value != 0))
  {
    unsigned long elapsed = wxGetCurrentTime() - timeStart;
    unsigned long estimated = (unsigned long)(((double)elapsed * maximum) / ((double)value));
    unsigned long remaining = estimated - elapsed;

    SetTimeLabel(elapsed, lblElapsed);
    SetTimeLabel(estimated, lblEstimated);
    SetTimeLabel(remaining, lblRemaining);
  }

  if (value == maximum)
  {
    // So that we return TRUE below and that out [Cancel] handler knew what
    // to do
    state = Finished;
    if (!(GetWindowStyle() & wxPD_AUTO_HIDE))
    {
      // Update the gauge
      if (gauProgress != NULL)
        gauProgress->SetValue(maximum);
      
      // Disable the pause button
      btnPause->Disable();
      
      // Tell the user what he should do...
      btnCancel->SetLabel(_("&Close"));
      btnCancel->Enable(true);
      btnCancel->SetFocus();
      
      bool hasAbortButton = (GetWindowStyle() & wxPD_CAN_ABORT) != 0;
      #if defined(__WXMSW__) && !defined(__WXUNIVERSAL__)
      if (!hasAbortButton)
      {
      // Enable the button to give the user a way to close the dlg
        EnableCloseButton(TRUE);
      }
      #endif // __WXMSW__

      if (!newmsg)
        // Also provide the finishing message if the application didn't
        lblMessage->SetLabel(_("Done."));

      wxYield();
      (void)ShowModal();
    }
    else // Auto hide
    {
      // Reenable other windows before hiding this one because otherwise
      // Windows wouldn't give the focus back to the window which had
      // been previously focused because it would still be disabled.
      ReenableOtherWindows();

      Hide();
    }
  }
  else
  {
    // Update the display
    wxYield();
  }

  #ifdef __WXMAC__
  MacUpdateImmediately();
  #endif

  return state != Canceled;
}
//---------------------------------------------------------------------------


/**
 * Can be called to continue after the <I>Cancel</I> button has been pressed.
 */
void dlgProgress::Resume()
{
  if (state == Canceled)
  {
    state = Continue;

    // It may have been disabled by OnCancel(), so enable it back to let the
    // user interrupt us again if needed.
    if ((GetWindowStyle() & wxPD_CAN_ABORT) != 0)
      btnCancel->Enable();
    btnPause->Enable();
  }
}
//---------------------------------------------------------------------------


/**
 * Shows the dialog.
 *
 * @param  show  If <CODE>true</CODE> displays the window. Otherwise, hides it.
 * @return <CODE>true</CODE> if the window has been shown or hidden or
 *         <CODE>false</CODE> if nothing was done because it already was in the
 *         requested state.
 */
bool dlgProgress::Show(bool show)
{
  // Reenable other windows before hiding this one because otherwise Windows
  // wouldn't give the focus back to the window which had been previously
  // focused because it would still be disabled.
  if (!show)
    ReenableOtherWindows();

  return wxDialog::Show(show);
}
//---------------------------------------------------------------------------


/**
 * Processes button Cancel.
 *
 * @param  event  The event's parameters
 */
void dlgProgress::btnCancelClick(wxCommandEvent& event)
{
  if (state == Finished)
  {
    // This means that the count down is already finished and we're being
    // shown as a modal dialog - so just let the default handler do the job
    event.Skip();
  }
  else
  {
    // Request to cancel was received, the next time Update() is called we
    // will handle it.
    state = Canceled;

    // Update the button state immediately so that the user knows that the
    // request has been noticed.
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
void dlgProgress::btnPauseClick(wxCommandEvent& event)
{
  switch (state)
  {
    case Continue :
    case Uncancelable :
      btnPause->SetLabel(_("C&ontinue"));
      state = Paused;
      break;
    case Paused :
      btnPause->SetLabel(_("&Pause"));
      if ((GetWindowStyle() & wxPD_CAN_ABORT) != 0)
        state = Continue;
      else
        state = Uncancelable;
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
void dlgProgress::FrameClose(wxCloseEvent& event)
{
  if (state == Uncancelable)
  {
    // Can't close this dialog
    event.Veto(true);
  }
  else if (state == Finished)
  {
    // Let the default handler close the window as we already terminated
    event.Skip();
  }
  else
  {
    // Check the paused state in Uncancelable mode
    if ((GetWindowStyle() & wxPD_CAN_ABORT) != 0)
    // Next Update() will notice it
      state = Canceled;
  }
}
//---------------------------------------------------------------------------


/**
 * Is the user has clicked on Pause ?
 *
 * @return <CODE>true</CODE> if the dialog has been paused, <CODE>false</CODE>
 *         otherwise.
 */
bool dlgProgress::isPaused() const
{
  return state == Paused;
}
//---------------------------------------------------------------------------


/**
 * Updates the label to show the given time (in seconds).
 *
 * @param  val    Time value.
 * @param  label  Label to change (can be <CODE>NULL</CODE>).
 */
void dlgProgress::SetTimeLabel(unsigned long val, wxStaticText* label)
{
  if (label != NULL)
  {
    wxString s;
    unsigned long hours = val / 3600;
    unsigned long minutes = (val % 3600) / 60;
    unsigned long seconds = val % 60;
    s.Printf(wxT("%lu:%02lu:%02lu"), hours, minutes, seconds);

    if (s != label->GetLabel())
      label->SetLabel(s);
  }
}
//---------------------------------------------------------------------------



BEGIN_EVENT_TABLE(dlgProgress, wxDialog)
  EVT_BUTTON(wxID_CANCEL, dlgProgress::btnCancelClick)
  EVT_BUTTON(BTN_PAUSE, dlgProgress::btnPauseClick)
  EVT_CLOSE(dlgProgress::FrameClose)
END_EVENT_TABLE()
//---------------------------------------------------------------------------
