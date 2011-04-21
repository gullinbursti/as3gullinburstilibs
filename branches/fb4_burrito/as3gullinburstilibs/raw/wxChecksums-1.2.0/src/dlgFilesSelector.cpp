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
 * \file dlgFilesSelector.cpp
 * Configuration dialog for selecting multiple files.
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
#include <wx/filename.h>
#include <wx/spinctrl.h>
#include <wx/txtstrm.h>
#include <wx/wfstream.h>

#include <climits>

#include "dlgFilesSelector.hpp"
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
// The list of files compare function
//###########################################################################

/**
 * Function that compare two elements of the list of files of the files
 * selector dialog.
 *
 * @param  item1  Data of the first item. This should be an unique identifier.
 * @param  item2  Data of the second item. This should be an unique identifier.
 * @param  sortData  Adress of the instance of the
 *                   <CODE>wxSortableListView</CODE> that contains the data to
 *                   short.
 */
static int wxCALLBACK filesListCmpFnct(long item1, long item2, long sortData)
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
  if (lv->GetSortOrder() == wxSortableListView::ascending)
    res = ::compareFileName(s1, s2);
  else
    res = ::compareFileName(s2, s1);

  return res;
}
//---------------------------------------------------------------------------



//###########################################################################
// A validator for the files' list
//###########################################################################

static long idGen = LONG_MIN + 1;  ///< Value for unique identifiers generation.

/**
 * Gets a new unique identifier.
 *
 * @return A new unique identifier.
 */
static long getUniqueId()
{
  return idGen++;
}
//---------------------------------------------------------------------------


/**
 * A validator for the files' list.
 *
 * Checks that the given list of file's names has one or more elements.
 *
 * If the list is empty, it displays a message.
 */
class dlgFilesSelector::FilesListValidator : public wxValidator
{
 protected:
  wxArrayString* value;  ///< Adress of the array of strings where the value will be transfered.

  // Clones the source instance in this instance.
  void clone(const FilesListValidator& source);

  // Returns the wxListView associated with the validator.
  wxSortableListView* GetSortableListView() const;

 public:
  // Constructor.
  FilesListValidator(wxArrayString* pValue);

  // Copy constructor.
  FilesListValidator(const FilesListValidator& source);
  
  // Assignment operator.
  FilesListValidator& operator=(const FilesListValidator& source);

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
dlgFilesSelector::FilesListValidator::FilesListValidator(wxArrayString* pValue)
{
  value = pValue;
}
//---------------------------------------------------------------------------


/**
 * Clones the source instance in this instance.
 *
 * @param  source  Source instance.
 */
void dlgFilesSelector::FilesListValidator::clone(const FilesListValidator& source)
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
dlgFilesSelector::FilesListValidator::FilesListValidator(const FilesListValidator& source)
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
dlgFilesSelector::FilesListValidator& dlgFilesSelector::FilesListValidator::operator=(const FilesListValidator& source)
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
wxObject* dlgFilesSelector::FilesListValidator::Clone() const
{
  return new FilesListValidator(*this);
}
//---------------------------------------------------------------------------


/**
 * Returns the <CODE>wxSortableListView</CODE> associated with the validator.
 *
 * @return The <CODE>wxSortableListView</CODE> associated with the validator or
 *         <CODE>NULL</CODE> if the <CODE>wxSortableListView</CODE> associated with
 *         the validator isn't a <CODE>wxSortableListView</CODE>.
 */
wxSortableListView* dlgFilesSelector::FilesListValidator::GetSortableListView() const
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
bool dlgFilesSelector::FilesListValidator::Validate(wxWindow* parent)
{
  wxSortableListView* control = GetSortableListView();
  if (control == NULL)
    return false;

  if (control->GetItemCount() == 0)
  {
    ::wxMessageBox(_("Select at least a file."), _("Warning"), wxOK | wxICON_EXCLAMATION);
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
bool dlgFilesSelector::FilesListValidator::TransferFromWindow()
{
  wxSortableListView* control = GetSortableListView();
  if (control == NULL || value == NULL)
    return false;
  else
  {
    wxString fileName, directory;
    wxListItem listItem;
    listItem.SetMask(wxLIST_MASK_TEXT);
    long item = control->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
    while (item != -1)
    {
      // Read items info
      listItem.SetId(item);
      listItem.SetColumn(0);
      control->GetItem(listItem);
      fileName = listItem.GetText();
      listItem.SetColumn(1);
      control->GetItem(listItem);
      directory = listItem.GetText();

      wxFileName fn(directory, fileName);
      value->Add(fn.GetFullPath());

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
bool dlgFilesSelector::FilesListValidator::TransferToWindow()
{
  wxSortableListView* control = GetSortableListView();
  if (control == NULL || value == NULL)
    return false;
  else
  {
    size_t s = value->GetCount();
    size_t i;
    wxString fileName, lstFileName;
    wxString directory, lstDirectory;
    wxListItem listItem;
    listItem.SetMask(wxLIST_MASK_TEXT);

    for (i = 0; i < s; i++)
    {
      wxFileName fn((*value)[i]);

      // Don't add a directory or a file with a non-absolute path.
      if (!fn.DirExists() && fn.IsAbsolute())
      {
        fileName = fn.GetFullName();
        directory = fn.GetPath(wxPATH_GET_VOLUME);
      
        // Checks if the file isn't already is the list.
        long item = control->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
        bool found = false;
        while (!found && item != -1)
        {
          listItem.SetId(item);
          listItem.SetColumn(0);
          control->GetItem(listItem);
          lstFileName = listItem.GetText();
          listItem.SetColumn(1);
          control->GetItem(listItem);
          lstDirectory = listItem.GetText();

          if (compareFileName(fileName, lstFileName) == 0 &&
              compareFileName(directory, lstDirectory) == 0)
            found = true;
          else
            item = control->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
        }
        if (!found)
        {
          long newItem = control->InsertItem(control->GetItemCount(), fileName);
          control->SetItem(newItem, 1, directory);
          control->SetItemData(newItem, dlgFilesSelector::getID());
        }
      }
    }
    control->SortItems(filesListCmpFnct, reinterpret_cast<long>(control));

    return true;
  }
}
//---------------------------------------------------------------------------



//###########################################################################
// dlgFilesSelector methods
//###########################################################################

IMPLEMENT_ABSTRACT_CLASS(dlgFilesSelector, wxDialog)


/**
 * Creates a new dialog.
 */
dlgFilesSelector::dlgFilesSelector() : wxDialog()
{
  extend = false;
}
//---------------------------------------------------------------------------


/**
 * Creates a new dialog.
 *
 * @param  parent        Parent of the dialog.
 * @param  extendDialog  <CODE>true</CODE> if the dialog will be extended with
 *                       other controls that the ones created by
 *                       <CODE>dlgFilesSelector</CODE>. If this parameter is
 *                       <CODE>true</CODE> then the <CODE>extendSizer</CODE>
 *                       attribute is initialised otherwise it equals to
 *                       <CODE>NULL</CODE>.
 */
dlgFilesSelector::dlgFilesSelector(wxWindow* parent, const bool extendDialog) :
  wxDialog(parent, -1, wxEmptyString, wxDefaultPosition, wxDefaultSize, 
           wxDEFAULT_DIALOG_STYLE | wxRESIZE_BORDER)
{
  extend = extendDialog;
}
//---------------------------------------------------------------------------


/**
 * Initializes the dialog.
 *
 * If you derivate this method, please call the one of the parent class before
 * doing anything.
 */
void dlgFilesSelector::initialize()
{
  createControls();
 
  Fit();
  
  // Get the size of the window
  wxSize s;
  if (PreferenceValue::read(getConfigKey(prGUI_WINDOW_SIZE), &s))
    SetSize(s);
  
  Centre();
}
//---------------------------------------------------------------------------



/**
 * Creates and initializes the controls of the dialog.
 */
void dlgFilesSelector::createControls()
{
  // Creates the controls
  SetTitle(getUIString(uiDialogTitle));
  wxStaticBox* fraFilesList = new wxStaticBox(this, -1, getUIString(uiFraFilesList));
  lvwFiles = new wxSortableListView(this, LVW_FILES, wxDefaultPosition,
                            wxSize((this->GetParent()->GetSize().GetWidth() * 2) / 3,
                                   (this->GetParent()->GetSize().GetHeight() / 2)),
                            wxLC_REPORT, FilesListValidator(&(this->fileNames)));
  lvwFiles->InsertColumn(0, _("File name"));
  lvwFiles->InsertColumn(1, _("Directory"));

  btnAdd = new wxButton(this, BTN_ADD, _("&Add..."));
  btnRemove = new wxButton(this, BTN_REMOVE, _("&Remove"));
  btnRemove->Disable();
  wxButton* btnAddList = new wxButton(this, BTN_ADDLIST, _("Add li&st..."));
  wxButton* btnLoadList = new wxButton(this, BTN_LOADLIST, _("L&oad list..."));
  wxButton* btnSaveList = new wxButton(this, BTN_SAVELIST, _("Sa&ve list..."));
  const wxString rbxSortByChoices[] = { _("File name"), _("Directory") };
  rbxSortBy = new wxRadioBox(this, RBX_SORT_BY, _("Sort b&y:"), wxDefaultPosition, wxDefaultSize, 2, rbxSortByChoices, 1, wxRA_SPECIFY_COLS);
  const wxString rbxSortOrderChoices[] = { _("Ascending"), _("Descending"), _("Don't sort") };
  rbxSortOrder = new wxRadioBox(this, RBX_SORT_ORDER, _("Sor&t order:"), wxDefaultPosition, wxDefaultSize, 3, rbxSortOrderChoices, 1, wxRA_SPECIFY_COLS);

  wxStaticBox* fraSearchFiles = new wxStaticBox(this, -1, getUIString(uiFraSearchFiles));
  wxStaticText* lblNamed = new wxStaticText(this, -1, _("&Named:"));
  cboNamed = new wxComboBox(this, CBO_NAMED);
  wxStaticText* lblLookIn = new wxStaticText(this, -1, _("Look &in:"));
  cboLookIn = new wxComboBox(this, CBO_LOOKIN);
  wxButton* btnBrowse = new wxButton(this, BTN_BROWSE, _("&Browse..."));
  wxStaticText* lblDepth = new wxStaticText(this, -1, _("&Depth:"));
  spnDepth = new wxSpinCtrl(this, SPN_DEPTH, wxT("0"), wxDefaultPosition, wxDefaultSize, wxSP_ARROW_KEYS | wxSP_WRAP, 0, SHRT_MAX, 0);
  btnSearchAndAdd = new wxButton(this, BTN_SEARCH_AND_ADD, _("S&earch and add"));

  wxButton* btnOK = new wxButton(this, BTN_OK, getUIString(uiBtnOK));
  btnOK->SetDefault();
  wxButton* btnCancel = new wxButton(this, wxID_CANCEL, _("Ca&ncel"));


  //-------------------------------------------------------------------------
  // Creates the dialog sizers

  // Dialog sizer
  wxBoxSizer* dlgFilesSelectorSizer2 = new wxBoxSizer(wxVERTICAL);
  this->SetSizer(dlgFilesSelectorSizer2);
  wxBoxSizer* dlgFilesSelectorSizer = new wxBoxSizer(wxVERTICAL);
  dlgFilesSelectorSizer2->Add(dlgFilesSelectorSizer, 1, wxALL | wxGROW, CONTROL_SPACE);

  // List of files
  wxStaticBoxSizer* fraFilesListSizer2 = new wxStaticBoxSizer(fraFilesList, wxVERTICAL);
  dlgFilesSelectorSizer->Add(fraFilesListSizer2, 1, wxGROW);  
  wxBoxSizer* fraFilesListSizer = new wxBoxSizer(wxHORIZONTAL);
  fraFilesListSizer2->Add(fraFilesListSizer, 1, wxALL | wxGROW, CONTROL_SPACE / 2);

  fraFilesListSizer->Add(lvwFiles, 1, wxGROW);
  
  wxBoxSizer* filesListButtonsSizer = new wxBoxSizer(wxVERTICAL);
  filesListButtonsSizer->Add(btnAdd, 0, wxGROW | wxTOP, CONTROL_SPACE);
  filesListButtonsSizer->Add(btnRemove, 0, wxGROW | wxTOP, CONTROL_SPACE / 2);
  filesListButtonsSizer->Add(btnAddList, 0, wxGROW | wxTOP, CONTROL_SPACE);
  filesListButtonsSizer->Add(btnLoadList, 0, wxGROW | wxTOP, CONTROL_SPACE / 2);
  filesListButtonsSizer->Add(btnSaveList, 0, wxGROW | wxTOP, CONTROL_SPACE / 2);
  filesListButtonsSizer->Add(rbxSortBy, 0, wxGROW | wxTOP, CONTROL_SPACE);
  filesListButtonsSizer->Add(rbxSortOrder, 0, wxGROW | wxTOP, CONTROL_SPACE / 2);
  fraFilesListSizer->Add(filesListButtonsSizer, 0, wxLEFT | wxALIGN_TOP, CONTROL_SPACE);

  // Search files section
  wxStaticBoxSizer* fraSearchFilesSizer2 = new wxStaticBoxSizer(fraSearchFiles, wxVERTICAL);
  dlgFilesSelectorSizer->Add(fraSearchFilesSizer2, 0, wxGROW | wxTOP, CONTROL_SPACE);  
  wxBoxSizer* fraSearchFilesSizer = new wxBoxSizer(wxVERTICAL);
  fraSearchFilesSizer2->Add(fraSearchFilesSizer, 0, wxALL | wxGROW, CONTROL_SPACE / 2);

  wxFlexGridSizer* searchSizer = new wxFlexGridSizer(2, CONTROL_SPACE / 2, CONTROL_SPACE);
  fraSearchFilesSizer->Add(searchSizer, 0, wxTOP | wxGROW, CONTROL_SPACE / 2);
  searchSizer->AddGrowableCol(1);
  searchSizer->Add(lblNamed, 0, wxALIGN_CENTER_VERTICAL);
  searchSizer->Add(cboNamed, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
  searchSizer->Add(lblLookIn, 0, wxALIGN_CENTER_VERTICAL);
  wxBoxSizer* searchDirSizer = new wxBoxSizer(wxHORIZONTAL);
  searchSizer->Add(searchDirSizer, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
  searchDirSizer->Add(cboLookIn, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
  searchDirSizer->Add(btnBrowse, 0, wxLEFT | wxALIGN_CENTER_VERTICAL, CONTROL_SPACE);
  searchSizer->Add(lblDepth, 0, wxALIGN_CENTER_VERTICAL);
  wxFlexGridSizer* searchDepthSizer = new wxFlexGridSizer(2, 0, CONTROL_SPACE);
  searchDepthSizer->AddGrowableCol(0);
  searchSizer->Add(searchDepthSizer, 1, wxALIGN_CENTER_VERTICAL | wxGROW);
  searchDepthSizer->Add(spnDepth, 1, wxALIGN_LEFT | wxALIGN_CENTER_VERTICAL);
  searchDepthSizer->Add(btnSearchAndAdd, 0, wxALIGN_RIGHT | wxALIGN_CENTER_VERTICAL);

  // Extend sizer
  if (extend)
  {
    extendSizer = new wxBoxSizer(wxVERTICAL);
    dlgFilesSelectorSizer->Add(extendSizer, 0, wxGROW);
  }
  else
    extendSizer = NULL;

  // Validation buttons sizer
  wxGridSizer* buttonsSizer = new wxGridSizer(2, 0, 2 * CONTROL_SPACE);
  buttonsSizer->Add(btnOK);
  buttonsSizer->Add(btnCancel);
  dlgFilesSelectorSizer->Add(buttonsSizer, 0, wxTOP | wxALIGN_RIGHT, (3 * CONTROL_SPACE) / 2);

  // Set on the auto-layout feature
  this->SetAutoLayout(true);
  this->Layout();


  //-------------------------------------------------------------------------
  // Initializes the controls
  for (int i = 1; i <= getHistoryMaxSize(); i++)
  {
    wxString named, lookIn;
    wxConfig::Get()->Read(getNamedConfigKey(i), &named, wxEmptyString);
    wxConfig::Get()->Read(getLookInConfigKey(i), &lookIn, wxEmptyString);
    if (!named.IsEmpty())
      cboNamed->Append(named.Strip(wxString::both));
    if (!lookIn.IsEmpty())
      cboLookIn->Append(lookIn.Strip(wxString::both));
  }
  cboNamed->SetValue(wxEmptyString);
  cboLookIn->SetValue(wxEmptyString);
  
  lvwFiles->SetColumnWidth(0, wxConfig::Get()->Read(getConfigKey(prGUI_FILENAME_WIDTH), wxLIST_AUTOSIZE_USEHEADER));
  lvwFiles->SetColumnWidth(1, wxConfig::Get()->Read(getConfigKey(prGUI_DIRECTORY_WIDTH), wxLIST_AUTOSIZE_USEHEADER));
  lvwFiles->SetColumnToSort(wxConfig::Get()->Read(getConfigKey(prGUI_SORT_BY), 0L));
  lvwFiles->SetSortOrder(static_cast<wxSortableListView::SortOrder>(wxConfig::Get()->Read(getConfigKey(prGUI_SORT_ORDER), static_cast<long>(wxSortableListView::none))));
  rbxSortBy->SetSelection(lvwFiles->GetColumnToSort());
  switch (lvwFiles->GetSortOrder())
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
 * The class descructor.
 */
dlgFilesSelector::~dlgFilesSelector()
{
}
//---------------------------------------------------------------------------


/**
 * Processes button Add.
 *
 * @param  event  The event's parameters
 */
void dlgFilesSelector::btnAddClick(wxCommandEvent& event)
{
  wxString lastDirKey = getRootConfigKey() + wxT("LastAddDirectory");
  wxString lastDir;

  // Get the last directory used
  wxConfig::Get()->Read(lastDirKey, &lastDir, wxEmptyString);
  if (!::wxDirExists(lastDir))
  {
    lastDir = AppPrefs::getUserDocumentsDirName();
    if (lastDir.IsEmpty())
      lastDir = ::wxGetCwd();
  }

  // Gets the filter for knows types of checksums' files
  wxFileDialogFilterMaker fltMaker = getFiltersForAddFilesDialog();

  wxFileDialog dlgSelect(this, getUIString(uiOpenDlgAddFiles),
                         lastDir, wxEmptyString, fltMaker.GetFilters(),
                         wxOPEN | wxHIDE_READONLY | wxMULTIPLE | wxFILE_MUST_EXIST, wxDefaultPosition);

  if (dlgSelect.ShowModal() == wxID_OK)
  {
    wxArrayString files;
    dlgSelect.GetPaths(files);
    addFileNamesToListView(files);

    // Save the last directory used    
    wxConfig::Get()->Write(lastDirKey, dlgSelect.GetDirectory());
  }
}
//---------------------------------------------------------------------------


/**
 * Processes button Remove.
 *
 * @param  event  The event's parameters
 */
void dlgFilesSelector::btnRemoveClick(wxCommandEvent& event)
{
  long item;

  item = lvwFiles->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED);
  while (item != -1)
  {
    lvwFiles->DeleteItem(item);
    item = lvwFiles->GetNextItem(item - 1, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED);
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
void dlgFilesSelector::getLastDirectoryAndFilter(const wxString& configKey, wxString& lastDirKey, wxString& lastDir, wxFileDialogFilterMaker& fltMaker)
{
  lastDirKey = getRootConfigKey() + configKey;

  // Get the last directory used
  wxConfig::Get()->Read(lastDirKey, &lastDir, wxEmptyString);
  if (!::wxDirExists(lastDir))
  {
    lastDir = AppPrefs::getUserDocumentsDirName();
    if (lastDir.IsEmpty())
      lastDir = ::wxGetCwd();
  }

  fltMaker.AddFilter(_("Known files"), wxT("lst|txt"));
  fltMaker.AddFilter(_("Text files"), wxT("txt"));
  fltMaker.AddFilter(_("List of files"), wxT("lst"));
  fltMaker.AddFilter(_("All the files"), wxT("*"));
}
//---------------------------------------------------------------------------


/**
 * Processes button Add List.
 *
 * @param  event  The event's parameters
 */
void dlgFilesSelector::btnAddListClick(wxCommandEvent& event)
{
  wxString lastDir, lastDirKey;
  wxFileDialogFilterMaker fltMaker;
  getLastDirectoryAndFilter(wxT("LastAddListDirectory"), lastDirKey, lastDir, fltMaker);

  // Show the open dialog
  wxFileDialog dlgOpen(this, getUIString(uiOpenDlgAddList),
                       lastDir, wxEmptyString, fltMaker.GetFilters(),
                       wxOPEN | wxFILE_MUST_EXIST, wxDefaultPosition);

  if (dlgOpen.ShowModal() == wxID_OK)
  {
    // Opens the file
    wxFileInputStream input(dlgOpen.GetPath());
    if (!input.Ok())
      return;
    wxTextInputStream text(input);

    // Reads the lines
    wxArrayString files;
    wxString line;
    line = text.ReadLine();
    while (!input.Eof())
    {
      line.Trim(false).Trim(true);
      if (!line.IsEmpty())
        files.Add(line);
      line = text.ReadLine();
    }
    
    // Add the files to the list
    addFileNamesToListView(files);

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
void dlgFilesSelector::btnLoadListClick(wxCommandEvent& event)
{
  wxString lastDir, lastDirKey;
  wxFileDialogFilterMaker fltMaker;
  getLastDirectoryAndFilter(wxT("LastLoadListDirectory"), lastDirKey, lastDir, fltMaker);

  // Show the open dialog
  wxFileDialog dlgOpen(this, getUIString(uiOpenDlgLoadList),
                       lastDir, wxEmptyString, fltMaker.GetFilters(),
                       wxOPEN | wxFILE_MUST_EXIST, wxDefaultPosition);

  if (dlgOpen.ShowModal() == wxID_OK)
  {
    // Opens the file
    wxFileInputStream input(dlgOpen.GetPath());
    if (!input.Ok())
      return;
    wxTextInputStream text(input);

    // Reads the lines
    wxArrayString files;
    wxString line;
    line = text.ReadLine();
    while (!input.Eof())
    {
      line.Trim(false).Trim(true);
      if (!line.IsEmpty())
        files.Add(line);
      line = text.ReadLine();
    }
    
    // Remove all the previous files
    lvwFiles->DeleteAllItems();
    
    // Add the files to the list
    addFileNamesToListView(files);

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
void dlgFilesSelector::btnSaveListClick(wxCommandEvent& event)
{
  wxString lastDir, lastDirKey;
  wxFileDialogFilterMaker fltMaker;
  getLastDirectoryAndFilter(wxT("LastSaveListDirectory"), lastDirKey, lastDir, fltMaker);

  // Show the open dialog
  wxFileDialog dlgSave(this, getUIString(uiSaveDlgAddList),
                       lastDir, wxEmptyString, fltMaker.GetFilters(),
                       wxSAVE | wxOVERWRITE_PROMPT, wxDefaultPosition);

  if (dlgSave.ShowModal() == wxID_OK)
  {
    wxFileOutputStream output(dlgSave.GetPath());
    if (!output.Ok())
      return;
    wxTextOutputStream text(output);

    wxString fileName, directory;
    wxListItem listItem;
    listItem.SetMask(wxLIST_MASK_TEXT);
    long item = lvwFiles->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
    while (item != -1)
    {
      // Read items info
      listItem.SetId(item);
      listItem.SetColumn(0);
      lvwFiles->GetItem(listItem);
      fileName = listItem.GetText();
      listItem.SetColumn(1);
      lvwFiles->GetItem(listItem);
      directory = listItem.GetText();

      wxFileName fn(directory, fileName);
      text.WriteString(fn.GetFullPath() + wxT('\n'));

      item = lvwFiles->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
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
void dlgFilesSelector::btnBrowseClick(wxCommandEvent& event)
{
  const wxString lastDirKey = getRootConfigKey() + wxT("LookInBrowseLastDir");
  wxString lastDir;
  
  // Get the last directory used
  wxConfig::Get()->Read(lastDirKey, &lastDir, wxEmptyString);
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
    cboLookIn->SetValue(dlgDir.GetPath());
    cboLookIn->SetFocus();
    wxConfig::Get()->Write(lastDirKey, dlgDir.GetPath());
  }
}
//---------------------------------------------------------------------------


/**
 * Adds a file or a directory or a match pattern to a combo box.
 *
 * @param  cboBox    The combobox.
 * @param  maxLines  The number of maximum lines in the combobox.
 */
void dlgFilesSelector::addLineToComboBox(wxComboBox* cboBox, const int maxLines)
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
 * Processes button Search and Add.
 *
 * @param  event  The event's parameters
 */
void dlgFilesSelector::btnSearchAndAddClick(wxCommandEvent& event)
{
  // Checks the validity of the parameters
  if (cboLookIn->GetValue().IsEmpty())
  {
    ::wxMessageBox(_("Please choose a directory."), _("Warning"), wxOK | wxICON_EXCLAMATION);
    cboLookIn->SetFocus();
    return;
  }
  if (!::wxDirExists(cboLookIn->GetValue()))
  {
    ::wxMessageBox(wxString::Format(_("'%s' is invalid."), cboLookIn->GetValue().c_str()), _("Warning"), wxOK | wxICON_EXCLAMATION);
    cboLookIn->SetFocus();
    return;
  }
  unsigned int depth = (spnDepth->GetValue() > 0) ? static_cast<unsigned int>(spnDepth->GetValue()) : 0U;

  // No log
  wxLogNull logNo;

  // Find the files  
  wxArrayString res;
  wxArrayString files;
  BytesDisplayer size;
  files.Add(cboLookIn->GetValue());
  if (::getFilesInSubdirectories(files, res, size, cboNamed->GetValue().Strip(wxString::both), depth))
  {
    addFileNamesToListView(res);
    addLineToComboBox(cboNamed, getHistoryMaxSize());
    addLineToComboBox(cboLookIn, getHistoryMaxSize());
    
    for (int i = 1; i <= getHistoryMaxSize(); i++)
    {
      wxString named = (cboNamed->GetCount() >= i) ? cboNamed->GetString(i - 1) : wxString();
      wxString lookIn = (cboLookIn->GetCount() >= i) ? cboLookIn->GetString(i - 1) : wxString();
      wxConfig::Get()->Write(getNamedConfigKey(i), named);
      wxConfig::Get()->Write(getLookInConfigKey(i), lookIn);
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Event handler for the selection of an item.
 *
 * @param  event  Event parameters.
 */
void dlgFilesSelector::lvwFilesSelectItem(wxListEvent& event)
{
  btnRemove->Enable();
}
//---------------------------------------------------------------------------


/**
 * Event handler for the deselection of an item.
 *
 * @param  event  Event parameters.
 */
void dlgFilesSelector::lvwFilesDeselectItem(wxListEvent& event)
{
  if (lvwFiles->GetSelectedItemCount() == 0)
    btnRemove->Disable();
}
//---------------------------------------------------------------------------


/**
 * Processes a selection of the column to sort.
 *
 * @param  event  Event parameters.
 */
void dlgFilesSelector::rbxSortBySelect(wxCommandEvent& event)
{
  lvwFiles->SetColumnToSort(event.GetInt());
  lvwFiles->SortItems(filesListCmpFnct, reinterpret_cast<long>(lvwFiles));
}
//---------------------------------------------------------------------------


/**
 * Processes a selection of the sort order.
 *
 * @param  event  Event parameters.
 */
void dlgFilesSelector::rbxSortOrderSelect(wxCommandEvent& event)
{
  switch (event.GetInt())
  {
    case 0 :  // ascending
      lvwFiles->SetSortOrder(wxSortableListView::ascending);
      break;
    case 1 :  // descending
      lvwFiles->SetSortOrder(wxSortableListView::descending);
      break;
    case 2 :  // none
      lvwFiles->SetSortOrder(wxSortableListView::none);
      break;
  }
  lvwFiles->SortItems(filesListCmpFnct, reinterpret_cast<long>(lvwFiles));
}
//---------------------------------------------------------------------------


/**
 * Event handler for the enter key pressed on a search combo box.
 *
 * @param  event  Event parameters.
 */
void dlgFilesSelector::cboSearchTextEnter(wxCommandEvent& event)
{
  wxCommandEvent e(wxEVT_COMMAND_BUTTON_CLICKED, BTN_SEARCH_AND_ADD);
  btnSearchAndAdd->ProcessEvent(e);
}
//---------------------------------------------------------------------------


/**
 * Event handler for the key down event.
 *
 * @param  event  Event parameters.
 */
void dlgFilesSelector::lvwFilesKeyDown(wxListEvent& event)
{
  switch (event.GetKeyCode())
  {
    case WXK_INSERT : {
      wxCommandEvent e(wxEVT_COMMAND_BUTTON_CLICKED, BTN_ADD);
      btnAdd->ProcessEvent(e);
      break; }
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
 * Processes a click on a header of a column of the list of files.
 *
 * @param  event  Event parameters.
 */
void dlgFilesSelector::lvwFilesColumnClick(wxListEvent& event)
{
  if (event.GetColumn() == lvwFiles->GetColumnToSort())
    lvwFiles->SetSortOrder((lvwFiles->GetSortOrder() == wxSortableListView::ascending) ? wxSortableListView::descending : wxSortableListView::ascending);
  else
  {
    lvwFiles->SetSortOrder(wxSortableListView::ascending);
    lvwFiles->SetColumnToSort(event.GetColumn());
  }

  rbxSortBy->SetSelection(event.GetColumn());
  switch (lvwFiles->GetSortOrder())
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

  lvwFiles->SortItems(filesListCmpFnct, reinterpret_cast<long>(lvwFiles));
}
//---------------------------------------------------------------------------


/**
 * Processes button OK.
 *
 * @param  event  The event's parameters
 */
void dlgFilesSelector::btnOKClick(wxCommandEvent& event)
{
  if (Validate() && TransferDataFromWindow())
  {
    // Save the preferences
    wxConfig::Get()->Write(getConfigKey(prGUI_SORT_BY), lvwFiles->GetColumnToSort());
    wxConfig::Get()->Write(getConfigKey(prGUI_SORT_ORDER), lvwFiles->GetSortOrder());
    wxConfig::Get()->Write(getConfigKey(prGUI_FILENAME_WIDTH), lvwFiles->GetColumnWidth(0));
    wxConfig::Get()->Write(getConfigKey(prGUI_DIRECTORY_WIDTH), lvwFiles->GetColumnWidth(1));
    wxSize s = GetSize();
    wxConfig::Get()->Write(getConfigKey(prGUI_WINDOW_SIZE), wxString::Format(wxT("%d,%d"), s.GetWidth(), s.GetHeight()));

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
 * Adds the given array of file names to the listview of file names.
 *
 * The names that already are in the list are not added.
 *
 * @param  fileNames  Names of the files to be added to the listview.
 */
void dlgFilesSelector::addFileNamesToListView(const wxArrayString& fileNames)
{
  size_t s = fileNames.GetCount();
  size_t i;
  wxString fileName, lstFileName;
  wxString directory, lstDirectory;
  wxListItem listItem;
  listItem.SetMask(wxLIST_MASK_TEXT);

  for (i = 0; i < s; i++)
  {
    wxFileName fn(fileNames[i]);

    // Don't add a directory or a file with a non-absolute path.
    if (!fn.DirExists() && fn.IsAbsolute())
    {
      fileName = fn.GetFullName();
      directory = fn.GetPath(wxPATH_GET_VOLUME);
      
      // Checks if the file isn't already is the list.
      long item = lvwFiles->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
      bool found = false;
      while (!found && item != -1)
      {
        listItem.SetId(item);
        listItem.SetColumn(0);
        lvwFiles->GetItem(listItem);
        lstFileName = listItem.GetText();
        listItem.SetColumn(1);
        lvwFiles->GetItem(listItem);
        lstDirectory = listItem.GetText();

        if (compareFileName(fileName, lstFileName) == 0 &&
            compareFileName(directory, lstDirectory) == 0)
          found = true;
        else
          item = lvwFiles->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
      }
      if (!found)
      {
        long newItem = lvwFiles->InsertItem(lvwFiles->GetItemCount(), fileName);
        lvwFiles->SetItem(newItem, 1, directory);
        lvwFiles->SetItemData(newItem, getID());
      }
    }
  }
  lvwFiles->SortItems(filesListCmpFnct, reinterpret_cast<long>(lvwFiles));
}
//---------------------------------------------------------------------------


/**
 * Gets the names of the files.
 *
 * @param  names  The array which will contain the names of the files.
 */
void dlgFilesSelector::getFileNames(wxArrayString& names) const
{
  names = fileNames;
}
//---------------------------------------------------------------------------


/**
 * Gets the configuration key for the last files' names for searching files.
 *
 * @param  n  The nth history configuration key to get.
 * @return The configuration key for the last files' names for searching files.
 */
wxString dlgFilesSelector::getNamedConfigKey(const int n)
{
  if (n >= 1 && n <= getHistoryMaxSize())
    return getRootConfigKey() + wxString::Format(wxT("History/Named%02d"), n);
  else
    return wxEmptyString;
}
//---------------------------------------------------------------------------


/**
 * Gets the configuration key for the last directories for searching files.
 *
 * @param  n  The nth history configuration key to get.
 * @return The configuration key for the last directories for searching files.
 */
wxString dlgFilesSelector::getLookInConfigKey(const int n)
{
  if (n >= 1 && n <= getHistoryMaxSize())
    return getRootConfigKey() + wxString::Format(wxT("History/LookIn%02d"), n);
  else
    return wxEmptyString;
}
//---------------------------------------------------------------------------


/**
 * Get the maximum size of the history of the last files' names and directories
 * for searching files.
 *
 * @return The maximum size of the history of the last files' names and
 *         directories for searching files.
 */
inline int dlgFilesSelector::getHistoryMaxSize()
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
wxString dlgFilesSelector::getConfigKey(const PreferencesKey pk)
{
  wxString res = getRootConfigKey();

  switch (pk)
  {
    case prGUI_SORT_BY :
      res += wxT("FilesList/SortBy");
      break;
    case prGUI_SORT_ORDER :
      res += wxT("FilesList/SortOrder");
      break;
    case prGUI_FILENAME_WIDTH :
      res += wxT("FilesList/ColumnWidthFileName");
      break;
    case prGUI_DIRECTORY_WIDTH :
      res += wxT("FilesList/ColumnWidthDirectory");
      break;
    case prGUI_WINDOW_SIZE :
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
long dlgFilesSelector::getID()
{
  return ::getUniqueId();
}
//---------------------------------------------------------------------------



BEGIN_EVENT_TABLE(dlgFilesSelector, wxDialog)
  EVT_BUTTON(BTN_ADD, dlgFilesSelector::btnAddClick)
  EVT_BUTTON(BTN_REMOVE, dlgFilesSelector::btnRemoveClick)
  EVT_BUTTON(BTN_ADDLIST, dlgFilesSelector::btnAddListClick)
  EVT_BUTTON(BTN_LOADLIST, dlgFilesSelector::btnLoadListClick)
  EVT_BUTTON(BTN_SAVELIST, dlgFilesSelector::btnSaveListClick)
  EVT_BUTTON(BTN_BROWSE, dlgFilesSelector::btnBrowseClick)
  EVT_BUTTON(BTN_SEARCH_AND_ADD, dlgFilesSelector::btnSearchAndAddClick)
  EVT_LIST_ITEM_SELECTED(LVW_FILES, dlgFilesSelector::lvwFilesSelectItem)
  EVT_LIST_ITEM_DESELECTED(LVW_FILES, dlgFilesSelector::lvwFilesDeselectItem)
  EVT_LIST_DELETE_ITEM(LVW_FILES, dlgFilesSelector::lvwFilesDeselectItem)
  EVT_LIST_KEY_DOWN(LVW_FILES, dlgFilesSelector::lvwFilesKeyDown)
  EVT_LIST_COL_CLICK(LVW_FILES, dlgFilesSelector::lvwFilesColumnClick)
  EVT_RADIOBOX(RBX_SORT_BY, dlgFilesSelector::rbxSortBySelect)
  EVT_RADIOBOX(RBX_SORT_ORDER, dlgFilesSelector::rbxSortOrderSelect)
  EVT_TEXT_ENTER(CBO_NAMED, dlgFilesSelector::cboSearchTextEnter)
  EVT_TEXT_ENTER(CBO_LOOKIN, dlgFilesSelector::cboSearchTextEnter)
  EVT_BUTTON(BTN_OK, dlgFilesSelector::btnOKClick)
END_EVENT_TABLE()
//---------------------------------------------------------------------------
