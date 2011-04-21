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
 * \file dlgMultiCheckConf.cpp
 * Configuration dialog for checking multiple checksums' files.
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

#include "dlgMultiCheckConf.hpp"
#include "fileutil.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


IMPLEMENT_DYNAMIC_CLASS(dlgMultiCheckConf, dlgFilesSelector)


/**
 * Creates a new dialog.
 */
dlgMultiCheckConf::dlgMultiCheckConf() : dlgFilesSelector()
{
}
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 *
 * @param  parent  Parent of the dialog.
 */
dlgMultiCheckConf::dlgMultiCheckConf(wxWindow* parent) :
  dlgFilesSelector(parent)
{
}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
dlgMultiCheckConf::~dlgMultiCheckConf()
{
}
//---------------------------------------------------------------------------


/**
 * Gets the root configuration key for parameters of this dialog.
 *
 * The returned string must be ended the a '<CODE>/</CODE>' character.
 *
 * @return  The root configuration key for parameters of this dialog.
 */
wxString dlgMultiCheckConf::getRootConfigKey()
{
  return wxT("GUI/MultiCheckConfigDlg/");
}
//---------------------------------------------------------------------------


/**
 * Gets the string for the specified UI element.
 *
 * @param  id  Identifier of the wanted UI element.
 * @return The string for the specified UI element and an empty string if the
 *         given UI element is invalid.
 */
wxString dlgMultiCheckConf::getUIString(UIStrings id)
{
  wxString res;
  switch (id)
  {
    case uiDialogTitle :
      res = _("Check multiple checksums' files"); break;
    case uiBtnOK :
      res = _("&Check"); break;
    case uiFraFilesList :
      res = _("List of files to c&heck:"); break;
    case uiFraSearchFiles :
      res = _("Search &for some files to check:"); break;
    case uiOpenDlgAddFiles :
      res = _("Select the files to be checked"); break;
    case uiOpenDlgAddList :
      res = _("Add a list of checksums' files"); break;
    case uiOpenDlgLoadList :
      res = _("Load a list of checksums' files"); break;
    case uiSaveDlgAddList :
      res = _("Save a list of checksums' files"); break;
  };
 
  return res;  
}
//---------------------------------------------------------------------------


/**
 * Returns a set of filters for the "Add files" dialog.
 *
 * @return A set of filters for the "Add files" dialog.
 */
wxFileDialogFilterMaker dlgMultiCheckConf::getFiltersForAddFilesDialog()
{
  return ::getFilterForKnownTypesOfChecksumsFiles();
}
//---------------------------------------------------------------------------


/*
BEGIN_EVENT_TABLE(dlgMultiCheckConf, dlgFilesSelector)
END_EVENT_TABLE()
*/
//---------------------------------------------------------------------------

