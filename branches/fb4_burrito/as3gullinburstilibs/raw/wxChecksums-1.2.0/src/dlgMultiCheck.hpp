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
 * \file dlgMultiCheck.hpp
 * Dialog for checking multiple checksums' files.
 */

#ifndef INC_DLGMULTICHECK_HPP
#define INC_DLGMULTICHECK_HPP

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
//---------------------------------------------------------------------------


/**
 * Dialog which displays results of multiple files checking.
 */
class dlgMultiCheck : public dlgResultsProgress
{
 public:
  // Creates a new dialog.
  dlgMultiCheck();

 protected:
  // Creates a new dialog.
  dlgMultiCheck(wxWindow *parent);

 public:
  // The class descructor.
  virtual ~dlgMultiCheck() {}

  // Creates and initializes the controls of the dialog.
  void createControls();

 protected:
  wxStaticText* lblTotal;         ///< Current checksum file (number/total).
  wxGauge*      gauTotal;         ///< Current checksum file (gauge).
  wxStaticText* lblChecksumFile;  ///< Current file in checksums' file (number/total).
  wxGauge*      gauChecksumFile;  ///< Current file in checksums' file (gauge).
  wxStaticText* lblFile;          ///< Current file (bytes read/total).
  wxGauge*      gauFile;          ///< Current file (gauge).

  // Processes button Cancel.
  void btnCancelClick(wxCommandEvent& event);

  DECLARE_EVENT_TABLE()

 private:
  DECLARE_DYNAMIC_CLASS(dlgMultiCheck)
  
 protected: 
  unsigned long  filesToCheck;  ///< Number of files to check.
  unsigned long  fileChecked;   ///< Number of the current file to be checked.
  unsigned long  filesInChecksumsFile;  ///< Number of files in the current checksums' file.
  unsigned long  fileInChecksumsFile;   ///< Number of the current file in the current checksums' file.
  BytesDisplayer totalBytes;      ///< Number of bytes of the current checked file.
  BytesDisplayer bytesRead;       ///< Number of read bytes in the current checked file.

 public:
  // Gets the number of files to check.
  unsigned long getFilesToCheck() const;
  // Sets the number of files to check.
  void setFilesToCheck(unsigned long nbTotalChecksumsFiles);

  // Gets the number of the current file to be check.
  unsigned long getFileToBeChecked() const;
  // Sets the number of files to check.
  void setFileToBeChecked(unsigned long nbChecksumsFiles);

  // Gets the number of files in the current checksums' file.
  unsigned long getFilesInChecksumsFile() const;
  // Sets the number of files in the current checksums' file.
  void setFilesInChecksumsFile(unsigned long nbTotalInChecksumsFiles);
  
  // Gets the number of the current file in the current checksums' file.
  unsigned long getFileInChecksumsFile() const;
  // Sets the number of the current file in the current checksums' file.
  void setFileInChecksumsFile(unsigned long nbInChecksumsFiles);

  // Gets the number of bytes of the current checked file in the current checked checksums' file.
  BytesDisplayer getTotalBytes() const;
  // Sets the number of bytes of the current checked file in the current checked checksums' file.
  void setTotalBytes(const BytesDisplayer& bytes);

  // Gets the number of bytes read of the current checked file in the current checked checksums' file.
  BytesDisplayer getReadBytes() const;
  // Sets the number of bytes read of the current checked file in the current checked checksums' file.
  void setReadBytes(const BytesDisplayer& bytes);

 protected:
  // Update the information of the total of the checksums' files to be checked.
  void updateTotalChecksumsFiles();

  // Update the information of the files in the checksums' files to be checked.
  void updateFilesInChecksumsFiles();

  // Update the information of the current checked file.
  void updateCurrentCheckedFile();

  // Statistics on the files.
  class FilesStatistics;

  // Checks a file.
  static void checkFile(const wxFileName& fileName, Checksum* cc, const wxString& checksum, dlgMultiCheck& dlgPrg, FilesStatistics& stats);
 
 public:
  // Checks multiple checksums' files.
  static void checkChecksumsFiles(const wxArrayString& files, wxWindow* parent = NULL);
 
 private:
  // Progress updater
  class ChecksumProgress;
};
//---------------------------------------------------------------------------

#endif  // INC_DLGMULTICHECK_HPP
