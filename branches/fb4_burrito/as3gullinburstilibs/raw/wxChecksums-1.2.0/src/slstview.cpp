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
 * \file slstview.cpp
 * A sortable ListView control.
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

#include <wx/listctrl.h>

#include "slstview.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------

/// The C++ standard namespace.
using namespace std;


IMPLEMENT_DYNAMIC_CLASS(wxSortableListView, wxListView)


/// Default Constructor.
wxSortableListView::wxSortableListView()
{
  SetSortOrder(none);
  SetColumnToSort(0);
}
//---------------------------------------------------------------------------


// Constructor, creating and showing a list control.
wxSortableListView::wxSortableListView(wxWindow *parent, wxWindowID id,
                                       const wxPoint& pos, const wxSize& size,
                                       long style, const wxValidator& validator,
                                       const wxString &name)
{
  Create(parent, id, pos, size, style, validator, name);
  SetSortOrder(none);
  SetColumnToSort(0);  
}
//---------------------------------------------------------------------------


// Sets the sort order for this ListView control.
void wxSortableListView::SetSortOrder(const SortOrder sortOrder)
{
  switch (sortOrder)
  {
    case ascending :
    case descending :
      m_sortOrder = sortOrder;
      break;
    default :
      m_sortOrder = none;
  }
}
//---------------------------------------------------------------------------


// Sets the column to sort on this ListView control.
void wxSortableListView::SetColumnToSort(const int sortColumn)
{
  if (sortColumn < 0 || sortColumn >= GetColumnCount())
    m_sortColumn = 0;
  else
    m_sortColumn = sortColumn;
}
//---------------------------------------------------------------------------
