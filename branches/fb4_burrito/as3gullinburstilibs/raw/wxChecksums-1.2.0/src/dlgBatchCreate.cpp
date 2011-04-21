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
 * \file dlgBatchCreate.cpp
 * Dialog for creating one checksums' file for each selected file.
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
#include <wx/filename.h>

#include <climits>

#include "dlgBatchCreate.hpp"
#include "appprefs.hpp"
#include "bytedisp.hpp"
#include "checksum.hpp"
#include "checksumfactory.hpp"
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


//###########################################################################
// dlgBatchCreation::Options methods
//###########################################################################

/**
 * Facility constructor.
 *
 * @param  iOvrCkFileWhenItExists  If <CODE>true</CODE>, when a checksums' file
 *                                 already exists it is overwritten. Otherwise
 *                                 the creation of the checksums' file is
 *                                 skipped.
 * @param  iReplaceExtension       If <CODE>true</CODE> the name of the
 *                                 checksums' file will be made by replacing the
 *                                 extension of the source file with the
 *                                 extension of the type of the checksums' file.
 *                                 Otherwise, the name of the checksums' file
 *                                 will be made by adding the extension of the
 *                                 type of checksums' file to the name of the
 *                                 source file.
 * @param  iVerbosity              Report's Verbosity.
 */
dlgBatchCreation::Options::Options(const bool iOvrCkFileWhenItExists,
                                   const bool iReplaceExtension,
                                   const dlgBatchCreation::Verbosity iVerbosity)
{
  // Put an initial value in case iVerbosity contains a bad value.
  verbosity = dlgBatchCreation::vNormal;
  setVerbosity(iVerbosity);
  ovrCkFileWhenItExists = iOvrCkFileWhenItExists;
  replaceExtension = iReplaceExtension;
}
//---------------------------------------------------------------------------


/**
 * Gets the report's verbosity.
 *
 * @return The report's verbosity.
 */
dlgBatchCreation::Verbosity dlgBatchCreation::Options::getVerbosity() const
{
  return verbosity;
}
//---------------------------------------------------------------------------


/**
 * Sets the report's verbosity.
 *
 * If the given parameter has an invalid value, the value of the instance isn't
 * changed.
 *
 * @param  newVerbosity  The new verbosity of the report.
 */
void dlgBatchCreation::Options::setVerbosity(const dlgBatchCreation::Verbosity newVerbosity)
{
  if (newVerbosity >= Verbosity_Min && newVerbosity <= Verbosity_Max)
    verbosity = newVerbosity;
}
//---------------------------------------------------------------------------



//###########################################################################
// dlgBatchCreation::FilesStatistics methods
//###########################################################################

/**
 * Statistics on the files.
 */
class dlgBatchCreation::FilesStatistics
{
 public:
  unsigned int FCorrect;    ///< Correct read files.
  unsigned int FReadError;  ///< Errors while reading the file.
  unsigned int FNotFound;   ///< Files not found.
  unsigned int FNotOpened;  ///< Files not opened.
  unsigned int FSkipped;    ///< Files skipped.

  unsigned int CKSkipped;      ///< Checksums' files skipped.
  unsigned int CKOverwritten;  ///< Checksums' files overwritten.
  unsigned int CKCreated;      ///< Checksums' files created.
  unsigned int CKWriteError;   ///< Errors while writing the checksums' file.

  /// Constructor.
  FilesStatistics()
  {
    FCorrect = 0;
    FReadError = 0;
    FNotFound = 0;
    FNotOpened = 0;
    FSkipped = 0;
    CKSkipped = 0;
    CKOverwritten = 0;
    CKCreated = 0;
    CKWriteError = 0;
  }
  
  /// Gets the total of checksum's files checked.
  int getNbProcessedFiles() const
  {
    return FCorrect + FReadError + FNotFound + FNotOpened + FSkipped;
  }
  
  /// Says if all the files in the checksums' file are corrects.
  bool allFileAreCorrects() const
  {
    return FReadError == 0 && FNotFound == 0 && FNotOpened == 0;
  }

  /// Gets the number of checksums' files written
  int getNbProcessedChecksumsFiles() const
  {
    return CKOverwritten + CKCreated + CKSkipped + CKWriteError;
  }

  /// Says if all the checksums' files are corrects.
  bool allChecksumsFilesAreCorrects() const
  {
    return CKWriteError == 0;
  }
};
//---------------------------------------------------------------------------



//###########################################################################
// A progression updater for the ChecksumFileCalculator class
//###########################################################################

/**
 * Displays the progression of the process of computing of a checksum.
 */
class dlgBatchCreation::ChecksumProgress : public ::ChecksumProgress
{
 protected:
  BytesDisplayer current;    ///< numbers of preceeded bytes.
  wxTimeSpan     timeSpan;   ///< Time between to updates of the progress dialog.
  wxDateTime     lt;         ///< Last saved time.
  wxDateTime     ct;         ///< Current time.
  dlgBatchCreation* progress;   ///< Progress dialog (don't delete it!).
  
  /// Default constructor. Don't call it.
  ChecksumProgress() { init(); };
  
  // Initializes the instance.
  void init();
  
 public:
  // Constructor.
  ChecksumProgress(dlgBatchCreation* progressDlg, const BytesDisplayer& total);
  
  // Updates the progression of the computing of a checksum.
  virtual void update(size_t read, bool& canceled);
  
  // Indicates that the process is finished (hides the progress dialog).
  void finished();
};
//---------------------------------------------------------------------------


/**
 * Initializes the instance.
 */
void dlgBatchCreation::ChecksumProgress::init()
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
dlgBatchCreation::ChecksumProgress::ChecksumProgress(dlgBatchCreation* progressDlg, const BytesDisplayer& total)
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
void dlgBatchCreation::ChecksumProgress::update(size_t read, bool& canceled)
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
  while (progress->getState() == dlgBatchCreation::paused)
    ::wxYield();
    
  // Canceled ?
  if (progress->getState() == dlgBatchCreation::canceled)
    canceled = true;
}
//---------------------------------------------------------------------------

  
/**
 * Indicates that the process is finished (hides the progress dialog).
 */
void dlgBatchCreation::ChecksumProgress::finished()
{
  progress->setReadBytes(current);
  ::wxYield();
}
//---------------------------------------------------------------------------



//###########################################################################
// dlgBatchCreation methods
//###########################################################################

IMPLEMENT_DYNAMIC_CLASS(dlgBatchCreation, dlgResultsProgress)


/// Gauges limits
#define  GAUGE_MAX  SHRT_MAX

/// Gauges limits (double value)
#define  DGAUGE_MAX  static_cast<double>(GAUGE_MAX)
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 */
dlgBatchCreation::dlgBatchCreation() : dlgResultsProgress()
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
dlgBatchCreation::dlgBatchCreation(wxWindow* parent) :
  dlgResultsProgress(parent, -1, _("Batch creation of checksums' files"),
     wxDefaultPosition, wxDefaultSize, wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
  createControls();
  Fit();
  
  // Change the size of the dialog.
  wxSize s = AppPrefs::get()->readSize(prBC_WINDOW_SIZE);
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
void dlgBatchCreation::createControls()
{
  // Creates the controls
  wxClientDC dc(txtResults);
  wxSize labelSize(dc.GetCharWidth() * 20, -1);

  wxStaticText* lblCurTotal = new wxStaticText(this, -1, _("Creating:"));
  lblTotal = new wxStaticText(this, -1, wxEmptyString, wxDefaultPosition, 
                              labelSize, wxALIGN_RIGHT | wxST_NO_AUTORESIZE);
  gauTotal = new wxGauge(this, -1, 0, wxDefaultPosition, wxSize(-1, lblTotal->GetSize().GetHeight()),
                         wxGA_HORIZONTAL | wxGA_SMOOTH);
  gauTotal->SetRange(GAUGE_MAX);
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
  progressSizer->Add(lblCurFile, 0, wxALIGN_CENTER_VERTICAL);
  progressSizer->Add(lblFile, 0, wxALIGN_CENTER_VERTICAL);
  progressSizer->Add(gauFile, 1, wxALIGN_CENTER_VERTICAL | wxGROW);

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();


  //-------------------------------------------------------------------------
  // Initializes the controls
  setFilesToProcess(0);
  setTotalBytes(BytesDisplayer(0UL));
}
//---------------------------------------------------------------------------


/**
 * Processes button Cancel.
 *
 * @param  event  The event's parameters
 */
void dlgBatchCreation::btnCancelClick(wxCommandEvent& event)
{
  if (getState() == finished)
  {
    // Save the dialog size.
    AppPrefs::get()->write(prBC_WINDOW_SIZE, GetSize());
  }

  // Let the default handler do the job.
  event.Skip();
}
//---------------------------------------------------------------------------


/**
 * Gets the number of files to process.
 *
 * @return  The number of files to process.
 */
unsigned long dlgBatchCreation::getFilesToProcess() const
{
  return filesToProcess;
}
//---------------------------------------------------------------------------


/**
 * // Sets the number of files to process.
 *
 * @param  nbTotalFiles  Number of files to process.
 */
void dlgBatchCreation::setFilesToProcess(unsigned long nbTotalFiles)
{
  filesToProcess = nbTotalFiles;
  if (getFileToBeProcessed() > getFilesToProcess())
    setFileToBeProcessed(getFilesToProcess());

  updateTotalFiles();
}
//---------------------------------------------------------------------------


/**
 * Gets the number of the current file to be processed.
 *
 * @return  The number of the current file to be processed.
 */
unsigned long dlgBatchCreation::getFileToBeProcessed() const
{
  return fileProcessed;
}
//---------------------------------------------------------------------------


/**
 * Sets the number of the file to be processed.
 *
 * @param  nbFiles The number of the current file to process.
 */
void dlgBatchCreation::setFileToBeProcessed(unsigned long nbFiles)
{
  fileProcessed = (getFilesToProcess() >= nbFiles) ? nbFiles : getFilesToProcess();
  updateTotalFiles();
}
//---------------------------------------------------------------------------


/**
 * Gets the number of bytes of the current processed file.
 *
 * @return The number of bytes of the current processed file.
 */
BytesDisplayer dlgBatchCreation::getTotalBytes() const
{
  return totalBytes;
}
//---------------------------------------------------------------------------


/**
 * Sets the number of bytes of the current processed file.
 *
 * @param  bytes  The number of bytes of the current processed file.
 */
void dlgBatchCreation::setTotalBytes(const BytesDisplayer& bytes)
{
  totalBytes = bytes;
  if (getReadBytes().toDouble() > getTotalBytes().toDouble())
    setReadBytes(getTotalBytes());

  updateCurrentProcessedFile();
}
//---------------------------------------------------------------------------


/**
 * Gets the number of bytes read of the current processed file.
 *
 * @return The number of bytes read of the current processed file.
 */
BytesDisplayer dlgBatchCreation::getReadBytes() const
{
  return bytesRead;
}
//---------------------------------------------------------------------------


/**
 * Sets the number of bytes read of the current processed file.
 *
 * @param  bytes  The number of bytes read of the current processed file.
 */
void dlgBatchCreation::setReadBytes(const BytesDisplayer& bytes)
{
  bytesRead = (getTotalBytes().toDouble() >= bytes.toDouble()) ? bytes : getTotalBytes();
  updateCurrentProcessedFile();
}
//---------------------------------------------------------------------------


/**
 * Update the information of the total of the files to be processed.
 */
void dlgBatchCreation::updateTotalFiles()
{
  lblTotal->SetLabel(wxString::Format(_("%d/%d"), getFileToBeProcessed(), getFilesToProcess()));
  double gauTotalValue = (getFileToBeProcessed() > 0) ? static_cast<double>(getFileToBeProcessed() - 1) : 0.0;

  if (getFilesToProcess() > 0)
    gauTotal->SetValue(static_cast<int>(gauTotalValue * DGAUGE_MAX / static_cast<double>(getFilesToProcess())));
  else
    gauTotal->SetValue(0);

  // Refresh the dialog
  refreshDialog();
}
//---------------------------------------------------------------------------


/**
 * Update the information of the current processed file.
 */
void dlgBatchCreation::updateCurrentProcessedFile()
{
  // Updating current file label
  lblFile->SetLabel(wxString::Format(_("%s/%s"), getReadBytes().toString().c_str(), getTotalBytes().toString().c_str()));

  // Computing gauges initial values (in interval [0.0...1.0])
  double gauFileValue = (getTotalBytes().toDouble() > 0.0) ? getReadBytes().toDouble() / getTotalBytes().toDouble() : 0.0;

  double gauTotalValue = (getFileToBeProcessed() > 0) ? static_cast<double>(getFileToBeProcessed() - 1) : 0.0;
  gauTotalValue += gauFileValue;
  gauTotalValue = (getFilesToProcess() > 0) ? gauTotalValue / static_cast<double>(getFilesToProcess()) : 0.0;

  // Changing gauges values
  int intFileValue = static_cast<int>(gauFileValue * DGAUGE_MAX);
  int intTotal = static_cast<int>(gauTotalValue * DGAUGE_MAX);

  if (gauFile->GetValue() != intFileValue)
    gauFile->SetValue(intFileValue);
  if (gauTotal->GetValue() != intTotal)
    gauTotal->SetValue(intTotal);

  // Refresh the dialog
  refreshDialog();
}
//---------------------------------------------------------------------------


/**
 * Gets the names of the checksums' files to create.
 *
 * @param  srcFileName  Name of the source file.
 * @param  options      Options for the batch creation of the checksums' files.
 * @param  ckSumsTypes  Array of checksums' file types to create.
 * @return A array of strings which contains the names of the checksums' files
 *         to create.
 */
wxArrayString dlgBatchCreation::getChecksumsFileNames(const wxString& srcFileName,
                                                      const dlgBatchCreation::Options& options,
                                                      const wxArrayInt& ckSumsTypes)
{
  wxArrayString res;
  
  for (size_t i = 0; i < ckSumsTypes.GetCount(); i++)
  {
    if (options.replaceExtension)
    {
      wxFileName fn(srcFileName);
      fn.SetExt(SumFileFactory::getSumFileExtension(ckSumsTypes[i]));
      res.Add(fn.GetFullPath());
    }
    else
      res.Add(srcFileName + wxT('.') + SumFileFactory::getSumFileExtension(ckSumsTypes[i]));
  }  
  
  return res;
}               
//---------------------------------------------------------------------------


/**
 * Indicates if all the checksums' files exist.
 *
 * @param  srcFileName  Name of the source file.
 * @param  options      Options for the batch creation of the checksums' files.
 * @param  ckSumsTypes  Array of checksums' file types to create.
 * @return <CODE>true</CODE> if all the checksums' files exist,
 *         <CODE>false</CODE> otherwise.
 */
bool dlgBatchCreation::allChecksumsFileNamesExist(const wxString& srcFileName,
                                                  const dlgBatchCreation::Options& options,
                                                  const wxArrayInt& ckSumsTypes)
{
  wxArrayString fileNames = getChecksumsFileNames(srcFileName, options, ckSumsTypes);
  
  bool oneDontExist = false;
  size_t i = 0;
  while (!oneDontExist && i < fileNames.GetCount())
    if (::wxFileExists(fileNames[i]))
      i++;
    else
      oneDontExist = true;
 
  return !oneDontExist;
}               
//---------------------------------------------------------------------------


/**
 * Saves the given sums in checksums files.
 *
 * @param  srcFileName  Name of the source file.
 * @param  options      Options for the batch creation of the checksums' files.
 * @param  ckSumsTypes  Array of checksums' file types to create.
 * @param  sumFiles     Array of <CODE>SumFile</CODE> for each checksum type.
 * @param  sums         Checksums values for each checksum type.
 * @param  fstats       Statistics on the files.
 * @param  dlgPrg      Progression dialog.
 */
void dlgBatchCreation::saveChecksumsInFiles(const wxString& srcFileName,
                                            const dlgBatchCreation::Options& options,
                                            const wxArrayInt& ckSumsTypes,
                                            const ArraySumFile& sumFiles,
                                            const wxArrayString& sums,
                                            dlgBatchCreation::FilesStatistics& fstats,
                                            dlgBatchCreation* dlgPrg)
{
  wxArrayString fileNames = getChecksumsFileNames(srcFileName, options, ckSumsTypes);

  for (size_t i = 0; i < ckSumsTypes.GetCount(); i++)
  {
    bool fileExists = ::wxFileExists(fileNames[i]);
    if (fileExists && !options.ovrCkFileWhenItExists)
    {
      // The checksums' file already exists, skipping.
      if (options.getVerbosity() >= dlgBatchCreation::vWarnings)
        dlgPrg->addResultLine(wxString::Format(_("'%s' already exists. Skipping.\n"), fileNames[i].c_str()), 1U, getColour(prBC_WARNING_COLOUR));
      fstats.CKSkipped++;
    }
    else  // create or overwrite the checksums' file.
    {
      sumFiles[i]->setFileName(fileNames[i]);
      sumFiles[i]->addChecksumData(ChecksumData(srcFileName, sums[i], ChecksumData::Verified));

      if (sumFiles[i]->write(fileNames[i]))
      // The checksums' file has been successfully created.
      {
        wxColour c;
        bool addNewLine = false;
        if (fileExists)
        // The checksums' file has been overwritten.
        {
          if (options.getVerbosity() >= dlgBatchCreation::vWarnings)
          {
            c = getColour(prBC_WARNING_COLOUR);
            dlgPrg->addResultLine(wxString::Format(_("'%s' has been overwritten."), fileNames[i].c_str()), 1U, c);
            addNewLine = true;
          }
          fstats.CKOverwritten++;
        }
        else // the checksums' file has been created.
        {
          if (options.getVerbosity() >= dlgBatchCreation::vNormal)
          {
            c = getColour(prBC_SUCCESS_COLOUR);
            dlgPrg->addResultLine(wxString::Format(_("'%s' has been created."), fileNames[i].c_str()), 1U, c);
            addNewLine = true;
          }
          fstats.CKCreated++;
        }
        if (options.getVerbosity() >= dlgBatchCreation::vTalkative)
          dlgPrg->addResultLine(wxString::Format(wxString(wxT(' ')) + _("(Checksum value : %s)."), sums[i].c_str()), 0U, c);
        if (addNewLine)
          dlgPrg->addResultLine(wxString::Format(wxT("\n"), sums[i].c_str()), 0U, c);
      }
      else  // error while creating the checksums' file.
      {
        if (options.getVerbosity() >= dlgBatchCreation::vErrors)
          dlgPrg->addResultLine(wxString::Format(_("Error while writing '%s'.\n"), fileNames[i].c_str()), 1U, getColour(prBC_ERROR_COLOUR));
        fstats.CKWriteError++;
      }
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Checks multiple checksums' files.
 *
 * @param  files        List of the files from which the checksums' files will
 *                      be created.
 * @param  options      Options for the batch creation of the checksums' files.
 * @param  ckSumsTypes  Array of checksums' file types to create.
 * @param  parent       Parent of the dialog that will be created.
 */
void dlgBatchCreation::batchCreation(const wxArrayString& files,
                                     const Options& options,
                                     wxArrayInt ckSumsTypes,
                                     wxWindow* parent)
{
  FilesStatistics fstats;
  dlgBatchCreation dlgPrg(parent);
  wxArrayString sums;
  ArraySumFile sumFiles;
  ArrayChecksum checksums;
  size_t   i, j;
  wxString msg;

  // No log
  wxLogNull logNo;

  // Suppressing invalids values in ckSumsTypes
  i = 0;
  while (i < ckSumsTypes.GetCount())
    if (SumFileFactory::exists(ckSumsTypes[i]))
      i++;
    else
      ckSumsTypes.RemoveAt(i);

  dlgPrg.setFilesToProcess(files.GetCount());
  i = 0;
  while (i < files.GetCount() && dlgPrg.canContinue())
  {
    // Initialize parameters that will be used to compute the checksums
    wxFileName fn(files[i]);
    for (j = 0; j < ckSumsTypes.GetCount(); j++)
    {
      sumFiles.Add(SumFileFactory::getSumFileNewInstance(ckSumsTypes[j]));
      checksums.Add(sumFiles[j]->getChecksumCalculator());
    }

    // Display information
    dlgPrg.addResultLine(wxString::Format(_("Processing '%s'.\n"), files[i].c_str()), 0U, getColour(prBC_NORMAL_COLOUR));
    dlgPrg.setFileToBeProcessed(i + 1);

    // Checks if all the target checksums' files exists
    if (allChecksumsFileNamesExist(fn.GetFullPath(), options, ckSumsTypes) &&
        !options.ovrCkFileWhenItExists)
    {
      fstats.FSkipped++;
      fstats.CKSkipped += static_cast<unsigned int>(ckSumsTypes.GetCount());
      if (options.getVerbosity() >= dlgBatchCreation::vWarnings)
        dlgPrg.addResultLine(_("All the checksums' files exist. Skipping.\n"), 1U, getColour(prBC_WARNING_COLOUR));
    }
    else  // creating the checksums' files.
    {
      wxCOff_t       fs;      // size of the file to read.
      BytesDisplayer total;   // total of bytes to process.
      ChecksumFileCalculator::State retState;  // state returned by the checksum' calculator.

      fs = wxCGetFileLength(fn.GetFullPath());  // get the length of the file to read
      total = (fs == static_cast<wxCOff_t>(wxInvalidOffset)) ? 0.0 : static_cast<double>(fs);

      ChecksumProgress progressUpdater(&dlgPrg, total);
      ChecksumFileCalculator cfc;
      cfc.setChecksumProgress(&progressUpdater);

      // Check the file.
      retState = cfc.calculate(fn.GetFullPath(), checksums, sums);

      // Update the progress dialog
      progressUpdater.finished();

      switch (retState)
      {
        case ChecksumFileCalculator::Ok :  // Checksum has been calculated.
          fstats.FCorrect++;
          saveChecksumsInFiles(fn.GetFullPath(), options, ckSumsTypes,
                               sumFiles, sums, fstats, &dlgPrg);
          break;

        case ChecksumFileCalculator::ReadError :  // Error while reading the stream.
          fstats.FNotFound++;
          if (options.getVerbosity() >= dlgBatchCreation::vErrors)
            dlgPrg.addResultLine(wxString::Format(_("Error while reading '%s'.\n"), fn.GetFullPath().c_str()), 1U, getColour(prBC_ERROR_COLOUR));
          break;

        case ChecksumFileCalculator::FileNotFound :  // The file has been not found.
          fstats.FNotFound++;
          if (options.getVerbosity() >= dlgBatchCreation::vErrors)
            dlgPrg.addResultLine(wxString::Format(_("'%s': File not found.\n"), fn.GetFullPath().c_str()), 1U, getColour(prBC_ERROR_COLOUR));
          break;

        case ChecksumFileCalculator::CantOpenFile :  // Can't open the stream.
          fstats.FNotOpened++;
          if (options.getVerbosity() >= dlgBatchCreation::vErrors)
            dlgPrg.addResultLine(wxString::Format(_("'%s': File cannot be opened.\n"), fn.GetFullPath().c_str()), 1U, getColour(prBC_ERROR_COLOUR));
          break;
      }
    }

    // Adds an end of line.
    dlgPrg.addResultLine(wxT("\n"), 0U, getColour(prBC_NORMAL_COLOUR));

    // Cleans-up the memory.
    WX_CLEAR_ARRAY(sumFiles)
    WX_CLEAR_ARRAY(checksums)

    i++;
  }

  if (dlgPrg.getState() != canceled)
  {
    // Some compilers don't like the ? : structure in function call, so using
    // this variable to store the result of ? : before the call.
    // Note : some versions of Borland C++ don't like nested ? : so using if else.
    wxColour colour;

    // Display the global summary.
    dlgPrg.addResultLine(wxString::Format(_("Total file(s) processed: %d\n"), fstats.getNbProcessedFiles()), 0L, getColour(prBC_NORMAL_COLOUR));
    if (fstats.allFileAreCorrects()) colour = getColour(prBC_SUCCESS_COLOUR); else if (fstats.FCorrect + fstats.FSkipped > 0 ) colour = getColour(prBC_WARNING_COLOUR); else colour = getColour(prBC_ERROR_COLOUR);
    dlgPrg.addResultLine(wxString::Format(_("Correct(s): %d"), fstats.FCorrect), 1L, colour);
    if (fstats.FSkipped > 0)
      dlgPrg.addResultLine(wxString::Format(wxString(wxT(' ')) + _("(Skipped: %d)"), fstats.FSkipped), 0L, getColour(prBC_WARNING_COLOUR));
    dlgPrg.addResultLine(wxT("\n"), 0L, getColour(prBC_SUCCESS_COLOUR));
    colour = (fstats.FNotFound == 0) ? getColour(prBC_SUCCESS_COLOUR) : getColour(prBC_ERROR_COLOUR);
    dlgPrg.addResultLine(wxString::Format(_("File(s) not found: %d\n"), fstats.FNotFound), 1U, colour);
    colour = (fstats.FNotOpened == 0) ? getColour(prBC_SUCCESS_COLOUR) : getColour(prBC_ERROR_COLOUR);
    dlgPrg.addResultLine(wxString::Format(_("File(s) not opened: %d\n"), fstats.FNotOpened), 1U, colour);
    colour = (fstats.FReadError == 0) ? getColour(prBC_SUCCESS_COLOUR) : getColour(prBC_ERROR_COLOUR);
    dlgPrg.addResultLine(wxString::Format(_("Error(s) while reading: %d\n"), fstats.FReadError), 1U, colour);
    
    dlgPrg.addResultLine(wxString::Format(wxString(wxT('\n')) + _("Total checksums' file(s) processed: %d\n"), fstats.getNbProcessedChecksumsFiles()), 0L, getColour(prBC_NORMAL_COLOUR));
    if (fstats.allChecksumsFilesAreCorrects()) colour = getColour(prBC_SUCCESS_COLOUR); else if (fstats.CKWriteError == fstats.getNbProcessedChecksumsFiles()) colour = getColour(prBC_ERROR_COLOUR); else colour = getColour(prBC_WARNING_COLOUR);
    dlgPrg.addResultLine(wxString::Format(_("Successfully processed: %d\n"), fstats.getNbProcessedChecksumsFiles() - fstats.CKWriteError), 1L, colour);
    if (fstats.CKCreated == fstats.getNbProcessedChecksumsFiles()) colour = getColour(prBC_SUCCESS_COLOUR); else if (fstats.CKCreated > 0 || (fstats.CKCreated == 0 && (fstats.CKSkipped > 0 || fstats.CKOverwritten > 0))) colour = getColour(prBC_WARNING_COLOUR); else colour = getColour(prBC_ERROR_COLOUR);
    dlgPrg.addResultLine(wxString::Format(_("Created: %d\n"), fstats.CKCreated), 2L, colour);
    if (fstats.CKSkipped == 0) if (fstats.CKCreated > 0 || fstats.CKOverwritten > 0) colour = getColour(prBC_SUCCESS_COLOUR); else colour = getColour(prBC_ERROR_COLOUR); else colour = getColour(prBC_WARNING_COLOUR);
    dlgPrg.addResultLine(wxString::Format(_("Skipped: %d\n"), fstats.CKSkipped), 2L, colour);
    if (fstats.CKOverwritten == 0) if (fstats.CKCreated > 0 || fstats.CKSkipped > 0) colour = getColour(prBC_SUCCESS_COLOUR); else colour = getColour(prBC_ERROR_COLOUR); else colour = getColour(prBC_WARNING_COLOUR);
    dlgPrg.addResultLine(wxString::Format(_("Overwritten: %d\n"), fstats.CKOverwritten), 2L, colour);
    colour = (fstats.CKWriteError == 0) ? getColour(prBC_SUCCESS_COLOUR) : getColour(prBC_ERROR_COLOUR);
    dlgPrg.addResultLine(wxString::Format(_("Error(s) while writing: %d\n"), fstats.CKWriteError), 1U, colour);
    
    dlgPrg.Finished();
  }
}
//---------------------------------------------------------------------------


BEGIN_EVENT_TABLE(dlgBatchCreation, dlgResultsProgress)
  EVT_BUTTON(wxID_CANCEL, dlgBatchCreation::btnCancelClick)
END_EVENT_TABLE()
//---------------------------------------------------------------------------

