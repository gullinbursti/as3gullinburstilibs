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
 * \file dlgBatchCreate.hpp
 * Dialog for creating one checksums' file for each selected file.
 */

#ifndef INC_DLGBATCHCREATE_HPP
#define INC_DLGBATCHCREATE_HPP

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
#include <wx/filename.h>

#include "dlgResProg.hpp"
#include "bytedisp.hpp"
#include "checksum.hpp"
#include "sumfile.hpp"
//---------------------------------------------------------------------------


/**
 * Dialog which displays results of multiple files checking.
 */
class dlgBatchCreation : public dlgResultsProgress
{
 public:
  // Creates a new dialog.
  dlgBatchCreation();

 protected:
  // Creates a new dialog.
  dlgBatchCreation(wxWindow *parent);

 public:
  // The class descructor.
  virtual ~dlgBatchCreation() {}

  // Creates and initializes the controls of the dialog.
  void createControls();

 protected:
  wxStaticText* lblTotal;         ///< Current checksum file (number/total).
  wxGauge*      gauTotal;         ///< Current checksum file (gauge).
  wxStaticText* lblFile;          ///< Current file (bytes read/total).
  wxGauge*      gauFile;          ///< Current file (gauge).

  // Processes button Cancel.
  void btnCancelClick(wxCommandEvent& event);

  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(dlgBatchCreation)
  
 protected: 
  unsigned long  filesToProcess;  ///< Number of files to process.
  unsigned long  fileProcessed;   ///< Number of the current file to be processed.
  BytesDisplayer totalBytes;      ///< Number of bytes of the current checked file.
  BytesDisplayer bytesRead;       ///< Number of read bytes in the current checked file.

 public:
  // Gets the number of files to process.
  unsigned long getFilesToProcess() const;
  // Sets the number of files to process.
  void setFilesToProcess(unsigned long nbTotalFiles);

  // Gets the number of the current file to be processed.
  unsigned long getFileToBeProcessed() const;
  // Sets the number of the file to be processed.
  void setFileToBeProcessed(unsigned long nbFiles);

  // Gets the number of bytes of the current processed file.
  BytesDisplayer getTotalBytes() const;
  // Sets the number of bytes of the current processed file.
  void setTotalBytes(const BytesDisplayer& bytes);

  // Gets the number of bytes read of the current processed file.
  BytesDisplayer getReadBytes() const;
  // Sets the number of bytes read of the current processed file.
  void setReadBytes(const BytesDisplayer& bytes);

 protected:
  // Update the information of the total of the files to be processed.
  void updateTotalFiles();

  // Update the information of the current processed file.
  void updateCurrentProcessedFile();


  // Statistics on the files.
  class FilesStatistics;

 public:
  /// Verbosity levels.
  enum Verbosity
  {
    vErrors = 0,
    vWarnings,
    vNormal,
    vTalkative,
    
    Verbosity_Min = vErrors,
    Verbosity_Max = vTalkative
  };

  class Options;

 public: 
  // Batch creation of checksums' files.
  static void batchCreation(const wxArrayString& files, const Options& options,
                            wxArrayInt ckSumsTypes, wxWindow* parent = NULL);

 private:
  // Progress updater
  class ChecksumProgress;
  
  // Utility functions
  // Gets the names of the checksums' files to create.
  static wxArrayString getChecksumsFileNames(const wxString& srcFileName,
                                             const dlgBatchCreation::Options& options,
                                             const wxArrayInt& ckSumsTypes);

  // Indicates if all the checksums' files exist.
  static bool allChecksumsFileNamesExist(const wxString& srcFileName,
                                         const dlgBatchCreation::Options& options,
                                         const wxArrayInt& ckSumsTypes);

  // Saves the given sums in checksums files.
  static void saveChecksumsInFiles(const wxString& srcFileName,
                                   const dlgBatchCreation::Options& options,
                                   const wxArrayInt& ckSumsTypes,
                                   const ArraySumFile& sumFiles,
                                   const wxArrayString& sums,
                                   dlgBatchCreation::FilesStatistics& fstats,
                                   dlgBatchCreation* dlgPrg);
};
//---------------------------------------------------------------------------


/**
 * Options for the <CODE>dlgBatchCreation</CODE> class.
 */
class dlgBatchCreation::Options
{
 protected:
  dlgBatchCreation::Verbosity verbosity;  ///< Report's Verbosity.
 
 public:
  /**
   * If <CODE>true</CODE>, when a checksums' file already exists it is
   * overwritten. Otherwise the creation of the checksums' file is skipped.
   */
  bool ovrCkFileWhenItExists;
  
  /**
   * If <CODE>true</CODE> the name of the checksums' file will be made by 
   * replacing the extension of the source file with the extension of the type
   * of the checksums' file. Otherwise, the name of the checksums' file will be
   * made by adding the extension of the type of checksums' file to the name of
   * the source file.
   */
  bool replaceExtension;
  
  // Facility constructor.
  Options(const bool iOvrCkFileWhenItExists = false, const bool iReplaceExtension = true, const dlgBatchCreation::Verbosity iVerbosity = vNormal);

  // Gets the report's verbosity.
  dlgBatchCreation::Verbosity getVerbosity() const;

  // Sets the report's verbosity.
  void setVerbosity(const dlgBatchCreation::Verbosity newVerbosity);  
};
//---------------------------------------------------------------------------



#endif  // INC_DLGBATCHCREATE_HPP
