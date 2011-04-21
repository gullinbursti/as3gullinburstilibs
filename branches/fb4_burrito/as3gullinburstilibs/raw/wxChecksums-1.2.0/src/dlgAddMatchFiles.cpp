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
 * \file dlgAddMatchFiles.cpp
 * Dialog for adding files by pattern matching.
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

#include <cstring>  // for memcpy

#include <wx/config.h>
#include <wx/filename.h>
#include <wx/spinctrl.h>
#include <wx/tokenzr.h>
#include <wx/txtstrm.h>
#include <wx/wfstream.h>

#include "dlgAddMatchFiles.hpp"
#include "appprefs.hpp"
#include "bytedisp.hpp"
#include "comdefs.hpp"
#include "fdftlmk.hpp"
#include "fileutil.hpp"
#include "slstview.hpp"
#include "utils.hpp"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


//###########################################################################
// The matching pattern
//###########################################################################


/**
 * Constructor.
 *
 * @param  dir  The directory.
 * @param  pat  The pattern.
 * @param  dep  The depth.
 */
dlgAddMatchFiles::MatchPattern::MatchPattern(const wxString& dir,
                                             const wxString& pat, const int dep)
{
  setDirectory(dir);
  setPattern(pat);
  setDepth(dep);
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void dlgAddMatchFiles::MatchPattern::clone(const MatchPattern& source)
{
  if (this != &source)
  {
    this->directory = source.directory;
    this->pattern = source.pattern;
    this->depth = source.depth;
  }
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  source  Source instance.
 * @return A reference on the instance.
 */
dlgAddMatchFiles::MatchPattern& dlgAddMatchFiles::MatchPattern::operator=(const MatchPattern& source)
{
  clone(source);
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Gets the patterns.
 *
 * @return The patterns in a array of strings.
 */
wxArrayString dlgAddMatchFiles::MatchPattern::getPatterns() const
{
  wxArrayString res;

  wxStringTokenizer tkz(getPattern(), wxT(";"), wxTOKEN_STRTOK);
  while (tkz.HasMoreTokens())
    res.Add(tkz.GetNextToken());
    
  return res;
}
//---------------------------------------------------------------------------


/**
 * Adds the given patterns to this pattern.
 *
 * @param  patterns  The patterns to add.
 */
void dlgAddMatchFiles::MatchPattern::addPatterns(const wxString& patterns)
{
  wxArrayString pats;
  wxArrayString mine = getPatterns();

  // Tokenizes the given patterns.
  wxStringTokenizer tkz(patterns, wxT(";"), wxTOKEN_STRTOK);
  while (tkz.HasMoreTokens())
    pats.Add(tkz.GetNextToken());

  // Merging
  wxString newPattern = getPattern();
  size_t j;
  bool found;
  for (size_t i = 0; i < pats.GetCount(); i++)
  {
    j = 0;
    found = false;
    while (!found && j < mine.GetCount())
    {
      if (::compareFileName(pats[i], mine[j]) == 0)
        found = true;
      j++;
    }
    if (!found)
    {
      if (mine.GetCount() > 0)
        newPattern += wxT(';');
      newPattern += pats[i];
      mine.Add(pats[i]);
    }
  }
  
  setPattern(newPattern);
}
//---------------------------------------------------------------------------


/**
 * Remove the given patterns from this pattern.
 *
 * @param  patterns  Patterns to remove.
 */
void dlgAddMatchFiles::MatchPattern::removePatterns(const wxString& patterns)
{
  wxArrayString pats;
  wxArrayString mine = getPatterns();

  // Tokenizes the given patterns.
  wxStringTokenizer tkz(patterns, wxT(";"), wxTOKEN_STRTOK);
  while (tkz.HasMoreTokens())
    pats.Add(tkz.GetNextToken());

  // Removing to patterns
  size_t j;
  bool found;
  for (size_t i = 0; i < pats.GetCount(); i++)
  {
    j = 0;
    found = false;
    while (!found && j < mine.GetCount())
    {
      if (::compareFileName(pats[i], mine[j]) == 0)
      {
        found = true;
        mine.Remove(j);
      }
      else
        j++;
    }
  }
  
  // Creating the new pattern
  wxString newPattern;
  for (j = 0; j < mine.GetCount(); j++)
  {
    if (j > 0)
      newPattern += wxT(';');
    newPattern += mine[j];
  }

  setPattern(newPattern);
}
//---------------------------------------------------------------------------


/**
 * Indicates if the pattern includes all the given patterns.
 *
 * @param  patterns  Patterns to check if they are in this pattern.
 * @return <CODE>true</CODE> if all the given patterns are in this pattern.
 *         <CODE>false</CODE> otherwise.
 */
bool dlgAddMatchFiles::MatchPattern::isIncludingAllPatterns(const wxString& patterns) const
{
  wxArrayString pats;
  wxArrayString mine = getPatterns();

  // Tokenizes the given patterns.
  wxStringTokenizer tkz(patterns, wxT(";"), wxTOKEN_STRTOK);
  while (tkz.HasMoreTokens())
    pats.Add(tkz.GetNextToken());
  
  bool found = true;
  size_t i = 0, j;
  while (found && i < pats.GetCount())
  {
    found = false;
    j = 0;
    while (!found && j < mine.GetCount())
    {
      if (::compareFileName(pats[i], mine[j]) == 0)
        found = true;
      j++;
    }

    i++;
  }
  
  return found;
}
//---------------------------------------------------------------------------


/**
 * Compare the depths of this pattern and the given one.
 *
 * A depth of <CODE>0</CODE> is infinite (i.e. bigger that any other depth).
 *
 * @param  cmp  Pattern to compare the depth.
 * @return A number < 0 if <I>the depth of this pattern</I> < <I>the depth of
 *          <CODE>cmp</CODE></I>, 0 if <I>the depth of this pattern</I> ==
 *          <I>the depth of <CODE>cmp</CODE></I>, > 0 if 
 *          <I>the depth of this pattern</I> >
 *          <I>the depth of <CODE>cmp</CODE></I>.
 */
int dlgAddMatchFiles::MatchPattern::compareDepth(const MatchPattern& cmp) const
{
  if (this->getDepth() == 0 && cmp.getDepth() == 0)
    return 0;
  else if (this->getDepth() == 0)
    return 1;
  else if (cmp.getDepth() == 0)
    return -1;
  else
    return this->getDepth() - cmp.getDepth();
}
//---------------------------------------------------------------------------


/**
 * Compare two matching patterns.
 *
 * The matching patterns are equals if:
 * - They have the same depth.
 * - They have the same directory
 * - The first pattern includes all the patterns of the second.
 * - The second pattern includes all the patterns of the first.
 *
 * @param  cmp  Matching pattern to compare with this matching pattern.
 * @return <CODE>true</CODE> if the patterns are equals, <CODE>false</CODE>
 *         otherwise.
 */
bool dlgAddMatchFiles::MatchPattern::operator==(const MatchPattern& cmp) const
{
  return (this->compareDepth(cmp) == 0 &&
          ::compareFileName(this->getDirectory(), cmp.getDirectory()) == 0 &&
          this->isIncludingAllPatterns(cmp.getPattern()) &&
          cmp.isIncludingAllPatterns(this->getPattern()));
}
//---------------------------------------------------------------------------


//###########################################################################
// Array of matching patterns
//###########################################################################

const size_t dlgAddMatchFiles::ArrayMatchPattern::ALLOC_NEW = 10;

/**
 * Default constructor.
 */
dlgAddMatchFiles::ArrayMatchPattern::ArrayMatchPattern()
{
  patterns = NULL;
  allocated = 0;
  used = 0;
  alloc(ALLOC_NEW);
}
//---------------------------------------------------------------------------

  
/**
 * Constructor with an amount of allocated elements.
 *
 * @param  count  Number of patterns to allocate.
 */
dlgAddMatchFiles::ArrayMatchPattern::ArrayMatchPattern(size_t count)
{
  patterns = NULL;
  allocated = 0;
  used = 0;
  alloc(count);
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void dlgAddMatchFiles::ArrayMatchPattern::clone(const ArrayMatchPattern& source)
{
  if (this != &source)
  {
    // Delete the current array.
    clear();
    alloc(source.allocated);
    for (size_t i = 0; i < source.used; i++)
      patterns[i] = new MatchPattern(*(source.patterns[i]));
    this->used = source.used;
  }
}
//---------------------------------------------------------------------------


/**
 * Copy constructor.
 *
 * @param  source  Source instance.
 */
dlgAddMatchFiles::ArrayMatchPattern::ArrayMatchPattern(const ArrayMatchPattern& source)
{
  patterns = NULL;
  allocated = 0;
  used = 0;  
  clone(source);
}
//---------------------------------------------------------------------------


/**
 * Assignment operator.
 *
 * @param  source  Source instance.
 * @return A reference on the instance.
 */
dlgAddMatchFiles::ArrayMatchPattern& dlgAddMatchFiles::ArrayMatchPattern::operator=(const ArrayMatchPattern& source)
{
  clone(source);
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Destructor.
 */
dlgAddMatchFiles::ArrayMatchPattern::~ArrayMatchPattern()
{
  clear();
}
//---------------------------------------------------------------------------


/**
 * Adds a pattern to the array.
 *
 * - The pattern is added if there is no other pattern with the same directory
 *   and same patterns and with a bigger depth.
 * - If a pattern is found with the same directory and the same patterns
 *   (including) and a smallest depth, the depth of the existing pattern is
 *   changed.
 * - If a pattern have the same directory and the same depth, the patterns
 *   are merged.
 *
 * @param  pattern  Pattern to add.
 */
void dlgAddMatchFiles::ArrayMatchPattern::add(MatchPattern pattern)
{
  bool found = false;
  size_t i = 0, l = getCount();
  while (!found && i < l)
  {
    if (::compareFileName(pattern.getDirectory(), patterns[i]->getDirectory()) == 0)
    // The directories are the same, checking for (see above)
      if (patterns[i]->compareDepth(pattern) == 0 ||
          (patterns[i]->compareDepth(pattern) >= 0 &&
           patterns[i]->isIncludingAllPatterns(pattern.getPattern())))
      // Merging the patterns.
      {
        patterns[i]->addPatterns(pattern.getPattern());
        found = true;  // don't add pattern to the array.
      }
      else if (patterns[i]->compareDepth(pattern) > 0)
      {
        pattern.removePatterns(patterns[i]->getPattern());
        if (pattern.getPattern().IsEmpty())
        // the pattern to add is now empty, don't add it to the array.
          found = true;
      }
      else if (patterns[i]->compareDepth(pattern) < 0)
      {
        patterns[i]->removePatterns(pattern.getPattern());
        if (patterns[i]->getPattern().IsEmpty())
        // adding the pattern at this position.
        {
          *(patterns[i]) = pattern;
          found = true;
        }
      }

    i++;
  }

  if (!found)
  // Adding the matching pattern to the array.
  {
    if (used == allocated)
      alloc(allocated + ALLOC_NEW);
    patterns[used] = new MatchPattern(pattern);
    used++;
  }
}
//---------------------------------------------------------------------------


/**
 * Preallocates memory for a given number of patterns.
 *
 * @param  count  Number of patterns to allocate.
 */ 
void dlgAddMatchFiles::ArrayMatchPattern::alloc(size_t count)
{
  if (count <= allocated)
  // Do nothing, bye.
    return;
  
  // Allocates a new array.
  pMatchPattern* pPatterns = new pMatchPattern[count];
  allocated = count;

  if (patterns == NULL)
    patterns = pPatterns;
  else  // copy and delete the old array
  {
    // Copy only the used pointers, the rest is useless.
    memcpy(pPatterns, patterns, sizeof(pMatchPattern) * used);
    delete[] patterns;
    patterns = pPatterns;
  }
}
//---------------------------------------------------------------------------

  
/**
 * Empties the array.
 */
void dlgAddMatchFiles::ArrayMatchPattern::clear()
{
  if (patterns != NULL)
  {
    // Deletes the elements of the array.
    for (size_t i = 0; i < used; i++)
      delete patterns[i];

    // Delete the array.
    delete[] patterns;
    patterns = NULL;
  }

  // Sets the number of allocated elements and the number of used elements.
  allocated = 0;
  used = 0;
}
//---------------------------------------------------------------------------

  
/**
 * Gets the number of patterns in the array.
 *
 * @return The number of patterns in the array.
 */
size_t dlgAddMatchFiles::ArrayMatchPattern::getCount() const
{
  return used;
}
//---------------------------------------------------------------------------

/**
 * Gets the pattern at the given index.
 *
 * If the index is out of bounds, nothing special is done (and the program
 * will surely fail with a segmentation fault).
 *
 * @param  index  Index of the item to get.
 * @return A reference on the matching pattern.
 */
dlgAddMatchFiles::MatchPattern& dlgAddMatchFiles::ArrayMatchPattern::item(size_t index) const
{
  return *(patterns[index]);
}
//---------------------------------------------------------------------------


/**
 * Gets the pattern at the given index.
 *
 * If the index is out of bounds, nothing special is done (and the program
 * will surely fail with a segmentation fault).
 *
 * @param  index  Index of the item to get.
 * @return A reference on the matching pattern.
 */
dlgAddMatchFiles::MatchPattern& dlgAddMatchFiles::ArrayMatchPattern::operator[](size_t index) const
{
  return *(patterns[index]);
}
//---------------------------------------------------------------------------



//###########################################################################
// The list of patterns compare function
//###########################################################################

/**
 * Function that compare two elements of the list of patterns of the multiple
 * check configuration dialog.
 *
 * @param  item1  Data of the first item. This should be an unique identifier.
 * @param  item2  Data of the second item. This should be an unique identifier.
 * @param  sortData  Adress of the instance of the
 *                   <CODE>wxSortableListView</CODE> that contains the data to
 *                   short.
 */
static int wxCALLBACK patternsListCmpFnct(long item1, long item2, long sortData)
{
  // Get the ListView
  wxSortableListView* lv = wxDynamicCast(sortData, wxSortableListView);

  // Can't get the listview -> no sort.
  if (lv == NULL)
    return item1 - item2;

  // No sort.
  if (lv->GetSortOrder() == wxSortableListView::none)
    return item1 - item2;

  // Get the strings for comparison
  wxListItem li1, li2;
  li1.SetMask(wxLIST_MASK_TEXT);
  li1.SetColumn(lv->GetColumnToSort());
  li1.SetId(lv->FindItem(-1, item1));
  lv->GetItem(li1);
  li2.SetMask(wxLIST_MASK_TEXT);
  li2.SetColumn(lv->GetColumnToSort());
  li2.SetId(lv->FindItem(-1, item2));
  lv->GetItem(li2);
  wxString s1 = li1.GetText();
  wxString s2 = li2.GetText();

  // Compute the result to return
  int res;
  if (lv->GetColumnToSort() != 2)
  // Compare string (directory or patterns)
  {
    if (lv->GetSortOrder() == wxSortableListView::ascending)
      res = ::compareFileName(s1, s2);
    else
      res = ::compareFileName(s2, s1);
  }
  else  // Compare integers (depth)
  {
    long i1, i2;
    s1.ToLong(&i1);
    s2.ToLong(&i2);
    res = (lv->GetSortOrder() == wxSortableListView::ascending) ? i1 - i2 : i2 -i1;
  }

  return res;
}
//---------------------------------------------------------------------------



//###########################################################################
// A validator for the patterns' list
//###########################################################################

/**
 * A validator for the patterns' list.
 *
 * Checks that the given list of file's names has one or more elements.
 *
 * If the list is empty, display a message.
 */
class dlgAddMatchFiles::PatternsListValidator : public wxValidator
{
 protected:
  ArrayMatchPattern* value;  ///< Adress of the array of strings where the value will be transfered.

  // Clones the source instance in this instance.
  void clone(const PatternsListValidator& source);

  // Returns the wxListView associated with the validator.
  wxSortableListView* GetSortableListView() const;

 public:
  // Constructor.
  PatternsListValidator(ArrayMatchPattern* pValue);

  // Copy constructor.
  PatternsListValidator(const PatternsListValidator& source);
  
  // Assignment operator.
  PatternsListValidator& operator=(const PatternsListValidator& source);

  // Returns a copy of the instance of the validator.
  virtual wxObject* Clone() const;

  // Validates the value in the associated window.
  virtual bool Validate(wxWindow* parent);
  
  // Transfers the value in the window to the validator.
  virtual bool TransferFromWindow();

  // Transfers the value associated with the validator to the window.
  virtual bool TransferToWindow();
};
//---------------------------------------------------------------------------


/**
 * Constructor.
 *
 * @param  pValue  Pointer on the array of strings where to value will be
 *                 transfered.
 */
dlgAddMatchFiles::PatternsListValidator::PatternsListValidator(ArrayMatchPattern* pValue)
{
  value = pValue;
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void dlgAddMatchFiles::PatternsListValidator::clone(const PatternsListValidator& source)
{
  if (this != &source)
  {
    this->value = source.value;
  }
}
//---------------------------------------------------------------------------


/**
 * Copy constructor.
 *
 * @param  source  Source instance.
 */
dlgAddMatchFiles::PatternsListValidator::PatternsListValidator(const PatternsListValidator& source)
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
dlgAddMatchFiles::PatternsListValidator& dlgAddMatchFiles::PatternsListValidator::operator=(const PatternsListValidator& source)
{
  clone(source);
  return *this;
}
//---------------------------------------------------------------------------


/**
 * Returns a copy of the instance of the validator.
 *
 * @return A copy of the instance of the validator.
 */
wxObject* dlgAddMatchFiles::PatternsListValidator::Clone() const
{
  return new PatternsListValidator(*this);
}
//---------------------------------------------------------------------------


/**
 * Returns the <CODE>wxSortableListView</CODE> associated with the validator.
 *
 * @return The <CODE>wxSortableListView</CODE> associated with the validator or
 *         <CODE>NULL</CODE> if the <CODE>wxSortableListView</CODE> associated with
 *         the validator isn't a <CODE>wxSortableListView</CODE>.
 */
wxSortableListView* dlgAddMatchFiles::PatternsListValidator::GetSortableListView() const
{
  wxWindow* win = GetWindow();
  if (win == NULL)
    return NULL;
  if (!win->IsKindOf(CLASSINFO(wxSortableListView)))
    return NULL;

  return wxDynamicCast(win, wxSortableListView);
}
//---------------------------------------------------------------------------


/**
 * Validates the value in the associated window.
 *
 * @param  parent  Parent window.
 */
bool dlgAddMatchFiles::PatternsListValidator::Validate(wxWindow* parent)
{
  wxSortableListView* control = GetSortableListView();
  if (control == NULL)
    return false;

  if (control->GetItemCount() == 0)
  {
    ::wxMessageBox(_("Add a matching pattern at least."), _("Warning"), wxOK | wxICON_EXCLAMATION);
    return false;
  }
  else
    return true;
}
//---------------------------------------------------------------------------
  

/**
 * Transfers the value in the window to the validator.
 *
 * @return <CODE>true</CODE> on success, <CODE>false</CODE> otherwise.
 */
bool dlgAddMatchFiles::PatternsListValidator::TransferFromWindow()
{
  wxSortableListView* control = GetSortableListView();
  if (control == NULL || value == NULL)
    return false;
  else
  {
    wxString pattern, directory;
    long     depth;
    wxListItem listItem;
    listItem.SetMask(wxLIST_MASK_TEXT);
    long item = control->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
    while (item != -1)
    {
      // Read items info
      listItem.SetId(item);
      listItem.SetColumn(0);
      control->GetItem(listItem);
      directory = listItem.GetText();
      listItem.SetColumn(1);
      control->GetItem(listItem);
      pattern = listItem.GetText();
      listItem.SetColumn(2);
      control->GetItem(listItem);
      listItem.GetText().ToLong(&depth);
      value->add(MatchPattern(directory, pattern, depth));

      item = control->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
    }

    return true;
  }
}
//---------------------------------------------------------------------------


/**
 * Transfers the value associated with the validator to the window.
 *
 * return <CODE>true</CODE> on success, <CODE>false</CODE> otherwise.
 */
bool dlgAddMatchFiles::PatternsListValidator::TransferToWindow()
{
  wxSortableListView* control = GetSortableListView();
  if (control == NULL || value == NULL)
    return false;
  else
  {
    size_t s = value->getCount();
    size_t i;
    wxListItem listItem;
    listItem.SetMask(wxLIST_MASK_TEXT);

    for (i = 0; i < s; i++)
    {
      // Remove spaces at the beginning and the end of the pattern and directory.
      wxString directory = value->item(i).getDirectory().Strip(wxString::both);
      wxString patterns = value->item(i).getPattern().Strip(wxString::both);

      // Checks the validity of the parameters
      if (directory.IsEmpty())
        directory = wxT(".");
      if (patterns.IsEmpty())
        patterns = wxT("*");
  
      // Remove the path separators at the end of the directory if needed
      while (!directory.IsEmpty() && directory.Last() == wxFileName::GetPathSeparator())
        directory.RemoveLast();

      MatchPattern patternToAdd(directory, patterns, value->item(i).getDepth());
      wxListItem listItem;
      listItem.SetMask(wxLIST_MASK_TEXT);
      MatchPattern p;
      long depth;

      // Checks if the pattern isn't already is the list.
      long item = control->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
      bool found = false;
      while (!found && item != -1)
      {
        listItem.SetId(item);
        listItem.SetColumn(0);
        control->GetItem(listItem);
        p.setDirectory(listItem.GetText());
        listItem.SetColumn(1);
        control->GetItem(listItem);
        p.setPattern(listItem.GetText());
        listItem.SetColumn(2);
        control->GetItem(listItem);
        listItem.GetText().ToLong(&depth);
        p.setDepth(depth);

        if (patternToAdd == p)
          found = true;
        else
          item = control->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
      }
      if (!found)
      {
        long newItem = control->InsertItem(control->GetItemCount(), patternToAdd.getDirectory());
        control->SetItem(newItem, 1, patternToAdd.getPattern());
        control->SetItem(newItem, 2, wxString::Format(wxT("%d"), patternToAdd.getDepth()));
        control->SetItemData(newItem, getID());
      }
    }
    control->SortItems(patternsListCmpFnct, reinterpret_cast<long>(control));

    return true;
  }
}
//---------------------------------------------------------------------------



//###########################################################################
// dlgAddMatchFiles methods
//###########################################################################

IMPLEMENT_DYNAMIC_CLASS(dlgAddMatchFiles, wxDialog)


// Static attributes of the dlgAddMatchFiles class.
// Value for unique identifiers generation.
long dlgAddMatchFiles::idGen = 0L;
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 */
dlgAddMatchFiles::dlgAddMatchFiles() : wxDialog()
{
  matchPatterns = NULL;
  createControls();
  setChecksumsFileName(wxFileName::GetCwd());
}
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 *
 * @param  parent  Parent of the dialog.
 * @param  checksumsFileName  Name of the checksums' file in which the matched
 *                            file will be added.
 */
dlgAddMatchFiles::dlgAddMatchFiles(wxWindow* parent,
                                   const wxString& checksumsFileName) :
  wxDialog(parent, -1, wxEmptyString, wxDefaultPosition, wxDefaultSize, 
           wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
  matchPatterns = NULL;
  createControls();
 
  Fit();
  
  // Get the size of the window
  wxSize s;
  if (PreferenceValue::read(getConfigKey(prGUI_ADD_MATCH_FILES_WINDOW_SIZE), &s))
    SetSize(s);
  
  Centre();
  
  if (checksumsFileName.IsEmpty())
    setChecksumsFileName(wxFileName::GetCwd());
  else
    setChecksumsFileName(checksumsFileName);
}
//---------------------------------------------------------------------------


/**
 * Creates and initializes the controls of the dialog.
 */
void dlgAddMatchFiles::createControls()
{
  // Creating a new array of matching patterns if necessary.
  if (matchPatterns == NULL)
    matchPatterns = new ArrayMatchPattern();
  
  // Creates the controls
  wxStaticBox* fraPatterns = new wxStaticBox(this, -1, _("List of the matc&hing patterns:"));
  lvwPatterns = new wxSortableListView(this, LVW_FILES, wxDefaultPosition,
                            wxSize((this->GetParent()->GetSize().GetWidth() * 2) / 3,
                                   (this->GetParent()->GetSize().GetHeight() / 2)),
                            wxLC_REPORT, PatternsListValidator(matchPatterns));
  lvwPatterns->InsertColumn(0, _("Directory"));
  lvwPatterns->InsertColumn(1, _("Pattern"));
  lvwPatterns->InsertColumn(2, _("Depth"));

  btnRemove = new wxButton(this, BTN_REMOVE, _("&Remove"));
  btnRemove->Disable();
  wxButton* btnAddList = new wxButton(this, BTN_ADDLIST, _("Add li&st..."));
  wxButton* btnLoadList = new wxButton(this, BTN_LOADLIST, _("L&oad list..."));
  wxButton* btnSaveList = new wxButton(this, BTN_SAVELIST, _("Sa&ve list..."));
  const wxString rbxSortByChoices[] = { _("Directory"), _("Pattern"), _("Depth") };
  rbxSortBy = new wxRadioBox(this, RBX_SORT_BY, _("Sort b&y:"), wxDefaultPosition, wxDefaultSize, 3, rbxSortByChoices, 1, wxRA_SPECIFY_COLS);
  const wxString rbxSortOrderChoices[] = { _("Ascending"), _("Descending"), _("Don't sort") };
  rbxSortOrder = new wxRadioBox(this, RBX_SORT_ORDER, _("Sor&t order:"), wxDefaultPosition, wxDefaultSize, 3, rbxSortOrderChoices, 1, wxRA_SPECIFY_COLS);

  wxStaticBox* fraAddingPattern = new wxStaticBox(this, -1, _("Add a mathing pattern to the li&st:"));
  wxStaticText* lblPattern = new wxStaticText(this, -1, _("Patter&n(s):"));
  cboPattern = new wxComboBox(this, CBO_PATTERN);
  wxStaticText* lblDirectory = new wxStaticText(this, -1, _("D&irectory:"));
  cboDirectory = new wxComboBox(this, CBO_DIRECTORY);
  wxButton* btnBrowse = new wxButton(this, BTN_BROWSE, _("&Browse..."));
  wxStaticText* lblDepth = new wxStaticText(this, -1, _("&Depth:"));
  spnDepth = new wxSpinCtrl(this, SPN_DEPTH, wxT("0"), wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS | wxSP_WRAP, 0, SHRT_MAX, 0);
  btnAddPattern = new wxButton(this, BTN_ADD_PATTERN, _("Add patt&ern"));

  wxButton* btnAdd = new wxButton(this, BTN_ADD, _("&Add..."));
  btnAdd->SetDefault();
  wxButton* btnCancel = new wxButton(this, wxID_CANCEL, _("Ca&ncel"));


  //-------------------------------------------------------------------------
  // Creates the dialog sizers

  // Dialog sizer
  wxBoxSizer* dlgAddMatchFilesSizer2 = new wxBoxSizer(wxVERTICAL);
  this->SetSizer(dlgAddMatchFilesSizer2);
  wxBoxSizer* dlgAddMatchFilesSizer = new wxBoxSizer(wxVERTICAL);
  dlgAddMatchFilesSizer2->Add(dlgAddMatchFilesSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // List of patterns
  wxStaticBoxSizer* fraPatternsSizer2 = new wxStaticBoxSizer(fraPatterns, wxVERTICAL);
  dlgAddMatchFilesSizer->Add(fraPatternsSizer2, 1, wxGROW);  
  wxBoxSizer* fraPatternsSizer = new wxBoxSizer(wxHORIZONTAL);
  fraPatternsSizer2->Add(fraPatternsSizer, 1, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraPatternsSizer->Add(lvwPatterns, 1, wxGROW);
  
  wxBoxSizer* patternsListButtonsSizer = new wxBoxSizer(wxVERTICAL);
  patternsListButtonsSizer->Add(btnRemove, 0, wxGROW | wxTOP, CONTROL_SPACE);
  patternsListButtonsSizer->Add(btnAddList, 0, wxGROW | wxTOP, CONTROL_SPACE);
  patternsListButtonsSizer->Add(btnLoadList, 0, wxGROW | wxTOP, CONTROL_SPACE / 2);
  patternsListButtonsSizer->Add(btnSaveList, 0, wxGROW | wxTOP, CONTROL_SPACE / 2);
  patternsListButtonsSizer->Add(rbxSortBy, 0, wxGROW | wxTOP, CONTROL_SPACE);
  patternsListButtonsSizer->Add(rbxSortOrder, 0, wxGROW | wxTOP, CONTROL_SPACE / 2);
  fraPatternsSizer->Add(patternsListButtonsSizer, 0, wxLEFT | wxALIGN_TOP, CONTROL_SPACE);

  // Add pattern section
  wxStaticBoxSizer* fraAddingPatternSizer2 = new wxStaticBoxSizer(fraAddingPattern, wxVERTICAL);
  dlgAddMatchFilesSizer->Add(fraAddingPatternSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);  
  wxBoxSizer* fraAddingPatternSizer = new wxBoxSizer(wxVERTICAL);
  fraAddingPatternSizer2->Add(fraAddingPatternSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  wxFlexGridSizer* addPatternSizer = new wxFlexGridSizer(2, CONTROL_SPACE / 2, CONTROL_SPACE);
  fraAddingPatternSizer->Add(addPatternSizer, 0, wxTOP | wxGROW, CONTROL_SPACE / 2);
  addPatternSizer->AddGrowableCol(1);
  addPatternSizer->Add(lblPattern, 0, wxALIGN_CENTER_VERTICAL);
  addPatternSizer->Add(cboPattern, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
  addPatternSizer->Add(lblDirectory, 0, wxALIGN_CENTER_VERTICAL);
  wxBoxSizer* searchDirSizer = new wxBoxSizer(wxHORIZONTAL);
  addPatternSizer->Add(searchDirSizer, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
  searchDirSizer->Add(cboDirectory, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
  searchDirSizer->Add(btnBrowse, 0, wxLEFT | wxALIGN_CENTER_VERTICAL, CONTROL_SPACE);
  addPatternSizer->Add(lblDepth, 0, wxALIGN_CENTER_VERTICAL);
  wxFlexGridSizer* searchDepthSizer = new wxFlexGridSizer(2, 0, CONTROL_SPACE);
  searchDepthSizer->AddGrowableCol(0);
  addPatternSizer->Add(searchDepthSizer, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
  searchDepthSizer->Add(spnDepth, 1, wxALIGN_LEFT | wxALIGN_CENTER_VERTICAL);
  searchDepthSizer->Add(btnAddPattern, 0, wxALIGN_RIGHT | wxALIGN_CENTER_VERTICAL);

  // Validation buttons sizer
  wxGridSizer* buttonsSizer = new wxGridSizer(2, 0, 2 * CONTROL_SPACE);
  buttonsSizer->Add(btnAdd);
  buttonsSizer->Add(btnCancel);
  dlgAddMatchFilesSizer->Add(buttonsSizer, 0, wxTOP | wxALIGN_RIGHT, (3 * CONTROL_SPACE) / 2);

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();


  //-------------------------------------------------------------------------
  // Initializes the controls
  for (int i = 1; i <= getHistoryMaxSize(); i++)
  {
    wxString pattern, directory;
    wxConfig::Get()->Read(getMatchPatternConfigKey(i), &pattern, wxEmptyString);
    wxConfig::Get()->Read(getDirectoryConfigKey(i), &directory, wxEmptyString);
    if (!pattern.IsEmpty())
      cboPattern->Append(pattern.Strip(wxString::both));
    if (!directory.IsEmpty())
      cboDirectory->Append(directory.Strip(wxString::both));
  }
  cboPattern->SetValue(wxEmptyString);
  cboDirectory->SetValue(wxEmptyString);
  
  lvwPatterns->SetColumnWidth(0, wxConfig::Get()->Read(getConfigKey(prGUI_ADD_MATCH_FILES_DIRECTORY_WIDTH), wxLIST_AUTOSIZE_USEHEADER));
  lvwPatterns->SetColumnWidth(1, wxConfig::Get()->Read(getConfigKey(prGUI_ADD_MATCH_FILES_PATTERN_WIDTH), wxLIST_AUTOSIZE_USEHEADER));
  lvwPatterns->SetColumnWidth(2, wxConfig::Get()->Read(getConfigKey(prGUI_ADD_MATCH_FILES_DEPTH_WIDTH), wxLIST_AUTOSIZE_USEHEADER));
  lvwPatterns->SetColumnToSort(wxConfig::Get()->Read(getConfigKey(prGUI_ADD_MATCH_FILES_SORT_BY), 0L));
  lvwPatterns->SetSortOrder(static_cast<wxSortableListView::SortOrder>(wxConfig::Get()->Read(getConfigKey(prGUI_ADD_MATCH_FILES_SORT_ORDER), static_cast<long>(wxSortableListView::none))));
  rbxSortBy->SetSelection(lvwPatterns->GetColumnToSort());
  switch (lvwPatterns->GetSortOrder())
  {
    case wxSortableListView::ascending :
      rbxSortOrder->SetSelection(0);
      break;
    case wxSortableListView::descending :
      rbxSortOrder->SetSelection(1);
      break;
    default :
      rbxSortOrder->SetSelection(2);
  }
}
//---------------------------------------------------------------------------


/**
 * Sets the title of the dialog.
 *
 * This method is called when the name of the checksums' file is modified.
 */
void dlgAddMatchFiles::setDialogTitle()
{
  SetTitle(wxString::Format(_("Add matching files - %s"), getChecksumsFileName().c_str()));
}
//---------------------------------------------------------------------------


/**
 * The class descructor.
 */
dlgAddMatchFiles::~dlgAddMatchFiles()
{
  if (matchPatterns != NULL)
  {
    delete matchPatterns;
    matchPatterns = NULL;
  }
}
//---------------------------------------------------------------------------


/**
 * Processes button Remove.
 *
 * @param  event  The event's parameters
 */
void dlgAddMatchFiles::btnRemoveClick(wxCommandEvent& event)
{
  long item;

  item = lvwPatterns->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED);
  while (item != -1)
  {
    lvwPatterns->DeleteItem(item);
    item = lvwPatterns->GetNextItem(item - 1, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED);
  }
}
//---------------------------------------------------------------------------


/**
 * Gets the last directory used and the filter for the open or save dialog.
 *
 * @param  configKey  Configuration key for the last directory.
 * @param  lastDirKey String that will contains the full configuration key for the last directory.
 * @param  lastDir    String that will contains the last directory.
 * @param  fltMaker   Filter that will contains the filters for the open or save dialog.
 */
void dlgAddMatchFiles::getLastDirectoryAndFilter(const wxString& configKey, wxString& lastDirKey, wxString& lastDir, wxFileDialogFilterMaker& fltMaker)
{
  lastDirKey = dlgAddMatchFiles::getRootConfigKey() + configKey;

  // Get the last directory used
  wxConfig::Get()->Read(lastDirKey, &lastDir, wxEmptyString);
  if (!::wxDirExists(lastDir))
  {
    lastDir = AppPrefs::getUserDocumentsDirName();
    if (lastDir.IsEmpty())
      lastDir = ::wxGetCwd();
  }

  fltMaker.AddFilter(_("wxChecksums matching patterns files"), wxT("wpf"));
  fltMaker.AddFilter(_("All the files"), wxT("*"));
}
//---------------------------------------------------------------------------


/**
 * Reads a file of matching patterns.
 *
 * @param  fileName  Name of the file to read.
 * @param  patterns  Array of patterns in which the read patterns will be
 *                   stored. The array is not erased before adding patterns.
 */
void dlgAddMatchFiles::readMatchPatternsFile(const wxString& fileName, ArrayMatchPattern& patterns)
{
  // Opens the file
  wxFileInputStream input(fileName);
  if (!input.Ok())
    return;
  wxTextInputStream text(input);

  // Reading the file
  wxString line;
  wxString directory;
  wxString pattern;
  long     depth = -1;
  bool     unknow;  // unknow content
  wxString rest;    // rest of the line

  line = text.ReadLine();
  while (!input.Eof())
  {
    unknow = false;
    line.Trim(false).Trim(true);
    if (!line.IsEmpty())
      if (line.GetChar(0) != wxT(';'))
      // This is not a comment
      {
        if (line.Length() >= 4)
        {
        // Reading the contents
          if (line.StartsWith(wxT("Di:"), &rest) && directory.IsEmpty() &&
              pattern.IsEmpty() && depth == -1)
          // Reading a directory
            directory = rest;
          else if (line.StartsWith(wxT("Pa:"), &rest) && !directory.IsEmpty() &&
                   pattern.IsEmpty() && depth == -1)
          // Directory was read, reading the pattern
            pattern = rest;
          else if (line.StartsWith(wxT("De:"), &rest) && !directory.IsEmpty() &&
                   !pattern.IsEmpty() && depth == -1)
          // Directory and pattern were read, reading the depth
          {
            if (rest.ToLong(&depth))
            {
              if (depth >= 0)
              // All is OK, add the pattern to the array
              {
                patterns.add(MatchPattern(directory, pattern, depth));
                unknow = true;  // say the content is unknow so all the parameters will be reinitialized
              }
              else // Bad value for the depth
                unknow = true;
            }
            else  // Can't convert the string to long.
              unknow = true;
          }
          else  // unknow content
            unknow = true;
        }  // line too small, unknow content
        else
          unknow = true;
        
        if (unknow)
        // Reinitializing reading variables
        {
          directory.Empty();
          pattern.Empty();
          depth = -1;
        }
      }

    line = text.ReadLine();
  }
}
//---------------------------------------------------------------------------


/**
 * Processes button Add List.
 *
 * @param  event  The event's parameters
 */
void dlgAddMatchFiles::btnAddListClick(wxCommandEvent& event)
{
  wxString lastDir, lastDirKey;
  wxFileDialogFilterMaker fltMaker;
  getLastDirectoryAndFilter(wxT("LastAddListDirectory"), lastDirKey, lastDir, fltMaker);

  // Show the open dialog
  wxFileDialog dlgOpen(this, _("Add a list of matching patterns"),
                       lastDir, wxEmptyString, fltMaker.GetFilters(),
                       wxOPEN | wxFILE_MUST_EXIST, wxDefaultPosition);

  if (dlgOpen.ShowModal() == wxID_OK)
  {
    ArrayMatchPattern patterns;
    readMatchPatternsFile(dlgOpen.GetPath(), patterns);
    
    // Add the matching patterns to the list
    for (size_t i = 0; i < patterns.getCount(); i++)
      addPatternToListView(patterns[i]);

    // Save the last directory used    
    wxConfig::Get()->Write(lastDirKey, dlgOpen.GetDirectory());
  }
}
//---------------------------------------------------------------------------


/**
 * Processes button Load List.
 *
 * @param  event  The event's parameters
 */
void dlgAddMatchFiles::btnLoadListClick(wxCommandEvent& event)
{
  wxString lastDir, lastDirKey;
  wxFileDialogFilterMaker fltMaker;
  getLastDirectoryAndFilter(wxT("LastLoadListDirectory"), lastDirKey, lastDir, fltMaker);

  // Show the open dialog
  wxFileDialog dlgOpen(this, _("Load a list of matching patterns"),
                       lastDir, wxEmptyString, fltMaker.GetFilters(),
                       wxOPEN | wxFILE_MUST_EXIST, wxDefaultPosition);

  if (dlgOpen.ShowModal() == wxID_OK)
  {
    ArrayMatchPattern patterns;
    readMatchPatternsFile(dlgOpen.GetPath(), patterns);
    
    if (patterns.getCount() > 0)
    {
      // Clear the list only if there is some patterns to add.
      lvwPatterns->DeleteAllItems();
      
      // Add the matching patterns to the list
      for (size_t i = 0; i < patterns.getCount(); i++)
        addPatternToListView(patterns[i]);
    }

    // Save the last directory used    
    wxConfig::Get()->Write(lastDirKey, dlgOpen.GetDirectory());
  }
}
//---------------------------------------------------------------------------


/**
 * Processes button Save List.
 *
 * @param  event  The event's parameters
 */
void dlgAddMatchFiles::btnSaveListClick(wxCommandEvent& event)
{
  wxString lastDir, lastDirKey;
  wxFileDialogFilterMaker fltMaker;
  getLastDirectoryAndFilter(wxT("LastSaveListDirectory"), lastDirKey, lastDir, fltMaker);

  // Show the open dialog
  wxFileDialog dlgSave(this, _("Save the list of matching patterns"),
                       lastDir, wxEmptyString, fltMaker.GetFilters(),
                       wxSAVE | wxOVERWRITE_PROMPT, wxDefaultPosition);

  if (dlgSave.ShowModal() == wxID_OK)
  {
    wxFileOutputStream output(dlgSave.GetPath());
    if (!output.Ok())
      return;
    wxTextOutputStream text(output);

    // Write header
    wxDateTime d = wxDateTime::Now();
    text.WriteString(wxString::Format(wxT("; Generated by %s on %s at %s\n"), ::getAppName().c_str(),
                     d.Format(wxT("%Y-%m-%d")).c_str(), d.Format(wxT("%H:%M:%S")).c_str()));

    // Write patterns
    wxListItem listItem;
    listItem.SetMask(wxLIST_MASK_TEXT);
    long item = lvwPatterns->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
    while (item != -1)
    {
      text.WriteString(wxT(";\n"));
      listItem.SetId(item);
      listItem.SetColumn(0);
      lvwPatterns->GetItem(listItem);
      text.WriteString(wxT("Di:") + listItem.GetText() + wxT('\n'));
      listItem.SetColumn(1);
      lvwPatterns->GetItem(listItem);
      text.WriteString(wxT("Pa:") + listItem.GetText() + wxT('\n'));
      listItem.SetColumn(2);
      lvwPatterns->GetItem(listItem);
      text.WriteString(wxT("De:") + listItem.GetText() + wxT('\n'));

      item = lvwPatterns->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
    }

    // Save the last directory used    
    wxConfig::Get()->Write(lastDirKey, dlgSave.GetDirectory());
  }
}
//---------------------------------------------------------------------------


/**
 * Processes button Browse.
 *
 * @param  event  The event's parameters
 */
void dlgAddMatchFiles::btnBrowseClick(wxCommandEvent& event)
{
  // Get the last directory used
  wxFileName fn(getChecksumsFileName());
  wxString lastDir = fn.GetPath(wxPATH_GET_VOLUME);
  if (!::wxDirExists(lastDir))
  {
    lastDir = AppPrefs::getUserDocumentsDirName();
    if (lastDir.IsEmpty())
      lastDir = ::wxGetCwd();
  }

  // Show the open dialog
  wxDirDialog dlgDir(this, _("Select the directory"));
  dlgDir.SetPath(lastDir);

  if (dlgDir.ShowModal() == wxID_OK)
  {
    cboDirectory->SetValue(dlgDir.GetPath());
    cboDirectory->SetFocus();
  }
}
//---------------------------------------------------------------------------


/**
 * Adds a file or a directory or a match pattern to a combo box.
 *
 * @param  cboBox    The combobox.
 * @param  maxLines  The number of maximum lines in the combobox.
 */
void dlgAddMatchFiles::addLineToComboBox(wxComboBox* cboBox, const int maxLines)
{
  wxString line = cboBox->GetValue().Strip(wxString::both);
  if (!line.IsEmpty())
  {
    bool alreadyPresent = false;
    wxArrayString lines;
    int i = 0;
    while (!alreadyPresent && i < cboBox->GetCount())
    {
      if (compareFileName(cboBox->GetString(i), line) == 0)
        alreadyPresent = true;
      else
      {
        lines.Add(cboBox->GetString(i));
        i++;
      }
    }

    if (!alreadyPresent)
    {
      cboBox->Freeze();
      lines.Insert(line, 0);
      while (cboBox->GetCount() > 0)
        cboBox->Delete(0);
      int s = (lines.GetCount() < maxLines) ? lines.GetCount() : maxLines;
      for (i = 0; i < s; i++)
        cboBox->Append(lines[i]);
      cboBox->Thaw();
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Processes button Add pattern.
 *
 * @param  event  The event's parameters
 */
void dlgAddMatchFiles::btnAddPatternClick(wxCommandEvent& event)
{
  unsigned int depth = (spnDepth->GetValue() > 0) ? static_cast<unsigned int>(spnDepth->GetValue()) : 0U;

  MatchPattern mp(cboDirectory->GetValue().Strip(wxString::both), 
                  cboPattern->GetValue().Strip(wxString::both),
                  depth);
  addPatternToListView(mp);

  addLineToComboBox(cboPattern, getHistoryMaxSize());
  addLineToComboBox(cboDirectory, getHistoryMaxSize());

  for (int i = 1; i <= getHistoryMaxSize(); i++)
  {
    wxString pattern = (cboPattern->GetCount() >= i) ? cboPattern->GetString(i - 1) : wxString();
    wxString directory = (cboDirectory->GetCount() >= i) ? cboDirectory->GetString(i - 1) : wxString();
    wxConfig::Get()->Write(getMatchPatternConfigKey(i), pattern);
    wxConfig::Get()->Write(getDirectoryConfigKey(i), directory);
  }
}
//---------------------------------------------------------------------------


/**
 * Event handler for the selection of an item.
 *
 * @param  event  Event parameters.
 */
void dlgAddMatchFiles::lvwPatternsSelectItem(wxListEvent& event)
{
  btnRemove->Enable();
}
//---------------------------------------------------------------------------


/**
 * Event handler for the deselection of an item.
 *
 * @param  event  Event parameters.
 */
void dlgAddMatchFiles::lvwPatternsDeselectItem(wxListEvent& event)
{
  if (lvwPatterns->GetSelectedItemCount() == 0)
    btnRemove->Disable();
}
//---------------------------------------------------------------------------


/**
 * Processes a selection of the column to sort.
 *
 * @param  event  Event parameters.
 */
void dlgAddMatchFiles::rbxSortBySelect(wxCommandEvent& event)
{
  lvwPatterns->SetColumnToSort(event.GetInt());
  lvwPatterns->SortItems(patternsListCmpFnct, reinterpret_cast<long>(lvwPatterns));
}
//---------------------------------------------------------------------------


/**
 * Processes a selection of the sort order.
 *
 * @param  event  Event parameters.
 */
void dlgAddMatchFiles::rbxSortOrderSelect(wxCommandEvent& event)
{
  switch (event.GetInt())
  {
    case 0 :  // ascending
      lvwPatterns->SetSortOrder(wxSortableListView::ascending);
      break;
    case 1 :  // descending
      lvwPatterns->SetSortOrder(wxSortableListView::descending);
      break;
    case 2 :  // none
      lvwPatterns->SetSortOrder(wxSortableListView::none);
      break;
  }
  lvwPatterns->SortItems(patternsListCmpFnct, reinterpret_cast<long>(lvwPatterns));
}
//---------------------------------------------------------------------------


/**
 * Event handler for the enter key pressed on a search combo box.
 *
 * @param  event  Event parameters.
 */
void dlgAddMatchFiles::cboAddTextEnter(wxCommandEvent& event)
{
  wxCommandEvent e(wxEVT_COMMAND_BUTTON_CLICKED, BTN_ADD_PATTERN);
  btnAddPattern->ProcessEvent(e);
}
//---------------------------------------------------------------------------


/**
 * Event handler for the key down event.
 *
 * @param  event  Event parameters.
 */
void dlgAddMatchFiles::lvwPatternsKeyDown(wxListEvent& event)
{
  switch (event.GetKeyCode())
  {
    case WXK_DELETE : {
      wxCommandEvent e(wxEVT_COMMAND_BUTTON_CLICKED, BTN_REMOVE);
      btnRemove->ProcessEvent(e);
      break; }
    default:
      event.Skip();
  }
}
//---------------------------------------------------------------------------


/**
 * Processes a click on a header of a column of the list of patterns.
 *
 * @param  event  Event parameters.
 */
void dlgAddMatchFiles::lvwPatternsColumnClick(wxListEvent& event)
{
  if (event.GetColumn() == lvwPatterns->GetColumnToSort())
    lvwPatterns->SetSortOrder((lvwPatterns->GetSortOrder() == wxSortableListView::ascending) ? wxSortableListView::descending : wxSortableListView::ascending);
  else
  {
    lvwPatterns->SetSortOrder(wxSortableListView::ascending);
    lvwPatterns->SetColumnToSort(event.GetColumn());
  }

  rbxSortBy->SetSelection(event.GetColumn());
  switch (lvwPatterns->GetSortOrder())
  {
    case wxSortableListView::ascending :
      rbxSortOrder->SetSelection(0);
      break;
    case wxSortableListView::descending :
      rbxSortOrder->SetSelection(1);
      break;
    default :
      rbxSortOrder->SetSelection(2);
  }

  lvwPatterns->SortItems(patternsListCmpFnct, reinterpret_cast<long>(lvwPatterns));
}
//---------------------------------------------------------------------------


/**
 * Processes button Add.
 *
 * @param  event  The event's parameters
 */
void dlgAddMatchFiles::btnAddClick(wxCommandEvent& event)
{
  if (Validate() && TransferDataFromWindow())
  {
    // Save the preferences
    wxConfig::Get()->Write(getConfigKey(prGUI_ADD_MATCH_FILES_SORT_BY), lvwPatterns->GetColumnToSort());
    wxConfig::Get()->Write(getConfigKey(prGUI_ADD_MATCH_FILES_SORT_ORDER), lvwPatterns->GetSortOrder());
    wxConfig::Get()->Write(getConfigKey(prGUI_ADD_MATCH_FILES_DIRECTORY_WIDTH), lvwPatterns->GetColumnWidth(0));
    wxConfig::Get()->Write(getConfigKey(prGUI_ADD_MATCH_FILES_PATTERN_WIDTH), lvwPatterns->GetColumnWidth(1));
    wxConfig::Get()->Write(getConfigKey(prGUI_ADD_MATCH_FILES_DEPTH_WIDTH), lvwPatterns->GetColumnWidth(2));
    wxSize s = GetSize();
    wxConfig::Get()->Write(getConfigKey(prGUI_ADD_MATCH_FILES_WINDOW_SIZE), wxString::Format(wxT("%d,%d"), s.GetWidth(), s.GetHeight()));

    // Close the dialog
    if (IsModal())
      EndModal(wxID_OK);
    else
    {
      SetReturnCode(wxID_OK);
      this->Show(FALSE);
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Add a pattern to the list view of patterns.
 *
 * If the pattern is already are in the list, it is not added.
 *
 * @param  pattern  Pattern to be added to the listview.
 */
void dlgAddMatchFiles::addPatternToListView(const MatchPattern& pattern)
{
  // Remove spaces at the beginning and the end of the pattern and directory. 
  wxString directory = pattern.getDirectory().Strip(wxString::both);
  wxString patterns = pattern.getPattern().Strip(wxString::both);

  // Checks the validity of the parameters
  if (directory.IsEmpty())
    directory = wxT(".");
  if (patterns.IsEmpty())
    patterns = wxT("*");
  
  // Remove the path separators at the end of the directory if needed
  while (!directory.IsEmpty() && directory.Last() == wxFileName::GetPathSeparator())
    directory.RemoveLast();

  MatchPattern patternToAdd(directory, patterns, pattern.getDepth());
  wxListItem listItem;
  listItem.SetMask(wxLIST_MASK_TEXT);
  MatchPattern p;
  long depth;

  // Checks if the pattern isn't already is the list.
  long item = lvwPatterns->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
  bool found = false;
  while (!found && item != -1)
  {
    listItem.SetId(item);
    listItem.SetColumn(0);
    lvwPatterns->GetItem(listItem);
    p.setDirectory(listItem.GetText());
    listItem.SetColumn(1);
    lvwPatterns->GetItem(listItem);
    p.setPattern(listItem.GetText());
    listItem.SetColumn(2);
    lvwPatterns->GetItem(listItem);
    listItem.GetText().ToLong(&depth);
    p.setDepth(depth);

    if (patternToAdd == p)
      found = true;
    else
      item = lvwPatterns->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
  }
  if (!found)
  {
    long newItem = lvwPatterns->InsertItem(lvwPatterns->GetItemCount(), patternToAdd.getDirectory());
    lvwPatterns->SetItem(newItem, 1, patternToAdd.getPattern());
    lvwPatterns->SetItem(newItem, 2, wxString::Format(wxT("%d"), patternToAdd.getDepth()));
    lvwPatterns->SetItemData(newItem, getID());
    lvwPatterns->SortItems(patternsListCmpFnct, reinterpret_cast<long>(lvwPatterns));
  }
}
//---------------------------------------------------------------------------


/**
 * Gets the choosed matching patterns.
 *
 * The given array of matching patterns is erased.
 * The matching array could contains directories with both relative and
 * absolute paths.
 *
 * @param  patterns  The array which will contain the patterns.
 */
void dlgAddMatchFiles::getMatchPatterns(ArrayMatchPattern& patterns) const
{
  if (matchPatterns != NULL)
    patterns = *matchPatterns;
}
//---------------------------------------------------------------------------


/**
 * Gets the name of the checksums' file where the files will be added.
 *
 * @return The name of the checksums' file where the files will be added.
 */
wxString dlgAddMatchFiles::getChecksumsFileName() const
{
  return checksumsFileName;
}
//---------------------------------------------------------------------------

 
/**
 * Sets the name of the checksums' file where the files will be added.
 *
 * @param  fileName  The name of the checksums' file where the files will be added.
 */
void dlgAddMatchFiles::setChecksumsFileName(const wxString& fileName)
{
  checksumsFileName = fileName;
  setDialogTitle();
}
//---------------------------------------------------------------------------


/**
 * Gets the root configuration key for parameters of this dialog.
 *
 * @return  The root configuration key for parameters of this dialog.
 */
inline wxString dlgAddMatchFiles::getRootConfigKey()
{
  return wxT("GUI/AddMatchingFilesDlg/");
}
//---------------------------------------------------------------------------


/**
 * Gets the configuration key for the last match patterns to add.
 *
 * @param  n  The nth history configuration key to get.
 * @return The configuration key for the last match patterns to add.
 */
wxString dlgAddMatchFiles::getMatchPatternConfigKey(const int n)
{
  if (n >= 1 && n <= getHistoryMaxSize())
    return getRootConfigKey() + wxString::Format(wxT("History/MatchPattern%02d"), n);
  else
    return wxEmptyString;
}
//---------------------------------------------------------------------------


/**
 * Gets the configuration key for the last directories to add.
 *
 * @param  n  The nth history configuration key to get.
 * @return The configuration key for the last directories to add.
 */
wxString dlgAddMatchFiles::getDirectoryConfigKey(const int n)
{
  if (n >= 1 && n <= getHistoryMaxSize())
    return getRootConfigKey() + wxString::Format(wxT("History/Directory%02d"), n);
  else
    return wxEmptyString;
}
//---------------------------------------------------------------------------


/**
 * Get the maximum size of the history of the last match patterns and
 * directories to add.
 *
 * @return The maximum size of the history of the match patterns and
 *         directories to add.
 */
inline int dlgAddMatchFiles::getHistoryMaxSize()
{
  return 16;
}
//---------------------------------------------------------------------------


/**
 * Gets the configuration key corresponding to the given preference key.
 *
 * @param  pk  The preference key to get.
 * @return The configuration key corresponding to the given preference key or
 *         an empty string if the preference key is invalid.
 */
wxString dlgAddMatchFiles::getConfigKey(const PreferencesKey pk)
{
  wxString res = getRootConfigKey();

  switch (pk)
  {
    case prGUI_ADD_MATCH_FILES_SORT_BY :
      res += wxT("PatternsList/SortBy");
      break;
    case prGUI_ADD_MATCH_FILES_SORT_ORDER :
      res += wxT("PatternsList/SortOrder");
      break;
    case prGUI_ADD_MATCH_FILES_DIRECTORY_WIDTH :
      res += wxT("PatternsList/ColumnWidthDirectory");
      break;
    case prGUI_ADD_MATCH_FILES_PATTERN_WIDTH :
      res += wxT("PatternsList/ColumnWidthPatterns");
      break;
    case prGUI_ADD_MATCH_FILES_DEPTH_WIDTH :
      res += wxT("PatternsList/ColumnWidthDepth");
      break;
    case prGUI_ADD_MATCH_FILES_WINDOW_SIZE :
      res += wxT("WindowSize");
      break;
    default :
      res = wxEmptyString;
  }

  return res;
}
//---------------------------------------------------------------------------


/**
 * Gets a new unique identifier.
 *
 * @return A new unique identifier.
 */
long dlgAddMatchFiles::getID()
{
  return idGen++;
}
//---------------------------------------------------------------------------



BEGIN_EVENT_TABLE(dlgAddMatchFiles, wxDialog)
  EVT_BUTTON(BTN_REMOVE, dlgAddMatchFiles::btnRemoveClick)
  EVT_BUTTON(BTN_ADDLIST, dlgAddMatchFiles::btnAddListClick)
  EVT_BUTTON(BTN_LOADLIST, dlgAddMatchFiles::btnLoadListClick)
  EVT_BUTTON(BTN_SAVELIST, dlgAddMatchFiles::btnSaveListClick)
  EVT_BUTTON(BTN_BROWSE, dlgAddMatchFiles::btnBrowseClick)
  EVT_BUTTON(BTN_ADD_PATTERN, dlgAddMatchFiles::btnAddPatternClick)
  EVT_LIST_ITEM_SELECTED(LVW_FILES, dlgAddMatchFiles::lvwPatternsSelectItem)
  EVT_LIST_ITEM_DESELECTED(LVW_FILES, dlgAddMatchFiles::lvwPatternsDeselectItem)
  EVT_LIST_DELETE_ITEM(LVW_FILES, dlgAddMatchFiles::lvwPatternsDeselectItem)
  EVT_LIST_KEY_DOWN(LVW_FILES, dlgAddMatchFiles::lvwPatternsKeyDown)
  EVT_LIST_COL_CLICK(LVW_FILES, dlgAddMatchFiles::lvwPatternsColumnClick)
  EVT_RADIOBOX(RBX_SORT_BY, dlgAddMatchFiles::rbxSortBySelect)
  EVT_RADIOBOX(RBX_SORT_ORDER, dlgAddMatchFiles::rbxSortOrderSelect)
  EVT_TEXT_ENTER(CBO_PATTERN, dlgAddMatchFiles::cboAddTextEnter)
  EVT_TEXT_ENTER(CBO_DIRECTORY, dlgAddMatchFiles::cboAddTextEnter)
  EVT_BUTTON(BTN_ADD, dlgAddMatchFiles::btnAddClick)
END_EVENT_TABLE()
//---------------------------------------------------------------------------
