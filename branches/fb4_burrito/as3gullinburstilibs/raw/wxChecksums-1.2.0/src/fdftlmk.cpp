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
 * \file fdftlmk.cpp
 * Files dialog filter maker class.
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

#include <wx/filename.h>
#include <wx/tokenzr.h>

#include "fdftlmk.hpp"
#include "utils.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


/**
 * Default constructor.
 */
wxFileDialogFilterMaker::wxFileDialogFilterMaker()
{
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void wxFileDialogFilterMaker::clone(const wxFileDialogFilterMaker& source)
{
  if (this != &source)
  {
    this->descrs = source.descrs;
    this->filters = source.filters;
  }
}
//---------------------------------------------------------------------------


/**
 * Copy constructor.
 *
 * @param  source  Source instance.
 */
wxFileDialogFilterMaker::wxFileDialogFilterMaker(const wxFileDialogFilterMaker& source)
{
  clone(source);
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  source  Source instance.
 * @return A reference on the instance.
 */
wxFileDialogFilterMaker& wxFileDialogFilterMaker::operator=(const wxFileDialogFilterMaker& source)
{
  clone(source);
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Adds a filter.
 *
 * @param  descr   Description of the filter (ex: "All files").
 * @param  filter  List of extensions without dot, separed with '|'.
 */
void wxFileDialogFilterMaker::AddFilter(const wxString& descr, const wxString& filter)
{
  descrs.Add(descr);
  filters.Add(filter);
}
//---------------------------------------------------------------------------


/**
 * Gets a string that contains the filters for a <CODE>wxFileDialog</CODE>
 * instance.
 *
 * @param  format  Creates filters for this path format. If the file names of
 *                 this type are case-sensitive, as much as combinaisons with
 *                 lower and upper cases for the filter name will created
 *                 (ex: under Unix 'cp' filter will be expanded to: 'cp', 'Cp',
 *                 'cP', 'CP').
 * @param  addFiltersInDescriptions  Adds the filters at the end of the
 *                                   description if <CODE>true</CODE> (ex:
 *                                   description = 'All the files',
 *                                   filter = 'c|cpp',
 *                                   result = 'All the files (*.c;*.cpp)').
 * @return A string that contains the filters for a <CODE>wxFileDialog</CODE>
 *         instance.
 */
wxString wxFileDialogFilterMaker::GetFilters(const wxPathFormat format,
                                             const bool addFiltersInDescriptions) const
{
  wxString s;

  for (size_t i = 0; i < descrs.GetCount(); i++)
  {
    // Adds the description
    if (!s.empty())
      s += wxT('|');
    s += descrs[i];
    
    // Adds the filters in the description
    if (addFiltersInDescriptions)
    {
      s += wxT(" (");
      bool firstToken = true;  // no ';' before the first filter
      wxStringTokenizer tkz(filters[i], wxT("|"));
      while (tkz.HasMoreTokens())
      {
        wxString token = tkz.GetNextToken();
        if (firstToken)
          firstToken = false;
        else
          s += wxT(';');
          
        s += wxT("*.") + token;
      }
      s += wxT(')');
    }
    s += wxT('|');
    
    // Creates the filters if files on the current OS are case sensitive
    wxArrayString tk;  // tokens to add
    wxStringTokenizer tkz(filters[i], wxT("|"));
    while (tkz.HasMoreTokens())
    {
      wxString token = tkz.GetNextToken();
      if (wxFileName::IsCaseSensitive(format))
        GetAllTokenCases(token, tk);
      else
        tk.Add(token);
    }
    
    // Adds the filters
    bool firstToken = true;  // no ';' before the first filter
    for (size_t j = 0; j < tk.GetCount(); j++)
    {
      if (firstToken)
        firstToken = false;
      else
        s += wxT(';');
      #if defined(__UNIX__)
      if (tk[j] != wxT("*"))
      #endif  // defined(__UNIX__)
        s += wxT("*.");
      s += tk[j];
    }
  }

  return s;
}
//---------------------------------------------------------------------------
