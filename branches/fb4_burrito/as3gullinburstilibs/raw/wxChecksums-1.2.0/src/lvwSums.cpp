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
 * \file lvwSums.cpp
 * A personalized listview to display information about checksums.
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

#if wxUSE_DRAG_AND_DROP
#include <wx/dnd.h>
#endif  // wxUSE_DRAG_AND_DROP
#include <wx/datetime.h>
#include <wx/imaglist.h>

#include "lvwSums.hpp"
#include "dlgAddMatchFiles.hpp"
#include "dlgInvalidFiles.hpp"
#include "dlgProgress.hpp"

#include "appprefs.hpp"
#include "bytedisp.hpp"
#include "checksumutil.hpp"
#include "comdefs.hpp"
#include "fileutil.hpp"
#include "fdftlmk.hpp"
#include "osdep.hpp"
#include "sumfile.hpp"
#include "utils.hpp"

#include "bitmaps/lvw_sums_notverified.xpm"
#include "bitmaps/lvw_sums_verified.xpm"
#include "bitmaps/lvw_sums_invalid.xpm"
#include "bitmaps/lvw_sums_notfound.xpm"
#include "bitmaps/hi16_action_fileadd.xpm"
#include "bitmaps/hi16_action_directoryadd.xpm"
#include "bitmaps/hi16_action_addmatchingfiles.xpm"
#include "bitmaps/hi16_action_fileremove.xpm"

#include "compat.hpp"
//---------------------------------------------------------------------------


/// The C++ standard namespace.
using namespace std;


/*
 * Defines a custom event for files dropping from the explorer or a file
 * manager.
 *
 * On Windows the Explorer waits that DndCheckSumListView::OnDropFiles()
 * return a value that could be long if the checksums are proceeded.
 * So DndCheckSumListView::OnDropFiles() post a EVT_DNDFILES_COMMAND
 * event and the checksums list adds itself the files.
 */
BEGIN_DECLARE_EVENT_TYPES()
    DECLARE_EVENT_TYPE(EVENT_DNDFILES_COMMAND, 10001)
END_DECLARE_EVENT_TYPES()

DEFINE_EVENT_TYPE(EVENT_DNDFILES_COMMAND)


/*
 * Defines a custom event for updating the dialog title.
 * Use this event when a child want the dialog title to be updated.
 */
DEFINE_LOCAL_EVENT_TYPE(EVENT_UPDATE_SUMS_FRAME_TITLE_COMMAND)

/*
 * Defines a custom event for updating the status bar.
 * Use this event when a child want the dialog status bar to be updated.
 */
DEFINE_LOCAL_EVENT_TYPE(EVENT_UPDATE_SUMS_FRAME_STATUSBAR_COMMAND)

/*
 * Defines a custom event for adding a file in the open recently file list.
 */
DEFINE_LOCAL_EVENT_TYPE(EVENT_OPEN_RECENT_ADD_FILE)


//###########################################################################
// A custom drop target which accepts files
//###########################################################################
#if wxUSE_DRAG_AND_DROP
/**
 * Drop target which accepts files for the checksums list.
 */
class DndCheckSumListView : public wxFileDropTarget
{
 public:
  // Constructor.
  DndCheckSumListView(ChecksumsListView *pOwner);

  // Event handler for dropped file of the list.
  virtual bool OnDropFiles(wxCoord x, wxCoord y, const wxArrayString& filenames);

 private:
  ChecksumsListView* owner;  ///< Owner list of this object.
};
//---------------------------------------------------------------------------


/**
 * Constructor.
 *
 * @param  pOwner  Adress of the list which owns this drop target.
 */
DndCheckSumListView::DndCheckSumListView(ChecksumsListView *pOwner)
{
  owner = pOwner;
}
//---------------------------------------------------------------------------


/**
 * Event handler for dropped file of the list.
 *
 * Posts an EVENT_DNDFILES_COMMAND event. The owner MUST register the 
 * EVENT_DNDFILES_COMMAND event and delete the array pointed by the client data
 * member.
 *
 * @param  x          The x coordinate of the mouse.
 * @param  y          The y coordinate of the mouse.
 * @param  filenames  An array of filenames.
 */
bool DndCheckSumListView::OnDropFiles(wxCoord x, wxCoord y, const wxArrayString& filenames)
{
  if (owner != NULL)
  {   
//    owner->addFiles(filenames);  // old method. Freeze explorer on Windows.

    wxArrayString* f = new wxArrayString(filenames);

    wxCommandEvent event(EVENT_DNDFILES_COMMAND);
    event.SetClientData(f);
    owner->AddPendingEvent(event);
  }

  return true;
}
//---------------------------------------------------------------------------

#endif  // wxUSE_DRAG_AND_DROP



//###########################################################################
// A progression updater for the ChecksumFileCalculator class
//###########################################################################

/**
 * Displays the progression of the process of computing of a checksum.
 */
class ChecksumsListView::ChecksumProgress : public ::ChecksumProgress
{
 protected:
  wxString       fileName;   ///< Name of the current file.
  wxString       msg;        ///< Message to display.
  BytesDisplayer current;    ///< numbers of preceeded bytes.
  double         dTotal;     ///< Total of bytes to process.
  wxString       sTotal;     ///< Total of bytes to process.
  int            p;          ///< Progress in %.
  wxTimeSpan     timeSpan;   ///< Time between to updates of the progress dialog.
  wxDateTime     lt;         ///< Last saved time.
  wxDateTime     ct;         ///< Current time.
  dlgProgress*   progress;   ///< Progress dialog.
  int            maxProgress;    ///< Maximal value of the progress dialog.
  int            maxProgressM1;  ///< Maximal value of the progress dialog - 1.
  double         maxProgressD;   ///< Maximal value of the progress dialog (double).
  
  /// Default constructor. Don't call it.
  ChecksumProgress() { init(); };
  
  // Initializes the instance.
  void init();
  
 public:
  // Constructor.
  ChecksumProgress(const wxString& message, const wxString& title, wxWindow* parent, const BytesDisplayer& total);
  
  // Destructor.
  virtual ~ChecksumProgress();
  
  // Updates the progression of the computing of a checksum.
  virtual void update(size_t read, bool& canceled);
  
  // Indicates that the process is finished (hides the progress dialog).
  void finished();
  
  // Gets the current file that is processed.
  wxString getFileName() const;
  
  // Sets the current file that is processed.
  void setFileName(const wxString& curFileName);
};
//---------------------------------------------------------------------------


/**
 * Initializes the instance.
 */
void ChecksumsListView::ChecksumProgress::init()
{
  progress = NULL;
}
//---------------------------------------------------------------------------


/**
 * Constructor.
 *
 * @param  message  Message that will be displayed in the progress dialog.
 *                  It should have the following from :
 *                  "Proceeding %s, %s on %s read."
 * @param  title    Title of the progress dialog.
 * @param  parent   Parent of the progress dialog.
 * @param  total    Total of bytes to process.
 */
ChecksumsListView::ChecksumProgress::ChecksumProgress(const wxString& message, const wxString& title, wxWindow* parent, const BytesDisplayer& total)
{
  init();

  msg = message;
  dTotal = total.toDouble(BytesDisplayer::byte);
  sTotal = total.toString();
  maxProgress = SHRT_MAX;
  maxProgressM1 = maxProgress - 1;
  maxProgressD = static_cast<double>(maxProgress);
  timeSpan = wxTimeSpan(0, 0, 0, UPDATE_PROGRESS_DLG);
  lt = wxDateTime::UNow() - timeSpan;
  progress = new dlgProgress(title, _("Beginning..."), maxProgress, parent,
    wxPD_APP_MODAL | wxPD_AUTO_HIDE | wxPD_CAN_ABORT | wxPD_ELAPSED_TIME | wxPD_ESTIMATED_TIME | wxPD_REMAINING_TIME);
}
//---------------------------------------------------------------------------


/**
 * Destructor.
 */
ChecksumsListView::ChecksumProgress::~ChecksumProgress()
{
  if (progress != NULL)
  {
    delete progress;
    progress = NULL;
  }
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
void ChecksumsListView::ChecksumProgress::update(size_t read, bool& canceled)
{
  current += static_cast<unsigned long>(read);
  p = (dTotal != 0.0) ? static_cast<int>(current.toDouble(BytesDisplayer::byte) * maxProgressD / dTotal) : maxProgress;
  if (p >= maxProgress)
    p = maxProgressM1;
  ct = wxDateTime::UNow();
  if (ct.IsLaterThan(lt))
  {
    canceled = !progress->Update(p, wxString::Format(msg, fileName.c_str(), current.toString().c_str(), sTotal.c_str()));
    ::wxYield();
    lt = ct + timeSpan;
  }
  
  // Pause ?
  while (progress->isPaused())
    ::wxYield();
}
//---------------------------------------------------------------------------

  
/**
 * Indicates that the process is finished (hides the progress dialog).
 */
void ChecksumsListView::ChecksumProgress::finished()
{
  progress->Update(maxProgress, _("Finished"));
}
//---------------------------------------------------------------------------

  
/**
 * Gets the current file that is processed.
 *
 * @return  The current file that is processed.
 */
wxString ChecksumsListView::ChecksumProgress::getFileName() const
{
  return fileName;
}
//---------------------------------------------------------------------------

  
/**
 * Sets the current file that is processed.
 *
 * @param  curFileName  New name of the current file which is processed.
 */
void ChecksumsListView::ChecksumProgress::setFileName(const wxString& curFileName)
{
  fileName = curFileName;
}
//---------------------------------------------------------------------------



//###########################################################################
// ChecksumsListView methods
//###########################################################################

IMPLEMENT_DYNAMIC_CLASS(ChecksumsListView, wxListView)


/**
 * Default constructor.
 */
ChecksumsListView::ChecksumsListView() : wxListView()
{
  init();
  sumFile = NULL;
}
//---------------------------------------------------------------------------


/**
 * Constructor, creating and showing a list control.
 *
 * @param  parent     Parent window. Must not be <CODE>NULL</CODE>.
 * @param  id         Window identifier. A value of <CODE>-1</CODE> indicates a
 *                    default value.
 * @param  checksumFile  The checksum file linked with this listview.
 * @param  pos        Window position.
 * @param  size       Window size. If the default size <CODE>(-1, -1)</CODE> is
 *                    specified then the window is sized appropriately.
 * @param  style      Window style. See <I>wxListCtrl</I>.
 * @param  validator  Window validator.
 * @param  name       Window name.
 */
ChecksumsListView::ChecksumsListView(wxWindow* parent, wxWindowID id,
                                     SumFile* checksumFile, const wxPoint& pos,
                                     const wxSize& size, long style,
                                     const wxValidator& validator,
                                     const wxString& name) :
                    wxListView(parent, id, pos, size, style, validator, name)
{
  init();
  sumFile = checksumFile;
}
//---------------------------------------------------------------------------


/**
 * Destructor.
 */
ChecksumsListView::~ChecksumsListView()
{
  if (sumFile != NULL)
  {
    delete sumFile;
    sumFile = NULL;
  }
}
//---------------------------------------------------------------------------


/**
 * Initializes the list parameters.
 */
void ChecksumsListView::init()
{
  // Creates an image list for this listview.
  // Order and index should corresponds to ChecksumData::State
  wxImageList* imlStateIcons = new wxImageList(16, 16);
  imlStateIcons->Add(wxIcon(lvw_sums_notverified_xpm));
  imlStateIcons->Add(wxIcon(lvw_sums_verified_xpm));
  imlStateIcons->Add(wxIcon(lvw_sums_invalid_xpm));
  imlStateIcons->Add(wxIcon(lvw_sums_notfound_xpm));

  setColumnToSort(0, NONE);
  AssignImageList(imlStateIcons, wxIMAGE_LIST_SMALL);
  
  #if wxUSE_DRAG_AND_DROP
  SetDropTarget(new DndCheckSumListView(this));
  #endif  // wxUSE_DRAG_AND_DROP

  columns[0] = FILE_NAME;
  columns[1] = DIRECTORY;
  columns[2] = CHECKSUM_VALUE;
  columns[3] = STATE;
  InsertColumn(0, getColumnName(columns[0]), wxLIST_FORMAT_LEFT);
  InsertColumn(1, getColumnName(columns[1]), wxLIST_FORMAT_LEFT);
  InsertColumn(2, getColumnName(columns[2]), wxLIST_FORMAT_LEFT);
  InsertColumn(3, getColumnName(columns[3]), wxLIST_FORMAT_LEFT);
}
//---------------------------------------------------------------------------


/**
 * Gets to sort order.
 *
 * @return  The sort order.
 */
ChecksumsListView::SortOrder ChecksumsListView::getSortOrder() const
{
  return sortOrder;
}
//---------------------------------------------------------------------------

  
/**
 * Sets the sort order.
 *
 * @param  newSortOrder  New sort order. Must be <CODE>ASCENDING</CODE> or
 *                       <CODE>DESCENDING</CODE>. If other value is given,
 *                       <CODE>ASCENDING</CODE> is assumed by default.
 */
void ChecksumsListView::setSortOrder(const SortOrder newSortOrder)
{
  switch (newSortOrder)
  {
    case NONE :
    case ASCENDING :
    case DESCENDING :
      sortOrder = newSortOrder;
      break;
    default :
      sortOrder = NONE;
  }
}
//---------------------------------------------------------------------------


/**
 * Gets the column to be sorted
 *
 * @return The column to be sorted.
 */
int ChecksumsListView::getColumnToSort() const
{
  return colToSort;
}
//---------------------------------------------------------------------------


/**
 * Sets the column to be sorted.
 *
 * @param  col  The column with witch the sort will be done. If the given 
 *              column is invalid, the first column of the list will be taken.
 */
void ChecksumsListView::setColumnToSort(const int col)
{
  if (col >= 0 && col < GetColumnCount())
    colToSort = col;
  else
    colToSort = 0;
}
//---------------------------------------------------------------------------


/**
 * Sets the column to be sorted.
 *
 * @param  col           The column with witch the sort will be done.
 * @param  newSortOrder  New sort order.
 * @see    getSortOrder(), setColumnToSort(int)
 */
void ChecksumsListView::setColumnToSort(const int col, const SortOrder newSortOrder)
{
  setColumnToSort(col);
  setSortOrder(newSortOrder);
}
//---------------------------------------------------------------------------


/**
 * List compare function.
 *
 * <B>Warning &nbsp;:</B> this is a quick&dirty fonction, where a pointer
 * on a ChecksumsListView class is passed in a parameter with the long type.
 *
 * @param  item1     data on the first item.
 * @param  item2     data on the second item.
 * @param  sortData  adress of the wallpaper list (yerk !)
 */
static int wxCALLBACK SumListCompareFnct(long item1, long item2, long sortData)
{
  ChecksumsListView* pList = reinterpret_cast<ChecksumsListView*>(sortData);

  // Gets the checksum data of the items
  ChecksumData cd1 = pList->getSumFile()->getChecksumData(item1);
  ChecksumData cd2 = pList->getSumFile()->getChecksumData(item2);

  // Gets the sort parameters
  int colToSort = pList->getColumnToSort();
  ChecksumsListView::SortOrder sortOrder = pList->getSortOrder();

  // Compare the items.
  if (sortOrder == ChecksumsListView::NONE)
  // Compare the keys
    return item1 - item2;

  int res;
  ChecksumsListView::Columns cols[LVW_SUMS_NBCOLS];
  pList->getColumns(cols);
  switch (cols[colToSort])
  {
    case ChecksumsListView::FILE_NAME :
      res = ::compareFileName(cd1.getFileName().GetFullName(), cd2.getFileName().GetFullName());
      break;
    case ChecksumsListView::DIRECTORY : { 
      wxFileName fn1 = cd1.getFileName();
      wxFileName fn2 = cd2.getFileName();
      wxFileName sumFileName = pList->getSumFile()->getFileName();

      if (AppPrefs::get()->readBool(prGUI_MAIN_SUMS_DIRSINABSOLUTEPATH))
      {
        if (fn1.IsRelative())
          fn1.MakeAbsolute(sumFileName.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
        if (fn2.IsRelative())
          fn2.MakeAbsolute(sumFileName.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
      }
      else
      {
        if (fn1.IsAbsolute())
          fn1.MakeRelativeTo(sumFileName.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
        if (fn2.IsAbsolute())
          fn2.MakeRelativeTo(sumFileName.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
      }
      res = ::compareFileName(fn1.GetPath(wxPATH_GET_VOLUME), fn2.GetPath(wxPATH_GET_VOLUME)); }
      break;
    case ChecksumsListView::CHECKSUM_VALUE :
      res = cd1.getChecksum().Cmp(cd2.getChecksum());
      break;
    case ChecksumsListView::STATE :
      res = static_cast<int>(cd1.getState()) - static_cast<int>(cd2.getState());
      break;
  }

  if (sortOrder == ChecksumsListView::DESCENDING)
    res = -res;

  return res;
}
//---------------------------------------------------------------------------


/** 
 * Sort the list.
 */
void ChecksumsListView::sort()
{
  if (this->getSumFile() != NULL)
  {
    wxBusyCursor wait;
    this->Freeze();
    this->SortItems(SumListCompareFnct, reinterpret_cast<long>(this));
    this->Thaw();
  }
}
//---------------------------------------------------------------------------


/**
 * Gets a pointer on the checksum file.
 *
 * @return A pointer on the checksum file.
 */
SumFile* ChecksumsListView::getSumFile() const
{
  return sumFile;
}
//---------------------------------------------------------------------------  


/**
 * Sets the checksum file.
 *
 * - Deletes the old checksums' file instance in memory.
 * - Deletes all the items.
 * - Creates new item from the given checksums file if not <CODE>NULL</CODE>.
 *
 * @param  pSumFile  A pointer on the new checksums file.
 * @remarks The given <CODE>SumFile*</CODE> instance will be deleted by this
 *          class.
 */
void ChecksumsListView::setSumFile(SumFile* pSumFile)
{
  // If sums file is the same do nothing.
  if (sumFile == pSumFile)
    return;

  if (sumFile != NULL)
    delete sumFile;

  this->DeleteAllItems();
  sumFile = pSumFile;
  if (sumFile != NULL)
  {
    MChecksumDataKeys keys;
    sumFile->getChecksumDataKeys(keys);
    size_t i, l = keys.GetCount();
    for (i = 0; i < l; i++)
      addChecksum(keys[i], _("Not verified"));
  }
  
  // Sort the list.
  sort();
}
//---------------------------------------------------------------------------


/**
 * Selects all the items.
 */
void ChecksumsListView::selectAll()
{
  int state;
  long item = this->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
  while (item != -1)
  {
    state = this->GetItemState(item, wxLIST_STATE_SELECTED);
    if (!(state & wxLIST_STATE_SELECTED))
      this->SetItemState(item, wxLIST_STATE_SELECTED, wxLIST_STATE_SELECTED);
    item = this->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
  }
}
//---------------------------------------------------------------------------


/**
 * Inverts the selection.
 */
void ChecksumsListView::invertSelection()
{
  int state;
  long item = this->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
  while (item != -1)
  {
    state = this->GetItemState(item, wxLIST_STATE_SELECTED);
    state = ~state;
    this->SetItemState(item, state, wxLIST_STATE_SELECTED);
    item = this->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
  }
}
//---------------------------------------------------------------------------


/**
 * Open a dialog to select the files to add to the list.
 */
void ChecksumsListView::selectFilesToAdd()
{
  if (this->getSumFile() != NULL)
  {
    // Show the open dialog
    wxFileDialogFilterMaker fltMaker;
    fltMaker.AddFilter(_("All the files"), wxT("*"));
    
    wxFileDialog dlgOpen(this, _("Select the files to be added"),
                         wxEmptyString, wxEmptyString, fltMaker.GetFilters(),
                         wxOPEN | wxHIDE_READONLY | wxMULTIPLE | wxFILE_MUST_EXIST, wxDefaultPosition);
    wxFileName direct(wxFileName(sumFile->getFileName()).GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
    if (direct.DirExists())
      dlgOpen.SetDirectory(direct.GetFullPath());

    if (dlgOpen.ShowModal() == wxID_OK)
    {
      wxArrayString files;
      dlgOpen.GetPaths(files);
      this->addFiles(files);
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Open a dialog to select the directories to add to the list.
 */
void ChecksumsListView::selectDirectoriesToAdd()
{
  if (this->getSumFile() != NULL)
  {
    // Show the open dialog
    wxDirDialog dlgDir(this, _("Select the directory"));
    wxFileName direct(wxFileName(sumFile->getFileName()).GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
    if (direct.DirExists())
      dlgDir.SetPath(direct.GetFullPath());

    if (dlgDir.ShowModal() == wxID_OK)
    {
      wxArrayString files;
      files.Add(dlgDir.GetPath());
      this->addFiles(files);
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Open a dialog to select files to add from matching patterns.
 */
void ChecksumsListView::selectMatchingFilesToAdd()
{
  if (this->getSumFile() != NULL)
  {
    dlgAddMatchFiles dlg(this, this->getSumFile()->getFileName());
    if (dlg.ShowModal() == wxID_OK)
    {
      // Gets the patterns
      size_t i;
      dlgAddMatchFiles::ArrayMatchPattern patterns;
      dlg.getMatchPatterns(patterns);
      
      if (patterns.getCount() > 0)
      {
        wxFileName checksum(getSumFile()->getFileName());
        dlgAddMatchFiles::ArrayMatchPattern pats;
        for (i = 0; i < patterns.getCount(); i++)
        {
          // Get a beautiful directory name and remove some possible multiple
          // same patterns.
          wxFileName fn(patterns[i].getDirectory() + wxFileName::GetPathSeparator());
          if (fn.IsRelative())
          // Make it absolute
          {
            fn.MakeAbsolute(checksum.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
            pats.add(dlgAddMatchFiles::MatchPattern(fn.GetPath(wxPATH_GET_VOLUME), patterns[i].getPattern(), patterns[i].getDepth()));
          }
          else
          {
            fn.MakeRelativeTo(checksum.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
            fn.MakeAbsolute(checksum.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
            pats.add(dlgAddMatchFiles::MatchPattern(fn.GetPath(wxPATH_GET_VOLUME), patterns[i].getPattern(), patterns[i].getDepth()));
          }
        }

        wxArrayString files;
        BytesDisplayer bs;
        bool cont = true;
        i = 0;
        while (cont && i < pats.getCount())
        {
          wxArrayString lFiles;
          lFiles.Add(pats[i].getDirectory());
          cont = ::getFilesInSubdirectories(lFiles, files, bs,
                                            pats[i].getPattern(),
                                            pats[i].getDepth());
          i++;
        }
        if (cont)
          addFiles(files);
      }
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Adds files to the list of checksums.
 *
 * This function will search recursively files in subdirectories.
 * All the files and all the directories that are provided in the array
 * must be in absolute path.
 *
 * @param  files  A list of files and directories to add.
 */
void ChecksumsListView::addFiles(const wxArrayString& files)
{
  if (this->getSumFile() == NULL || files.IsEmpty())
    return;

  // No log
  wxLogNull logNo;

  // Search the files in the subdirectories.
  wxArrayString allFiles;
  BytesDisplayer total;
  if (!::getFilesInSubdirectories(files, allFiles, total))
    return;

  if (allFiles.IsEmpty())
  // No files to add, exiting
    return;

  this->Freeze();

  // Adds the checksums
  InvalidFilesContainer invalidFiles;  // all the invalid files.
  wxString   sumFilePath = wxFileName(getSumFile()->getFileName()).GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR);
  Checksum*  c = sumFile->getChecksumCalculator();  // checksum calculator
  wxFileName fn;            // name of the current file
  ChecksumFileCalculator::State retState;  // state returned by the checksum' calculator.
  wxString   calcSumValue;  // Calculated checksum's value
  bool       cont = true;   // continue ?

  // Removes the files that are already in the list.
//  wxArrayString in;
  cont = removeFilesInList(allFiles/*, &in*/);

/*  if (in.GetCount() > 0)    // For debug only
  {
    for (size_t i = 0; i < in.GetCount(); i++)
      invalidFiles[in[i]] = _("Already in the list");
  }*/

  // Show the progress dialog
  ChecksumProgress progressUpdater(_("Computing the checkum of %s\n%s on %s read."), _("Computing the checksums"), this, total);
  ChecksumFileCalculator cfc(c, &progressUpdater);
  size_t i = 0;
  size_t l = allFiles.GetCount();
  while (i < l && cont)
  {
    wxString& curFile = allFiles[i];
    fn = curFile;

    // Compute the checksum.
    progressUpdater.setFileName(fn.GetFullName());
    retState = cfc.calculate(curFile, calcSumValue);

    switch (retState)
    {
      case ChecksumFileCalculator::Ok :              // Checksum has been calculated (and corresponds for the check method).
        {
          fn.MakeRelativeTo(sumFilePath);
          ChecksumData d(fn, calcSumValue, ChecksumData::Verified);
          long k = this->getSumFile()->addChecksumData(d);
          this->addChecksum(k, _("OK"));
        }
        break;

      case ChecksumFileCalculator::ReadError :       // Error while reading the stream.
        invalidFiles[curFile] = _("Error while reading the file");
        break;

      case ChecksumFileCalculator::FileNotFound :    // The file has been not found.
        invalidFiles[curFile] = _("File not found");
        break;

      case ChecksumFileCalculator::CantOpenFile :    // Can't open the stream.
        invalidFiles[curFile] = _("File cannot be open");
        break;

      case ChecksumFileCalculator::CanceledByUser :  // User has canceled the calculation.
        cont = false;
        break;
    }

    i++;
  }
  delete c;
  progressUpdater.finished();

  this->Thaw();
  
  // Sort the list
  sort();
  
  if (!invalidFiles.empty())
  {
    dlgInvalidFiles dlg(this, _("Invalid files"),
                        _("The following files were not added to the list of the checksums:"), invalidFiles);
    dlg.ShowModal();
  }
}
//---------------------------------------------------------------------------


/**
 * Compare function for <CODE>removeFilesInList</CODE>.
 *
 * For internal use only.
 * For more information, see <CODE>wxArrayString::Sort</CODE> in the wxWidgets
 * documentation.
 */
static int removeFilesInListCompare(const wxString& first, const wxString& second)
{
  return ::compareFileName(first, second);
}
//---------------------------------------------------------------------------


/**
 * Removes the files that are already in the listview.
 *
 * @param  files  List of files to be checked. The files already present in
 *                the listview will be removed list of <CODE>files</CODE>.
 * @param  in     Pointer on an array string where the files already present in
 *                the listview will be stored. Could be <CODE>NULL</CODE>.
 * @return <CODE>true</CODE> if the user hasn't canceled.
 */
bool ChecksumsListView::removeFilesInList(wxArrayString& files, wxArrayString* in)
{
  if (sumFile->getChecksumDataCount() == 0 && files.IsEmpty())
    return true;

  wxArrayString lFiles;  // Files in the listview
  wxFileName    fn;
  bool cont = true;
  wxString sumFilePath = wxFileName(sumFile->getFileName()).GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR);
  MChecksumData::const_iterator it = sumFile->getChecksumDataBegin();
  MChecksumData::const_iterator end = sumFile->getChecksumDataEnd();

  // Get the files in the list
  lFiles.Alloc(sumFile->getChecksumDataCount() + files.GetCount());
  while (it != end)
  {
    fn = it->second.getFileName();
    if (!fn.IsAbsolute())
      fn.MakeAbsolute(sumFilePath);
    lFiles.Add(fn.GetFullPath());
    it++;
  }

  dlgProgress dlgProgress(_("Checking for duplicate files"), _("Beginning..."), 100, this,
    wxPD_APP_MODAL | wxPD_AUTO_HIDE | wxPD_CAN_ABORT | wxPD_ELAPSED_TIME | wxPD_ESTIMATED_TIME | wxPD_REMAINING_TIME);

  lFiles.Sort(removeFilesInListCompare);

  wxTimeSpan timeSpan(0, 0, 0, UPDATE_PROGRESS_DLG);
  wxDateTime lt = wxDateTime::UNow() - timeSpan;  // last saved time
  wxDateTime ct;                   // current time

  // Search for the present files
  size_t i = 0;
  int r, a, b;
  while (cont && i < files.GetCount())
  {
    fn = files[i];
    fn.Normalize(wxPATH_NORM_ALL, sumFilePath);
    wxString s = fn.GetFullPath();

    int c = -1;
    a = 0;
    b = lFiles.GetCount() - 1;
    r = (a + b) / 2;

    while ((a < b) && (r >= 0) && (r < lFiles.GetCount()) && ((c = ::compareFileName(s, lFiles[r])) != 0))
    {
      if (c < 0)
        b = r - 1;
      else
        a = r + 1;
        
      r = (a + b) / 2;
    }
    if ((r >= 0) && (r < lFiles.GetCount()) && ::compareFileName(s, lFiles[r]) == 0)
    {
      if (in != NULL)
        in->Add(s);
      files.Remove(i);
    }
    else
    {
      // To avoid to add files likes /dir1/dir2/file1 and /dir1/dir2/../dir2/file1
      if (r < 0) r = 0;
      if (!lFiles.IsEmpty() && r >= lFiles.GetCount()) r = lFiles.GetCount() - 1;
      while (r > 0 && ::compareFileName(s, lFiles[r]) < 0)
        r--;
      while (r < lFiles.GetCount() && ::compareFileName(s, lFiles[r]) >= 0)
        r++;
      lFiles.Insert(s, r);

      /* Reference for debugging
      lFiles.Add(s);
      lFiles.Sort(removeFilesInListCompare); */

      i++;
    }
    
    // Upadate the progress dialog
    ct = wxDateTime::UNow();
    if (ct.IsLaterThan(lt))
    {
      int p;  // progress value (0-100)
      lt = ct + timeSpan;
      size_t fc = files.GetCount();
      if (fc > 0)
        p = static_cast<int>((static_cast<double>(i) / static_cast<double>(fc)) * 100.0);
      else
        p = 100;
      if (p >= 100) p = 99;
      cont = dlgProgress.Update(p, wxString::Format(_("Checking %s"), s.c_str()));
      ::wxYield();
    }
    
    // Pause ?
    while (dlgProgress.isPaused())
      ::wxYield();
  }

  files.Shrink();

  dlgProgress.Update(100, wxString::Format(_("Finished."), files[i].c_str()));
  
  return cont;
}
//---------------------------------------------------------------------------


/**
 * Indicates if the specified file is present in the list.
 *
 * The given file name must be an absolute path.
 *
 * @param  fileName  File name to test the presence in the list.
 * @return <CODE>true</CODE> if the file is present in the list,
 *         <CODE>false</CODE> otherwise.
 */
bool ChecksumsListView::isInList(const wxString& fileName)
{
  bool       found = false;
  wxFileName fn;
  wxString   sumFilePath = wxFileName(sumFile->getFileName()).GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR);

  MChecksumData::const_iterator it = sumFile->getChecksumDataBegin();
  MChecksumData::const_iterator end = sumFile->getChecksumDataEnd();

  while (!found && it != end)
  {
    fn = it->second.getFileName();
    fn.MakeAbsolute(sumFilePath);
    if (::compareFileName(fn.GetFullPath(), fileName) == 0)
      found = true;
    else
      it++;
  }

  return found;
}
//---------------------------------------------------------------------------


/**
 * Adds a checksum in the list.
 *
 * @param  key    Key of the item in the file of checksums.
 * @param  stateMsg  Information about the state.
 * @return The index of the new item.
 */
long ChecksumsListView::addChecksum(const long key, const wxString& stateMsg)
{
  int p = this->GetItemCount();
  
  // Create the item and set its data as the key of corresponding ChecksumData
  InsertItem(p, wxT(""), 0);
  SetItemData(p, key);
  
  // Sets the item text and picture
  setChecksum(p, stateMsg);
  ChecksumData cd = sumFile->getChecksumData(key);
  setChecksumState(p, cd.getState(), stateMsg);
  
  return p;
}
//---------------------------------------------------------------------------


/**
 * Sets an item.
 *
 * This function doesn't set the item picture and the data associated with
 * the item.
 *
 * @param  item      Item to set.
 * @param  stateMsg  Information about the state.
 */
void ChecksumsListView::setChecksum(long item, const wxString& stateMsg)
{
  wxFileName fn;
  ChecksumData cd = sumFile->getChecksumData(this->GetItemData(item));
  
  for (int i = 0; i < LVW_SUMS_NBCOLS; i++)
    switch (columns[i])
    {
      case FILE_NAME :
        SetItem(item, i, cd.getFileName().GetFullName());
        break;
      case DIRECTORY :
        fn = cd.getFileName();
        if (AppPrefs::get()->readBool(prGUI_MAIN_SUMS_DIRSINABSOLUTEPATH))
        {
          if (fn.IsRelative())
            fn.MakeAbsolute(wxFileName(sumFile->getFileName()).GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
        }
        else
        {
          if (fn.IsAbsolute())
            fn.MakeRelativeTo(wxFileName(sumFile->getFileName()).GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
        }
        SetItem(item, i, fn.GetPath(wxPATH_GET_VOLUME | wxPATH_GET_SEPARATOR));
        break;
      case CHECKSUM_VALUE :
        if (AppPrefs::get()->readBool(prGUI_MAIN_SUMS_UPPERCASE))
          SetItem(item, i, cd.getChecksum().Upper());
        else
          SetItem(item, i, cd.getChecksum().Lower());
        break;
      case STATE :
          SetItem(item, i, stateMsg);
          break;
    }

}
//---------------------------------------------------------------------------


/**
 * Sets the state of a checksum
 *
 * @param  item   Item which to state should be modified.
 * @param  state  New state of the checksum corresponding to the item.
 * @param  msg    Information about the state.
 */
void ChecksumsListView::setChecksumState(long item, const ChecksumData::State state, const wxString& msg)
{
  long key = GetItemData(item);
  ChecksumData d = sumFile->getChecksumData(key);
  sumFile->setChecksumState(key, state);
  
  // Find the column of the state
  int stateCol = -1;
  for (int i = 0; (i < LVW_SUMS_NBCOLS) && (stateCol == -1); i++)
    if (columns[i] == STATE)
      stateCol = i;

  SetItem(item, stateCol, msg);
  SetItem(item, 0, GetItemText(item), state);
}
//---------------------------------------------------------------------------


/**
 * Removes the selected checksums from the list.
 */
void ChecksumsListView::removeSelectedChecksums()
{
  if (this->getSumFile() != NULL)
  {
    long item;

    item = this->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED);
    while (item != -1)
    {
      sumFile->removeChecksumData(this->GetItemData(item));
      this->DeleteItem(item);
      item = this->GetNextItem(item - 1, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED);
    }
  }
}
//---------------------------------------------------------------------------


/**
 * Gets the total of each state in the list of checksums.
 *
 * @param  onlySelected  If <CODE>true</CODE> gets the state of the selected
 *                       checksums/files. If <CODE>false</CODE> gets the state
 *                       of all the files.
 * @return An array that contains the total of each state in the list of
 *         checksums or an empty array if there is no checksum file opened.
 */
wxArrayInt ChecksumsListView::getStates(const bool onlySelected) const
{
  wxArrayInt states;

  if (this->getSumFile() != NULL)
  {
    ChecksumData d;
    const int state = onlySelected ? wxLIST_STATE_SELECTED : wxLIST_STATE_DONTCARE;
    
    states.Add(0, CD_STATE_COUNT);

    long item = this->GetNextItem(-1, wxLIST_NEXT_ALL, state);
    while (item != -1)
    {
      d = this->getSumFile()->getChecksumData(this->GetItemData(item));
      states[static_cast<size_t>(d.getState())]++;

      item = this->GetNextItem(item, wxLIST_NEXT_ALL, state);
    }
  }
  
  return states;
}
//---------------------------------------------------------------------------


/**
 * Sums up the total of each state in the list of checksums.
 *
 * @param  onlySelected  If <CODE>true</CODE> gets the state of the selected
 *                       checksums/files. If <CODE>false</CODE> gets the state
 *                       of all the files.
 * @return A string which contains a sum up of the total of each state in the
 *         list of checksums or an empty string if there is no checksum file
 *         opened.
 */
wxString ChecksumsListView::sumUpStates(const bool onlySelected) const
{
  wxString res;

  if (this->getSumFile() != NULL)
  {
    wxArrayInt states = getStates(onlySelected);
    int itemsCount = onlySelected ? this->GetSelectedItemCount() : this->GetItemCount();

    if (itemsCount == 1)
      res = _("1 file was checked. ");
    else
      res.Printf(_("%d files were checked. "), itemsCount);

    if (states[ChecksumData::Verified] == itemsCount)
      res += _("All are ok.");
    else if (states[ChecksumData::Invalid] == itemsCount)
      res += _("All are invalid.");
    else if (states[ChecksumData::NotFound] == itemsCount)
      res += _("All cannot be opened.");
    else
    {
      if (states[ChecksumData::Verified] == 0)
        res += _("None is ok");
      else if (states[ChecksumData::Verified] == 1)
        res += _("1 is ok");
      else
        res += wxString::Format(_("%d are ok"), states[ChecksumData::Verified]);
      
      if (states[ChecksumData::Invalid] == 1)
        res += _(", 1 is invalid");
      else if (states[ChecksumData::Invalid] > 1)
        res += wxString::Format(_(", %d are invalid"), states[ChecksumData::Invalid]);

      if (states[ChecksumData::NotFound] == 1)
        res += _(", 1 can't be opened");
      else if (states[ChecksumData::NotFound] > 1)
        res += wxString::Format(_(", %d can't be opened"), states[ChecksumData::NotFound]);

      res += wxT('.');
    }
  }

  return res;
}
//---------------------------------------------------------------------------


/**
 * Open a checksum file.
 *
 * @param  fileName  Name of the file to open.
 * @return <CODE>true</CODE> if the has has been opened successfully,
 *         <CODE>false</CODE> otherwise.
 */
bool ChecksumsListView::openChecksumFile(const wxFileName& fileName)
{
  SumFile* sf = ::openChecksumFile(fileName);

  if (sf != NULL)
  {
    // Assign the read file to this list
    this->setSumFile(sf);
    
    // Update the main dialog title
    wxCommandEvent event(EVENT_UPDATE_SUMS_FRAME_TITLE_COMMAND);
    this->GetParent()->ProcessEvent(event);
    
    // Auto check ?
    if (AppPrefs::get()->readBool(prGUI_AUTO_CHECK_ON_OPEN))
      this->check();

    // Adds the file in the recently open files history
    wxCommandEvent event2(EVENT_OPEN_RECENT_ADD_FILE);
    event2.SetString(fileName.GetFullPath());
    this->GetParent()->ProcessEvent(event2);

    return true;
  }
  else
  {
    ::wxMessageBox(wxString::Format(_("'%s' cannot be read."), fileName.GetFullPath().c_str()), _("Open a checksums' file"), wxOK | wxICON_EXCLAMATION);
    return false;
  }
}
//---------------------------------------------------------------------------


/**
 * Checks the files.
 */
void ChecksumsListView::check()
{
  if (this->getSumFile() == NULL)
    return;  // no file is open
  
  wxLogNull      logNo;   // No log
  ChecksumData   d;       // a checksum data
  wxFileName     fn;      // name of the current file
  wxCOff_t       fs;      // rest of the file size to read
  BytesDisplayer total;   // total of bytes to process
  const int state = (this->GetSelectedItemCount() > 0) ? wxLIST_STATE_SELECTED : wxLIST_STATE_DONTCARE;

  // Get the number of bytes to read.
  long item = this->GetNextItem(-1, wxLIST_NEXT_ALL, state);
  while (item != -1)
  {
    d = this->getSumFile()->getChecksumData(this->GetItemData(item));
    fn = d.getFileName();
    if (!fn.IsAbsolute())
      fn.MakeAbsolute(wxFileName(this->getSumFile()->getFileName()).GetPath(wxPATH_GET_VOLUME));
    if ((fs = wxCGetFileLength(fn.GetFullPath())) != static_cast<wxCOff_t>(wxInvalidOffset))
      total += static_cast<double>(fs);

    item = this->GetNextItem(item, wxLIST_NEXT_ALL, state);
  }

  // Check the checksums
  Checksum* c = sumFile->getChecksumCalculator();  // checksum calculator
  ChecksumFileCalculator::State retState;  // state returned by the checksum' calculator.
  bool cont = true;   // continue ?

  // Show the progress dialog
  ChecksumProgress progressUpdater(_("Checking %s\n%s on %s read."), _("Checking the files"), this, total);
  ChecksumFileCalculator cfc(c, &progressUpdater);
  item = this->GetNextItem(-1, wxLIST_NEXT_ALL, state);
  while (item != -1 && cont)
  {
    // Get the name of the next file to check.
    d = this->getSumFile()->getChecksumData(this->GetItemData(item));
    fn = d.getFileName();
    if (!fn.IsAbsolute())
      fn.MakeAbsolute(wxFileName(this->getSumFile()->getFileName()).GetPath(wxPATH_GET_VOLUME));

    // Check the file.
    progressUpdater.setFileName(fn.GetFullName());
    retState = cfc.check(fn.GetFullPath(), d.getChecksum());

    switch (retState)
    {
      case ChecksumFileCalculator::Ok :              // Checksum has been calculated (and corresponds for the check method).
        this->setChecksumState(item, ChecksumData::Verified, _("OK"));      
        break;

      case ChecksumFileCalculator::Invalid :         // Checksum has been verified and not corresponds.
        this->setChecksumState(item, ChecksumData::Invalid, _("Checksums differ"));
        break;

      case ChecksumFileCalculator::ReadError :       // Error while reading the stream.
        this->setChecksumState(item, ChecksumData::NotFound, _("Error while reading the file"));
        break;

      case ChecksumFileCalculator::FileNotFound :    // The file has been not found.
        this->setChecksumState(item, ChecksumData::NotFound, _("File not found"));
        break;

      case ChecksumFileCalculator::CantOpenFile :    // Can't open the stream.
        this->setChecksumState(item, ChecksumData::NotFound, _("File cannot be open"));
        break;

      case ChecksumFileCalculator::CanceledByUser :  // User has canceled the calculation.
        cont = false;
        break;
    }
    
    item = this->GetNextItem(item, wxLIST_NEXT_ALL, state);
  }
  delete c;
  progressUpdater.finished();

  // Sort the list
  sort();
  
  // Display the result
  if (cont && AppPrefs::get()->readBool(prGUI_DLG_SUMUP_CHECK))
    ::wxMessageBox(this->sumUpStates(), _("Checking checksums"), wxOK | wxICON_INFORMATION);

  // Update the main dialog status bar
  wxCommandEvent event(EVENT_UPDATE_SUMS_FRAME_STATUSBAR_COMMAND);
  event.SetString(this->sumUpStates(this->GetSelectedItemCount() != 0));
  event.SetInt(0);
  this->GetParent()->ProcessEvent(event);
}
//---------------------------------------------------------------------------


/** 
 * Recomputes the checksums.
 */
void ChecksumsListView::recompute()
{
  if (this->getSumFile() == NULL || this->GetSelectedItemCount() == 0)
    return;  // no file is open or no file is selected
  
  wxLogNull      logNo;   // No log
  ChecksumData   d;       // a checksum data
  wxFileName     fn;      // name of the current file
  wxCOff_t       fs;      // rest of the file size to read
  BytesDisplayer total;   // total of bytes to process

  // Get the number of bytes to read.
  long item = this->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED);
  while (item != -1)
  {
    d = this->getSumFile()->getChecksumData(this->GetItemData(item));
    fn = d.getFileName();
    if (!fn.IsAbsolute())
      fn.MakeAbsolute(wxFileName(this->getSumFile()->getFileName()).GetPath(wxPATH_GET_VOLUME));
    if ((fs = wxCGetFileLength(fn.GetFullPath())) != static_cast<wxCOff_t>(wxInvalidOffset))
      total += static_cast<double>(fs);

    item = this->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED);
  }

  // Recompute the checksums
  Checksum* c = sumFile->getChecksumCalculator();  // checksum calculator
  ChecksumFileCalculator::State retState;  // state returned by the checksum' calculator.
  wxString calcSumValue;  // Calculated checksum's value.
  bool cont = true;   // continue ?

  // Show the progress dialog
  ChecksumProgress progressUpdater(_("Recomputing the checkum of %s\n%s on %s read."), _("Recomputing the checksums"), this, total);
  ChecksumFileCalculator cfc(c, &progressUpdater);
  item = this->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED);
  while (item != -1 && cont)
  {
    d = this->getSumFile()->getChecksumData(this->GetItemData(item));
    fn = d.getFileName();
    if (!fn.IsAbsolute())
      fn.MakeAbsolute(wxFileName(this->getSumFile()->getFileName()).GetPath(wxPATH_GET_VOLUME));

    // Recompute the checksum.
    progressUpdater.setFileName(fn.GetFullName());
    retState = cfc.calculate(fn.GetFullPath(), calcSumValue);
    
    switch (retState)
    {
      case ChecksumFileCalculator::Ok :              // Checksum has been calculated (and corresponds for the check method).
        this->setChecksumState(item, ChecksumData::Verified, _("OK"));
        if (calcSumValue.CmpNoCase(d.getChecksum()) != 0)
        // changes the checksum value
        {
          ChecksumData cd = this->getSumFile()->getChecksumData(this->GetItemData(item));
          cd.setChecksum(calcSumValue);
          this->getSumFile()->setChecksumData(this->GetItemData(item), cd);
          this->setChecksum(item, _("OK"));
        }
        break;

      case ChecksumFileCalculator::ReadError :       // Error while reading the stream.
        this->setChecksumState(item, ChecksumData::NotFound, _("Error while reading the file"));
        break;

      case ChecksumFileCalculator::FileNotFound :    // The file has been not found.
        this->setChecksumState(item, ChecksumData::NotFound, _("File not found"));
        break;

      case ChecksumFileCalculator::CantOpenFile :    // Can't open the stream.
        this->setChecksumState(item, ChecksumData::NotFound, _("File cannot be open"));
        break;

      case ChecksumFileCalculator::CanceledByUser :  // User has canceled the calculation.
        cont = false;
        break;
    }

    item = this->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_SELECTED);
  }
  delete c;
  progressUpdater.finished();
  
  // Sort the list
  sort();
}
//---------------------------------------------------------------------------


/**
 * Reformats the list.
 */
void ChecksumsListView::reformat()
{
  reformat(NULL);
}
//---------------------------------------------------------------------------


#if defined(__WXMSW__)
/**
 * Event handler for the context menu demand.
 *
 * @param  event  event parameters.
 */
void ChecksumsListView::OnContextMenu(wxContextMenuEvent& event)
{
  ShowContextMenu(ScreenToClient(event.GetPosition()));
}
//---------------------------------------------------------------------------
#else
/**
 * Event handler for the context menu demand.
 *
 * @param  event  event parameters.
 */
void ChecksumsListView::OnRightUp(wxMouseEvent& event)
{
  ShowContextMenu(event.GetPosition());
}
//---------------------------------------------------------------------------
#endif  // defined(__WXMSW__)


/**
 * Shows the context menu.
 *
 * @param  p  Position of the context menu.
 */
void ChecksumsListView::ShowContextMenu(const wxPoint& p)
{
  if (sumFile != NULL)
  {
    // Initializes the popup-menu
    wxMenu pmnFonds;
    wxMenuItem* itpFilesAdd = new wxMenuItem(&pmnFonds, ITP_FILESADD, wxString(_("&Add files...")));
    itpFilesAdd->SetBitmap(wxBitmap(hi16_action_fileadd_xpm));
    wxMenuItem* itpDirectoriesAdd = new wxMenuItem(&pmnFonds, ITP_DIRECTORIESADD, wxString(_("A&dd directories...")));
    itpDirectoriesAdd->SetBitmap(wxBitmap(hi16_action_directoryadd_xpm));
    wxMenuItem* itpAddMatchingFiles = new wxMenuItem(&pmnFonds, ITP_ADDMATCHINGFILES, wxString(_("Add &matching files...")));
    itpAddMatchingFiles->SetBitmap(wxBitmap(hi16_action_addmatchingfiles_xpm));
    wxMenuItem* itpRemove = new wxMenuItem(&pmnFonds, ITP_REMOVE, wxString(_("&Remove")));
    itpRemove->SetBitmap(wxBitmap(hi16_action_fileremove_xpm));

    pmnFonds.Append(itpFilesAdd);
    pmnFonds.Append(itpDirectoriesAdd);
    pmnFonds.Append(itpAddMatchingFiles);
    pmnFonds.Append(itpRemove);

    // Check for the remove menu
    if (this->GetSelectedItemCount() == 0)
      itpRemove->Enable(false);
  
    PopupMenu(&pmnFonds, p);
  }
}
//---------------------------------------------------------------------------


/**
 * Event handler a pop-up menu click on 'Add files...'.
 *
 * @param  event  event parameters.
 */
void ChecksumsListView::itpAddFilesClick(wxCommandEvent& event)
{
  this->selectFilesToAdd();
}
//---------------------------------------------------------------------------


/**
 * Event handler a pop-up menu click on 'Add directories...'.
 *
 * @param  event  event parameters.
 */
void ChecksumsListView::itpAddDirectoriesClick(wxCommandEvent& event)
{
  this->selectDirectoriesToAdd();
}
//---------------------------------------------------------------------------


/**
 * Event handler a pop-up menu click on 'Add matching files...'.
 *
 * @param  event  event parameters.
 */
void ChecksumsListView::itpAddMatchingFilesClick(wxCommandEvent& event)
{
  this->selectMatchingFilesToAdd();
}
//---------------------------------------------------------------------------


/**
 * Event handler a pop-up menu click on 'Remove'.
 *
 * @param  event  event parameters.
 */
void ChecksumsListView::itpRemoveClick(wxCommandEvent& event)
{
  this->removeSelectedChecksums();
}
//---------------------------------------------------------------------------


/**
 * Processes a drop of files on the list.
 *
 * @param  event  event parameters.
 */
void ChecksumsListView::DnDFiles(wxCommandEvent& event)
{
  // Get the files list
  wxArrayString* f = reinterpret_cast<wxArrayString*>(event.GetClientData());

  // Add the files in the list or open a file
  if (f != NULL)
  {
    if (this->getSumFile() == NULL)
    {
      size_t i = 0;
      while (i < f->GetCount() && !(this->openChecksumFile((*f)[i])))
        i++;
    }
    else  // add the files in the list
    {
      this->addFiles(*f);

      // Update the main dialog title
      wxCommandEvent event(EVENT_UPDATE_SUMS_FRAME_TITLE_COMMAND);
      this->GetParent()->ProcessEvent(event);
    }
  }

  // Delete the array created by DndCheckSumListView::OnDropFiles()
  if (f != NULL)
    delete f;
}
//---------------------------------------------------------------------------


/**
 * Gets the columns.
 *
 * @param  cols  Array that will contain the columns.
 */
void ChecksumsListView::getColumns(Columns cols[LVW_SUMS_NBCOLS])
{
  for (int i = 0; i < LVW_SUMS_NBCOLS; i++)
    cols[i] = columns[i];
}
//---------------------------------------------------------------------------


/**
 * Sets the columns.
 *
 * @param  newColumns  The new columns order.
 * @return <CODE>true</CODE> if the order of the columns has been changed,
 *         <CODE>false</CODE> otherwise.
 */
bool ChecksumsListView::setColumns(Columns newColumns[LVW_SUMS_NBCOLS])
{
  int       i = 0;
  int       j;
  bool      OK = true;
  bool      hasChanged = false;
  Columns   oldColumns[LVW_SUMS_NBCOLS];
  
  // Checks values of the given array.
  while (OK && i < LVW_SUMS_NBCOLS)
  {
    if (newColumns[i] != FILE_NAME && newColumns[i] != DIRECTORY &&
        newColumns[i] != CHECKSUM_VALUE && newColumns[i] != STATE)
      OK = false;

    i++;
  }

  // Checks that all the values are unique
  i = 0;
  while (OK && i < LVW_SUMS_NBCOLS)
  {
    j = i + 1;
    while (j < LVW_SUMS_NBCOLS)
    {
      if (newColumns[i] == newColumns[j])
        OK = false;
      j++;
    }
    i++;
  }

  // Copy the array
  if (OK)
    for (i = 0; i < LVW_SUMS_NBCOLS; i++)
    {
      oldColumns[i] = columns[i];
      if (columns[i] != newColumns[i])
      {
        hasChanged = true;
        columns[i] = newColumns[i];
      }
    }

  // Reformat the list
  if (OK && hasChanged)
  {
    reformat(oldColumns);
    return true;
  }
  return false;
}
//---------------------------------------------------------------------------


/**
 * Reformats the list.
 *
 * @param  oldColumns  Old order of the columns. <CODE>NULL</CODE> if the order
 *                     has not changed.
 */
void ChecksumsListView::reformat(Columns oldColumns[LVW_SUMS_NBCOLS])
{
  wxBusyCursor wait;
  this->Freeze();
  
  // Sets the text of the headers of the columns
  if (oldColumns != NULL)
  {
    wxListItem colitem;
    colitem.SetMask(wxLIST_MASK_TEXT);
    for (int i = 0; i < LVW_SUMS_NBCOLS; i++)
    {
      this->GetColumn(i, colitem);
      colitem.SetText(getColumnName(columns[i]));
      this->SetColumn(i, colitem);
    }
  }

  wxString     state;
  int          i;
  wxListItem   li;
  Columns*     refTab = (oldColumns == NULL) ? columns : oldColumns;

  // Find the column of the state
  int stateCol = -1;
  for (i = 0; (i < LVW_SUMS_NBCOLS) && (stateCol == -1); i++)
    if (refTab[i] == STATE)
      stateCol = i;

  li.SetMask(wxLIST_MASK_TEXT);
  long item = this->GetNextItem(-1, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
  while (item != -1)
  {
    // Get necessary data.
    li.SetId(item);
    li.SetColumn(stateCol);
    this->GetItem(li);
    state = li.GetText();

    // Sets the item data
    setChecksum(item, state);

    item = this->GetNextItem(item, wxLIST_NEXT_ALL, wxLIST_STATE_DONTCARE);
  }

  this->Thaw();
  
  // Sort the list
  sort();
}
//---------------------------------------------------------------------------


/**
 * Gets the name of a column.
 *
 * @param  col  The column which the name will be returned.
 * @return The name of a column.
 */
wxString ChecksumsListView::getColumnName(const Columns col)
{
  wxString res;
  switch (col)
  {
    case FILE_NAME :
      res = _("File name");
      break;
    case DIRECTORY :
      res = _("Directory");
      break;
    case CHECKSUM_VALUE :
      res = _("Checksum value");
      break;
    case STATE :
      res = _("State");
      break;
    default :
      res = wxT("");
  }
  return res;
}
//---------------------------------------------------------------------------


BEGIN_EVENT_TABLE(ChecksumsListView, wxListView)
  EVT_MENU(ITP_FILESADD, ChecksumsListView::itpAddFilesClick)
  EVT_MENU(ITP_DIRECTORIESADD, ChecksumsListView::itpAddDirectoriesClick)
  EVT_MENU(ITP_ADDMATCHINGFILES, ChecksumsListView::itpAddMatchingFilesClick)
  EVT_MENU(ITP_REMOVE, ChecksumsListView::itpRemoveClick)
  EVT_CUSTOM(EVENT_DNDFILES_COMMAND, -1, ChecksumsListView::DnDFiles)

  #if defined(__WXMSW__)
  EVT_CONTEXT_MENU(ChecksumsListView::OnContextMenu)
  #else
  EVT_RIGHT_UP(ChecksumsListView::OnRightUp)
  #endif  // defined(__WXMSW__)
END_EVENT_TABLE()
//---------------------------------------------------------------------------
