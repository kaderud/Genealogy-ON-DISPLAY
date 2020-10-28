  100 REM REFERENC Program.
  110 REM Documentation.  Reference Material.
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
  750 DATA ".vt 31"
  870 DATA "Copyright (c) 1983 ... 1989, by:"
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
 1060 LPRINT TAB(TAB.POS+2); TITLE$+" ON DISPLAY.  Version 6.0" 'on line 47
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
 1850 GOTO 6020
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
 3000 DATA ".h1 REFERENCE MATERIAL"
 3010 DATA ".pn 51"
 3020 DATA ".h2 SAMPLE SCREENS AND PROMPTING MESSAGES"
 3030 DATA "The following is a sample session, using"
 3040 DATA "a One-drive system (e.g. IBM PCjr),"
 3050 DATA "where the user wishes to view his"
 3060 DATA "Genealogy the screen, through the use of"
 3070 DATA "the DISPLAY Program, and where he has"
 3080 DATA "included an (LDS) Ordinance File."
 3090 DATA ".vt 2"
 3100 DATA "He begins in the normal manner.  He"
 3110 DATA "has the DOS Diskette in place, and has"
 3120 DATA "Cartridge BASIC in place since he is"
 3130 DATA "using a PCjr."
 3140 DATA ".sp"
 3150 DATA "He turns the system on, and responds to"
 3160 DATA "any messages which ask for date and time."
 3170 DATA ".sp"
 3180 DATA "He then requests BASIC by typing:"
 3190 DATA ".sp"
 3200 DATA "   basic/s:256"
 3210 DATA "     and presses the 'enter' key."
 3220 DATA ".sp"
 3230 DATA "He replaces the DOS Diskette with the"
 3240 DATA "Genealogy ON DISPLAY Program Diskette."
 3250 DATA ".sp"
 3260 DATA "He then starts Genealogy ON DISPLAY"
 3270 DATA "by typing:"
 3280 DATA ".sp"
 3290 DATA "   run ~menu~"
 3300 DATA "     and presses the 'enter' key."
 3310 DATA ".pa"
 3320 DATA "The display screen then appears as:"
 3330 DATA ".sp"
 3340 DATA ".vt 3"
 3350 DATA ".pk             MENU of Programs in Genealogy ON DISPLAY"
 3360 DATA ".pk                           Version 6.0"
 3370 DATA ".vt 2"
 3380 DATA ".pk              If you are using these programs, you are"
 3390 DATA ".pk               expected to become a Registered User,"
 3400 DATA ".pk              by making a contribution to the author"
 3410 DATA ".pk                 of the programs ($49 suggested)."
 3420 DATA ".sp"
 3430 DATA ".pk                         Melvin O. Duke"
 3440 DATA ".pk                         P. O. Box 2048"
 3450 DATA ".pk                   Morgan Hill, CA  95038-2048"
 3460 DATA ".vt 3"
 3470 DATA ".pk                 Copyright (c) 1982 ... 1989, by:"
 3480 DATA ".pk                         Melvin O. Duke"
 3490 DATA ".vt 3"
 3500 DATA ".pk Have Program Diskette in place, then press any key to continue."
 3510 DATA ".sp"
 3520 DATA "Since the Program Diskette is already"
 3530 DATA "in place, he just presses a key."
 3540 DATA ".pa"
 3550 DATA "A new screen appears, which shows the"
 3560 DATA "available programs.  It appears as:"
 3570 DATA ".sp"
 3580 DATA ".in -3"
 3590 DATA ".pk No   Name       Function of the Program"
 3600 DATA ".sp"
 3610 DATA ".pk  1   CREATPER   Creates (FORMATS) a Persons File."
 3620 DATA ".pk  2   CREATMAR   Creates (FORMATS) a Marriages File."
 3630 DATA ".pk  3   CREATORD   Creates (FORMATS) an Ordinances File."
 3640 DATA ".pk  4   UPDATPER   Updates Information in the Persons File."
 3650 DATA ".pk  5   UPDATMAR   Updates Information in the Marriages File."
 3660 DATA ".pk  6   UPDATORD   Updates Information in the Ordinances File."
 3670 DATA ".pk  7   INDEXPC    Prepares a Parent/Child Index.  (For 13, 16, 18 and 19.)"
 3680 DATA ".pk  8   INDEXMAR   Prepares a Marriages Index.  (For 15, 16, 17, 18 and 19.)"
 3690 DATA ".pk  9   PRINTPER   Prints Detailed Information about Persons."
 3700 DATA ".pk 10   PRINTMAR   Prints Detailed Information about Marriages."
 3710 DATA ".pk 11   LISTPER    List of Persons, in Numerical Order."
 3720 DATA ".pk 12   LISTMAR    List of Marriages, in Numerical Order."
 3730 DATA ".pk 13   LISTPCI    List of the Parent/Child Index."
 3740 DATA ".pk 14   ALPHAPER   List of Persons, in Alphabetical Order."
 3750 DATA ".pk 15   ALPHAMAR   List of Marriages, in Alphabetical Order."
 3760 DATA ".pk 16   DISPLAY    Displays Genealogical Information on the Screen."
 3770 DATA ".pk 17   ANCESTOR   Prints Charts of Ancestors."
 3780 DATA ".pk 18   FAMILY     Prints Charts of Families."
 3790 DATA ".pk 19   DESCEND    Displays (and Optionally Prints) Charts of Descendants."
 3800 DATA ".sp"
 3810 DATA ".pk Type a Program Number, and press the 'enter' key.: "
 3820 DATA ".pk  (0 to quit, 20 to restart the MENU, 21 to return to DOS)"
 3830 DATA ".in 0"
 3840 DATA ".sp"
 3850 DATA "The user selects program 16, by typing"
 3860 DATA ".sp"
 3870 DATA "   16"
 3880 DATA "     and presses the enter key."
 3890 DATA ".pa"
 3900 DATA "The user then sees the logo of the"
 3910 DATA "DISPLAY Program as:"
 3920 DATA ".vt 3"
 3930 DATA ".pk                     Display Program ON DISPLAY"
 3940 DATA ".pk                           Version 6.0"
 3950 DATA ".vt 2"
 3960 DATA ".sp"
 3970 DATA ".sp"
 3980 DATA ".sp"
 3990 DATA ".vt 2"
 4000 DATA ".sp"
 4010 DATA ".sp"
 4020 DATA ".sp"
 4030 DATA ".sp"
 4040 DATA ".pk                 Copyright (c) 1982 ... 1989 by:"
 4050 DATA ".pk                         Melvin O. Duke"
 4060 DATA ".vt 4"
 4070 DATA ".pk Have Data Diskette(s) in Place, then Press any key to continue."
 4080 DATA ".vt 3"
 4090 DATA "The user replaces the Program Diskette"
 4100 DATA "with the Data Diskette, then presses a"
 4110 DATA "key."
 4120 DATA ".pa"
 4130 DATA "After pressing a key, the user watches"
 4140 DATA "the screen as the indexes are read, and"
 4150 DATA "the data files are opened.  He sees:"
 4160 DATA ".sp"
 4170 DATA ".pk Open the Parent/Child Index"
 4180 DATA ".pk Reading Index Record #: 592"
 4190 DATA ".sp"
 4200 DATA ".pk Open the Marriage Index"
 4210 DATA ".pk Reading Marriage Index Record #: 262"
 4220 DATA ".sp"
 4230 DATA ".pk Open the Persons File"
 4240 DATA ".sp"
 4250 DATA ".pk Open the Marriages File"
 4260 DATA ".sp"
 4270 DATA ".pk Open the Ordinances File"
 4280 DATA ".vt 4"
 4290 DATA ".pk Enter the Record-number of a Person?"
 4300 DATA ".vt 2"
 4310 DATA "The user responds with a number, such as"
 4320 DATA "1, as:"
 4330 DATA ".sp"
 4340 DATA ".pk Enter the Record-number of a Person: 1"
 4350 DATA ".pa"
 4360 DATA "He then sees:"
 4370 DATA ".vt 2"
 4380 DATA ".pk Personal Information for:  Melvin Otto ABLE                    Person: 1"
 4390 DATA ".sp"
 4400 DATA ".pk Person:                                Person's Vital Statistics:"
 4410 DATA ".pk Record-no.:   1"
 4420 DATA ".pk Surname:     ABLE                      Birth-date:      5 Oct 1925"
 4430 DATA ".pk Given Names: Melvin Otto               Birth-city:     Salt Lake City"
 4440 DATA ".pk Sex:         Male                      Birth-county:   Salt Lake"
 4450 DATA ".pk                                        Birth-state:    Utah"
 4460 DATA ".pk Male Parent:"
 4470 DATA ".pk Record-no.:   7                        Death-date:"
 4480 DATA ".pk Surname:     ABLE                      Death-city:"
 4490 DATA ".pk Given-names: Otto                      Death-county:"
 4500 DATA ".pk Birth-date:  31 Mar 1899               Death-state:"
 4510 DATA ".sp"
 4520 DATA ".pk Female Parent:                         Burial-date:"
 4530 DATA ".pk Record-no.:   8                        Burial-city:"
 4540 DATA ".pk Surname:     BAKER                     Burial-county:"
 4550 DATA ".pk Given-names: Beatrice                  Burial-state:"
 4560 DATA ".pk Birth-date:  27 Sep 1902"
 4570 DATA ".sp 2"
 4580 DATA ".pk Type a Request.  Then press the 'enter' key.: "
 4590 DATA ".pk (Possible Requests:  ps, an, fg, o, p1...pn, m1...mn, q)"
 4600 DATA ".pa
 4610 DATA "The user asks for a Chart of Ancestors,"
 4620 DATA "by typing:  an, as:"
 4630 DATA ".sp"
 4640 DATA ".pk Type a Request.  Then press the 'enter' key.? an"
 4650 DATA ".sp"
 4660 DATA "The user then sees:"
 4670 DATA ".vt 2"
 4680 DATA ".in -3"
 4690 DATA ".pk  Ancestors of: Melvin Otto ABLE                              Person: 1   "
 4700 DATA ".sp"
 4710 DATA ".pk                                                                Birthdate:"
 4720 DATA ".pk                      __8_(40) ABLE, John_____________________ 28 Nov 1834"
 4730 DATA ".pk              __4_(30) ABLE, James Alfred_____________________ 19 Jan 1866"
 4740 DATA ".pk              |      |_ 9_(47) YOUNGER, Martha Vance__________  8 Feb 1842"
 4750 DATA ".pk        __2_(7) ABLE, Otto____________________________________ 31 Mar 1899"
 4760 DATA ".pk       |      |       __10_(51) FARMER, Charles_______________ 19 Jan 1833"
 4770 DATA ".pk       |      |_5_(31) FARMER, Janet__________________________ 18 Feb 1876"
 4780 DATA ".pk       |              |_11_(52) BIGBY, Susanna________________  5 Nov 1834"
 4790 DATA ".pk 1_(1) ABLE, Melvin Otto______________________________________  5 Oct 1925"
 4800 DATA ".pk       |              __12_(82) BAKER, William________________ 12 Apr 1803"
 4810 DATA ".pk       |      __6_(32) BAKER, Jabez Thompson__________________ 26 Apr 1840"
 4820 DATA ".pk       |      |      |_ 13_(83) THOMASON, Martha______________ 22 Aug 1805"
 4830 DATA ".pk       |_3_(8) BAKER, Beatrice________________________________ 27 Sep 1902"
 4840 DATA ".pk              |       __14_(84) SWENSON, Karl Kristian________ 11 Jul 1834"
 4850 DATA ".pk              |_7_(33) SWENSON, Anna Pauline__________________  8 Aug 1866"
 4860 DATA ".pk                      |_15_(85) KRALL, Wilhelmina_____________ 23 Mar 1833"
 4870 DATA ".vt 2"
 4880 DATA ".pk Type a Request.  Then press the 'enter' key.: "
 4890 DATA ".pk (Possible Requests:  ps, an, fg, o, l1...ln, p1...pn, m1...mn, q)"
 4900 DATA ".in 0"
 4910 DATA ".pa"
 4920 DATA "Instead of asking for a Chart of An-"
 4930 DATA "cestors, the user may have asked for"
 4940 DATA "a Family Group (fg), as:"
 4950 DATA ".sp"
 4960 DATA ".pk Type a Request.  Then press the 'enter' key.? fg"
 4970 DATA ".sp"
 4980 DATA "The user would then have seen:"
 4990 DATA ".vt 2"
 5000 DATA ".pk Family Group                                                Marriage: 1"
 5010 DATA ".sp"
 5020 DATA ".pk Father: (1) ABLE, Melvin Otto                       Birthdate:  5 Oct 1925"
 5030 DATA ".pk Mother: (2) LOVELY, Helen Lillian                   Birthdate: 13 Jun 1928"
 5040 DATA ".sp"
 5050 DATA ".pk Marriage Date: 16 Jun 1947      Location: Salt Lake City, Utah"
 5060 DATA ".sp"
 5070 DATA ".pk No. S Children:                       Birthdate:  Birth Location:"
 5080 DATA ".sp"
 5090 DATA ".pk   1 M ABLE, Melvin Kent                6 Jan 1949 Salt Lake City, Utah"
 5100 DATA ".pk   2 M ABLE, Ronald Robert             24 Jun 1951 Oklahoma City, Oklahoma"
 5110 DATA ".pk   3 F ABLE, Carolyn Elizabeth         26 Apr 1955 Wichita, Kansas"
 5120 DATA ".pk   4 F ABLE, Linda Ann                 22 Aug 1962 Bellevue, Washington"
 5130 DATA ".sp"
 5140 DATA ".sp"
 5150 DATA ".sp"
 5160 DATA ".sp"
 5170 DATA ".sp"
 5180 DATA ".sp"
 5190 DATA ".sp"
 5200 DATA ".sp"
 5210 DATA ".pk Type a Request.  Then press the 'enter' key.: "
 5220 DATA ".pk (Possible Requests:  ps, f, m, p1...pn, c1...cn, m1...mn, q)"
 5230 DATA ".pa"
 5240 DATA "Instead of asking for a Chart of An-"
 5250 DATA "cestors, the user may have asked for"
 5260 DATA "the Ordinances of the person (o), as:"
 5270 DATA ".sp"
 5280 DATA ".pk Type a Request.  Then press the 'enter' key.? o"
 5290 DATA ".sp"
 5300 DATA "The user would have seen:"
 5310 DATA ".sp"
 5320 DATA ".in -3"
 5330 DATA ".pk Ordinances of: Melvin Otto ABLE                               Rec.no: 1"
 5340 DATA ".sp"
 5350 DATA ".pk     Personal Record                                   Priesthood Record"
 5360 DATA ".pk Christening:                                      Aaronic:     10 Oct 1937"
 5370 DATA ".pk Blessing:                  1 Nov 1925               Deacon:    10 Oct 1937"
 5380 DATA ".pk Sealed to Parents:                BIC               Teacher:   16 Feb 1941"
 5390 DATA ".pk   Father's Rec.no:        0                         Priest:    18 Oct 1942"
 5400 DATA ".pk     Name:"
 5410 DATA ".pk   Mother's Rec.no:        0                       Melchizedek: 18 Apr 1944"
 5420 DATA ".pk     Name:                                           Elder:     18 Apr 1944"
 5430 DATA ".pk Baptism:                   4 Nov 1933               Seventy:"
 5440 DATA ".pk Confirmation:              5 Nov 1933               High Priest:
 5450 DATA ".pk Patriarchal Blessing:     13 Jun 1939"
 5460 DATA ".pk Endowment:                16 Jun 1947             Bishop:"
 5470 DATA ".pk                                                   Patriarch:"
 5480 DATA ".pk                                                   Apostle:"
 5490 DATA ".sp
 5500 DATA ".sp"
 5510 DATA ".pk Occupation: Author"
 5520 DATA ".sp"
 5530 DATA ".pk Type a Request.  Then press the 'enter' key.: "
 5540 DATA ".pk (Possible Requests:  ps, an, fg, o, p1...pn, m1...mn, q)"
 5550 DATA ".in 0"
 5560 DATA ".pa"
 5570 DATA "The user decides to quit, and types:"
 5580 DATA ".sp"
 5590 DATA "  q"
 5600 DATA "    and presses the enter key."
 5610 DATA ".vt 2"
 5620 DATA "He once again sees the menu.  Since he"
 5630 DATA "has decided to quit, he types:"
 5640 DATA ".sp"
 5650 DATA "  0"
 5660 DATA "    and presses the enter key."
 5670 DATA ".vt 2"
 5680 DATA "At the bottom of the screen he sees:"
 5690 DATA ".sp"
 5700 DATA ".pk End of Program"
 5710 DATA ".pk OK"
 5720 DATA ".pk _"
 5730 DATA ".pa"
 5740 DATA ".h2 COMMANDS USED."
 5750 DATA ".h3 basic/s:256"
 5760 DATA ".sp"
 5770 DATA "The basic command is used in order to"
 5780 DATA "load the basic processor from either"
 5790 DATA "the PCjr's BASIC Cartridge, or from"
 5800 DATA "wherever it is located, into storage,"
 5810 DATA "and to establish a buffer size for"
 5820 DATA "the data files."
 5830 DATA ".h3 load (or the F3 function-key)"
 5840 DATA ".sp"
 5850 DATA "The load command is used in order to"
 5860 DATA "load a program prior to running it"
 5870 DATA "or prior to editing it."
 5880 DATA ".h3 save (or the F4 function-key)"
 5890 DATA ".sp"
 5900 DATA "The save command is used in order to"
 5910 DATA "save an edited program."
 5920 DATA ".pa"
 5930 DATA ".h3 run"
 5940 DATA ".sp"
 5950 DATA "The run command is used to cause any"
 5960 DATA "of the Genealogy ON DISPLAY documen-"
 5970 DATA "tation programs to begin."
 5980 DATA ".sp"
 5990 DATA "It is also used to cause the MENU"
 6000 DATA "Program to be run."
 6010 DATA ".eof"
 6020 END
