  100 REM DIRECTOR Program.
  110 REM Program Directory for the Genealogy ON DISPLAY Programs
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 DATA Genealogy
  140 DATA Program Directory
  150 DATA -1
  160 DATA 1
  170 INDENT = 0
  180 REM Printer Definitions
  190 FORM.FEED$  = CHR$(12)
  200 COMPR.OFF$  = CHR$(18)     : COMPR.ON$ = CHR$(15)
  210 BOLD.OFF$   = CHR$(27)+"F" : BOLD.ON$ = CHR$(27)+"E"
  220 EXPAND.OFF$ = CHR$(18)     : EXPAND.ON$ = CHR$(14)
  300 REM Program begins here
  310 READ TITLE$, DOC.NAME$, PAGE.NO, LINE.NO
  320 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
  330 GOSUB 920  'For trim line and heading space
  340 FOR I = 1 TO 6 : LPRINT : NEXT I
  350 LPRINT BOLD.ON$;    'Set Emphasized Print
  360 LPRINT EXPAND.ON$;  'Set Expanded Print
  370 LPRINT TAB(TAB.POS-1);TITLE$
  380 LPRINT EXPAND.OFF$;  'Return to normal
  390 LPRINT BOLD.OFF$;    'Return to normal
  400 FOR I = 1 TO 3 : LPRINT : NEXT I
  410 LPRINT BOLD.ON$; 'Set Emphasized mode
  420 LPRINT TAB(TAB.POS+12);"ON DISPLAY"
  430 LPRINT BOLD.OFF$; 'Return to normal
  440 LPRINT : LPRINT : LPRINT
  450 LPRINT TAB(TAB.POS+11);"Version 6.0"
  460 FOR I = 1 TO 11 : LPRINT : NEXT I
  470 LPRINT TAB(TAB.POS+8); DOC.NAME$
  480 LINE.NO = LINE.NO + 27
  490 '
  500 READ REPLY$
  510 REM First, change tildes to quotes
  520 FOR Q = 1 TO LEN(REPLY$)
  530  IF MID$(REPLY$,Q,1)="~"THEN MID$(REPLY$,Q,1)=CHR$(34)
  540 NEXT Q
  550 IF LEFT$(REPLY$,1) = "." THEN GOSUB 1270: GOTO 500
  560 IF LINE.NO > 44 THEN GOSUB 1030
  570 REM Print the line if not a command
  580 LPRINT TAB(TAB.POS);REPLY$
  590 LINE.NO = LINE.NO + 1
  600 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
  610 GOTO 500
  620 REM Data for the Copyright Page
  630 DATA ".pa"
  640 DATA " "
  750 DATA ".vt 2"
  754 DATA "If you are using these programs, you are"
  758 DATA "expected to become a Registered User,"
  762 DATA "by making a contribution to the Author"
  766 DATA "of the programs ($49.00 suggested)."
  770 DATA "Registration is by each individual,"
  774 DATA "and not by any company or group."
  778 DATA ".vt 2"
  782 DATA "Users are encouraged to copy and to"
  786 DATA "share the programs with others."
  820 DATA ".vt 13"
  830 DATA "Melvin O. Duke"
  840 DATA "P. O. Box 2048"
  850 DATA "Morgan Hill, CA  95038-2048"
  860 DATA ".vt 3"
  870 DATA "Copyright (c) 1982 ... 1989, by:"
  880 DATA "Melvin O. Duke."
  890 DATA ".sp"
  900 DATA "All rights reserved."
  910 '
  920 REM Top of each page routine
  930 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
  940 LPRINT
  950 LPRINT TAB(30); "(Trim-line)"
  960 LPRINT "+"+STRING$(54,45)+"+" 'Dashes
  970 FOR I = 1 TO 6
  980  LPRINT
  990 NEXT I
 1000 LINE.NO = LINE.NO + 6
 1010 RETURN
 1020 '
 1030 REM Bottom of each page Routine
 1040 IF PAGE.NO < 1 THEN LPRINT : LPRINT : LPRINT : GOTO 1160
 1050 LPRINT TAB(TAB.POS); STRING$(40,45)  'on line 46
 1060 LPRINT TAB(TAB.POS+2); TITLE$+" ON DISPLAY.  Version 6.0" 'on line 47
 1070 IF PAGE.NO MOD 2 = 1 THEN 1110
 1080 LPRINT TAB(TAB.POS);"Page";PAGE.NO;
 1090 LPRINT TAB(TAB.POS+23);"Program Directory"
 1100 GOTO 1160
 1110 LPRINT TAB(TAB.POS); "Program Directory";
 1120 IF PAGE.NO < 10 THEN DELTA = 34
 1130 IF PAGE.NO >  9 THEN DELTA = 33
 1140 IF PAGE.NO > 99 THEN DELTA = 32
 1150 LPRINT TAB(TAB.POS+DELTA); "Page"; PAGE.NO  'on line 48
 1160 LPRINT : LPRINT : LPRINT
 1170 LPRINT "+"+STRING$(54,45)+"+" 'dashes after 51
 1180 LPRINT TAB(30); "(Trim-line)"
 1190 LPRINT FORM.FEED$;
 1200 PAGE.NO = PAGE.NO + 1
 1210 LINE.NO = 1
 1220 IF REPLY$ = ".eof" THEN 1240  'Bypass after last page
 1230 GOSUB 920  'For top of next page
 1240 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 1250 RETURN
 1260 '
 1270 REM Command Processor
 1280 IF LEFT$(REPLY$,3) = ".h1" THEN 1380
 1290 IF LEFT$(REPLY$,3) = ".h2" THEN 1540
 1300 IF LEFT$(REPLY$,3) = ".h3" THEN 1650
 1310 IF LEFT$(REPLY$,3) = ".sp" THEN 1760
 1320 IF LEFT$(REPLY$,4) = ".eof" THEN 1810
 1330 IF LEFT$(REPLY$,3) = ".pa" THEN 1850
 1340 IF LEFT$(REPLY$,3) = ".vt" THEN 1920
 1350 IF LEFT$(REPLY$,3) = ".pk" THEN 2020
 1360 IF LEFT$(REPLY$,3) = ".in" THEN 2150
 1370 STOP
 1380 REM Head 1 Processor
 1390 FOR I = LINE.NO TO 44
 1400  LPRINT
 1410 NEXT I
 1420 GOSUB 1030  'Bottom of page Routine
 1430 IF PAGE.NO MOD 2 = 0 THEN GOSUB 1850  'For h1 on Odd pages
 1440 LPRINT BOLD.ON$;     'Set Emphasized Printing
 1450 LPRINT EXPAND.ON$;   'Set expanded print
 1460 IF PAGE.NO MOD 2 = 0 THEN ADJUST = -2 :ELSE ADJUST = -5
 1470 LPRINT TAB(TAB.POS+ADJUST); RIGHT$(REPLY$,LEN(REPLY$)-4)
 1480 LPRINT EXPAND.OFF$;  'Return to normal
 1490 LPRINT BOLD.OFF$;    'Return to non-bold
 1500 LINE.NO = LINE.NO+1
 1510 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 1520 RETURN
 1530 '
 1540 REM Head 2 Processor
 1550 IF LINE.NO = 7 THEN 1570 'skip spacing if at top of page
 1560 IF LINE.NO > 43 THEN GOSUB 1850 :ELSE LPRINT:LPRINT:LINE.NO = LINE.NO+2
 1570 LPRINT BOLD.ON$;    'Set emphasized print
 1580 LPRINT TAB(TAB.POS+1); RIGHT$(REPLY$,LEN(REPLY$)-4)
 1590 LPRINT BOLD.OFF$;   'Return to normal
 1600 LPRINT
 1610 LINE.NO = LINE.NO + 2
 1620 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 1630 RETURN
 1640 '
 1650 REM Head 3 Processor
 1660 IF LINE.NO = 7 THEN 1680 'skip spacing if at top of page
 1670 IF LINE.NO > 43 THEN GOSUB 1850 :ELSE LPRINT:LPRINT:LINE.NO = LINE.NO+2
 1680 LPRINT BOLD.ON$;    'Set emphasized print
 1690 LPRINT TAB(TAB.POS+1); RIGHT$(REPLY$,LEN(REPLY$)-4)
 1700 LPRINT BOLD.OFF$;   'Return to normal
 1710 LPRINT
 1720 LINE.NO = LINE.NO + 2
 1730 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 1740 RETURN
 1750 '
 1760 REM Single Space Processor
 1770 IF LINE.NO = 7 THEN 1790
 1780 IF LINE.NO > 44 THEN GOSUB 1850 :ELSE LPRINT : LINE.NO = LINE.NO + 1
 1790 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 1800 RETURN
 1810 REM End of File Processor
 1820 GOSUB 1850 'Bottom of Page
 1840 GOTO 6100
 1850 REM Page Eject Processor
 1860 FOR I = LINE.NO TO 44
 1870  LPRINT
 1880  LINE.NO = LINE.NO + 1
 1890 NEXT I
 1900 GOSUB 1030  'Bottom of Page Processing
 1910 RETURN
 1920 REM Vertical Tab Processor
 1930 IF LINE.NO = 7 THEN 2010
 1940 QTY = VAL(RIGHT$(REPLY$,LEN(REPLY$)-3))
 1950 FOR I = 1 TO QTY
 1960  LPRINT
 1970  LINE.NO = LINE.NO + 1
 1980  IF LINE.NO > 44 THEN I = QTY
 1990 NEXT I
 2000 IF LINE.NO > 44 THEN GOSUB 1030  'End of page
 2010 RETURN
 2020 REM Pack Processor
 2030 IF LINE.NO > 44 THEN GOSUB 1030
 2040 IF TAB.POS = 8 THEN ADJUST = 4
 2050 IF TAB.POS = 13 THEN ADJUST = 7
 2060 TAB.POS = TAB.POS + ADJUST + INDENT
 2070 WIDTH "lpt1:", 132  'set condensed width
 2080 LPRINT COMPR.ON$;   'Packed printing
 2090 LPRINT TAB(TAB.POS); RIGHT$(REPLY$,LEN(REPLY$)-3)
 2100 LPRINT COMPR.OFF$;  'Return to normal
 2110 WIDTH "lpt1:", 80   'return to normal
 2120 LINE.NO = LINE.NO + 1
 2130 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 2140 RETURN
 2150 REM Indent Processor
 2160 INDENT = VAL(RIGHT$(REPLY$,LEN(REPLY$)-3))
 2170 RETURN
 3000 REM DIRECTOR
 3010 DATA ".h1 INTRODUCTION"
 3020 DATA ".h2 OVERVIEW"
 3030 DATA "This Program Directory contains the"
 3040 DATA "information about the contents of the"
 3050 DATA "Distribution Diskette for the Genealogy"
 3060 DATA "ON DISPLAY programs and documentation."
 3070 DATA ".h2 CONTENT"
 3080 DATA "The Distribution Diskette contains the"
 3090 DATA "following Documentation Programs:"
 3100 DATA ".sp"
 3110 DATA "  Program    Program      Program"
 3120 DATA "  Name       Language        Size"
 3130 DATA "  --------   --------   ---------"
 3140 DATA "  READ       ME             1,082"
 3150 DATA "  PRINTERS   BASIC          1,352"
 3160 DATA "  DIRECTOR   BASIC         16,085"
 3170 DATA "  TABLEOFC   BASIC         13,343"
 3180 DATA "  INTRODUC   BASIC         12,583"
 3190 DATA "  GENERAL    BASIC         18,845"
 3200 DATA "  USINGTHE   BASIC         29,379"
 3210 DATA "  REFERENC   BASIC         17,893"
 3220 DATA "  APPENDIX   BASIC         28,965"
 3230 DATA ".vt 2"
 3240 DATA "The Distribution Diskette contains the"
 3250 DATA "following Overview program:"
 3260 DATA ".sp"
 3270 DATA "  Program    Program      Program"
 3280 DATA "  Name       Language        Size"
 3290 DATA "  --------   --------   ---------"
 3300 DATA "  OVERVIEW   BASIC         13,113"
 3310 DATA ".pa"
 3320 DATA "The Distribution Diskette contains the"
 3330 DATA "following Genealogy programs:"
 3340 DATA ".sp"
 3350 DATA "  Program    Program      Program"
 3360 DATA "  Name       Language        Size"
 3370 DATA "  --------   --------   ---------"
 3380 DATA "  MENU       BASIC         13,006"
 3390 DATA "  CREATPER   BASIC          2,864"
 3400 DATA "  CREATMAR   BASIC          2,333"
 3410 DATA "  CREATORD   BASIC          3,128"
 3420 DATA "  UPDATPER   BASIC         14,442"
 3430 DATA "  UPDATMAR   BASIC         11,292"
 3440 DATA "  UPDATORD   BASIC         16,226"
 3450 DATA "  INDEXPC    BASIC          5,321"
 3460 DATA "  INDEXMAR   BASIC          5,229"
 3470 DATA "  PRINTPER   BASIC          6,499"
 3480 DATA "  PRINTMAR   BASIC          3,811"
 3490 DATA "  LISTPER    BASIC          2,835"
 3500 DATA "  LISTMAR    BASIC          3,494"
 3510 DATA "  LISTPCI    BASIC          3,267"
 3520 DATA "  ALPHAPER   BASIC          4,926"
 3530 DATA "  ALPHAMAR   BASIC          4,680"
 3540 DATA "  DISPLAY    BASIC         24,489"
 3550 DATA "  ANCESTOR   BASIC         24,262"
 3560 DATA "  FAMILY     BASIC         22,630"
 3570 DATA "  DESCEND    BASIC         13,432"
 3580 DATA ".vt 3"
 3590 DATA "The Distribution Diskette contains the"
 3600 DATA "following Data File:"
 3610 DATA ".sp"
 3620 DATA "  Data File             Data File"
 3630 DATA "  Name                       Size"
 3640 DATA "  --------              ---------"
 3650 DATA "  VERIFILE                    256"
 3660 DATA ".pa"
 3670 DATA ".h2 REQUIREMENTS"
 3680 DATA ".h3 Hardware Requirements"
 3690 DATA "Any member of the IBM PC Family of"
 3700 DATA "computers, from the PCjr upward (in-"
 3710 DATA "cluding 'Truly-Compatibles'), with at"
 3720 DATA "least the following:"
 3730 DATA ".sp"
 3740 DATA "  One double-sided Diskette Drive."
 3750 DATA ".sp"
 3760 DATA "  60K of Main Memory available to the"
 3770 DATA "  Genealogy ON DISPLAY Programs, after"
 3780 DATA "  the Operating System and the BASIC"
 3790 DATA "  Processor have been loaded."
 3800 DATA ".sp"
 3810 DATA "  A printer, such as the IBM Matrix"
 3820 DATA "  printer, which has the capability"
 3830 DATA "  of controlling the appearance of the"
 3840 DATA "  output, including the following:"
 3850 DATA ".sp"
 3860 DATA "    120 Print Positions"
 3870 DATA "      For full-sized printouts of the"
 3880 DATA "      Charts of Ancestors and Charts"
 3890 DATA "      of Families, a 132 character"
 3900 DATA "      (10 char/in) printer is required."
 3910 DATA "    Normal Printing"
 3920 DATA "    Compressed Printing"
 3930 DATA "    Emphasized Printing"
 3940 DATA "    Form Feed (Page Eject)"
 3950 DATA ".sp"
 3960 DATA "  A Display, either Monochrome or"
 3970 DATA "  Color, with at least 80 display"
 3980 DATA "  positions, in each of 25 lines."
 3990 DATA ".pa"
 4000 DATA ".h2 Software Requirements."
 4010 DATA "IBM PC DOS (Version 2.1 or later), or"
 4020 DATA "a compatible equivalent."
 4030 DATA ".sp"
 4040 DATA "IBM PC BASIC (PCjr Level or higher), or"
 4050 DATA "a compatible equivalent."
 4060 DATA ".h1 GENERAL INFORMATION"
 4070 DATA ".h2 DOCUMENTATION PROGRAMS"
 4080 DATA "Nine documentation programs are included"
 4090 DATA "on the Distribution Diskette.  Except"
 4100 DATA "for the READ.ME Program, these are BASIC"
 4110 DATA "programs, which can be 'run'."
 4120 DATA ".sp"
 4130 DATA "The documentation programs contain their"
 4140 DATA "own formatting capability, as well as"
 4150 DATA "the content of the documents which they"
 4160 DATA "will produce."
 4170 DATA ".sp"
 4180 DATA "By 'running' each of the documentation"
 4190 DATA "programs, the user is able to obtain one"
 4200 DATA "or more copies of each chapter of the"
 4210 DATA "documentation as he desires."
 4220 DATA ".vt 2"
 4230 DATA "These documentation programs are:"
 4240 DATA ".sp
 4250 DATA "  1.  READ.ME  (causes a display of the"
 4260 DATA "      cover letter, showing how to get"
 4270 DATA "      started.)"
 4280 DATA ".sp"
 4290 DATA "  2.  PRINTERS  (shows the changes to"
 4300 DATA "      the documentation programs for"
 4310 DATA "      printing on other printers.)"
 4320 DATA ".pa"
 4330 DATA "  3.  DIRECTOR  (documentation of the"
 4340 DATA "      content of the Distribution"
 4350 DATA "      Diskette)."
 4360 DATA ".sp"
 4370 DATA "      Produces this document."
 4380 DATA ".vt 2"
 4390 DATA "  4 through 9.  Documentation for the"
 4400 DATA "      Genealogy ON DISPLAY Programs."
 4410 DATA ".sp"
 4420 DATA "      Produces an 86 Page User's Manual"
 4430 DATA "      for use with the Genealogy ON"
 4440 DATA "      DISPLAY, Version 6.0 programs."
 4450 DATA ".sp"
 4460 DATA "  4.  TABLEOFC  (Table of Contents for"
 4470 DATA "      the User's Manual)."
 4480 DATA ".sp"
 4490 DATA "  5.  INTRODUC  (Introduction for the"
 4500 DATA "      User's Manual)."
 4510 DATA ".sp"
 4520 DATA "  6.  GENERAL  (General Information for"
 4530 DATA "      the User's Manual)."
 4540 DATA ".sp"
 4550 DATA "  7.  USINGTHE  (Using the Programs, for"
 4560 DATA "      the User's Manual)."
 4570 DATA ".sp"
 4580 DATA "  8.  REFERENC  (Reference Material for"
 4590 DATA "      the User's Manual)."
 4600 DATA ".sp"
 4610 DATA "  9.  APPENDIX  (Appendixes for the"
 4620 DATA "      User's Manual)."
 4630 DATA ".pa"
 4640 DATA ".h2 GENEALOGY PROGRAMS"
 4650 DATA "Twenty Genealogy programs are"
 4660 DATA "included on the Distribution"
 4670 DATA "Diskette.  They are:"
 4680 DATA ".sp"
 4690 DATA "  1.  CREATPER"
 4700 DATA "      Formats a Persons File."
 4710 DATA ".vt 2"
 4720 DATA "  2.  CREATMAR"
 4730 DATA "      Formats a Marriages File."
 4740 DATA ".vt 2"
 4750 DATA "  3.  CREATORD"
 4760 DATA "      Formats an Ordinances File."
 4770 DATA ".vt 2"
 4780 DATA "  4.  UPDATPER"
 4790 DATA "      Updates the Persons File."
 4800 DATA ".vt 2"
 4810 DATA "  5.  UPDATMAR"
 4820 DATA "      Updates the Marriages File."
 4830 DATA ".vt 2"
 4840 DATA "  6.  UPDATORD"
 4850 DATA "      Updates the Ordinances File."
 4860 DATA ".vt 2"
 4870 DATA "  7.  INDEXPC"
 4880 DATA "      Prepares a Parent/Child Index."
 4890 DATA ".pa"
 4900 DATA "  8.  INDEXMAR"
 4910 DATA "      Prepares a Marriages Index."
 4920 DATA ".vt 2"
 4930 DATA "  9.  PRINTPER"
 4940 DATA "      Prints the combined contents of the"
 4950 DATA "      Persons and Ordinances Files."
 4960 DATA ".vt 2"
 4970 DATA " 10.  PRINTMAR"
 4980 DATA "      Prints the contents of the"
 4990 DATA "      Marriages File."
 5000 DATA ".vt 2"
 5010 DATA " 11.  LISTPER"
 5020 DATA "      List of persons, in numerical"
 5030 DATA "      order."
 5040 DATA ".vt 2"
 5050 DATA " 12.  LISTMAR"
 5060 DATA "      List of marriages, in numerical"
 5070 DATA "      order."
 5080 DATA ".vt 2"
 5090 DATA " 13.  LISTPCI"
 5100 DATA "      Lists the Parent/Child Index."
 5110 DATA ".vt 2"
 5120 DATA " 14.  ALPHAPER"
 5130 DATA "      List of persons, in alphabetical"
 5140 DATA "      order."
 5150 DATA ".pa"
 5160 DATA " 15.  ALPHAMAR"
 5170 DATA "      List of marriages, in alphabetical"
 5180 DATA "      order."
 5190 DATA ".vt 2"
 5200 DATA " 16.  DISPLAY"
 5210 DATA "      Provides for displaying all of the"
 5220 DATA "      information in all of the files,"
 5230 DATA "      in the form of personal, family,"
 5240 DATA "      ancestors, and ordinance informa-"
 5250 DATA "      tion."
 5260 DATA ".vt 2"
 5270 DATA " 17.  ANCESTOR"
 5280 DATA "      Provides a printout of a Chart of"
 5290 DATA "      the Ancestors of any person."
 5300 DATA ".vt 2"
 5310 DATA " 18.  FAMILY"
 5320 DATA "      Provides a printout of a Chart of"
 5330 DATA "      the Family of any marriage."
 5340 DATA ".vt 2"
 5350 DATA " 19.  DESCEND"
 5360 DATA "      Provides a display (and an option-"
 5370 DATA "      al printout) of a Chart of the"
 5380 DATA "      Descendants of any person."
 5390 DATA ".vt 2"
 5400 DATA " 20.  MENU"
 5410 DATA "      Provides for user selection of"
 5420 DATA "      any of the other programs to be"
 5430 DATA "      run."
 5440 DATA ".pa"
 5450 DATA ".h2 DATA FILE"
 5460 DATA "One data file is included on the Distri-"
 5470 DATA "bution Diskette.  It is:"
 5480 DATA ".sp"
 5490 DATA "  1.  VERIFILE"
 5500 DATA ".sp"
 5510 DATA "Its purpose is to verify that BASIC was"
 5520 DATA "brought up with the /s:256 parameter."
 5530 DATA ".h2 OVERVIEW PROGRAM"
 5540 DATA "One overview program is provided, which"
 5550 DATA "may be used to show your friends just"
 5560 DATA "what 'Genealogy ON DISPLAY' is all"
 5570 DATA "about.  The overview program may also"
 5580 DATA "be used for presentations, such as at"
 5590 DATA "Association or Club Meetings."
 5600 DATA ".sp"
 5610 DATA "While the overview program makes a"
 5620 DATA "better presentation in color, it is"
 5630 DATA "also suitable for use on a Monochrome"
 5640 DATA "Monitor."
 5650 DATA ".sp"
 5660 DATA "In order to use this program, type:"
 5670 DATA ".sp"
 5680 DATA "  run ~overview~"
 5690 DATA ".sp"
 5700 DATA "and press the 'enter' key."
 5710 DATA ".h1 USING THE PROGRAMS"
 5720 DATA ".h2 FIRST TIME USAGE"
 5730 DATA "If your system does not have a hard-"
 5740 DATA "disk, you will need to set up a Pro-"
 5750 DATA "gram Diskette (by making a copy of"
 5760 DATA "the Distribution Diskette of Genealogy"
 5770 DATA "ON DISPLAY), and a Data Diskette for"
 5780 DATA "your genealogical information."
 5790 DATA ".sp"
 5800 DATA "If your system has a hard-disk, you"
 5810 DATA "will need to define a Sub-directory"
 5820 DATA "for Genealogy ON DISPLAY, and copy the"
 5830 DATA "contents of the Distribution Diskette"
 5840 DATA "of Genealogy ON DISPLAY into it."
 5850 DATA ".sp"
 5860 DATA "Whatever hardware you have, you will"
 5870 DATA "also need to format (create) the"
 5880 DATA "Genealogy ON DISPLAY records with the"
 5890 DATA "formatting programs provided."
 5900 DATA ".sp"
 5910 DATA "(Formatting puts numbers where numbers"
 5920 DATA "should be and letters where letters"
 5930 DATA "should be, in each record in each data"
 5940 DATA "file.)"
 5950 DATA ".sp"
 5960 DATA "Details are contained within the User's"
 5970 DATA "Manual."
 5980 DATA ".pa"
 5990 DATA ".h2 GETTING STARTED"
 6000 DATA "Getting started consists of bringing up"
 6010 DATA "the BASIC Processor (with the size of"
 6020 DATA "of the BASIC Records defined to be"
 6030 DATA "256, which is the size of the records"
 6040 DATA "in the Persons File), and then running"
 6050 DATA "the MENU Program."
 6060 DATA ".sp"
 6070 DATA "Details are contained within the User's"
 6080 DATA "Manual."
 6090 DATA ".eof"
 6100 END
