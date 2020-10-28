  100 REM MENU Program
  110 REM for Version 6.0 of Genealogy ON DISPLAY.
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  200 REM Screen Definitions
  210 S1 = 0      'Set Text Mode
  220 S2 = 1      'Enable Color
  230 S3 = 0      'Active Page
  240 '
  250 WIDTH "scrn:",80
  260 SCREEN S1, S2, S3
  300 REM Color Definitions
  310 K = 0       'blacK
  320 N = 1       'blue (Navy or uNderline)
  330 G = 2       'Green
  340 B = 3       'cyan (light Blue)
  350 R = 4       'Red
  360 P = 5       'magenta (Purple)
  370 O = 6       'brown (Orange)
  380 W = 7       'White
  400 REM Disk Definitions
  410 DD.MENU$   = ""     'Path to the Menu
  420 DD.VERI$   = ""     'Path to the Verifile
  430 DD.PROG$   = ""     'Path to the Programs
  440 DD.PERS$   = ""     'Path to the Persons File
  450 DD.MARR$   = ""     'Path to the Marriages File
  451 rem 460 DD.ORD$    = "no"   'Path to the Ordinances File
  460 DD.ORD$    = "no"     'Path to the Ordinances File
  470 DD.PCIDX$  = ""     'Path to the Parent/Child Index
  480 DD.MARIDX$ = ""     'Path to the Marriages Index
  490 REM Printer Definitions
  500 PTR.SCRN      = 0              'Character sets differ
  510 FORM.FEED$    = CHR$(12)       'Form Feed the Paper
  520 PAP.SENS.ON$  = CHR$(27)+"9"   'Detect out-of-paper
  530 PAP.SENS.OFF$ = CHR$(27)+"8"   'Ignore out-of-paper
  540 PAP.LONG$     = CHR$(27)+"C"+CHR$(66)       '66 Lines per Page
  550 PAP.SHORT$    = CHR$(27)+"C"+CHR$(51)       '51 Lines per Page
  560 COMPR.ON$     = CHR$(15)       'Compressed Printing ON
  570 COMPR.OFF$    = CHR$(18)       'Compressed Printing OFF
  580 BOLD.ON$      = CHR$(27)+"E"   'Emphasized Printing ON
  590 BOLD.OFF$     = CHR$(27)+"F"   'Emphasized Printing OFF
  600 REM Constants
  610 MAX.PER     = 500   'Maximum Number of Persons
  620 MAX.MAR     = 200   'Maximum Number of Marriages
  630 OLD.MAX.PER =   0   'Previous Maximum Number of Persons
  640 OLD.MAX.MAR =   0   'Previous Maximum Number of Marriages
  650 MAX.GEN     =  30   'Maximum Number of Generations in DESCEND
  660 MAX.LINES   =  55   'Lines per page in DESCEND
  670 CHART.NOS$  = "n"   'Show Person Numbers Instead
  680 START.PER   =   1   'For beginning lists of Persons
  690 START.MAR   =   1   'For beginning lists of Marriages
  700 GENS        =   5   'Generations for ANCESTOR
  710 LEFT.SPACE  =  10   'Binding Space for FAMILY
  720 BEGIN.LTR$  = " "   'Start Alphabetized List
  730 END.LTR$    = "Z"   'End Alphabetized List
  740 MALE.LTR$   = "M" : MALE.SEX$   = "Male"    'Sex Designators
  750 FEMALE.LTR$ = "F" : FEMALE.SEX$ = "Female"  'Sex Designators
  760 WIDE        =   1   'Narrow Paper (8-1/2 Inches)
  770 LENGTH      =   2   'Long Paper (11 Inches)
  780 FORMS       =   1   'Continuous Forms
  790 WHERE.LIST  =   1   'Lists to the Printer
  800 REM Function Key Settings
  810 KEY  1, ""          'Function Key  1
  820 KEY  2, ""          'Function Key  2
  830 KEY  3, ""          'Function Key  3
  840 KEY  4, ""          'Function Key  4
  850 KEY  5, ""          'Function Key  5
  860 KEY  6, ""          'Function Key  6
  870 KEY  7, ""          'Function Key  7
  880 KEY  8, ""          'Function Key  8
  890 KEY  9, ""          'Function Key  9
  900 KEY 10, ""          'Function Key 10
  910 REM Identify LDS Pre-printed Forms
  920 PP.FORMS    =   0   '1 if Forms available
  930 REM Eliminate CODE
  940 CODE$  = "no"       'Delete if Code is Desired
  950 REM Prepared by:
  960 PREP1$ = ""         'Name & Address, Line 1
  970 PREP2$ = ""         'Name & Address, Line 2
  980 PREP3$ = ""         'Name & Address, Line 3
  990 PREP4$ = ""         'Name & Address, Line 4
 1000 REM Titles
 1010 TITLE$ = "MENU of Programs in Genealogy"
 1020 TITLE$ = TITLE$ + " ON DISPLAY"
 1030 VERSION$ = "Version 6.0"
 1040 COPY1$ = "Copyright (c) 1982 ... 1989, by:"
 1050 COPY2$ = "Melvin O. Duke"
 1060 PRICE$ = "$49"
 1070 ADDR1$ = "Melvin O. Duke"
 1080 ADDR2$ = "P. O. Box 2048"
 1090 ADDR3$ = "Morgan Hill, CA  95038-2048"
 1100 DATADISK$ = "Have Data Diskette(s) in Place, then Press any key to Continue."
 1110 REM Concatenate all Paths and Filenames
 1120 CC.MENU$     = DD.MENU$+"menu"
 1130 CC.VERIFILE$ = DD.VERI$+"verifile"
 1140 CC.CREATPER$ = DD.PROG$+"creatper"
 1150 CC.CREATMAR$ = DD.PROG$+"creatmar"
 1160 IF DD.ORD$   = "no" THEN 1180
 1170 CC.CREATORD$ = DD.PROG$+"creatord"
 1180 CC.UPDATPER$ = DD.PROG$+"updatper"
 1190 CC.UPDATMAR$ = DD.PROG$+"updatmar"
 1200 IF DD.ORD$   = "no" THEN 1220
 1210 CC.UPDATORD$ = DD.PROG$+"updatord"
 1220 CC.INDEXPC$  = DD.PROG$+"indexpc"
 1230 CC.INDEXMAR$ = DD.PROG$+"indexmar"
 1240 CC.PRINTPER$ = DD.PROG$+"printper"
 1250 CC.PRINTMAR$ = DD.PROG$+"printmar"
 1260 CC.LISTPER$  = DD.PROG$+"listper"
 1270 CC.LISTMAR$  = DD.PROG$+"listmar"
 1280 CC.LISTPCI$  = DD.PROG$+"listpci"
 1290 CC.ALPHAPER$ = DD.PROG$+"alphaper"
 1300 CC.ALPHAMAR$ = DD.PROG$+"alphamar"
 1310 CC.DISPLAY$  = DD.PROG$+"display"
 1320 CC.ANCESTOR$ = DD.PROG$+"ancestor"
 1330 CC.FAMILY$   = DD.PROG$+"family"
 1340 CC.DESCEND$  = DD.PROG$+"descend"
 1350 CC.PERSFILE$ = DD.PERS$+"persfile"
 1360 CC.MARRFILE$ = DD.MARR$+"marrfile"
 1370 IF DD.ORD$   = "no" THEN 1390
 1380 CC.ORDFILE$  = DD.ORD$+"ordfile"
 1390 CC.PCINDEX$  = DD.PCIDX$+"pcindex"
 1400 CC.MINDEX$   = DD.MARIDX$+"mindex"
 1410 '
 1420 REM Make sure that BASIC was invoked with /s:256
 1430 ON ERROR GOTO 1500
 1440 OPEN CC.VERIFILE$ AS #1 LEN = 256
 1450 ON ERROR GOTO 0
 1460 FIELD 1, 128 AS DUMY1$, 128 AS DUMY2$
 1470 CLOSE
 1480 GOTO 2000
 1490 '
 1500 IF ERR = 5 THEN 1510 :ELSE ON ERROR GOTO 0 : GOTO 1440
 1510 REM File Buffer less than 256 bytes
 1520 KEY ON : CLS : LOCATE 10,1 : COLOR R,B
 1530 PRINT "BASIC must be brought up with /s:256, for Genealogy Records."
 1540 PRINT "Program has been Terminated."
 1550 PRINT "Enter CONT to return to DOS"
 1560 COLOR W,K : STOP
 1570 SYSTEM
 1580 '
 2000 REM Produce the first screen
 2010 KEY ON : CLS : KEY OFF
 2020 REM Draw the outer double box
 2030 R1 = 1 : C1 = 1 : R2 = 24 : C2 = 79 : GOSUB 2300
 2040 REM Find the title location
 2050 TITLE.POS = 40 - INT(LEN(TITLE$)/2)
 2060 REM Draw the title box
 2070 R1=3:C1=TITLE.POS-2:R2=6:C2=TITLE.POS+LEN(TITLE$)+1:GOSUB 2440
 2080 REM Print the title
 2090 LOCATE 4,TITLE.POS : PRINT TITLE$
 2100 LOCATE 5,40-INT(LEN(VERSION$)/2) :  PRINT VERSION$;
 2110 REM Draw the Contribution box
 2120 R1 = 7 : C1 = 18 : R2 = 17 : C2 = 61 : GOSUB 2300
 2130 REM Request the Contribution
 2140 LOCATE  8,20 : PRINT "If you are using these programs, you are"
 2150 LOCATE  9,21 : PRINT "expected to become a Registered User,"
 2160 LOCATE 10,20 : PRINT "by making a contribution to the author"
 2170 LOCATE 11,23 : PRINT "of the programs ("+PRICE$+" suggested)."
 2180 REM Draw the Mailing Label
 2190 R1 = 12 : C1 = 25 : R2 = 16 : C2 = 55 : GOSUB 2440
 2200 REM Print the Name and Address
 2210 LOCATE 13,40-INT(LEN(ADDR1$)/2) :  PRINT ADDR1$;
 2220 LOCATE 14,40-INT(LEN(ADDR2$)/2) :  PRINT ADDR2$;
 2230 LOCATE 15,40-INT(LEN(ADDR3$)/2) :  PRINT ADDR3$;
 2240 REM Draw the Copyright box
 2250 R1 = 19 : C1 = 21 : R2 = 22 : C2 = 59 : GOSUB 2300
 2260 REM Print the Copyright
 2270 LOCATE 20,40-INT(LEN(COPY1$)/2) :  PRINT COPY1$;
 2280 LOCATE 21,40-INT(LEN(COPY2$)/2) :  PRINT COPY2$;
 2290 GOTO 2580
 2300 REM subroutine to print a double box
 2310 COLOR P
 2320 FOR I = R1 + 1 TO R2 - 1
 2330  LOCATE I, C1 : PRINT CHR$(186);
 2340  LOCATE I, C2 : PRINT CHR$(186);
 2350 NEXT I
 2360 LOCATE R1, C1+1 : PRINT STRING$(C2-C1-1,205);
 2370 LOCATE R2, C1+1 : PRINT STRING$(C2-C1-1,205);
 2380  LOCATE R1, C1 : PRINT CHR$(201);
 2390  LOCATE R1, C2 : PRINT CHR$(187);
 2400  LOCATE R2, C1 : PRINT CHR$(200);
 2410  LOCATE R2, C2 : PRINT CHR$(188);
 2420 COLOR W
 2430 RETURN
 2440 REM subroutine to print a single box
 2450 COLOR B
 2460 FOR I = R1 + 1 TO R2 - 1
 2470  LOCATE I, C1 : PRINT CHR$(179);
 2480  LOCATE I, C2 : PRINT CHR$(179);
 2490 NEXT I
 2500 LOCATE R1, C1+1 : PRINT STRING$(C2-C1-1,196);
 2510 LOCATE R2, C1+1 : PRINT STRING$(C2-C1-1,196);
 2520  LOCATE R1, C1 : PRINT CHR$(218);
 2530  LOCATE R1, C2 : PRINT CHR$(191);
 2540  LOCATE R2, C1 : PRINT CHR$(192);
 2550  LOCATE R2, C2 : PRINT CHR$(217);
 2560 COLOR W
 2570 RETURN
 2580 REM ask user to press a key to continue
 2590 LOCATE 25,1
 2600 rem PRINT "Have Program Diskette in Place, then Press any key to continue.";
 2610 rem A$ = INKEY$ : IF A$ = "" THEN 2610
 2620 KEY ON : CLS : KEY OFF
 2630 '
 2640 REM Prevent Common User Errors
 2650 IF WIDE   < 1 OR WIDE   > 2 THEN WIDE   = 1
 2660 IF LENGTH < 1 OR LENGTH > 2 THEN LENGTH = 2
 2670 IF FORMS  < 1 OR FORMS  > 2 THEN FORMS  = 1
 2680 IF PP.FORMS = 1 THEN WIDE  = 2
 2690 IF PP.FORMS = 1 THEN FORMS = 2
 2700 '
 2710 REM MENU Selection Starts Here.
 2720 REM Draw the Menu itself.
 2730 REM Draw the Outer Double Box.
 2740 R1 = 1 : C1 = 1 : R2 = 23 : C2 = 79 : GOSUB 2300
 2750 REM Draw the Heading Separator.
 2760 R1 = 3 : C1 = 1 : R2 = 3 : C2 = 79 : GOSUB 3900
 2770 REM Draw the Vertical Separators.
 2780 R1 = 1 : C1 = 6 : R2 = 23 : C2 = 6 : GOSUB 3970
 2790 R1 = 1 : C1 =17 : R2 = 23 : C2 =17 : GOSUB 3970
 2800 REM Attach the intersections
 2810 COLOR P
 2820 LOCATE 3, 6 : PRINT CHR$(197);
 2830 LOCATE 3,17 : PRINT CHR$(197);
 2840 COLOR W,K
 2850 REM Print the content of the menu.
 2860 COLOR K,W
 2870 LOCATE 2,3 : PRINT "No";
 2880 LOCATE 2,8 : PRINT "Name"
 2890 LOCATE 2,19 : PRINT "Function of the Program"
 2900 COLOR W,K
 2910 COLOR K,W : LOCATE  4,3 : PRINT " 1"; : COLOR R,K
 2920 LOCATE  4,  8 : PRINT "CREATPER";
 2930 LOCATE  4, 19 : PRINT "Creates (FORMATS) a Persons File.";
 2940 COLOR K,W : LOCATE  5,3 : PRINT " 2"; : COLOR R,K
 2950 LOCATE  5,  8 : PRINT "CREATMAR";
 2960 LOCATE  5, 19 : PRINT "Creates (FORMATS) a Marriages File.";
 2970 IF DD.ORD$ = "no" THEN 2980 :ELSE 3010
 2980 COLOR R,K
 2990 LOCATE 6,19 : PRINT "  **(Formatting of Ordinance File has been Bypassed.)**"
 3000 GOTO 3040
 3010 COLOR K,W : LOCATE  6,3 : PRINT " 3"; : COLOR R,K
 3020 LOCATE  6,  8 : PRINT "CREATORD";
 3030 LOCATE  6, 19 : PRINT "Creates (FORMATS) an Ordinances File.";
 3040 COLOR K,W : LOCATE  7,3 : PRINT " 4"; : COLOR G,K
 3050 LOCATE  7,  8 : PRINT "UPDATPER";
 3060 LOCATE  7, 19 : PRINT "Updates Information in the Persons File."
 3070 COLOR K,W : LOCATE  8,3 : PRINT " 5"; : COLOR G,K
 3080 LOCATE  8,  8 : PRINT "UPDATMAR";
 3090 LOCATE  8, 19 : PRINT "Updates Information in the Marriages File."
 3100 IF DD.ORD$ = "no" THEN 3110 :ELSE 3140
 3110 COLOR G,K
 3120 LOCATE 9,19 : PRINT "  **(Updating of Ordinance File has been Bypassed.)**"
 3130 GOTO 3170
 3140 COLOR K,W : LOCATE  9,3 : PRINT " 6"; : COLOR G,K
 3150 LOCATE  9,  8 : PRINT "UPDATORD";
 3160 LOCATE  9, 19 : PRINT "Updates Information in the Ordinances File."
 3170 COLOR K,W : LOCATE 10,3 : PRINT " 7"; : COLOR R,K
 3180 LOCATE 10,  8 : PRINT "INDEXPC ";
 3190 LOCATE 10, 19 : PRINT "Prepares a Parent/Child Index.  (For 13, 16, 18 and 19.)";
 3200 COLOR K,W : LOCATE 11,3 : PRINT " 8"; : COLOR R,K
 3210 LOCATE 11,  8 : PRINT "INDEXMAR";
 3220 LOCATE 11, 19 : PRINT "Prepares a Marriages Index.  (For 15, 16, 17, 18 and 19.)";
 3230 COLOR K,W : LOCATE 12,3 : PRINT " 9"; : COLOR O,K
 3240 LOCATE 12,  8 : PRINT "PRINTPER";
 3250 LOCATE 12, 19 : PRINT "Prints Detailed Information about Persons.";
 3260 COLOR K,W : LOCATE 13,3 : PRINT "10"; : COLOR O,K
 3270 LOCATE 13,  8 : PRINT "PRINTMAR";
 3280 LOCATE 13, 19 : PRINT "Prints Detailed Information about Marriages."
 3290 COLOR K,W : LOCATE 14,3 : PRINT "11"; : COLOR O,K
 3300 LOCATE 14,  8 : PRINT "LISTPER ";
 3310 LOCATE 14, 19 : PRINT "List of Persons, in Numerical Order."
 3320 COLOR K,W : LOCATE 15,3 : PRINT "12"; : COLOR O,K
 3330 LOCATE 15,  8 : PRINT "LISTMAR ";
 3340 LOCATE 15, 19 : PRINT "List of Marriages, in Numerical Order."
 3350 COLOR K,W : LOCATE 16,3 : PRINT "13"; : COLOR O,K
 3360 LOCATE 16,  8 : PRINT "LISTPCI ";
 3370 LOCATE 16, 19 : PRINT "List of the Parent/Child Index.";
 3380 COLOR K,W : LOCATE 17,3 : PRINT "14"; : COLOR O,K
 3390 LOCATE 17,  8 : PRINT "ALPHAPER";
 3400 LOCATE 17, 19 : PRINT "List of Persons, in Alphabetical Order."
 3410 COLOR K,W : LOCATE 18,3 : PRINT "15"; : COLOR O,K
 3420 LOCATE 18,  8 : PRINT "ALPHAMAR";
 3430 LOCATE 18, 19 : PRINT "List of Marriages, in Alphabetical Order."
 3440 COLOR K,W : LOCATE 19,3 : PRINT "16"; : COLOR B,K
 3450 LOCATE 19,  8 : PRINT "DISPLAY ";
 3460 LOCATE 19, 19 : PRINT "Displays Genealogical Information on the Screen."
 3470 COLOR K,W : LOCATE 20,3 : PRINT "17"; : COLOR G,K
 3480 LOCATE 20,  8 : PRINT "ANCESTOR";
 3490 LOCATE 20, 19 : PRINT "Prints Charts of Ancestors."
 3500 COLOR K,W : LOCATE 21,3 : PRINT "18"; : COLOR G,K
 3510 LOCATE 21,  8 : PRINT "FAMILY  ";
 3520 LOCATE 21, 19 : PRINT "Prints Charts of Families."
 3530 COLOR K,W : LOCATE 22,3 : PRINT "19"; : COLOR B,K
 3540 LOCATE 22,  8 : PRINT "DESCEND";
 3550 LOCATE 22, 19 : PRINT "Displays (and Optionally Prints) Charts of Descendants."
 3560 COLOR W,K
 3570 REM Now obtain User Response
 3580 LOCATE 25,2 : PRINT "(0 to quit, 20 to restart the MENU, 21 to return to DOS)";
 3590 LOCATE 24,1
 3600 LINE INPUT "Type a Program Number, and press the 'enter' key.: "; REPLY$
 3610 IF REPLY$ = "" THEN 2620
 3620 IF REPLY$ = "0" THEN 4060
 3630 REPLY = VAL(REPLY$)
 3640 IF REPLY <  0 OR REPLY > 21 THEN 2620
 3650 IF REPLY = 21 THEN SYSTEM
 3660 IF REPLY =  1 THEN KEY ON : CHAIN CC.CREATPER$,,ALL
 3670 IF REPLY =  2 THEN KEY ON : CHAIN CC.CREATMAR$,,ALL
 3680 IF DD.ORD$ = "no" THEN 3700
 3690 IF REPLY =  3 THEN KEY ON : CHAIN CC.CREATORD$,,ALL
 3700 IF REPLY =  4 THEN KEY ON : CHAIN CC.UPDATPER$,,ALL
 3710 IF REPLY =  5 THEN KEY ON : CHAIN CC.UPDATMAR$,,ALL
 3720 IF DD.ORD$ = "no" THEN 3740
 3730 IF REPLY =  6 THEN KEY ON : CHAIN CC.UPDATORD$,,ALL
 3740 IF REPLY =  7 THEN KEY ON : CHAIN CC.INDEXPC$ ,,ALL
 3750 IF REPLY =  8 THEN KEY ON : CHAIN CC.INDEXMAR$,,ALL
 3760 IF REPLY =  9 THEN KEY ON : CHAIN CC.PRINTPER$,,ALL
 3770 IF REPLY = 10 THEN KEY ON : CHAIN CC.PRINTMAR$,,ALL
 3780 IF REPLY = 11 THEN KEY ON : CHAIN CC.LISTPER$ ,,ALL
 3790 IF REPLY = 12 THEN KEY ON : CHAIN CC.LISTMAR$ ,,ALL
 3800 IF REPLY = 13 THEN KEY ON : CHAIN CC.LISTPCI$ ,,ALL
 3810 IF REPLY = 14 THEN KEY ON : CHAIN CC.ALPHAPER$,,ALL
 3820 IF REPLY = 15 THEN KEY ON : CHAIN CC.ALPHAMAR$,,ALL
 3830 IF REPLY = 16 THEN KEY ON : CHAIN CC.DISPLAY$ ,,ALL
 3840 IF REPLY = 17 THEN KEY ON : CHAIN CC.ANCESTOR$,,ALL
 3850 IF REPLY = 18 THEN KEY ON : CHAIN CC.FAMILY$  ,,ALL
 3860 IF REPLY = 19 THEN KEY ON : CHAIN CC.DESCEND$ ,,ALL
 3870 IF REPLY = 20 THEN KEY ON : RUN CC.MENU$
 3880 REM Improper Response
 3890 GOTO 2620
 3900 REM Subroutine to draw a single horizontal line.  Attach to double.
 3910 COLOR P
 3920 LOCATE R1, C1+1 : PRINT STRING$(C2-C1-1,196);
 3930 LOCATE R1,C1 : PRINT CHR$(199);
 3940 LOCATE R1,C2 : PRINT CHR$(182);
 3950 COLOR W
 3960 RETURN
 3970 REM Subroutine to draw a single vertical line.  Attach to double.
 3980 COLOR P
 3990 FOR I = R1 + 1 TO R2 - 1
 4000  LOCATE I,C1 : PRINT CHR$(179);
 4010 NEXT I
 4020 LOCATE R1,C1 : PRINT CHR$(209);
 4030 LOCATE R2,C1 : PRINT CHR$(207);
 4040 COLOR W
 4050 RETURN
 4060 KEY ON : CLS
 4070 REM Reset the Function Keys
 4080 KEY 1, "LIST "
 4090 KEY 2, "RUN"+CHR$(13)
 4100 KEY 3, "LOAD"+CHR$(34)
 4110 KEY 4, "SAVE"+CHR$(34)
 4120 KEY 5, "CONT"+CHR$(13)
 4130 KEY 6, ","+CHR$(34)+"LPT1:"+CHR$(34)+CHR$(13)
 4140 KEY 7, "TRON"+CHR$(13)
 4150 KEY 8, "TROFF"+CHR$(13)
 4160 KEY 9, "KEY "
 4170 KEY 10, "SCREEN 0,0,0"+CHR$(13)
 4180 LOCATE 21,1
 4190 PRINT "End of Program"
 4200 END
