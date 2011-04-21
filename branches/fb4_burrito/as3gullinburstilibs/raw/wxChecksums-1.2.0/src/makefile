#############################################################################
# makefile                                                                  #
#############################################################################
# Julien Couot                                                              #
#############################################################################
# 29/02/2004                                                                #
#   Added USE_LARGE_FILES define                                            #
#                                                                           #
# 04/11/2003                                                                #
#   Added install target                                                    #
#                                                                           #
# 15/07/2003                                                                #
#   Initial release                                                         #
#############################################################################


# Compilation options
CXX = $(shell wx-config --cxx)
CCINCL = $(shell wx-config --cppflags)
CCOPTS = -O2
LD = $(shell wx-config --ld)
LDOPTS = $(shell wx-config --libs)

# Customizable options
ifdef USE_LARGE_FILES
CCOPTS += -DwxC_USE_LARGE_FILES=1
endif


# Installation options
# Prefix where the program will be installed
# Executable will be installed in $(PREFIX)/bin
# Locale will be installed in $(PREFIX)/share/locale/xx/
# where xx is the name of the locale.
# PREFIX can be defined on the command line, for example:
# make install PREFIX=/usr
INSTALL = install -c
ifndef PREFIX
PREFIX = /usr/local
endif


# Targets
WXCHECKSUMS = wxcksums


all: $(WXCHECKSUMS)


.SUFFIXES: .o .cpp

.cpp.o:
	$(CXX) -c $(CCINCL) $(CCOPTS) -o $@ $<


WXCHECKSUMS_OBJS = cksums.o lvwSums.o frmSums.o dlgProgress.o dlgResProg.o dlgFilesSelector.o dlgConf.o dlgAbout.o dlgInvalidFiles.o dlgNewFile.o dlgMultiCheckConf.o dlgMultiCheck.o dlgBatchCreateConf.o dlgBatchCreate.o dlgAddMatchFiles.o slstview.o appprefs.o language.o checksumutil.o checksumfactory.o md5.o crc32.o sumfile.o md5file.o sfvfile.o bytedisp.o utils.o osdep.o fileutil.o fdftlmk.o cmdlnopt.o licence.o


# wxcksums
$(WXCHECKSUMS): $(WXCHECKSUMS_OBJS)
	$(CXX) -o $(WXCHECKSUMS) $(WXCHECKSUMS_OBJS) $(LDOPTS) 

clean:
	rm -f *.o
	rm -f ./$(WXCHECKSUMS)
	rm -fr docs/html

install:
	$(INSTALL) -d $(PREFIX)/bin/
	$(INSTALL) -s $(WXCHECKSUMS) $(PREFIX)/bin/
	$(INSTALL) -d $(PREFIX)/share/wxChecksums
	$(INSTALL) languages.ini $(PREFIX)/share/wxChecksums
	$(INSTALL) -d $(PREFIX)/share/locale/fr/LC_MESSAGES
	$(INSTALL) fr/cksums.mo $(PREFIX)/share/locale/fr/LC_MESSAGES

doc:
	doxygen cksums.doxygen

edit:
	nedit *.cpp *.hpp makefile&

depend:
	makedepend -fmakefile.dep cksums.cpp lvwSums.cpp frmSums.cpp dlgProgress.cpp dlgResProg.cpp dlgFilesSelector.cpp dlgConf.cpp dlgAbout.cpp dlgInvalidFiles.cpp dlgNewFile.cpp dlgMultiCheckConf.cpp dlgMultiCheck.cpp dlgBatchCreateConf.cpp dlgBatchCreate.cpp dlgAddMatchFiles.cpp slstview.cpp appprefs.cpp language.cpp checksumutil.cpp checksumfactory.cpp md5.cpp crc32.cpp sumfile.cpp md5file.cpp sfvfile.cpp bytedisp.cpp utils.cpp osdep.cpp fileutil.cpp fdftlmk.cpp cmdlnopt.cpp licence.cpp

include makefile.dep
