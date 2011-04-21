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
 * \file dlgMultiCheck.cpp
 * Dialog for checking multiple checksums' files.
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
#include <wx/datetime.h>
#include <wx/file.h>
#include <wx/filename.h>

#include <climits>

#include "dlgMultiCheck.hpp"
#include "appprefs.hpp"
#include "bytedisp.hpp"
#include "checksum.hpp"
#include "checksumutil.hpp"
#include "comdefs.hpp"
#include "fileutil.hpp"
#include "osdep.hpp"
#include "sumfile.hpp"
#include "utils.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


IMPLEMENT_DYNAMIC_CLASS(dlgMultiCheck, dlgResultsProgress)


//###########################################################################
// dlgMultiCheck::FilesStatistics methods
//###########################################################################

/**
 * Statistics on the files.
 */
class dlgMultiCheck::FilesStatistics
{
 public:
  int CKTotallyCorrect;    ///< Checksums' files totally corrects.
  int CKPartiallyCorrect;  ///< Checksums' files partially corrects.
  int CKFullyIncorrect;    ///< Checksums' files fully incorrects.
  int CKInvalid;           ///< Invalids Checksums' files.
  int CKNotOpened;         ///< Checksums' files not opened.

  int FCorrect;    ///< Correct checked files.
  int FIncorrect;  ///< Incorrect checked files.
  int FNotFound;   ///< Files not found.
  int FNotOpened;  ///< Files not opened.

  /// Constructor.
  FilesStatistics()
  {
    CKTotallyCorrect = 0;
    CKPartiallyCorrect = 0;
    CKFullyIncorrect = 0;
    CKInvalid = 0;
    CKNotOpened = 0;

    resetCkFiles();
  }
  
  /// Reset checksums' file statics.
  void resetCkFiles()
  {
    FCorrect = 0;
    FIncorrect = 0;
    FNotFound = 0;
    FNotOpened = 0;
  }
  
  /// Gets the total of checked files.
  int getCheckedFilesCount() const
  {
    return FCorrect + FIncorrect + FNotFound + FNotOpened;
  }

  /// Gets the total of checksum's files checked.
  int getChecksumsFilesChecked() const
  {
    return CKTotallyCorrect + CKPartiallyCorrect + CKFullyIncorrect + CKInvalid + CKNotOpened;
  }
  
  /// Says if all the files in the checksums' file are corrects.
  bool allAreCorrects() const
  {
    return FIncorrect == 0 && FNotFound == 0 && FNotOpened == 0;
  }

  /// Says if all the checksums' files are corrects.
  bool allChecksumsFilesAreCorrects() const
  {
    return CKPartiallyCorrect == 0 && CKFullyIncorrect == 0 && CKInvalid == 0 && CKNotOpened == 0;
  }
};
//---------------------------------------------------------------------------



//###########################################################################
// A progression updater for the ChecksumFileCalculator class
//###########################################################################

/**
 * Displays the progression of the process of computing of a checksum.
 */
class dlgMultiCheck::ChecksumProgress : public ::ChecksumProgress
{
 protected:
  BytesDisplayer current;    ///< numbers of preceeded bytes.
  wxTimeSpan     timeSpan;   ///< Time between to updates of the progress dialog.
  wxDateTime     lt;         ///< Last saved time.
  wxDateTime     ct;         ///< Current time.
  dlgMultiCheck* progress;   ///< Progress dialog (don't delete it!).
  
  /// Default constructor. Don't call it.
  ChecksumProgress() { init(); };
  
  // Initializes the instance.
  void init();
  
 public:
  // Constructor.
  ChecksumProgress(dlgMultiCheck* progressDlg, const BytesDisplayer& total);
  
  // Updates the progression of the computing of a checksum.
  virtual void update(size_t read, bool& canceled);
  
  // Indicates that the process is finished (hides the progress dialog).
  void finished();
};
//---------------------------------------------------------------------------


/**
 * Initializes the instance.
 */
void dlgMultiCheck::ChecksumProgress::init()
{
  progress = NULL;
}
//---------------------------------------------------------------------------


/**
 * Constructor.
 *
 * @param  progressDlg Progress dialog to update.
 * @param  total       Total of bytes to process.
 */
dlgMultiCheck::ChecksumProgress::ChecksumProgress(dlgMultiCheck* progressDlg, const BytesDisplayer& total)
{
  init();

  timeSpan = wxTimeSpan(0, 0, 0, UPDATE_PROGRESS_DLG);
  lt = wxDateTime::UNow() - timeSpan;
  progress = progressDlg;

  // Display information
  progress->setReadBytes(current);
  progress->setTotalBytes(total);
}
//---------------------------------------------------------------------------


/**
 * Updates the progression of the computing of a checksum.
 *
 * @param  read      Number of bytes read.
 * @param  canceled  Set it to <CODE>true</CODE> if the user want to cancel
 *                   the calculation. The caller should call it with its value
 *                   set to <CODE>false</CODE>.
 */
void dlgMultiCheck::ChecksumProgress::update(size_t read, bool& canceled)
{
  current += static_cast<unsigned long>(read);
  ct = wxDateTime::UNow();
  if (ct.IsLaterThan(lt))
  {
    progress->setReadBytes(current);
    ::wxYield();
    lt = ct + timeSpan;
  }
  
  // Pause ?
  while (progress->getState() == dlgMultiCheck::paused)
    ::wxYield();
    
  // Canceled ?
  if (progress->getState() == dlgMultiCheck::canceled)
    canceled = true;
}
//---------------------------------------------------------------------------

  
/**
 * Indicates that the process is finished (hides the progress dialog).
 */
void dlgMultiCheck::ChecksumProgress::finished()
{
  progress->setReadBytes(current);
  ::wxYield();
}
//---------------------------------------------------------------------------



//###########################################################################
// dlgMultiCheck methods
//###########################################################################


/// Gauges limits
#define  GAUGE_MAX  SHRT_MAX

/// Gauges limits (double value)
#define  DGAUGE_MAX  static_cast<double>(GAUGE_MAX)
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 */
dlgMultiCheck::dlgMultiCheck() : dlgResultsProgress()
{
  winDisabler = NULL;
  createControls();
}
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 *
 * @param  parent  Parent of the dialog.
 */
dlgMultiCheck::dlgMultiCheck(wxWindow* parent) :
  dlgResultsProgress(parent, -1, _("Check multiple checksums' files"),
     wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
  createControls();
  Fit();
  
  // Change the size of the dialog.
  wxSize s = AppPrefs::get()->readSize(prMC_WINDOW_SIZE);
  if (s.GetWidth() == -1 || s.GetHeight() == -1)
  {
    if (GetParent() != NULL)
      SetSize(GetParent()->GetSize());
  }
  else
    SetSize(s);
  Centre();
  
  Show(true);
  Enable(true);
  ::wxYield();
  #ifdef __WXMAC__
  MacUpdateImmediately();
  #endif
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the dialog.
 */
void dlgMultiCheck::createControls()
{
  // Creates the controls
  wxClientDC dc(txtResults);
  wxSize labelSize(dc.GetCharWidth() * 20, -1);

  wxStaticText* lblCurTotal = new wxStaticText(this, -1, _("Checking:"));
  lblTotal = new wxStaticText(this, -1, wxEmptyString, wxDefaultPosition, 
                              labelSize, wxALIGN_RIGHT | wxST_NO_AUTORESIZE);
  gauTotal = new wxGauge(this, -1, 0, wxDefaultPosition, wxSize(-1, lblTotal->GetSize().GetHeight()),
                         wxGA_HORIZONTAL | wxGA_SMOOTH);
  gauTotal->SetRange(GAUGE_MAX);
  wxStaticText* lblCurChecksumFile = new wxStaticText(this, -1, _("In checksums' file:"));
  lblChecksumFile = new wxStaticText(this, -1, wxEmptyString, wxDefaultPosition, 
                                     labelSize, wxALIGN_RIGHT | wxST_NO_AUTORESIZE);
  gauChecksumFile = new wxGauge(this, -1, 0, wxDefaultPosition, wxSize(-1, lblChecksumFile->GetSize().GetHeight()),
                                wxGA_HORIZONTAL | wxGA_SMOOTH);
  gauChecksumFile->SetRange(GAUGE_MAX);
  wxStaticText* lblCurFile = new wxStaticText(this, -1, _("Current file:"));
  lblFile = new wxStaticText(this, -1, wxEmptyString, wxDefaultPosition, 
                             labelSize, wxALIGN_RIGHT | wxST_NO_AUTORESIZE);
  gauFile = new wxGauge(this, -1, 0, wxDefaultPosition, wxSize(-1, lblFile->GetSize().GetHeight()),
                        wxGA_HORIZONTAL | wxGA_SMOOTH);
  gauFile->SetRange(GAUGE_MAX);

  //-------------------------------------------------------------------------
  // Creates the dialog sizers

  // Progress section
  wxFlexGridSizer* progressSizer = new wxFlexGridSizer(3, CONTROL_SPACE / 2, CONTROL_SPACE);
  infoSizer->Add(progressSizer, 0, wxTOP | wxGROW, 3 * CONTROL_SPACE / 2);
  progressSizer->AddGrowableCol(2);
  progressSizer->Add(lblCurTotal, 0, wxALIGN_CENTER_VERTICAL);
  progressSizer->Add(lblTotal, 0, wxALIGN_CENTER_VERTICAL);
  progressSizer->Add(gauTotal, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
  progressSizer->Add(lblCurChecksumFile, 0, wxALIGN_CENTER_VERTICAL);
  progressSizer->Add(lblChecksumFile, 0, wxALIGN_CENTER_VERTICAL);
  progressSizer->Add(gauChecksumFile, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
  progressSizer->Add(lblCurFile, 0, wxALIGN_CENTER_VERTICAL);
  progressSizer->Add(lblFile, 0, wxALIGN_CENTER_VERTICAL);
  progressSizer->Add(gauFile, 1, wxALIGN_CENTER_VERTICAL | wxGROW);

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();


  //-------------------------------------------------------------------------
  // Initializes the controls
  setFilesToCheck(0);
  setFilesInChecksumsFile(0);
  setTotalBytes(BytesDisplayer(0UL));
}
//---------------------------------------------------------------------------


/**
 * Processes button Cancel.
 *
 * @param  event  The event's parameters
 */
void dlgMultiCheck::btnCancelClick(wxCommandEvent& event)
{
  if (getState() == finished)
  {
    // Save the dialog size.
    AppPrefs::get()->write(prMC_WINDOW_SIZE, GetSize());
  }

  // Let the default handler do the job.
  event.Skip();
}
//---------------------------------------------------------------------------


/**
 * Gets the number of files to check.
 *
 * @return  The number of files to check.
 */
unsigned long dlgMultiCheck::getFilesToCheck() const
{
  return filesToCheck;
}
//---------------------------------------------------------------------------


/**
 * Sets the number of checksums' files to check.
 *
 * @param  nbTotalChecksumsFiles  Number of checksums' files to check.
 */
void dlgMultiCheck::setFilesToCheck(unsigned long nbTotalChecksumsFiles)
{
  filesToCheck = nbTotalChecksumsFiles;
  if (getFileToBeChecked() > getFilesToCheck())
    setFileToBeChecked(getFilesToCheck());

  updateTotalChecksumsFiles();
}
//---------------------------------------------------------------------------


/**
 * Gets the number of the current checksum's file to be check.
 *
 * @return  The number of the current checksum's file to be check.
 */
unsigned long dlgMultiCheck::getFileToBeChecked() const
{
  return fileChecked;
}
//---------------------------------------------------------------------------


/**
 * Sets the number of the current checksum's files to check.
 *
 * @param  nbChecksumsFiles The number of the current checksum's files to check.
 */
void dlgMultiCheck::setFileToBeChecked(unsigned long nbChecksumsFiles)
{
  fileChecked = (getFilesToCheck() >= nbChecksumsFiles) ? nbChecksumsFiles : getFilesToCheck();
  updateTotalChecksumsFiles();
}
//---------------------------------------------------------------------------


/**
 * Gets the number of files in the current checksums' file.
 *
 * @return The number of files in the current checksums' file.
 */
unsigned long dlgMultiCheck::getFilesInChecksumsFile() const
{
  return filesInChecksumsFile;
}
//---------------------------------------------------------------------------


/**
 * Sets the number of files in the current checksums' file.
 *
 * @param  nbTotalInChecksumsFiles  The number of files in the current checksums' file.
 */
void dlgMultiCheck::setFilesInChecksumsFile(unsigned long nbTotalInChecksumsFiles)
{
  filesInChecksumsFile = nbTotalInChecksumsFiles;
  if (getFileInChecksumsFile() > getFilesInChecksumsFile())
    setFileInChecksumsFile(getFilesInChecksumsFile());

  updateFilesInChecksumsFiles();
}
//---------------------------------------------------------------------------

  
/**
 * Gets the number of the current file in the current checksums' file.
 *
 * @return The number of the current file in the current checksums' file.
 */
unsigned long dlgMultiCheck::getFileInChecksumsFile() const
{
  return fileInChecksumsFile;
}
//---------------------------------------------------------------------------


/**
 * Sets the number of the current file in the current checksums' file.
 *
 * @param  nbInChecksumsFiles  The number of the current file in the current checksums' file.
 */
void dlgMultiCheck::setFileInChecksumsFile(unsigned long nbInChecksumsFiles)
{
  fileInChecksumsFile = (getFilesInChecksumsFile() >= nbInChecksumsFiles) ? nbInChecksumsFiles : getFilesInChecksumsFile();
  updateFilesInChecksumsFiles();
}
//---------------------------------------------------------------------------


/**
 * Gets the number of bytes of the current checked file in the current checked checksums' file.
 *
 * @return The number of bytes of the current checked file in the current checked checksums' file.
 */
BytesDisplayer dlgMultiCheck::getTotalBytes() const
{
  return totalBytes;
}
//---------------------------------------------------------------------------


/**
 * Sets the number of bytes of the current checked file in the current checked checksums' file.
 *
 * @param  bytes  The number of bytes of the current checked file in the current checked checksums' file.
 */
void dlgMultiCheck::setTotalBytes(const BytesDisplayer& bytes)
{
  totalBytes = bytes;
  if (getReadBytes().toDouble() > getTotalBytes().toDouble())
    setReadBytes(getTotalBytes());

  updateCurrentCheckedFile();
}
//---------------------------------------------------------------------------


/**
 * Gets the number of bytes read of the current checked file in the current checked checksums' file.
 *
 * @return The number of bytes read of the current checked file in the current checked checksums' file.
 */
BytesDisplayer dlgMultiCheck::getReadBytes() const
{
  return bytesRead;
}
//---------------------------------------------------------------------------


/**
 * Sets the number of bytes read of the current checked file in the current checked checksums' file.
 *
 * @param  bytes  The number of bytes read of the current checked file in the current checked checksums' file.
 */
void dlgMultiCheck::setReadBytes(const BytesDisplayer& bytes)
{
  bytesRead = (getTotalBytes().toDouble() >= bytes.toDouble()) ? bytes : getTotalBytes();
  updateCurrentCheckedFile();
}
//---------------------------------------------------------------------------


/**
 * Update the information of the total of the checksums' files to be checked.
 */
void dlgMultiCheck::updateTotalChecksumsFiles()
{
  lblTotal->SetLabel(wxString::Format(_("%d/%d"), getFileToBeChecked(), getFilesToCheck()));
  double gauTotalValue = (getFileToBeChecked() > 0) ? static_cast<double>(getFileToBeChecked() - 1) : 0.0;

  if (getFilesToCheck() > 0)
    gauTotal->SetValue(static_cast<int>(gauTotalValue * DGAUGE_MAX / static_cast<double>(getFilesToCheck())));
  else
    gauTotal->SetValue(0);

  // Refresh the dialog
  refreshDialog();
}
//---------------------------------------------------------------------------


/**
 * Update the information of the files in the checksums' files to be checked.
 */
void dlgMultiCheck::updateFilesInChecksumsFiles()
{
  lblChecksumFile->SetLabel(wxString::Format(_("%d/%d"), getFileInChecksumsFile(), getFilesInChecksumsFile()));
  double gauChecksumFileValue = (getFileInChecksumsFile() > 0) ? static_cast<double>(getFileInChecksumsFile() - 1) : 0.0;

  if (getFilesInChecksumsFile() > 0)
    gauChecksumFile->SetValue(static_cast<int>(gauChecksumFileValue * DGAUGE_MAX / static_cast<double>(getFilesInChecksumsFile())));
  else
    gauChecksumFile->SetValue(0);

  // Refresh the dialog
  refreshDialog();

}
//---------------------------------------------------------------------------


/**
 * Update the information of the current checked file.
 */
void dlgMultiCheck::updateCurrentCheckedFile()
{
  // Updating current file label
  lblFile->SetLabel(wxString::Format(_("%s/%s"), getReadBytes().toString().c_str(), getTotalBytes().toString().c_str()));

  // Computing gauges initial values (in interval [0.0...1.0])
  double gauFileValue = (getTotalBytes().toDouble() > 0.0) ? getReadBytes().toDouble() / getTotalBytes().toDouble() : 0.0;

  double gauChecksumFileValue = (getFileInChecksumsFile() > 0) ? static_cast<double>(getFileInChecksumsFile() - 1) : 0.0;
  gauChecksumFileValue += gauFileValue;
  gauChecksumFileValue = (getFilesInChecksumsFile() > 0) ? gauChecksumFileValue / static_cast<double>(getFilesInChecksumsFile()) : 0.0;

  double gauTotalValue = (getFileToBeChecked() > 0) ? static_cast<double>(getFileToBeChecked() - 1) : 0.0;
  gauTotalValue += gauChecksumFileValue;
  gauTotalValue = (getFilesToCheck() > 0) ? gauTotalValue / static_cast<double>(getFilesToCheck()) : 0.0;

  // Changing gauges values
  int intFileValue = static_cast<int>(gauFileValue * DGAUGE_MAX);
  int intChecksumFile = static_cast<int>(gauChecksumFileValue * DGAUGE_MAX);
  int intTotal = static_cast<int>(gauTotalValue * DGAUGE_MAX);

  if (gauFile->GetValue() != intFileValue)
    gauFile->SetValue(intFileValue);
  if (gauChecksumFile->GetValue() != intChecksumFile)
    gauChecksumFile->SetValue(intChecksumFile);
  if (gauTotal->GetValue() != intTotal)
    gauTotal->SetValue(intTotal);

  // Refresh the dialog
  refreshDialog();
}
//---------------------------------------------------------------------------


/**
 * Checks a file.
 *
 * @param  fileName  Name of the file to check.
 * @param  cc        Checksum calculator.
 * @param  checksum  Checksum of the file stored in the checksums' file.
 * @param  dlgPrg    Progress dialog to update.
 * @param  stats     Statistics on the files.
 */
void dlgMultiCheck::checkFile(const wxFileName& fileName, Checksum* cc, const wxString& checksum, dlgMultiCheck& dlgPrg, FilesStatistics& stats)
{
  wxCOff_t       fs;      // rest of the file size to read.
  BytesDisplayer total;   // total of bytes to process.
  ChecksumFileCalculator::State retState;  // state returned by the checksum' calculator.

  fs = wxCGetFileLength(fileName.GetFullPath());  // get the length of the file to read
  total = (fs == static_cast<wxCOff_t>(wxInvalidOffset)) ? 0.0 : static_cast<double>(fs);

  ChecksumProgress progressUpdater(&dlgPrg, total);
  ChecksumFileCalculator cfc(cc, &progressUpdater);

  // Check the file.
  retState = cfc.check(fileName.GetFullPath(), checksum);

  // Update the progress dialog
  progressUpdater.finished();

  switch (retState)
  {
    case ChecksumFileCalculator::Ok :              // Checksum has been calculated (and corresponds for the check method).
      stats.FCorrect++;
      if (AppPrefs::get()->readBool(prMC_FILE_STATE))
        if (AppPrefs::get()->readBool(prMC_NO_CORRECT_FILE_STATE))
          dlgPrg.removeLastResultLine();
        else
          dlgPrg.replaceLastResultLine(wxString::Format(_("'%s': OK\n"), fileName.GetFullPath().c_str()), 1U, getColour(prMC_SUCCESS_COLOUR));
      break;

    case ChecksumFileCalculator::Invalid :         // Checksum has been verified and not corresponds.
      stats.FIncorrect++;
      if (AppPrefs::get()->readBool(prMC_FILE_STATE))
        dlgPrg.replaceLastResultLine(wxString::Format(_("'%s': Checksums differ\n"), fileName.GetFullPath().c_str()), 1U, getColour(prMC_ERROR_COLOUR));
      break;

    case ChecksumFileCalculator::ReadError :       // Error while reading the stream.
      stats.FNotFound++;
      if (AppPrefs::get()->readBool(prMC_FILE_STATE))
        dlgPrg.replaceLastResultLine(wxString::Format(_("Error while reading '%s'.\n"), fileName.GetFullPath().c_str()), 1U, getColour(prMC_ERROR_COLOUR));
      break;

    case ChecksumFileCalculator::FileNotFound :    // The file has been not found.
      stats.FNotFound++;
      if (AppPrefs::get()->readBool(prMC_FILE_STATE))
        dlgPrg.replaceLastResultLine(wxString::Format(_("'%s': File not found\n"), fileName.GetFullPath().c_str()), 1U, getColour(prMC_ERROR_COLOUR));
      break;

    case ChecksumFileCalculator::CantOpenFile :    // Can't open the stream.
      stats.FNotOpened++;
      if (AppPrefs::get()->readBool(prMC_FILE_STATE))
        dlgPrg.replaceLastResultLine(wxString::Format(_("'%s': File cannot be opened\n"), fileName.GetFullPath().c_str()), 1U, getColour(prMC_ERROR_COLOUR));
      break;

//    case ChecksumFileCalculator::CanceledByUser :  // User has canceled the calculation.
  }
}
//---------------------------------------------------------------------------


/**
 * Checks multiple checksums' files.
 *
 * @param  files   List of the checksums' files to check.
 * @param  parent  Parent of the dialog that will be created.
 */
void dlgMultiCheck::checkChecksumsFiles(const wxArrayString& files, wxWindow* parent)
{
  FilesStatistics fstats;
  dlgMultiCheck dlgPrg(parent);
  SumFile* sumFile;
  wxFile   file;
  size_t   i, j;
  wxString msg;

  // Some compilers don't like the ? : structure in function call, so using
  // this variable to store the result of ? : before the call.
  // Note : some versions of Borland C++ don't like nested ? : so using if else.
  wxColour colour;

  // No log
  wxLogNull logNo;

  dlgPrg.setFilesToCheck(files.GetCount());
  i = 0;
  while (i < files.GetCount() && dlgPrg.canContinue())
  {
    // Display information
    dlgPrg.addResultLine(wxString::Format(_("Checking '%s'.\n"), files[i].c_str()), 0U, getColour(prMC_NORMAL_COLOUR));
    dlgPrg.setFileToBeChecked(i + 1);

    // Try to open the file
    if (file.Open(files[i], wxFile::read))
    {
      file.Close();
      sumFile = ::openChecksumFile(files[i]);
      if (sumFile != NULL)
      {
        // Gets the name of the checksums' file.
        wxFileName sumFileName(sumFile->getFileName());
        
        // Set the number of files in this checksums' file.
        dlgPrg.setFilesInChecksumsFile(sumFile->getChecksumDataCount());

        // Gets a checksum calculator for this checksums' file.
        Checksum* cc = sumFile->getChecksumCalculator();
        
        // Checking each file.
        fstats.resetCkFiles();
        j = 1;
        MChecksumData::const_iterator it = sumFile->getChecksumDataBegin();
        while (it != sumFile->getChecksumDataEnd() && dlgPrg.canContinue())
        {
          // Get the absolute name of the file to check.
          wxFileName fn(it->second.getFileName());
          fn.MakeAbsolute(sumFileName.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
          
          // Update the dialog
          dlgPrg.setFileInChecksumsFile(j);
          msg.Printf(_("Checking '%s'...\n"), fn.GetFullPath().c_str());
          if (it == sumFile->getChecksumDataBegin() || AppPrefs::get()->readBool(prMC_FILE_STATE))
            dlgPrg.addResultLine(msg, 1U, getColour(prMC_NORMAL_COLOUR));
          else
            dlgPrg.replaceLastResultLine(msg, 1U, getColour(prMC_NORMAL_COLOUR));

          // Check the file.
          checkFile(fn, cc, it->second.getChecksum(), dlgPrg, fstats);

          it++;
          j++;
        }

        // Display the summary of the checksums' file.
        if (dlgPrg.canContinue())
        {
          if (sumFile->getChecksumDataCount() > 0)
          {
            // Remove the last line if the status of each file is NOT displayed
            if (!AppPrefs::get()->readBool(prMC_FILE_STATE))
              dlgPrg.removeLastResultLine();
            
            if (AppPrefs::get()->readBool(prMC_CHECKSUMS_FILE_SUMMARY))
            {
              if (AppPrefs::get()->readBool(prMC_FILE_STATE))
                dlgPrg.addResultLine(wxT("\n"));
              dlgPrg.addResultLine(wxString::Format(_("Total checked: %d\n"), fstats.getCheckedFilesCount()), 0U, getColour(prMC_NORMAL_COLOUR));
              if (fstats.allAreCorrects()) colour = getColour(prMC_SUCCESS_COLOUR); else if (fstats.FCorrect > 0) colour = getColour(prMC_WARNING_COLOUR); else colour = getColour(prMC_ERROR_COLOUR);
              dlgPrg.addResultLine(wxString::Format(_("Correct(s): %d\n"), fstats.FCorrect), 1U, colour);
              colour = (fstats.FIncorrect == 0) ? getColour(prMC_SUCCESS_COLOUR) : getColour(prMC_ERROR_COLOUR);
              dlgPrg.addResultLine(wxString::Format(_("Incorrect(s): %d\n"), fstats.FIncorrect), 1U, colour);
              colour = (fstats.FNotFound == 0) ? getColour(prMC_SUCCESS_COLOUR) : getColour(prMC_ERROR_COLOUR);
              dlgPrg.addResultLine(wxString::Format(_("Not found: %d\n"), fstats.FNotFound), 1U, colour);
              colour = (fstats.FNotOpened == 0) ? getColour(prMC_SUCCESS_COLOUR) : getColour(prMC_ERROR_COLOUR);
              dlgPrg.addResultLine(wxString::Format(_("Not opened: %d\n"), fstats.FNotOpened), 1U, colour);

              if (AppPrefs::get()->readBool(prMC_FILE_STATE))
                dlgPrg.addResultLine(wxT("\n"));
            }
            else
            {
              if (fstats.allAreCorrects())
                dlgPrg.addResultLine(_("All checksums are corrects.\n"), 0U, getColour(prMC_SUCCESS_COLOUR));
              else
                dlgPrg.addResultLine(_("Some checksums are incorrects.\n"), 0U, getColour(prMC_ERROR_COLOUR));
            }
          }
          else
            dlgPrg.addResultLine(wxString::Format(_("'%s' is empty.\n"), files[i].c_str()), 0U, getColour(prMC_WARNING_COLOUR));
        }

        delete cc;
        delete sumFile;
        
        // Updates statistics of checksums' files.
        if (fstats.allAreCorrects())
          fstats.CKTotallyCorrect++;
        else
          if (fstats.FCorrect == 0)
            fstats.CKFullyIncorrect++;
          else
            fstats.CKPartiallyCorrect++;
      }
      else  // the file can't be open
      {
        dlgPrg.addResultLine(wxString::Format(_("'%s' is not a valid checksums' file.\n"), files[i].c_str()), 0U, getColour(prMC_ERROR_COLOUR));
        fstats.CKInvalid++;
      }
    }
    else
    {
      dlgPrg.addResultLine(wxString::Format(_("'%s' cannot be opened.\n"), files[i].c_str()), 0U, getColour(prMC_ERROR_COLOUR));
      fstats.CKNotOpened++;
    }

    dlgPrg.addResultLine(wxT("\n"));

    i++;
  }

  if (dlgPrg.getState() != canceled)
  {
    // Display the global summary.
    if (AppPrefs::get()->readBool(prMC_GLOBAL_SUMMARY))
    {
      dlgPrg.addResultLine(wxString::Format(_("Total checksums' files checked: %d\n"), fstats.getChecksumsFilesChecked()), 0U, getColour(prMC_NORMAL_COLOUR));
      if (fstats.allChecksumsFilesAreCorrects()) colour = getColour(prMC_SUCCESS_COLOUR); else if (fstats.CKTotallyCorrect > 0) colour = getColour(prMC_WARNING_COLOUR); else colour = getColour(prMC_ERROR_COLOUR);
      dlgPrg.addResultLine(wxString::Format(_("Correct(s): %d\n"), fstats.CKTotallyCorrect), 1U, colour);
      colour = (fstats.CKPartiallyCorrect == 0) ? getColour(prMC_SUCCESS_COLOUR) : getColour(prMC_ERROR_COLOUR);
      dlgPrg.addResultLine(wxString::Format(_("Partially correct(s): %d\n"), fstats.CKPartiallyCorrect), 1U, colour);
      colour = (fstats.CKFullyIncorrect == 0) ? getColour(prMC_SUCCESS_COLOUR) : getColour(prMC_ERROR_COLOUR);
      dlgPrg.addResultLine(wxString::Format(_("Fully incorrect(s): %d\n"), fstats.CKFullyIncorrect), 1U, colour);
      colour = (fstats.CKInvalid == 0) ? getColour(prMC_SUCCESS_COLOUR) : getColour(prMC_ERROR_COLOUR);
      dlgPrg.addResultLine(wxString::Format(_("Invalid(s): %d\n"), fstats.CKInvalid), 1U, colour);
      colour = (fstats.CKNotOpened == 0) ? getColour(prMC_SUCCESS_COLOUR) : getColour(prMC_ERROR_COLOUR);
      dlgPrg.addResultLine(wxString::Format(_("Not opened: %d\n"), fstats.CKNotOpened), 1U, colour);
    }
    else
    {
      if (fstats.allChecksumsFilesAreCorrects())
        dlgPrg.addResultLine(_("All checksums' files are corrects.\n"), 0U, getColour(prMC_SUCCESS_COLOUR));
      else
        dlgPrg.addResultLine(_("Some checksums' files are incorrects.\n"), 0U, getColour(prMC_ERROR_COLOUR));
    }
    
    dlgPrg.Finished();
  }
}
//---------------------------------------------------------------------------


BEGIN_EVENT_TABLE(dlgMultiCheck, dlgResultsProgress)
  EVT_BUTTON(wxID_CANCEL, dlgMultiCheck::btnCancelClick)
END_EVENT_TABLE()
//---------------------------------------------------------------------------
