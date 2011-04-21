/*
 * wxChecksums
 * Written by Julien Couot.
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
 * \file checksumfactory.hpp
 * Classes for enumerate and create all the checksums' files types that the
 * application knows.
 */

#ifndef INC_CHECKSUMFACTORY_HPP
#define INC_CHECKSUMFACTORY_HPP

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

#include <wx/hashmap.h>

#include "checksum.hpp"
#include "sumfile.hpp"
//---------------------------------------------------------------------------


/// Pointer to a function which returns a pointer on a new instance of the <CODE>SumFile</CODE> class.
typedef SumFile* (FnctGetSumFile)();


/**
 * Generates new instances of the subclasses of the <CODE>SumFile</CODE> class
 * that the application knows.
 *
 * Known classes are registered in the <CODE>Initialize</CODE> static member.
 * Call it at the start of the program.
 *
 * The enumeration of known checksums' file types begin from <CODE>0</CODE> to
 * <CODE>getSumFilesCount() - 1</CODE>.
 */
class SumFileFactory
{
 private:
  /**
   * Represents an entry of the checksums' files that the application knows.
   */
  class SumFileEntry
  {
   public:
    FnctGetSumFile* fnctGetSumFile;  ///< Pointer on a function that gives a pointer on a new instance of the <CODE>SumFile</CODE> class.
    wxString name;     ///< Name of the checksums' file type.
    wxString descr;    ///< Description of the checksums' file type.
    wxString fileExt;  ///< Extension of the checksums' file type.
    
   protected:
    // Clones the source instance in this instance.
    void clone(const SumFileEntry& source);

   public:
    /// Default constructor
    SumFileEntry() { fnctGetSumFile = NULL; }

    /**
     * Constructor.
     *
     * @param  getSumFile        Pointer on a function that gives a pointer on
     *                           a new instance of the <CODE>SumFile</CODE> class.
     * @param  name              Name of the checksums' file type.
     * @param  description       Description of the checksums' file type.
     * @param  sumFileExtension  Standard extension of the checksums' file type.
     */
    SumFileEntry(FnctGetSumFile* getSumFile, const wxString& name,
                 const wxString& description, const wxString& sumFileExtension) :
      fnctGetSumFile(getSumFile), name(name), descr(description),
      fileExt(sumFileExtension) {}

    /**
     * Copy constructor.
     *
     * @param  source  Source instance.
     */
    SumFileEntry(const SumFileEntry& source) { clone(source); };

    /**
     * Assignment operator.
     *
     * @param  source  Source instance.
     * @return A reference on the instance.
     */
    SumFileEntry& operator=(const SumFileEntry& source) { clone(source); return *this; };
  };

  /// A hashmap of string keys and SumFileEntry values.
//  WX_DECLARE_STRING_HASH_MAP(SumFileEntry, );
  WX_DECLARE_HASH_MAP(int, SumFileEntry, wxIntegerHash, wxIntegerEqual, SumFileEntries);

  static SumFileEntries sumFilesTypes;  ///< All the checksums' file types that the application knows.

  /// Default constructor. Don't use it.
  SumFileFactory() {}

 public:
  // Initializes the static members of the class.
  static void initialize();

  // Gets all the identifers of the available checksums' file types.
  static wxArrayInt getAvailableSumFiles();

  // Gets the number of available identifers of checksums' file types.
  static int getSumFilesCount();

  // Returns true if the given identifer of checksums' file type exists.
  static bool exists(const int sumFileType);

  // Gives a pointer on a new instance of the specified checksums' file type.
  static SumFile* getSumFileNewInstance(const int sumFileType);

  // Gives the name of the specified checksums' file type.
  static wxString getSumFileName(const int sumFileType);
  
  // Gives the description of the specified checksums' file type.
  static wxString getSumFileDescription(const int sumFileType);

  // Gives the file's extension of the specified checksums' file type.
  static wxString getSumFileExtension(const int sumFileType);

  
  /// Enumeration of the types of the checksums' files.
  enum SumFileType
  {
    ftSFV = 0,
    ftMD5
  };
};
//---------------------------------------------------------------------------


#endif  // INC_CHECKSUMFACTORY_HPP
