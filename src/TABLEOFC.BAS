  100 REM TABLEOFC Program.
  110 REM Documentation.  Table of Contents.
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 DATA Genealogy
  140 DATA User's Manual
  150 DATA -7
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
  320 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 6 :ELSE TAB.POS = 11
  330 GOSUB 920  'For trim line and heading space
  340 FOR I = 1 TO 6 : LPRINT : NEXT I
  350 LPRINT BOLD.ON$;     'Set Emphasized mode
  360 LPRINT EXPAND.ON$;   'Set Expanded Print
  370 LPRINT TAB(TAB.POS+0);TITLE$
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
  600 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 6 :ELSE TAB.POS = 11
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
  860 DATA ".vt 4"
  870 DATA "Copyright (c) 1982 ... 1989, by:"
  880 DATA "Melvin O. Duke."
  890 DATA ".sp"
  900 DATA "All rights reserved."
  910 '
  920 REM Top of each page routine
  930 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 6 :ELSE TAB.POS = 11
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
 1240 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 6 :ELSE TAB.POS = 11
 1250 RETURN
 1260 '
 1270 REM Command Processor
 1280 IF LEFT$(REPLY$,3) = ".h1" THEN 1390
 1290 IF LEFT$(REPLY$,3) = ".h2" THEN 1550
 1300 IF LEFT$(REPLY$,3) = ".h3" THEN 1660
 1310 IF LEFT$(REPLY$,3) = ".sp" THEN 1770
 1320 IF LEFT$(REPLY$,4) = ".eof" THEN 1820
 1330 IF LEFT$(REPLY$,3) = ".pa" THEN 1860
 1340 '
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
 1470 IF PAGE.NO MOD 2 = 0 THEN ADJUST = -1 :ELSE ADJUST = -4
 1480 LPRINT TAB(TAB.POS+ADJUST); RIGHT$(REPLY$,LEN(REPLY$)-4)
 1490 LPRINT EXPAND.OFF$;  'Return to normal
 1500 LPRINT BOLD.OFF$;    'Return to non-bold
 1510 LINE.NO = LINE.NO+1
 1520 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 6 :ELSE TAB.POS = 11
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
 1630 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 6 :ELSE TAB.POS = 11
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
 1740 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 6 :ELSE TAB.POS = 11
 1750 RETURN
 1760 '
 1770 REM Single Space Processor
 1780 IF LINE.NO = 7 THEN 1800
 1790 IF LINE.NO > 44 THEN GOSUB 1860 :ELSE LPRINT : LINE.NO = LINE.NO + 1
 1800 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 6 :ELSE TAB.POS = 11
 1810 RETURN
 1820 REM End of File Processor
 1830 GOSUB 1860 'Bottom of Page
 1850 GOTO 4590
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
 2020 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 6 :ELSE TAB.POS = 11
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
 2150 IF PAGE.NO MOD 2 = 0 THEN TAB.POS = 6 :ELSE TAB.POS = 11
 2160 RETURN
 2170 REM Indent Processor
 2180 INDENT = VAL(RIGHT$(REPLY$,LEN(REPLY$)-3))
 2190 RETURN
 3000 DATA ".h1 TABLE OF CONTENTS"
 3010 DATA ".sp"
 3020 DATA "INTRODUCTION - - - - - - - - - - - - -   1"
 3030 DATA "  OVERVIEW - - - - - - - - - - - - - -   1"
 3040 DATA "  CAPABILITIES - - - - - - - - - - - -   1"
 3050 DATA "    Display the Genealogy  - - - - - -   2"
 3060 DATA "    Print Charts of Ancestors  - - - -   2"
 3070 DATA "    Print Charts of Families - - - - -   3"
 3080 DATA "    Produce Charts of Descendants  - -   3"
 3090 DATA "    Format the Data Files  - - - - - -   3"
 3100 DATA "    Update the Data Files  - - - - - -   4"
 3110 DATA "    Prepare the Indexes  - - - - - - -   4"
 3120 DATA "    List the Records in the File - - -   4"
 3130 DATA "    Printing the Contents of the"
 3140 DATA "      files  - - - - - - - - - - - - -   5"
 3150 DATA "    Alphabetical Lists - - - - - - - -   5"
 3160 DATA "    Parent/Child Index List  - - - - -   5"
 3170 DATA "  BENEFITS/ADVANTAGES  - - - - - - - -   6"
 3180 DATA "  RESULTS  - - - - - - - - - - - - - -   6"
 3190 DATA "  REQUIREMENTS - - - - - - - - - - - -   7"
 3200 DATA "    Software Requirements  - - - - - -   7"
 3210 DATA "    Hardware Requirements  - - - - - -   8"
 3220 DATA ".sp"
 3230 DATA "GENERAL INFORMATION  - - - - - - - - -   9"
 3240 DATA "  DATA ACCESS REQUIREMENTS - - - - - -   9"
 3250 DATA "  DESCRIPTION OF FUNCTIONS - - - - - -   9"
 3260 DATA "    File Formatting  - - - - - - - - -   9"
 3270 DATA "    File Maintenance - - - - - - - - -   9"
 3280 DATA "    File Indexes - - - - - - - - - - -   9"
 3290 DATA "    Summary Lists  - - - - - - - - - -  10"
 3300 DATA "    Detailed Data  - - - - - - - - - -  10"
 3310 DATA "    Displaying the Genealogy - - - - -  10"
 3320 DATA "    Printing Charts of Ancestors - - -  11"
 3330 DATA "    Printing Charts of Families  - - -  11"
 3340 DATA "    Producing Charts of Descendants  -  11"
 3350 DATA ".pa"
 3360 DATA "  DEFINITION OF TERMS  - - - - - - - -  12"
 3370 DATA "    Information about Persons  - - - -  12"
 3380 DATA "    Information about Ancestors  - - -  12"
 3390 DATA "    Information about Families - - - -  12"
 3400 DATA "    Information about Descendants  - -  13"
 3410 DATA "    Information about Ordinances - - -  13"
 3420 DATA "  EXPLANATION OF GENERAL CONCEPTS  - -  14"
 3430 DATA "    Persfile - - - - - - - - - - - - -  15"
 3440 DATA "    Marrfile - - - - - - - - - - - - -  16"
 3450 DATA "    Pcindex  - - - - - - - - - - - - -  17"
 3460 DATA "    Mindex - - - - - - - - - - - - - -  17"
 3470 DATA "    Ordfile  - - - - - - - - - - - - -  18"
 3480 DATA "    Relationships  - - - - - - - - - -  19"
 3490 DATA "  BEFORE YOU START - - - - - - - - - -  20"
 3500 DATA "    List of Persons  - - - - - - - - -  20"
 3510 DATA "    List of Marriages  - - - - - - - -  22"
 3520 DATA ".sp"
 3530 DATA "USING THE PROGRAMS - - - - - - - - - -  23"
 3540 DATA "  GETTING STARTED  - - - - - - - - - -  23"
 3550 DATA "  First Time Usage - One-Drive System   24"
 3560 DATA "  First Time Usage - Two-Drive System   25"
 3570 DATA "  First Time Usage - Hard-Disk System   27"
 3580 DATA "  First Time Usage - All Systems - - -  28"
 3590 DATA "    Formatting the Data Files  - - - -  28"
 3600 DATA "    Caution  - - - - - - - - - - - - -  28"
 3610 DATA "  HOW TO OPERATE - - - - - - - - - - -  29"
 3620 DATA "  How to Operate - One-Drive System  -  29"
 3630 DATA "  How to Operate - Two-Drive System  -  30"
 3640 DATA "  How to Operate - Hard-Disk System  -  31"
 3650 DATA "    Operating the CREATPER Program - -  32"
 3660 DATA "    Operating the CREATMAR Program - -  33"
 3670 DATA "    Operating the CREATORD Program - -  34"
 3680 DATA "    Operating the UPDATPER Program - -  35"
 3690 DATA "    Operating the UPDATMAR Program - -  37"
 3700 DATA "    Operating the UPDATORD Program - -  39"
 3710 DATA "    Operating the INDEXPC Program  - -  40"
 3720 DATA "    Operating the INDEXMAR Program - -  41"
 3730 DATA "    Operating the DISPLAY Program  - -  42"
 3740 DATA "    Operating the ANCESTOR Program - -  45"
 3750 DATA "    Operating the FAMILY Program - - -  46"
 3760 DATA "    Operating the DESCEND Program  - -  47"
 3770 DATA "    Operating the Other Programs - - -  47"
 3780 DATA ".sp"
 3790 DATA "  HOW TO STOP  - - - - - - - - - - - -  48"
 3800 DATA "    Stopping the update programs - - -  48"
 3810 DATA "    Stopping the DISPLAY Program - - -  48"
 3820 DATA "    Stopping the ANCESTOR Program  - -  48"
 3830 DATA "    Stopping the FAMILY Program  - - -  49"
 3840 DATA "    Stopping the DESCEND Program - - -  49"
 3850 DATA "    Stopping the Other Programs  - - -  49"
 3860 DATA ".sp"
 3870 DATA "REFERENCE MATERIAL - - - - - - - - - -  51"
 3880 DATA "  SAMPLE SCREENS AND PROMPTING"
 3890 DATA "      MESSAGES - - - - - - - - - - - -  51"
 3900 DATA "    Menu Logo  - - - - - - - - - - - -  52"
 3910 DATA "    Menu of Programs - - - - - - - - -  53"
 3920 DATA "    Display Logo - - - - - - - - - - -  54"
 3930 DATA "    Personal Information - - - - - - -  56"
 3940 DATA "    Ancestor Information - - - - - - -  57"
 3950 DATA "    Family Group Information - - - - -  58"
 3960 DATA "    Ordinance Information  - - - - - -  59"
 3970 DATA "  COMMANDS USED  - - - - - - - - - - -  61"
 3980 DATA "    Basic Command  - - - - - - - - - -  61"
 3990 DATA "    Load Command - - - - - - - - - - -  61"
 4000 DATA "    Save Command - - - - - - - - - - -  61"
 4010 DATA "    Run Command  - - - - - - - - - - -  62"
 4020 DATA ".sp"
 4030 DATA "APPENDIX A.  MESSAGES  - - - - - - - -  63"
 4040 DATA "  Start-up Messages  - - - - - - - - -  63"
 4050 DATA ".sp"
 4060 DATA "APPENDIX B. SUMMARY  - - - - - - - - -  65"
 4070 DATA "  General Programs - - - - - - - - - -  65"
 4080 DATA "  Data Files - - - - - - - - - - - - -  66"
 4090 DATA "  Indexes  - - - - - - - - - - - - - -  67"
 4100 DATA "  Documentation  - - - - - - - - - - -  67"
 4110 DATA "  Overview Information - - - - - - - -  67"
 4120 DATA ".pa"
 4130 DATA "APPENDIX C. HINTS  - - - - - - - - - -  69"
 4140 DATA "  Names  - - - - - - - - - - - - - - -  69"
 4150 DATA "  Dates  - - - - - - - - - - - - - - -  69"
 4160 DATA "  Replacing Information  - - - - - - -  69"
 4170 DATA "  Removing a Record  - - - - - - - - -  70"
 4180 DATA ".sp"
 4190 DATA "APPENDIX D.  MODIFICATIONS - - - - - -  71"
 4200 DATA "  Making Changes - - - - - - - - - - -  71"
 4210 DATA "  Color Considerations - - - - - - - -  71"
 4220 DATA "  Color Definitions  - - - - - - - - -  72"
 4230 DATA "  Changing the Number of Persons - - -  72"
 4240 DATA "    Extending Existing Files - - - - -  73"
 4250 DATA "  Printing a Partial Alphabetic List -  74"
 4260 DATA "  Changing the Number of Marriages - -  74"
 4270 DATA "    Extending an Existing File - - - -  75"
 4280 DATA "  Including Numeric Codes  - - - - - -  76"
 4290 DATA "  Printing Partial Files - - - - - - -  76"
 4300 DATA "    Partial Printout of Persons  - - -  76"
 4310 DATA "    Partial Printout of Marriages  - -  76"
 4320 DATA "  Repositioning the Files  - - - - - -  77"
 4330 DATA "  Removing Person and Marriage"
 4340 DATA "    Numbers  - - - - - - - - - - - - -  78"
 4350 DATA "  Changing the Chart of Descendants  -  78"
 4360 DATA "   Continuous Charts of Descendants  -  78"
 4370 DATA "   Changing the Generations Shown  - -  79"
 4380 DATA "  Chart of Family Binding Space  - - -  79"
 4390 DATA "  Adding an LDS Ordinances File  - - -  80"
 4400 DATA "  Changing Number of Ancestor"
 4410 DATA "    Generations  - - - - - - - - - - -  80"
 4420 DATA "  Changing Sex Designations  - - - - -  81"
 4430 DATA "  Utilizing Other Printers - - - - - -  81"
 4440 DATA "  Paper Considerations - - - - - - - -  82"
 4450 DATA "   Use of Wide Paper - - - - - - - - -  83"
 4460 DATA "   Use of Short Paper  - - - - - - - -  83"
 4470 DATA "   Use of Single Sheets  - - - - - - -  83"
 4480 DATA "  Defining Function Keys - - - - - - -  83"
 4490 DATA "  Displaying Lists - - - - - - - - - -  84"
 4500 DATA ".pa"
 4510 DATA "  Including Your Name and Address  - -  84"
 4520 DATA "  Using LDS Pre-printed Forms  - - - -  84"
 4530 DATA ".sp"
 4540 DATA "APPENDIX E.  TERMS & CONDITIONS  - - -  85"
 4550 DATA "  Terms  - - - - - - - - - - - - - - -  85"
 4560 DATA "  Conditions - - - - - - - - - - - - -  86"
 4570 DATA "  Disclaimer - - - - - - - - - - - - -  86"
 4580 DATA ".eof"
 4590 END
