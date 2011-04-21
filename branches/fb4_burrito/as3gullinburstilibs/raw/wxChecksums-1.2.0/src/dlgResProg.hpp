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
 * \file dlgResProg.hpp
 * Template for progress dialogs which display textual informations.
 */

#ifndef INC_DLGRESPROG_HPP
#define INC_DLGRESPROG_HPP

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

#include "appprefs.hpp"
//---------------------------------------------------------------------------


/**
 * Template for progress dialogs which display textual informations.
 *
 * To use it, follow these steps:
 * <UL>
 *   <LI>Make a subclass.</LI>
 *   <LI>Don't forget to call the dlgResultsProgress contructors.</LI>
 * </UL>
 */
class dlgResultsProgress : public wxDialog
{
 public:
  // Creates a new dialog.
  dlgResultsProgress();

  // Creates a new dialog.
  dlgResultsProgress(wxWindow* parent, wxWindowID id, const wxString& title,
                     const wxPoint& pos = wxDefaultPosition, 
                     const wxSize& size = wxDefaultSize,
                     long  style = wxDEFAULT_DIALOG_STYLE,
                     const wxString& name = wxT("ResultsProgressDialog"));

  // Destructor.
  virtual ~dlgResultsProgress();

  // Creates and initializes the controls of the dialog.
  void createControls();

  // Hides or shows the dialog.
  virtual bool Show(bool show = true);

 protected:
  wxWindowDisabler* winDisabler;  ///< Disable all others windows.
  wxButton*     btnCancel;        ///< Cancel and close button.
  wxButton*     btnPause;         ///< Pause button
  wxTextCtrl*   txtResults;       ///< Text control used to display results.
  wxBoxSizer*   infoSizer;        ///< Sizer where informatives controls should be added.

  // Processes button Cancel.
  void btnCancelClick(wxCommandEvent& event);
  // Processes button Pause.
  void btnPauseClick(wxCommandEvent& event);

  // Event handler to respond to system close events.
  void FrameClose(wxCloseEvent& event);


  /// Controls IDs
  enum
  {
    TXT_RESULTS = wxID_HIGHEST + 1,
    BTN_PAUSE
  };

  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(dlgResultsProgress)
  
 protected:
  // Reenables the others windows.
  void reenableOtherWindows();

 // Dialog's state management.
 public:
  /// States of the dialog.
  enum State
  {
    running = 1,
    paused,
    canceled,
    finished
  };

 protected: 
  State          state;  ///< Dialog state.

 public:
  // Says to the dialog that the process is finished.
  void Finished();

  // Gets the dialog state.
  State getState() const;

  // Says if the process can continue.
  virtual bool canContinue() const;

 protected:
  // Sets the dialog state.
  void setState(State newState);
  
  // Refresh the dialog.
  void refreshDialog();


  // Results management
  long lastInsertedPos;  ///< Last inserted position.
  long lastInsertedWidth;  ///< Last inserted width.
 
 public:
  // Adds a line to the results.
  void addResultLine(const wxString& text, const unsigned int indentation = 0, const wxColour& colour = *wxBLACK);

  // Replace the last inserted result line.
  void replaceLastResultLine(const wxString& text, const unsigned int indentation = 0, const wxColour& colour = *wxBLACK);

  // Remove the last inserted result line.
  void removeLastResultLine();

 protected:
  /// Virtual function hiding supression
  virtual void Update() { wxDialog::Update(); }
  
 protected:
  static wxColour getColour(PreferencesKeys pk);
};
//---------------------------------------------------------------------------

#endif  // INC_DLGRESPROG_HPP
