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
 * \file slstview.hpp
 * A sortable ListView control.
 */

#ifndef INC_SLSTVIEW_HPP
#define INC_SLSTVIEW_HPP

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
//---------------------------------------------------------------------------


/**
 * A sortable ListView control.
 *
 * This control is a wxListView control with two more attributes:
 * - The sort order (ascending, descending, none).
 * - The column to sort.
 */
class wxSortableListView : public wxListView
{
 public:
  /// Default Constructor.
  wxSortableListView();
  
  /**
   * Constructor, creating and showing a list control.
   *
   * @param  parent    Parent window. Must not be <CODE>NULL</CODE>.
   * @param  id        Window identifier. A value of <CODE>-1</CODE> indicates a
   *                   default value.
   * @param  pos       Window position.
   * @param  size      Window size. If the default size <CODE>(-1, -1)</CODE> is
   *                   specified then the window is sized appropriately.
   * @param  style     Window style. See <CODE>wxListCtrl</CODE>.
   * @param  validator Window validator.
   * @param  name      Window name.
   */
  wxSortableListView(wxWindow *parent,
                     wxWindowID id = -1,
                     const wxPoint& pos = wxDefaultPosition,
                     const wxSize& size = wxDefaultSize,
                     long style = wxLC_REPORT,
                     const wxValidator& validator = wxDefaultValidator,
                     const wxString &name = wxT("sortablelistview"));

  /// Sort orders
  enum SortOrder
  {
    none = 0,
    ascending,
    descending
  };

  /**
   * Gets the sort order of this ListView control.
   *
   * @return The sort order of this ListView control.
   */
  SortOrder GetSortOrder() const
  {
    return m_sortOrder;
  }
  
  /**
   * Sets the sort order for this ListView control.
   *
   * If the sort given order is invalid, the sort order is set to 'none'.
   *
   * @param  sortOrder  The new sort order for this ListView control.
   */
  void SetSortOrder(const SortOrder sortOrder);

  /**
   * Gets the column to sort on this ListView control.
   *
   * @return The column to sort on this ListView control.
   */
  int GetColumnToSort() const
  {
    return m_sortColumn;
  }
  
  /**
   * Sets the column to sort on this ListView control.
   *
   * If the given column to sort is invalid, the column will be <CODE>0</CODE>.
   *
   * @param  sortColumn  The new column to sort on this ListView control.
   */
  void SetColumnToSort(const int sortColumn);

 protected:
  SortOrder m_sortOrder;    ///< The sort order.
  int       m_sortColumn;   ///< The column to sort.

 private:
  DECLARE_DYNAMIC_CLASS(wxSortableListView)
};
//---------------------------------------------------------------------------

#endif  // INC_SLSTVIEW_HPP
