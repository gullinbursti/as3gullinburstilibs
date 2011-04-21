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
 * \file dlgProgress.hpp
 * Progress dialog.
 */

#ifndef INC_DLGPROGRESS_HPP
#define INC_DLGPROGRESS_HPP

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
 * Progress dialog which shows a moving progress bar.
 * Taken from wxWidgets.
 */
class dlgProgress : public wxDialog
{
 public:
  // Creates and displays dialog
  dlgProgress(const wxString& title, const wxString& message,
              int maximum = 100, wxWindow* parent = NULL,
              int style = wxPD_APP_MODAL | wxPD_AUTO_HIDE);

  // Destructor.
  virtual ~dlgProgress();

  // Creates and initializes the controls of the dialog.
  void createControls(const wxString& message = wxEmptyString);

 protected:
  wxWindowDisabler* winDisabler;  ///< Disable all others windows (for wxPD_APP_MODAL case).
  wxGauge*      gauProgress;   ///< Progress bar.
  wxStaticText* lblMessage;    ///< The message displayed.
  wxStaticText* lblElapsed;    ///< Elapsed time.
  wxStaticText* lblEstimated;  ///< Estimated time.
  wxStaticText* lblRemaining;  ///< Remaining time.
  wxButton*     btnCancel;     ///< Cancel and close button.
  wxButton*     btnPause;      ///< Pause button

  // Processes button Cancel.
  void btnCancelClick(wxCommandEvent& event);
  // Processes button Pause.
  void btnPauseClick(wxCommandEvent& event);

  // Event handler to respond to system close events.
  void FrameClose(wxCloseEvent& event);


  /// Controls IDs
  enum
  {
    BTN_PAUSE
  };

  DECLARE_EVENT_TABLE()

 protected:
  // Must be called to reenable the other windows temporarily disabled while
  // the dialog was shown.
  void ReenableOtherWindows();

  /// Continue processing or not (return value for Update()).
  enum State
  {
    Uncancelable = -1,  // dialog can't be canceled
    Paused,             // paused, can be cancelled
    Canceled,           // can be cancelled and, in fact, was
    Continue,           // can be cancelled but wasn't
    Finished            // finished, waiting to be removed from screen
  } state;

  wxWindow*     ctrParentTop;  ///< Parent top level window (may be NULL).
  unsigned long timeStart;     ///< Time when the dialog was created.
  int           maximum;       ///< The maximum value
  #if defined(__WXMSW__ ) || defined(__WXPM__)
  // The factor we use to always keep the value in 16 bit range as the native
  // control only supports ranges from 0 to 65,535.
  size_t factor;  ///< The factor we use to always keep the value in 16 bit range.
  #endif // __WXMSW__
 
 private:
  /// Virtual function hiding supression.
  virtual void Update() { wxDialog::Update(); }

 public:
  // Updates the status bar to the new value.
  bool Update(int value, const wxString& newmsg = wxEmptyString);

  // Can be called to continue after the cancel button has been pressed.
  void Resume();

  // Shows the dialog.
  bool Show(bool show = true);
  
  // Is the user has clicked on Pause ?
  bool isPaused() const;

 protected:
  // Update the label to show the given time (in seconds).
  void SetTimeLabel(unsigned long val, wxStaticText* label);

 private:
  DECLARE_DYNAMIC_CLASS(dlgProgress)

  /// Default constructor. Don't use it.
  dlgProgress::dlgProgress() : wxDialog() {}
};
//---------------------------------------------------------------------------

#endif  // INC_DLGPROGRESS_HPP
