  100 REM INTRODUC Program.
  110 REM Documentation.  Introduction.
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 DATA Genealogy
  140 DATA User's Manual
  150 DATA -5
  160 DATA 1
  170 INDENT = 0
  180 REM Printer Definitions
  190 FORM.FEED$  = CHR$(12)
  200 COMPR.OFF$  = CHR$(18)     : COMPR.ON$ = CHR$(15)
  210 BOLD.OFF$   = CHR$(27)+"F" : BOLD.ON$ = CHR$(27)+"E"
  220 EXPAND.OFF$ = CHR$(18)     : EXPAND.ON$ = CHR$(14)
  230 DASHES$ = "+"+STRING$(54,45)+"+"
  240 TRIM.LINE$ = "(Trim-line)"
  300 REM Program begins here
  310 READ TITLE$, DOC.NAME$, PAGE.NO, LINE.NO
  320 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
  330 GOSUB 920  'For trim line and heading space
  340 FOR I = 1 TO 6 : LPRINT : NEXT I
  350 LPRINT BOLD.ON$;     'Set Emphasized mode
  360 LPRINT EXPAND.ON$;   'Set Expanded Print
  370 LPRINT TAB(TAB.POS-1);TITLE$
  380 LPRINT EXPAND.OFF$;  'Return to normal
  390 LPRINT BOLD.OFF$;    'Return to normal
  400 FOR I = 1 TO 3 : LPRINT : NEXT I
  410 LPRINT BOLD.ON$;     'Set Emphasized mode
  420 LPRINT TAB(TAB.POS+12);"ON DISPLAY"
  430 LPRINT BOLD.OFF$;    'Return to normal
  440 LPRINT : LPRINT : LPRINT
  450 LPRINT TAB(TAB.POS+11);"Version 6.0"
  460 FOR I = 1 TO 11 : LPRINT : NEXT I
  470 LPRINT TAB(TAB.POS+10); DOC.NAME$
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
  650 DATA ".vt 31"
  870 DATA "Copyright (c) 1982 ... 1989, by:"
  880 DATA "Melvin O. Duke."
  890 DATA ".sp"
  900 DATA "All rights reserved."
  910 '
  920 REM Top of each page routine
  930 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
  940 LPRINT
  950 LPRINT TAB(30); TRIM.LINE$
  960 LPRINT DASHES$ 'Dashes
  970 FOR I = 1 TO 6
  980  LPRINT
  990 NEXT I
 1000 LINE.NO = LINE.NO + 6
 1010 RETURN
 1020 '
 1030 REM Bottom of each page Routine
 1040 IF PAGE.NO < 1 THEN LPRINT : LPRINT : LPRINT : GOTO 1160
 1050 LPRINT TAB(TAB.POS); STRING$(40,45)  'on line 46
 1060 LPRINT TAB(TAB.POS+3); TITLE$+" ON DISPLAY.  Version 6.0" 'on line 47
 1070 IF PAGE.NO MOD 2 = 1 THEN 1110
 1080 LPRINT TAB(TAB.POS);"Page";PAGE.NO;
 1090 LPRINT TAB(TAB.POS+27);"User's Manual"
 1100 GOTO 1160
 1110 LPRINT TAB(TAB.POS); "User's Manual";
 1120 IF PAGE.NO < 10 THEN DELTA = 34
 1130 IF PAGE.NO >  9 THEN DELTA = 33
 1140 IF PAGE.NO > 99 THEN DELTA = 32
 1150 LPRINT TAB(TAB.POS+DELTA); "Page"; PAGE.NO  'on line 48
 1160 LPRINT : LPRINT : LPRINT
 1170 LPRINT DASHES$ 'dashes after 51
 1180 LPRINT TAB(30); TRIM.LINE$
 1190 LPRINT FORM.FEED$;
 1200 PAGE.NO = PAGE.NO + 1
 1210 LINE.NO = 1
 1220 IF REPLY$ = ".eof" THEN 1240  'Bypass after last page
 1230 GOSUB 920  'For top of next page
 1240 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 1250 RETURN
 1260 '
 1270 REM Command Processor
 1280 IF LEFT$(REPLY$,3) = ".h1" THEN 1390
 1290 IF LEFT$(REPLY$,3) = ".h2" THEN 1550
 1300 IF LEFT$(REPLY$,3) = ".h3" THEN 1660
 1310 IF LEFT$(REPLY$,3) = ".sp" THEN 1770
 1320 IF LEFT$(REPLY$,4) = ".eof" THEN 1820
 1330 IF LEFT$(REPLY$,3) = ".pa" THEN 1860
 1340 IF LEFT$(REPLY$,3) = ".pn" THEN PAGE.NO = VAL(RIGHT$(REPLY$,LEN(REPLY$)-3)) : RETURN
 1350 IF LEFT$(REPLY$,3) = ".vt" THEN 1930
 1360 IF LEFT$(REPLY$,3) = ".pk" THEN 2040
 1370 IF LEFT$(REPLY$,3) = ".in" THEN 2170
 1380 STOP
 1390 REM Head 1 Processor
 1400 FOR I = LINE.NO TO 44
 1410  LPRINT
 1420 NEXT I
 1430 GOSUB 1030  'Bottom of page Routine
 1440 IF PAGE.NO MOD 2 = 0 THEN GOSUB 1860  'For h1 on Odd pages
 1450 LPRINT BOLD.ON$;     'Set emphasized print
 1460 LPRINT EXPAND.ON$;   'Set expanded print
 1470 IF PAGE.NO MOD 2 = 0 THEN ADJUST = -2 :ELSE ADJUST = -5
 1480 LPRINT TAB(TAB.POS+ADJUST); RIGHT$(REPLY$,LEN(REPLY$)-4)
 1490 LPRINT EXPAND.OFF$;  'Return to normal
 1500 LPRINT BOLD.OFF$;    'Return to non-bold
 1510 LINE.NO = LINE.NO+1
 1520 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 1530 RETURN
 1540 '
 1550 REM Head 2 Processor
 1560 IF LINE.NO = 7 THEN 1580 'skip spacing if at top of page
 1570 IF LINE.NO > 43 THEN GOSUB 1860 :ELSE LPRINT:LPRINT:LINE.NO = LINE.NO+2
 1580 LPRINT BOLD.ON$;  'Set emphasized print
 1590 LPRINT TAB(TAB.POS+1); RIGHT$(REPLY$,LEN(REPLY$)-4)
 1600 LPRINT BOLD.OFF$; 'Return to normal
 1610 LPRINT
 1620 LINE.NO = LINE.NO + 2
 1630 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 1640 RETURN
 1650 '
 1660 REM Head 3 Processor
 1670 IF LINE.NO = 7 THEN 1690 'skip spacing if at top of page
 1680 IF LINE.NO > 43 THEN GOSUB 1860 :ELSE LPRINT:LPRINT:LINE.NO = LINE.NO+2
 1690 LPRINT BOLD.ON$;  'Set emphasized print
 1700 LPRINT TAB(TAB.POS+1); RIGHT$(REPLY$,LEN(REPLY$)-4)
 1710 LPRINT BOLD.OFF$; 'Return to normal
 1720 LPRINT
 1730 LINE.NO = LINE.NO + 2
 1740 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 1750 RETURN
 1760 '
 1770 REM Single Space Processor
 1780 IF LINE.NO = 7 THEN 1800
 1790 IF LINE.NO > 44 THEN GOSUB 1860 :ELSE LPRINT : LINE.NO = LINE.NO + 1
 1800 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 1810 RETURN
 1820 REM End of File Processor
 1830 GOSUB 1860 'Bottom of Page
 1850 GOTO 4890
 1860 REM Page Eject Processor
 1870 FOR I = LINE.NO TO 44
 1880  LPRINT
 1890  LINE.NO = LINE.NO + 1
 1900 NEXT I
 1910 GOSUB 1030  'Bottom of Page Processing
 1920 RETURN
 1930 REM Vertical Tab Processor
 1940 IF LINE.NO = 7 THEN 2030
 1950 IF LINE.NO > 44 THEN GOSUB 1030  'End of page
 1960 QTY = VAL(RIGHT$(REPLY$,LEN(REPLY$)-3))
 1970 FOR I = 1 TO QTY
 1980  LPRINT
 1990  LINE.NO = LINE.NO + 1
 2000  IF LINE.NO > 44 THEN I = QTY
 2010 NEXT I
 2020 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 2030 RETURN
 2040 REM Pack Processor
 2050 IF LINE.NO > 44 THEN GOSUB 1030
 2060 IF TAB.POS = 8 THEN ADJUST = 4
 2070 IF TAB.POS = 13 THEN ADJUST = 7
 2080 TAB.POS = TAB.POS + ADJUST + INDENT
 2090 WIDTH "lpt1:", 132 'set condensed width
 2100 LPRINT COMPR.ON$;  'Packed printing
 2110 LPRINT TAB(TAB.POS); RIGHT$(REPLY$,LEN(REPLY$)-3)
 2120 LPRINT COMPR.OFF$; 'Return to normal
 2130 WIDTH "lpt1:", 80  'return to normal
 2140 LINE.NO = LINE.NO + 1
 2150 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 8 :ELSE TAB.POS = 13
 2160 RETURN
 2170 REM Indent Processor
 2180 INDENT = VAL(RIGHT$(REPLY$,LEN(REPLY$)-3))
 2190 RETURN
 3000 DATA ".h1 INTRODUCTION"
 3010 DATA ".pn 1"
 3020 DATA ".h2 OVERVIEW"
 3030 DATA "The Genealogy ON DISPLAY Programs pro-"
 3040 DATA "vide the user with the capability to"
 3050 DATA "create and maintain data files which"
 3060 DATA "contain information about his or her"
 3070 DATA "ancestors and relatives, to interro-"
 3080 DATA "gate the contents of the files, and to"
 3090 DATA "obtain printouts of charts of ances-"
 3100 DATA "tors, charts of families, and charts of"
 3110 DATA "descendants in standard formats, using"
 3120 DATA "the information from those files."
 3130 DATA ".sp"
 3140 DATA "Other than the total size of the files,"
 3150 DATA "there is no practical limit to the"
 3160 DATA "number of generations contained in the"
 3170 DATA "files, or capable of being displayed or"
 3180 DATA "printed."
 3190 DATA ".h2 CAPABILITIES"
 3200 DATA "Following are the capabilities of the"
 3210 DATA "the group of programs known as the"
 3220 DATA "Genealogy ON DISPLAY Programs."
 3230 DATA ".pa"
 3240 DATA ".h3 Display the Genealogy."
 3250 DATA "The DISPLAY Program is one of the four"
 3260 DATA "principal programs in the Genealogy ON"
 3270 DATA "DISPLAY set of programs.  (Note: All of"
 3280 DATA "the other programs supplement these four"
 3290 DATA "principal programs.)"
 3300 DATA ".sp"
 3310 DATA "By using the DISPLAY Program, a user may"
 3320 DATA "display personal information, ancestors,"
 3330 DATA "and family groups, for any person whose"
 3340 DATA "records are in the data files."
 3350 DATA ".h2 Print Charts of Ancestors"
 3360 DATA "The ANCESTOR Program is the second of"
 3370 DATA "the four principal programs in the"
 3380 DATA "Genealogy ON DISPLAY set of programs."
 3390 DATA ".sp"
 3400 DATA "By using this program, a user may obtain"
 3410 DATA "a printout of a chart of the ancestors"
 3420 DATA "of any person whose records are in the"
 3430 DATA "data files."
 3440 DATA ".pa"
 3450 DATA ".h2 Print Charts of Families"
 3460 DATA "The FAMILY Program is the third of the"
 3470 DATA "four principal programs in the Genealogy"
 3480 DATA "ON DISPLAY set of programs."
 3490 DATA ".sp
 3500 DATA "By using this program, a user may obtain"
 3510 DATA "a printout of a chart of the family of"
 3520 DATA "any person whose records are in the data"
 3530 DATA "files."
 3540 DATA ".h2 Produce Charts of Descendants"
 3550 DATA "The DESCEND Program is the fourth of"
 3560 DATA "the four principal programs in the"
 3570 DATA "Genealogy ON DISPLAY set of programs."
 3580 DATA ".sp
 3590 DATA "By using this program, a user may dis-"
 3600 DATA "play (and optionally obtain a printout)"
 3610 DATA "a chart of the descendants of any person"
 3620 DATA "whose records are in the data files."
 3630 DATA ".h3 Format the Data Files."
 3640 DATA "Three programs, the CREATPER, the"
 3650 DATA "CREATMAR, and the CREATORD Programs,"
 3660 DATA "provide formatting of the records in the"
 3670 DATA "PERSFILE, the MARRFILE, and the ORDFILE"
 3680 DATA "respectively."
 3690 DATA ".pa"
 3700 DATA ".h3 Update the Data Files."
 3710 DATA "Three programs, the UPDATPER, the"
 3720 DATA "UPDATMAR, and the UPDATORD Programs,"
 3730 DATA "permit update of the records in the"
 3740 DATA "PERSFILE, the MARRFILE, and the ORDFILE"
 3750 DATA "respectively."
 3760 DATA ".h3 Prepare the Indexes."
 3770 DATA "Two programs, the INDEXPC and the"
 3780 DATA "INDEXMAR programs, prepare the indexes"
 3790 DATA "PCINDEX and MINDEX respectively."
 3800 DATA ".sp"
 3810 DATA "Note:  These two indexes are essential"
 3820 DATA "to the DISPLAY, ANCESTOR, FAMILY, and"
 3830 DATA "DESCEND Programs, as they provide all"
 3840 DATA "of the linkages between persons, ances-"
 3850 DATA "tors, families, and descendants."
 3860 DATA ".h3 List the Records in the Files."
 3870 DATA "Two programs, the LISTPER and the"
 3880 DATA "LISTMAR Programs, provide listings"
 3890 DATA "of the records in the PERSFILE and"
 3900 DATA "MARRFILE, respectively.  These are"
 3910 DATA "one-line summary listings of the"
 3920 DATA "records in the files."
 3930 DATA ".pa"
 3940 DATA ".h3 Printing the Contents of the Files."
 3950 DATA "Two programs, the PRINTPER, and the"
 3960 DATA "PRINTMAR Programs, provide for print-"
 3970 DATA "ing individual records or for complete"
 3980 DATA "printouts of the files.  The PRINTPER"
 3990 DATA "Program provides a combined printout"
 4000 DATA "of the PERSFILE and the ORDFILE.  The"
 4010 DATA "PRINTMAR Program provides a printout"
 4020 DATA "of the MARRFILE."
 4030 DATA ".h3 Alphabetical Lists."
 4040 DATA "Two programs, the ALPHAPER, and the"
 4050 DATA "ALPHAMAR Programs, provide alphabetical"
 4060 DATA "listings of the persons in the Persons"
 4070 DATA "File, and marriages in the Marriages"
 4080 DATA "File, respectively.  Note:  These two"
 4090 DATA "lists are very helpful in permitting the"
 4100 DATA "user to locate records of persons and of"
 4110 DATA "marriages."
 4120 DATA ".h3 Parent/Child Index List"
 4130 DATA "One program, the LISTPCI Program, pro-"
 4140 DATA "vides a list of all persons who are"
 4150 DATA "parents, together with the children of"
 4160 DATA "those persons."
 4170 DATA ".pa"
 4180 DATA ".h2 BENEFITS/ADVANTAGES"
 4190 DATA "The Genealogy ON DISPLAY Programs pro-"
 4200 DATA "vide an organized, cohesive set of"
 4210 DATA "programs, to permit a user to create and"
 4220 DATA "maintain that person's genealogical"
 4230 DATA "information."
 4240 DATA ".sp"
 4250 DATA "One major advantage of this technique is"
 4260 DATA "that the user only enters information a"
 4270 DATA "single time, in a single place.  Hence,"
 4280 DATA "there is never any discrepancy between"
 4290 DATA "separate reportings of the data."
 4300 DATA ".sp"
 4310 DATA "The programs use the relationships be-"
 4320 DATA "tween persons for extracting and report-"
 4330 DATA "ing the data in meaningful formats."
 4340 DATA ".sp"
 4350 DATA "Since most genealogical information is"
 4360 DATA "not complete, whenever new information"
 4370 DATA "is obtained, the user may readily add"
 4380 DATA "that new information (or change any"
 4390 DATA "erroneous old information) as the user"
 4400 DATA "desires."
 4410 DATA ".h2 RESULTS"
 4420 DATA "The final results are a well-organized"
 4430 DATA "set of data files and indices, which"
 4440 DATA "permit a user to obtain related infor-"
 4450 DATA "mation in formats which are meaningful"
 4460 DATA "to that user."
 4470 DATA ".pa"
 4480 DATA "Charts of Ancestors, Charts of Famil-"
 4490 DATA "ies, Charts of Descendants, as well as"
 4500 DATA "personal information about each indivi-"
 4510 DATA "dual are available upon demand, either"
 4520 DATA "on the printer or on the display."
 4530 DATA ".h2 REQUIREMENTS"
 4540 DATA ".h2 Software Requirements."
 4550 DATA "IBM PC DOS (Version 2.1 or later), or"
 4560 DATA "a compatible equivalent."
 4570 DATA ".sp"
 4580 DATA "IBM PC BASIC (PCjr Level or higher), or"
 4590 DATA "a compatible equivalent."
 4600 DATA ".pa"
 4610 DATA ".h3 Hardware Requirements"
 4620 DATA "Any member of the IBM PC Family of"
 4630 DATA "computers, from the PCjr upward (in-"
 4640 DATA "cluding 'Truly-Compatibles), with at"
 4650 DATA "least the following:"
 4660 DATA ".sp"
 4670 DATA "  One double-sided Diskette Drive."
 4680 DATA ".sp"
 4690 DATA "  60K of Main Memory available to the"
 4700 DATA "  Genealogy ON DISPLAY Programs, after"
 4710 DATA "  the Operating System and the BASIC"
 4720 DATA "  Processor have been loaded."
 4730 DATA ".sp"
 4740 DATA "  A printer, such as the IBM Matrix"
 4750 DATA "  printer, which has the capability"
 4760 DATA "  of controlling the appearance of the"
 4770 DATA "  output, including the following:"
 4780 DATA ".sp"
 4790 DATA "    120 Print Positions"
 4800 DATA "      For full-sized printouts of the"
 4810 DATA "      Charts of Ancestors, and Charts"
 4820 DATA "      of Families, a 132 character"
 4830 DATA "      (10 char/in) printer is required."
 4840 DATA "    Normal Printing"
 4850 DATA "    Compressed Printing"
 4860 DATA "    Emphasized Printing"
 4870 DATA "    Form Feed (Page Eject)"
 4880 DATA ".eof"
 4890 END
