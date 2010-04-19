# Make file for SciTE on Windows Visual C++ and Borland C++ version
# Copyright 1998-2001 by Neil Hodgson <neilh@scintilla.org>
# The License.txt file describes the conditions under which this software may be distributed.
# This makefile is for using Visual C++ with nmake or Borland C++ with make depending on
# the setting of the VENDOR macro. If no VENDOR is defined n the command line then
# the tool used is automatically detected.
# Usage for Microsoft:
#     nmake -f scite.mak
# Usage for Borland:
#     make -f scite.mak
# For debug versions define DEBUG on the command line.
# For a build without Lua, define NO_LUA on the command line.
# The main makefile uses mingw32 gcc and may be more current than this file.

.SUFFIXES: .cxx

DIR_BIN=..\bin

PROG=$(DIR_BIN)\SciTE.exe
PROGSTATIC=$(DIR_BIN)\Sc1.exe
DLLS=$(DIR_BIN)\Scintilla.dll $(DIR_BIN)\SciLexer.dll

!IFNDEF VENDOR
!IFDEF _NMAKE_VER
#Microsoft nmake so make default VENDOR MICROSOFT
VENDOR=MICROSOFT
!ELSE
VENDOR=BORLAND
!ENDIF
!ENDIF

WIDEFLAGS=-DUNICODE -D_UNICODE

!IF "$(VENDOR)"=="MICROSOFT"

CC=cl
RC=rc
LD=link

CXXFLAGS=-Zi -TP -W4 -EHsc -Zc:forScope -Zc:wchar_t -D_CRT_SECURE_NO_DEPRECATE=1 -D_CRT_NONSTDC_NO_DEPRECATE $(WIDEFLAGS)
CCFLAGS=-TC -W3 -wd4244 -D_CRT_SECURE_NO_DEPRECATE=1

# For something scary:-Wp64
CXXDEBUG=-Od -MTd -DDEBUG
# Don't use "-MD", even with "-D_STATIC_CPPLIB" because it links to MSVCR71.DLL
CXXNDEBUG=-O1 -Oi -MT -DNDEBUG -GL
NAME=-Fo
LDFLAGS=-OPT:NOWIN98 -OPT:REF -LTCG -DEBUG
LDDEBUG=
LIBS=KERNEL32.lib USER32.lib GDI32.lib COMDLG32.lib COMCTL32.lib ADVAPI32.lib IMM32.lib SHELL32.LIB OLE32.LIB
NOLOGO=-nologo

!ELSE
# BORLAND

CC=bcc32
RC=brcc32 -r
LD=ilink32

CXXFLAGS=-P -tWM -w -w-prc -w-inl -RT- $(WIDEFLAGS)
CCFLAGS=-tWM -w -RT- -x- -v- -w-aus -w-sig

# Above turns off warnings for clarfying parentheses and inlines with for not expanded
CXXDEBUG=-Od -v -DDEBUG
CXXNDEBUG=-O1 -DNDEBUG
NAME=-o
LDFLAGS=-Gn -x -c
LDDEBUG=-v
LIBS=import32 cw32mt
NOLOGO=-q

!ENDIF

!IFDEF QUIET
CC=@$(CC)
CXXFLAGS=$(CXXFLAGS) $(NOLOGO)
CCFLAGS=$(CCFLAGS) $(NOLOGO)
LDFLAGS=$(LDFLAGS) $(NOLOGO)
!ENDIF

!IFDEF DEBUG
CXXFLAGS=$(CXXFLAGS) $(CXXDEBUG)
CCFLAGS=$(CCFLAGS) $(CXXDEBUG)
LDFLAGS=$(LDDEBUG) $(LDFLAGS)
!ELSE
CXXFLAGS=$(CXXFLAGS) $(CXXNDEBUG)
CCFLAGS=$(CCFLAGS) $(CXXNDEBUG)
!ENDIF

INCLUDEDIRS=-I../../scintilla/include -I../../scintilla/win32 -I../src

OBJS=\
	SciTEBase.obj \
	FilePath.obj \
	SciTEBuffers.obj \
	SciTEIO.obj \
	Exporters.obj \
	PropSetFile.obj \
	StringList.obj \
	SciTEProps.obj \
	Utf8_16.obj \
	SciTEWin.obj \
	SciTEWinBar.obj \
	SciTEWinDlg.obj \
	IFaceTable.obj \
	DirectorExtension.obj \
	MultiplexExtension.obj \
	StyleWriter.obj \
	GUIWin.obj \
	UniqueInstance.obj \
	WinMutex.obj

# modified by Mitchell
#++Autogenerated -- run src/LexGen.py to regenerate
#**LEXOBJS=\\\n\(\t..\\..\\scintilla\\win32\\\*.obj \\\n\)
LEXOBJS=\
	..\..\scintilla\win32\LexLPeg.obj

#--Autogenerated -- end of automatically generated section
# end modified by Mitchell

OBJSSTATIC=\
	SciTEBase.obj \
	FilePath.obj \
	SciTEBuffers.obj \
	SciTEIO.obj \
	Exporters.obj \
	PropSetFile.obj \
	StringList.obj \
	SciTEProps.obj \
	Utf8_16.obj \
	Sc1.obj \
	SciTEWinBar.obj \
	SciTEWinDlg.obj \
	IFaceTable.obj \
	DirectorExtension.obj \
	MultiplexExtension.obj \
	StyleWriter.obj \
	GUIWin.obj \
	UniqueInstance.obj \
	WinMutex.obj \
	..\..\scintilla\win32\AutoComplete.obj \
	..\..\scintilla\win32\CallTip.obj \
	..\..\scintilla\win32\CellBuffer.obj \
	..\..\scintilla\win32\ContractionState.obj \
	..\..\scintilla\win32\CharClassify.obj \
	..\..\scintilla\win32\Decoration.obj \
	..\..\scintilla\win32\Document.obj \
	..\..\scintilla\win32\DocumentAccessor.obj \
	..\..\scintilla\win32\Editor.obj \
	..\..\scintilla\win32\ExternalLexer.obj \
	..\..\scintilla\win32\Indicator.obj \
	..\..\scintilla\win32\KeyMap.obj \
	..\..\scintilla\win32\KeyWords.obj \
	..\..\scintilla\win32\LineMarker.obj \
	..\..\scintilla\win32\PerLine.obj \
	..\..\scintilla\win32\PlatWin.obj \
	..\..\scintilla\win32\PositionCache.obj \
	..\..\scintilla\win32\PropSet.obj \
	..\..\scintilla\win32\RESearch.obj \
	..\..\scintilla\win32\RunStyles.obj \
	..\..\scintilla\win32\ScintillaBaseL.obj \
	..\..\scintilla\win32\ScintillaWinL.obj \
	..\..\scintilla\win32\Selection.obj \
	..\..\scintilla\win32\Style.obj \
	..\..\scintilla\win32\StyleContext.obj \
	..\..\scintilla\win32\UniConversion.obj \
	..\..\scintilla\win32\ViewStyle.obj \
	..\..\scintilla\win32\WindowAccessor.obj \
	..\..\scintilla\win32\XPM.obj

#++Autogenerated -- run scintilla/src/LexGen.py to regenerate
#**1:LEXPROPS=\\\n\($(DIR_BIN)\\\* \)
LEXPROPS=\
$(DIR_BIN)\abaqus.properties $(DIR_BIN)\ada.properties \
$(DIR_BIN)\asm.properties $(DIR_BIN)\asn1.properties $(DIR_BIN)\au3.properties \
$(DIR_BIN)\ave.properties $(DIR_BIN)\baan.properties \
$(DIR_BIN)\blitzbasic.properties $(DIR_BIN)\bullant.properties \
$(DIR_BIN)\caml.properties $(DIR_BIN)\cmake.properties \
$(DIR_BIN)\cobol.properties $(DIR_BIN)\conf.properties \
$(DIR_BIN)\cpp.properties $(DIR_BIN)\csound.properties \
$(DIR_BIN)\css.properties $(DIR_BIN)\d.properties $(DIR_BIN)\eiffel.properties \
$(DIR_BIN)\erlang.properties $(DIR_BIN)\escript.properties \
$(DIR_BIN)\flagship.properties $(DIR_BIN)\forth.properties \
$(DIR_BIN)\fortran.properties $(DIR_BIN)\freebasic.properties \
$(DIR_BIN)\gap.properties $(DIR_BIN)\html.properties \
$(DIR_BIN)\inno.properties $(DIR_BIN)\kix.properties \
$(DIR_BIN)\latex.properties $(DIR_BIN)\lisp.properties \
$(DIR_BIN)\lot.properties $(DIR_BIN)\lout.properties $(DIR_BIN)\lua.properties \
$(DIR_BIN)\matlab.properties $(DIR_BIN)\metapost.properties \
$(DIR_BIN)\mmixal.properties $(DIR_BIN)\nimrod.properties \
$(DIR_BIN)\nncrontab.properties $(DIR_BIN)\nsis.properties \
$(DIR_BIN)\opal.properties $(DIR_BIN)\others.properties \
$(DIR_BIN)\pascal.properties $(DIR_BIN)\perl.properties \
$(DIR_BIN)\pov.properties $(DIR_BIN)\powerpro.properties \
$(DIR_BIN)\powershell.properties $(DIR_BIN)\ps.properties \
$(DIR_BIN)\purebasic.properties $(DIR_BIN)\python.properties \
$(DIR_BIN)\r.properties $(DIR_BIN)\rebol.properties $(DIR_BIN)\ruby.properties \
$(DIR_BIN)\scriptol.properties $(DIR_BIN)\smalltalk.properties \
$(DIR_BIN)\sorcins.properties $(DIR_BIN)\specman.properties \
$(DIR_BIN)\spice.properties $(DIR_BIN)\sql.properties \
$(DIR_BIN)\tacl.properties $(DIR_BIN)\tal.properties $(DIR_BIN)\tcl.properties \
$(DIR_BIN)\tex.properties $(DIR_BIN)\vb.properties \
$(DIR_BIN)\verilog.properties $(DIR_BIN)\vhdl.properties \
$(DIR_BIN)\yaml.properties
#--Autogenerated -- end of automatically generated section

PROPS=$(DIR_BIN)\SciTEGlobal.properties $(DIR_BIN)\abbrev.properties $(LEXPROPS)

!IFNDEF NO_LUA
LUA_CORE_OBJS = lapi.obj lcode.obj ldebug.obj ldo.obj ldump.obj lfunc.obj lgc.obj llex.obj \
                lmem.obj lobject.obj lopcodes.obj lparser.obj lstate.obj lstring.obj \
                ltable.obj ltm.obj lundump.obj lvm.obj lzio.obj

LUA_LIB_OBJS =	lauxlib.obj lbaselib.obj ldblib.obj liolib.obj lmathlib.obj ltablib.obj \
                lstrlib.obj loadlib.obj loslib.obj linit.obj

LUA_OBJS = LuaExtension.obj SingleThreadExtension.obj $(LUA_CORE_OBJS) $(LUA_LIB_OBJS)

OBJS = $(OBJS) $(LUA_OBJS)
OBJSSTATIC = $(OBJSSTATIC) $(LUA_OBJS)
INCLUDEDIRS = $(INCLUDEDIRS) -I../lua/include
!ELSE
CXXFLAGS=$(CXXFLAGS) -DNO_LUA
!ENDIF

CXXFLAGS=$(CXXFLAGS) $(INCLUDEDIRS)
CCFLAGS=$(CCFLAGS) $(INCLUDEDIRS)


ALL: $(PROG) $(PROGSTATIC) $(DLLS) $(PROPS)

clean:
	del /q $(DIR_BIN)\*.exe *.o *.obj $(DIR_BIN)\*.dll *.res *.map $(DIR_BIN)\*.exp $(DIR_BIN)\*.lib $(DIR_BIN)\*.pdb

$(DIR_BIN)\Scintilla.dll: ..\..\scintilla\bin\Scintilla.dll
	copy ..\..\scintilla\bin\Scintilla.dll $@

$(DIR_BIN)\SciLexer.dll: ..\..\scintilla\bin\SciLexer.dll
	copy ..\..\scintilla\bin\SciLexer.dll $@

$(DIR_BIN)\SciTEGlobal.properties: ..\src\SciTEGlobal.properties
	copy ..\src\SciTEGlobal.properties $@

$(DIR_BIN)\abbrev.properties: ..\src\abbrev.properties
	copy ..\src\abbrev.properties $@

#++Autogenerated -- run scintilla/src/LexGen.py to regenerate
#**1:\($(DIR_BIN)\\\*:\t..\\src\\\*\n\tcopy ..\\src\\\* $@\n\)
$(DIR_BIN)\abaqus.properties:	..\src\abaqus.properties
	copy ..\src\abaqus.properties $@
$(DIR_BIN)\ada.properties:	..\src\ada.properties
	copy ..\src\ada.properties $@
$(DIR_BIN)\asm.properties:	..\src\asm.properties
	copy ..\src\asm.properties $@
$(DIR_BIN)\asn1.properties:	..\src\asn1.properties
	copy ..\src\asn1.properties $@
$(DIR_BIN)\au3.properties:	..\src\au3.properties
	copy ..\src\au3.properties $@
$(DIR_BIN)\ave.properties:	..\src\ave.properties
	copy ..\src\ave.properties $@
$(DIR_BIN)\baan.properties:	..\src\baan.properties
	copy ..\src\baan.properties $@
$(DIR_BIN)\blitzbasic.properties:	..\src\blitzbasic.properties
	copy ..\src\blitzbasic.properties $@
$(DIR_BIN)\bullant.properties:	..\src\bullant.properties
	copy ..\src\bullant.properties $@
$(DIR_BIN)\caml.properties:	..\src\caml.properties
	copy ..\src\caml.properties $@
$(DIR_BIN)\cmake.properties:	..\src\cmake.properties
	copy ..\src\cmake.properties $@
$(DIR_BIN)\cobol.properties:	..\src\cobol.properties
	copy ..\src\cobol.properties $@
$(DIR_BIN)\conf.properties:	..\src\conf.properties
	copy ..\src\conf.properties $@
$(DIR_BIN)\cpp.properties:	..\src\cpp.properties
	copy ..\src\cpp.properties $@
$(DIR_BIN)\csound.properties:	..\src\csound.properties
	copy ..\src\csound.properties $@
$(DIR_BIN)\css.properties:	..\src\css.properties
	copy ..\src\css.properties $@
$(DIR_BIN)\d.properties:	..\src\d.properties
	copy ..\src\d.properties $@
$(DIR_BIN)\eiffel.properties:	..\src\eiffel.properties
	copy ..\src\eiffel.properties $@
$(DIR_BIN)\erlang.properties:	..\src\erlang.properties
	copy ..\src\erlang.properties $@
$(DIR_BIN)\escript.properties:	..\src\escript.properties
	copy ..\src\escript.properties $@
$(DIR_BIN)\flagship.properties:	..\src\flagship.properties
	copy ..\src\flagship.properties $@
$(DIR_BIN)\forth.properties:	..\src\forth.properties
	copy ..\src\forth.properties $@
$(DIR_BIN)\fortran.properties:	..\src\fortran.properties
	copy ..\src\fortran.properties $@
$(DIR_BIN)\freebasic.properties:	..\src\freebasic.properties
	copy ..\src\freebasic.properties $@
$(DIR_BIN)\gap.properties:	..\src\gap.properties
	copy ..\src\gap.properties $@
$(DIR_BIN)\html.properties:	..\src\html.properties
	copy ..\src\html.properties $@
$(DIR_BIN)\inno.properties:	..\src\inno.properties
	copy ..\src\inno.properties $@
$(DIR_BIN)\kix.properties:	..\src\kix.properties
	copy ..\src\kix.properties $@
$(DIR_BIN)\latex.properties:	..\src\latex.properties
	copy ..\src\latex.properties $@
$(DIR_BIN)\lisp.properties:	..\src\lisp.properties
	copy ..\src\lisp.properties $@
$(DIR_BIN)\lot.properties:	..\src\lot.properties
	copy ..\src\lot.properties $@
$(DIR_BIN)\lout.properties:	..\src\lout.properties
	copy ..\src\lout.properties $@
$(DIR_BIN)\lua.properties:	..\src\lua.properties
	copy ..\src\lua.properties $@
$(DIR_BIN)\matlab.properties:	..\src\matlab.properties
	copy ..\src\matlab.properties $@
$(DIR_BIN)\metapost.properties:	..\src\metapost.properties
	copy ..\src\metapost.properties $@
$(DIR_BIN)\mmixal.properties:	..\src\mmixal.properties
	copy ..\src\mmixal.properties $@
$(DIR_BIN)\nimrod.properties:	..\src\nimrod.properties
	copy ..\src\nimrod.properties $@
$(DIR_BIN)\nncrontab.properties:	..\src\nncrontab.properties
	copy ..\src\nncrontab.properties $@
$(DIR_BIN)\nsis.properties:	..\src\nsis.properties
	copy ..\src\nsis.properties $@
$(DIR_BIN)\opal.properties:	..\src\opal.properties
	copy ..\src\opal.properties $@
$(DIR_BIN)\others.properties:	..\src\others.properties
	copy ..\src\others.properties $@
$(DIR_BIN)\pascal.properties:	..\src\pascal.properties
	copy ..\src\pascal.properties $@
$(DIR_BIN)\perl.properties:	..\src\perl.properties
	copy ..\src\perl.properties $@
$(DIR_BIN)\pov.properties:	..\src\pov.properties
	copy ..\src\pov.properties $@
$(DIR_BIN)\powerpro.properties:	..\src\powerpro.properties
	copy ..\src\powerpro.properties $@
$(DIR_BIN)\powershell.properties:	..\src\powershell.properties
	copy ..\src\powershell.properties $@
$(DIR_BIN)\ps.properties:	..\src\ps.properties
	copy ..\src\ps.properties $@
$(DIR_BIN)\purebasic.properties:	..\src\purebasic.properties
	copy ..\src\purebasic.properties $@
$(DIR_BIN)\python.properties:	..\src\python.properties
	copy ..\src\python.properties $@
$(DIR_BIN)\r.properties:	..\src\r.properties
	copy ..\src\r.properties $@
$(DIR_BIN)\rebol.properties:	..\src\rebol.properties
	copy ..\src\rebol.properties $@
$(DIR_BIN)\ruby.properties:	..\src\ruby.properties
	copy ..\src\ruby.properties $@
$(DIR_BIN)\scriptol.properties:	..\src\scriptol.properties
	copy ..\src\scriptol.properties $@
$(DIR_BIN)\smalltalk.properties:	..\src\smalltalk.properties
	copy ..\src\smalltalk.properties $@
$(DIR_BIN)\sorcins.properties:	..\src\sorcins.properties
	copy ..\src\sorcins.properties $@
$(DIR_BIN)\specman.properties:	..\src\specman.properties
	copy ..\src\specman.properties $@
$(DIR_BIN)\spice.properties:	..\src\spice.properties
	copy ..\src\spice.properties $@
$(DIR_BIN)\sql.properties:	..\src\sql.properties
	copy ..\src\sql.properties $@
$(DIR_BIN)\tacl.properties:	..\src\tacl.properties
	copy ..\src\tacl.properties $@
$(DIR_BIN)\tal.properties:	..\src\tal.properties
	copy ..\src\tal.properties $@
$(DIR_BIN)\tcl.properties:	..\src\tcl.properties
	copy ..\src\tcl.properties $@
$(DIR_BIN)\tex.properties:	..\src\tex.properties
	copy ..\src\tex.properties $@
$(DIR_BIN)\vb.properties:	..\src\vb.properties
	copy ..\src\vb.properties $@
$(DIR_BIN)\verilog.properties:	..\src\verilog.properties
	copy ..\src\verilog.properties $@
$(DIR_BIN)\vhdl.properties:	..\src\vhdl.properties
	copy ..\src\vhdl.properties $@
$(DIR_BIN)\yaml.properties:	..\src\yaml.properties
	copy ..\src\yaml.properties $@

#--Autogenerated -- end of automatically generated section

# Normally distributed rather than built as may not have grep on all machines
# Copy all non-comment lines from all the properties files into one combined file
..\src\Embedded.properties: $(PROPS)
	grep -v -h "^[#]" $(PROPS) >..\src\Embedded.properties

# A custom rule for .obj files built by scintilla:
..\..\scintilla\win32\PlatWin.obj: 	..\..\scintilla\win32\PlatWin.cxx
	@echo You must run the Scintilla makefile to build $*.obj
	@exit 255

SciTERes.res: SciTERes.rc ..\src\SciTE.h ..\..\scintilla\win32\PlatformRes.h SciTE.exe.manifest
	$(RC) $(INCLUDEDIRS) -fo$@ SciTERes.rc

Sc1Res.res: SciTERes.rc ..\src\SciTE.h ..\..\scintilla\win32\PlatformRes.h SciTE.exe.manifest
	$(RC) $(INCLUDEDIRS) -dSTATIC_BUILD -fo$@ SciTERes.rc

!IF "$(VENDOR)"=="MICROSOFT"

$(PROG): $(OBJS) SciTERes.res
	$(LD) $(LDFLAGS) -OUT:$@ $** $(LIBS)

$(PROGSTATIC): $(OBJSSTATIC) $(LEXOBJS) Sc1Res.res
	$(LD) $(LDFLAGS) -OUT:$@ $** $(LIBS)

!ELSE

$(PROG): $(OBJS) SciTERes.res
	$(LD) $(LDFLAGS) -Tpe -aa @&&|
	c0w32 $(OBJS)
	$@

	$(LIBS)

	SciTERes.res
|

$(PROGSTATIC): $(OBJSSTATIC) $(LEXOBJS) Sc1Res.res
	$(LD) $(LDFLAGS) -Tpe -aa @&&|
	c0w32 $(OBJSSTATIC) $(LEXOBJS)
	$@

	$(LIBS)

	Sc1Res.res
|

!ENDIF

# Define how to build all the objects and what they depend on
# Some source files are compiled into more than one object because of different conditional compilation

{..\src}.cxx.obj:
	$(CC) $(CXXFLAGS) -c $<
{.}.cxx.obj:
	$(CC) $(CXXFLAGS) -c $<

{..\lua\src}.c.obj:
	$(CC) $(CCFLAGS) -c $<
{..\lua\src\lib}.c.obj:
	$(CC) $(CCFLAGS) -c $<

Sc1.obj: SciTEWin.cxx
	$(CC) $(CXXFLAGS) -DSTATIC_BUILD -c $(NAME)$@ SciTEWin.cxx

# Dependencies
DirectorExtension.obj: \
	DirectorExtension.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/Extender.h \
	DirectorExtension.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h
GUIWin.obj: \
	GUIWin.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h
SciTEWin.obj: \
	SciTEWin.cxx \
	SciTEWin.h \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h \
	../src/SciTEKeys.h \
	UniqueInstance.h \
	../src/MultiplexExtension.h \
	../src/Extender.h \
	DirectorExtension.h \
	SingleThreadExtension.h \
	../src/LuaExtension.h
Sc1.obj: \
	SciTEWin.cxx \
	SciTEWin.h \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h \
	../src/SciTEKeys.h \
	UniqueInstance.h \
	../src/MultiplexExtension.h \
	../src/Extender.h \
	DirectorExtension.h \
	SingleThreadExtension.h \
	../src/LuaExtension.h
SciTEWinBar.obj: \
	SciTEWinBar.cxx \
	SciTEWin.h \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h \
	../src/SciTEKeys.h \
	UniqueInstance.h
SciTEWinDlg.obj: \
	SciTEWinDlg.cxx \
	SciTEWin.h \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h \
	../src/SciTEKeys.h \
	UniqueInstance.h
SingleThreadExtension.obj: \
	SingleThreadExtension.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	SingleThreadExtension.h \
	../src/Extender.h
UniqueInstance.obj: \
	UniqueInstance.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	SciTEWin.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h \
	../src/SciTEKeys.h \
	UniqueInstance.h
WinMutex.obj: \
	WinMutex.cxx \
	../src/Mutex.h
Exporters.obj: \
	../src/Exporters.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h
FilePath.obj: \
	../src/FilePath.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/SString.h \
	../src/FilePath.h
JobQueue.obj: \
	../src/JobQueue.cxx \
	../../scintilla/include/Scintilla.h \
	../src/SString.h \
	../src/FilePath.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h
MultiplexExtension.obj: \
	../src/MultiplexExtension.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/MultiplexExtension.h \
	../src/Extender.h
PropSetFile.obj: \
	../src/PropSetFile.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/SString.h \
	../src/FilePath.h \
	../src/PropSetFile.h
SciTEBase.obj: \
	../src/SciTEBase.cxx \
	../../scintilla/include/Scintilla.h \
	../../scintilla/include/SciLexer.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h
SciTEBuffers.obj: \
	../src/SciTEBuffers.cxx \
	../../scintilla/include/Scintilla.h \
	../../scintilla/include/SciLexer.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h
SciTEIO.obj: \
	../src/SciTEIO.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/SciTE.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h \
	../src/Utf8_16.h
SciTEProps.obj: \
	../src/SciTEProps.cxx \
	../../scintilla/include/Scintilla.h \
	../../scintilla/include/SciLexer.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StringList.h \
	../src/FilePath.h \
	../src/PropSetFile.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/SciTE.h \
	../src/IFaceTable.h \
	../src/Mutex.h \
	../src/JobQueue.h \
	../src/SciTEBase.h
StringList.obj: \
	../src/StringList.cxx \
	../src/SString.h \
	../src/StringList.h
StyleWriter.obj: \
	../src/StyleWriter.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/StyleWriter.h
Utf8_16.obj: \
	../src/Utf8_16.cxx \
	../src/Utf8_16.h

!IFNDEF NO_LUA
LuaExtension.obj: \
	../src/LuaExtension.cxx \
	../../scintilla/include/Scintilla.h \
	../src/GUI.h \
	../src/SString.h \
	../src/StyleWriter.h \
	../src/Extender.h \
	../src/LuaExtension.h \
	../src/IFaceTable.h \
	../src/SciTEKeys.h

IFaceTable.obj: \
	../src/IFaceTable.cxx \
	../src/IFaceTable.h

# Lua core dependencies are omitted; if the Lua source code
# is modified, a make clean may be necessary.
!ENDIF
