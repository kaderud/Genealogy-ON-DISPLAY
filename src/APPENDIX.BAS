  100 REM APPENDIX Program.
  110 REM Documentation.  Appendices.
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
 1850 GOTO 9230
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
 3000 REM APPENDIX
 3010 DATA ".h1 A.  MESSAGES"
 3020 DATA ".pn 63"
 3030 DATA ".h2 START-UP MESSAGES"
 3040 DATA "The initial System Message, when the"
 3050 DATA "system is turned on, is:"
 3060 DATA ".sp"
 3070 DATA ".pk Current date is Tue 1-01-1980"
 3080 DATA ".pk Enter new date:"
 3090 DATA ".sp"
 3100 DATA "The user is expected to respond with an"
 3110 DATA "appropriate date."
 3120 DATA ".sp"
 3130 DATA "The next system message is:"
 3140 DATA ".sp"
 3150 DATA ".pk Current time is 0:00:52.17"
 3160 DATA ".pk Enter new time:"
 3170 DATA ".sp"
 3180 DATA "The user is expected to respond with a"
 3190 DATA "correct time."
 3200 DATA ".sp"
 3210 DATA "The System then responds:"
 3220 DATA ".sp"
 3230 DATA ".pk The IBM Personal Computer DOS"
 3240 DATA ".pk Version 2.10 (C) Copyright IBM Corp 1981, 1982, 1983"
 3250 DATA ".sp"
 3260 DATA "When Starting BASIC, the message"
 3270 DATA "in response to"
 3280 DATA ".sp"
 3290 DATA ".pk basic/s:256"
 3300 DATA ".sp"
 3310 DATA "is similar to:"
 3320 DATA ".sp"
 3330 DATA ".pk IBM Personal Computer Basic"
 3340 DATA ".pk Version D2.00 Copyright IBM Corp. 1981, 1982, 1983"
 3350 DATA ".pk 61118 Bytes Free"
 3360 DATA ".pa"
 3370 DATA ".h1 B.  Summary"
 3380 DATA ".h2 General Programs"
 3390 DATA ".pk Function Performed                     Filename"
 3400 DATA ".pk -----------------------------------    --------"
 3410 DATA ".pk Initial File Formatting"
 3420 DATA ".pk   Persons File                         CREATPER"
 3430 DATA ".pk   Marriages File                       CREATMAR"
 3440 DATA ".pk   Ordinances File                      CREATORD"
 3450 DATA ".sp"
 3460 DATA ".pk Entry of Data"
 3470 DATA ".pk   Persons File                         UPDATPER"
 3480 DATA ".pk   Marriages File                       UPDATMAR"
 3490 DATA ".pk   Ordinances File                      UPDATORD"
 3500 DATA ".sp"
 3510 DATA ".pk Print Detailed Information"
 3520 DATA ".pk   Detailed Personal Information        PRINTPER"
 3530 DATA ".pk   Detailed Marriage Information        PRINTMAR"
 3540 DATA ".sp"
 3550 DATA ".pk Numerical Lists"
 3560 DATA ".pk   Persons                              LISTPER"
 3570 DATA ".pk   Marriages                            LISTMAR"
 3580 DATA ".pk   Parent/Child Index                   LISTPCI"
 3590 DATA ".sp"
 3600 DATA ".pk Alphabetical Lists"
 3610 DATA ".pk   Persons                              ALPHAPER"
 3620 DATA ".pk   Marriages                            ALPHAMAR"
 3630 DATA ".sp"
 3640 DATA ".pk Prepare an Index"
 3650 DATA ".pk   Parent/Child Index                   INDEXPC"
 3660 DATA ".pk   Marriages Index                      INDEXMAR"
 3670 DATA ".pa"
 3680 DATA ".h2 General Programs, Cont."
 3690 DATA ".pk Function Performed                     Filename"
 3700 DATA ".pk -----------------------------------    --------"
 3710 DATA ".pk Display the Information                DISPLAY"
 3720 DATA ".pk   Personal Information"
 3730 DATA ".pk   Ancestor Information"
 3740 DATA ".pk   Family Information"
 3750 DATA ".pk   Ordinances Information"
 3760 DATA ".sp"
 3770 DATA ".pk Print the Genealogical Forms"
 3780 DATA ".pk   Print Charts of Ancestors            ANCESTOR"
 3790 DATA ".pk   Print Charts of Families             FAMILY"
 3800 DATA ".sp"
 3810 DATA ".pk Produce Charts of Descendants          DESCEND"
 3820 DATA ".pk   Display on the Screen"
 3830 DATA ".pk   Print the Charts"
 3840 DATA ".sp"
 3850 DATA ".pk Display a Menu"
 3860 DATA ".pk   Displays Available Programs          MENU"
 3870 DATA ".h2 Data Files"
 3880 DATA ".pk File Usage                             Filename"
 3890 DATA ".pk ------------------------------------   --------"
 3900 DATA ".pk Personal Vital Statistics              PERSFILE"
 3910 DATA ".pk Marriage Vital Statistics              MARRFILE"
 3920 DATA ".pk Life Events (LDS Ordinances)           ORDFILE"
 3930 DATA ".pk Verify BASIC has 256 byte buffer       VERIFILE"
 3940 DATA ".pa"
 3950 DATA ".h2 Indexes"
 3960 DATA ".pk Function Performed                     Filename"
 3970 DATA ".pk ------------------------------------   --------"
 3980 DATA ".pk Relates Parents and Children           PCINDEX"
 3990 DATA ".pk Relates Spouses by Marriage            MINDEX"
 4000 DATA ".h2 Documentation"
 4010 DATA ".pk Purpose of Documentation               Filename"
 4020 DATA ".pk ------------------------------------   --------"
 4030 DATA ".pk Getting Started Information            READ.ME"
 4040 DATA ".sp"
 4050 DATA ".pk Change Printers for Documentation      PRINTERS"
 4060 DATA ".sp"
 4070 DATA ".pk Print a Program Directory              DIRECTOR"
 4080 DATA ".sp"
 4090 DATA ".pk Print a User's Manual"
 4100 DATA ".pk   Table of Contents                    TABLEOFC"
 4110 DATA ".pk   Introduction                         INTRODUC"
 4120 DATA ".pk   General Information                  GENERAL"
 4130 DATA ".pk   Using the Programs                   USINGTHE"
 4140 DATA ".pk   Reference Material                   REFERENC"
 4150 DATA ".pk   Appendexes                           APPENDIX"
 4160 DATA ".h2 Overview Information"
 4170 DATA ".pk Function Perfomed                      Filename"
 4180 DATA ".pk ------------------------------------   --------"
 4190 DATA ".pk Overview on the Display Screen         OVERVIEW"
 4200 DATA ".h1 C.  HINTS"
 4210 DATA ".h2 NAMES"
 4220 DATA "It is best to enter surnames with all"
 4230 DATA "capitals, such as:  ABLE"
 4240 DATA ".sp"
 4250 DATA "(Note: It is common practice to use the"
 4260 DATA "Maiden name of a woman, and the surname"
 4270 DATA "given at birth for a child.)"
 4280 DATA ".h2 DATES"
 4290 DATA "All of the programs expect dates in the"
 4300 DATA "form dd Mmm yyyy, such as: 16 Jun 1928."
 4310 DATA "However, partial dates, or approximate"
 4320 DATA "dates, may be entered.  They will be"
 4330 DATA "moved as far to the right as possible."
 4340 DATA ".h2 Replacing Information"
 4350 DATA "When using one of the update-programs,"
 4360 DATA "information (with the exception of the"
 4370 DATA "record-number) can be replaced by"
 4380 DATA "entering the new information.  The new"
 4390 DATA "information simply replaces the old."
 4400 DATA ".sp"
 4410 DATA "In the event that a user wishes to re-"
 4420 DATA "place a current value with blanks (the"
 4430 DATA "data was not correct), the user should"
 4440 DATA "type a quote, then a blank, and then"
 4450 DATA "another quote (i.e. ~ ~).
 4460 DATA ".pa"
 4470 DATA ".h2 Removing a Record."
 4480 DATA "In the rare event that a user wishes"
 4490 DATA "to remove a record from the Persons"
 4500 DATA "File, the Marriages File, or the Ord-"
 4510 DATA "inances File, he may do so by chang-"
 4520 DATA "ing the record-number to the same num-"
 4530 DATA "ber preceded by a minus-sign.  This"
 4540 DATA "will cause the record to be cleared,"
 4550 DATA "and it may then be 'saved'."
 4560 DATA ".sp"
 4570 DATA "(Note:  Remove an Ordinance Record be-"
 4580 DATA "fore removing its Corresponding Person"
 4590 DATA "Record, because an Ordinance Record"
 4600 DATA "cannot be accessed if its Person Record"
 4610 DATA "does not exist.)"
 4620 DATA ".sp"
 4630 DATA "After a record is removed, it may be"
 4640 DATA "necessary to change any references to"
 4650 DATA "the removed record (in persons and"
 4660 DATA "marriage records), and you may have"
 4670 DATA "to prepare the indexes again."
 4680 DATA ".h1 D.  MODIFICATIONS"
 4690 DATA ".h2 Making Changes"
 4700 DATA "In all of the following examples, the"
 4710 DATA "MENU Program has to be loaded and"
 4720 DATA "edited.  If you desire the changes to"
 4730 DATA "be permanent, you must then save the"
 4740 DATA "MENU again.  Unless you save the MENU,"
 4750 DATA "the changes will be only temporary"
 4760 DATA "(gone the next time that the MENU is"
 4770 DATA "loaded)."
 4780 DATA ".sp"
 4790 DATA "Since the MENU Program is a BASIC"
 4800 DATA "program, you will need to use the"
 4810 DATA "BASIC Editor (see the BASIC Manual"
 4820 DATA "for details) to make the changes."
 4830 DATA ".sp"
 4840 DATA "Note:  If you are using a one-drive"
 4850 DATA "system, make sure that both copies"
 4860 DATA "are modified in the same way."
 4870 DATA ".h2 Color Considerations"
 4880 DATA "Line 260 in the MENU Program establish-"
 4890 DATA "es color, through the use of a SCREEN"
 4900 DATA "Statement, which is:"
 4910 DATA ".sp"
 4920 DATA "  SCREEN S1,S2,S3
 4930 DATA ".sp"
 4940 DATA "For many display screens, color can be"
 4950 DATA "disabled by editing the definition of"
 4960 DATA "S2 in Line 220 of the MENU Program."
 4970 DATA "It can be changed from S2 = 1, to"
 4980 DATA "S2 = 0."
 4990 DATA ".pa"
 5000 DATA ".h2 Color Definitions"
 5010 DATA "Lines 300 through 380 of the MENU Pro-"
 5020 DATA "gram establish color for a number of"
 5030 DATA "variables, which are then used by all"
 5040 DATA "of the programs."
 5050 DATA ".sp"
 5060 DATA "Color can be disabled, or it can be"
 5070 DATA "changed, by changing the numbers for"
 5080 DATA "the variables.  For example, color"
 5090 DATA "can be disabled by changing each of"
 5100 DATA "the numbers which is not a zero (0)"
 5110 DATA "to a seven (7)."
 5120 DATA ".h2 Changing the Number of Persons"
 5130 DATA "The programs, as distributed, provide"
 5140 DATA "for 500 persons, and 500 ordinances."
 5150 DATA ".sp"
 5160 DATA "In order to change the number of"
 5170 DATA "persons and ordinances, it is then"
 5180 DATA "necessary to change the 500 to some"
 5190 DATA "other, more desirable, number."
 5200 DATA ".sp"
 5210 DATA "This can be done in the following way:"
 5220 DATA ".sp"
 5230 DATA "In the MENU Program:"
 5240 DATA ".sp"
 5250 DATA "Line-number:   610"
 5260 DATA "Old-value:     MAX.PER = 500"
 5270 DATA "New-value:     you decide."
 5280 DATA ".pa"
 5290 DATA ".h2 Extending Existing Files"
 5300 DATA "Before extending any existing file,"
 5310 DATA "it is always wise to make a back-up"
 5320 DATA "copy of that file, in case you make"
 5330 DATA "any mistakes."
 5340 DATA ".sp"
 5350 DATA "A current file can be extended by"
 5360 DATA "changing the old maximum and setting"
 5370 DATA "a new upper limit.  Once set, the"
 5380 DATA "CREATPER and CREATORD Programs must"
 5390 DATA "then be ~run~."
 5400 DATA ".sp"
 5410 DATA "For example, expanding from 500 to 600"
 5420 DATA "persons would require a change in the"
 5430 DATA "the MENU Program in line 610 and line"
 5440 DATA "630."
 5450 DATA ".sp"
 5460 DATA "Line-number:   610"
 5470 DATA "Old-value:     MAX.PER = 500"
 5480 DATA "New-value:     MAX.PER = 600"
 5490 DATA ".sp"
 5500 DATA "Line-number:   630"
 5510 DATA "Old-value:     OLD.MAX.PER = 0"
 5520 DATA "New-value:     OLD.MAX.PER = 500"
 5530 DATA ".pa"
 5540 DATA ".h2 Printing A Partial Alphabetic List"
 5550 DATA "The beginning and ending letters, to"
 5560 DATA "be used when printing an alphabetic"
 5570 DATA "list of persons, are set in lines 720"
 5580 DATA "and 730 of the MENU Program.  These"
 5590 DATA "may be changed, in order to print a"
 5600 DATA "partial list (e.g. F through M)."
 5610 DATA ".h2 Changing the Number of Marriages"
 5620 DATA "The programs, as designed, provide"
 5630 DATA "for 200 marriages."
 5640 DATA ".sp"
 5650 DATA "In order to change the number of"
 5660 DATA "marriages, it is then necessary to"
 5670 DATA "change the 200 to some other, more"
 5680 DATA "desirable, number."
 5690 DATA ".sp"
 5700 DATA "In the MENU Program:"
 5710 DATA ".sp"
 5720 DATA "Line-number:   620"
 5730 DATA "Old-value:     MAX.MAR = 200"
 5740 DATA "New-value:     you decide."
 5750 DATA ".pa"
 5760 DATA ".h2 Extending an Existing File"
 5770 DATA "Before extending any existing file,"
 5780 DATA "it is always wise to make a back-up"
 5790 DATA "copy of that file, in case you make"
 5800 DATA "any mistakes."
 5810 DATA ".sp"
 5820 DATA "A current file of marriages can be ex-"
 5830 DATA "tended by changing the old maximum and"
 5840 DATA "establishing a new upper limit.  Then"
 5850 DATA "the CREATMAR Program must be ~run~."
 5860 DATA ".sp"
 5870 DATA "For example, expanding from 200 to 300"
 5880 DATA "marriages would require a change in"
 5890 DATA "the MENU Program in line 620 and line"
 5900 DATA "640."
 5910 DATA ".sp"
 5920 DATA "Line-number:   620"
 5930 DATA "Old-value:     MAX.MAR = 200"
 5940 DATA "New-value:     MAX.MAR = 300"
 5950 DATA ".sp"
 5960 DATA "Line-number:   640"
 5970 DATA "Old-value:     OLD.MAX.MAR = 0"
 5980 DATA "New-value:     OLD.MAX.MAR = 200"
 5990 DATA ".pa"
 6000 DATA ".h2 Including Numeric Codes"
 6010 DATA "Line 940 in the MENU Program specifies"
 6020 DATA "that ~no~ numeric codes are to be in-"
 6030 DATA "cluded within the user's data.  Deleting"
 6040 DATA "line 940 causes codes to be included."
 6050 DATA ".h2 Printing Partial Files"
 6060 DATA "As your files grow in size, you may want"
 6070 DATA "printouts of just the new information,"
 6080 DATA "rather than of entire files."
 6090 DATA ".h2 Partial Printout of Persons"
 6100 DATA "Line 680 in the MENU Program defines"
 6110 DATA "the beginning Person Number for use by"
 6120 DATA "the PRINTPER and LISTPER Programs.  It"
 6130 DATA "is 1.  If you change this number to a"
 6140 DATA "higher number (such as 201), the print-"
 6150 DATA "outs will begin at the higher number,"
 6160 DATA "rather than at 1."
 6170 DATA ".h2 Partial Printout of Marriages"
 6180 DATA "Line 690 in the MENU Program defines"
 6190 DATA "the beginning Marriage Number for use by"
 6200 DATA "the PRINTMAR and LISTMAR Programs.  It"
 6210 DATA "is 1.  If you change this number to a"
 6220 DATA "higher number (such as 101), the print-"
 6230 DATA "outs will begin at the higher number,"
 6240 DATA "rather than at 1."
 6250 DATA ".pa"
 6260 DATA ".h2 Repositioning the Files"
 6270 DATA "As released, all files are associated"
 6280 DATA "with the current directory.  In order"
 6290 DATA "to reposition any file onto a different"
 6300 DATA "drive, the path must be changed."
 6310 DATA ".sp"
 6320 DATA "In the MENU Program, the default paths"
 6330 DATA "are located in line numbers 410-480."
 6340 DATA "They are:"
 6350 DATA ".sp"
 6360 DATA "Name                Reference"
 6370 DATA "-----------------   -------------------"
 6380 DATA "DD.PROG$   = ~~     The Programs"
 6390 DATA "DD.VERI$   = ~~     Verify s/256: file"
 6400 DATA "DD.MENU$   = ~~     Menu"
 6410 DATA "DD.PERS$   = ~~     Persons File"
 6420 DATA "DD.MARR$   = ~~     Marriages File"
 6430 DATA "DD.ORD$    = ~no~   Ordinances File"
 6440 DATA "DD.PCIDX$  = ~~     Parent/Child Index"
 6450 DATA "DD.MARIDX$ = ~~     Marriages Index"
 6460 DATA ".sp"
 6470 DATA "The Path to any of the above programs"
 6480 DATA "and files may be changed, by inserting"
 6490 DATA "a path between the quotes (e.g. b:\)"
 6500 DATA "for any specific file."
 6510 DATA ".sp"
 6520 DATA "If the current directory is not where"
 6530 DATA "you have placed the Genealogy ON DISPLAY"
 6540 DATA "Programs and Data Files, then each path"
 6550 DATA "must be defined.  For example:"
 6560 DATA ".sp"
 6570 DATA "DD.PROG$ = ~c:\GENONDIS\~"
 6580 DATA ".sp"
 6590 DATA "Where: GENONDIS is a Sub-Directory Name."
 6600 DATA ".pa"
 6610 DATA ".h2 Removing Person and Marriage Numbers"
 6620 DATA "As distributed, numbers for both the"
 6630 DATA "Person and Marriage are shown.  These"
 6640 DATA "numbers may be removed by changing line"
 6650 DATA "670 in the MENU Program,"
 6660 DATA ".sp"
 6670 DATA "  from:  670 CHART.NOS$ = ~n~"
 6680 DATA "  to:    670 CHART.NOS$ = ~y~"
 6690 DATA ".sp"
 6700 DATA "One other effect is that after this"
 6710 DATA "change, Ancestral Numbers (e.g. 1,2,4,"
 6720 DATA "8,16) will be shown in Pedigree Charts"
 6730 DATA "instead of Person Numbers."
 6740 DATA ".h2 Changing the Chart of Descendants"
 6750 DATA "As distributed, the Chart of Descendants"
 6760 DATA "prints in pages.  It also prints a max-"
 6770 DATA "imum of 30 generations.  Both of these"
 6780 DATA "may be changed by the user."
 6790 DATA ".h2 Continuous Charts of Descendants"
 6800 DATA "Line 660 of the MENU Program contains"
 6810 DATA "a definition of the number of lines on"
 6820 DATA "a page, which is 55.  By changing this"
 6830 DATA "to a very large number (e.g. 9999),"
 6840 DATA "continuous charts may be produced."
 6850 DATA ".pa"
 6860 DATA ".h2 Changing the Generations Shown"
 6870 DATA "Line number 650 of the MENU Program"
 6880 DATA "contains a definition of the maximum"
 6890 DATA "number of generations of descendants"
 6900 DATA "to be shown, which is 30.  This number"
 6910 DATA "may be reduced to as few as 1.  Making"
 6920 DATA "the number more than 30 may cause in-"
 6930 DATA "terference between names and dates."
 6940 DATA "Making the number greater than 50 may"
 6950 DATA "exceed the printer width definition."
 6960 DATA ".h2 Charts of Families Binding Space"
 6970 DATA "When Charts of Families are printed"
 6980 DATA "without the LDS Ordinances, the part of"
 6990 DATA "each sheet which contain those LDS"
 7000 DATA "Ordinances is removed, and the form is"
 7010 DATA "shifted to the right to provide space"
 7020 DATA "for binding (3-hole punching)."
 7030 DATA ".sp"
 7040 DATA "Line 710 in the MENU Program contains"
 7050 DATA "the definition of the number of char-"
 7060 DATA "acters removed on each side of the"
 7070 DATA "chart (10).  If this number is redu-"
 7080 DATA "ced (1 minimum), less binding space"
 7090 DATA "will result, and more information will"
 7100 DATA "be shown."
 7110 DATA ".sp"
 7120 DATA "If this number is increased (18 maxi-"
 7130 DATA "mum), more binding space will result,"
 7140 DATA "and less information will be shown."
 7150 DATA ".pa"
 7160 DATA ".h2 Adding an LDS Ordinances File"
 7170 DATA "An LDS Ordinances File may be added by"
 7180 DATA "changing line 460 in the MENU Program.
 7190 DATA ".sp"
 7200 DATA "Line 460 currently defines the absence"
 7210 DATA "of an Ordinances file.  Its content is:"
 7220 DATA ".sp"
 7230 DATA "   DD.ORD$ = ~no~"
 7240 DATA ".sp"
 7250 DATA "By changing this to:"
 7260 DATA ".sp"
 7270 DATA "   DD.ORD$ = ~~"
 7280 DATA ".sp"
 7290 DATA "an LDS Ordinance File is added, together"
 7300 DATA "with the ability to Create (format) it,"
 7310 DATA "update it, print its content as part of"
 7320 DATA "the output of the PRINTPER Program, and"
 7330 DATA "display it in the DISPLAY Program."
 7340 DATA ".h2 Changing Number of Ancestor Generations"
 7350 DATA "Line 700 of the MENU Program contains"
 7360 DATA "the definition of the number of Genera-"
 7370 DATA "tions to be shown, when a Chart of An-"
 7380 DATA "cestors is prepared.  It is set at 5."
 7390 DATA ".sp"
 7400 DATA "If additional binding space (for 3-hole"
 7410 DATA "punching) is desired, changing the num-"
 7420 DATA "ber from 5 to 4 will reduce the number"
 7430 DATA "of generations shown, and cause the"
 7440 DATA "remaining generations to be centered"
 7450 DATA "on the page."
 7460 DATA ".pa"
 7470 DATA ".h2 Changing Sex Designations"
 7480 DATA "Lines 740 and 750 in the MENU Program"
 7490 DATA "contain one-letter abbreviations, and"
 7500 DATA "full-word designations for male and"
 7510 DATA "female sexes.  These designations may"
 7520 DATA "be changed for other uses, such as for"
 7530 DATA "animal and bird genealogies.  (Note:"
 7540 DATA "The same abbreviation cannot be used"
 7550 DATA "for both the male and female sex.)"
 7560 DATA ".h2 Utilizing other Printers"
 7570 DATA "As designed, an IBM Matrix Printer,"
 7580 DATA "an IBM ProPrinter, or some equivalent"
 7590 DATA "printer is assumed."
 7600 DATA ".sp"
 7610 DATA "Control for Compressed Printing, for"
 7620 DATA "Page Length, for Paper Sensing, and"
 7630 DATA "for Form Feeding is provided in the"
 7640 DATA "ANCESTOR Program, in the FAMILY Pro-"
 7650 DATA "gram, and in the DESCEND Program."
 7660 DATA ".sp"
 7670 DATA "Form Feeding is also provided in the"
 7680 DATA "PRINTPER, PRINTMAR, LISTPER, LISTMAR,"
 7690 DATA "LISTPCI, ALPHAPER, ALPHAMAR, and DIS-"
 7700 DATA "PLAY Programs."
 7710 DATA ".sp"
 7720 DATA "Emphasized (bold) printing is used in"
 7730 DATA "the PRINTPER Program."
 7740 DATA ".sp"
 7750 DATA "In order to provide the same facility"
 7760 DATA "for another printer, these controls"
 7770 DATA "may need to be changed.  They are"
 7780 DATA "found in lines 510-590 of the MENU"
 7790 DATA "Program."
 7800 DATA ".pa"
 7810 DATA "The variable names, and their purposes,"
 7820 DATA "are as follows:"
 7830 DATA ".sp"
 7840 DATA "Name:           Purpose"
 7850 DATA "-------------   -----------------------"
 7860 DATA "FORM.FEED$      To Top of the Next Page"
 7870 DATA "PAP.SEN.ON$     Paper Sensing ON"
 7880 DATA "PAP.SEN.OFF$    Paper Sensing OFF"
 7890 DATA "PAP.LONG$       Long (11 inch) Paper"
 7900 DATA "PAP.SHORT$      Short (8-1/2 in.) Paper"
 7910 DATA "COMPR.ON$       Compressed Print ON"
 7920 DATA "COMPR.OFF$      Compressed Print OFF"
 7930 DATA "BOLD.ON$        Emphasized Print ON"
 7940 DATA "BOLD.OFF$       Emphasized Print OFF"
 7950 DATA ".sp"
 7960 DATA "For each of the above, change the"
 7970 DATA "definition to that of your printer."
 7980 DATA ".h2 Paper Considerations"
 7990 DATA "The definition of the paper being used"
 8000 DATA "is continuous, 8-1/2 x 11 inch paper."
 8010 DATA "This is the normal printer paper for"
 8020 DATA "most printers in use.  However, when-"
 8030 DATA "ever a printer has the capabilities of"
 8040 DATA "using wider paper, paper with another"
 8050 DATA "length, and single sheets, changes can"
 8060 DATA "be made to the MENU Program to use"
 8070 DATA "these features in the DESCEND, FAMILY,"
 8080 DATA "and ANCESTOR Programs."
 8090 DATA ".sp"
 8100 DATA "Lines 760 through 780 of the MENU Pro-"
 8110 DATA "gram contain coded definitions for"
 8120 DATA "different paper characteristics."
 8130 DATA ".pa"
 8140 DATA ".h2 Use of Wide Paper"
 8150 DATA "Line 760 defines compressed printing"
 8160 DATA "for narrow (e.g. 8-1/2 inch) paper.  By"
 8170 DATA "changing the 1 to a 2, compressed print-"
 8180 DATA "ing will not occur, and wide (e.g. 14"
 8190 DATA "inch) paper may be used."
 8200 DATA ".h2 Use of Short Paper"
 8210 DATA "Line 770 specifies long (i.e. 11 inch)"
 8220 DATA "paper.  By changing the 2 to a 1, the"
 8230 DATA "alternate (short) paper length will be"
 8240 DATA "used (i.e. 51 lines per page, for an"
 8250 DATA "8-1/2 inch paper length).  Note: Line"
 8260 DATA "550 may be changed to a different page"
 8270 DATA "length (e.g. 72 lines per page, for a"
 8280 DATA "12 inch paper length)."
 8290 DATA ".h2 Use of Single Sheets"
 8300 DATA "Line 780 defines continuous paper.  By"
 8310 DATA "changing the 1 to a 2, the paper will"
 8320 DATA "then be defined as existing in single"
 8330 DATA "sheets (e.g. some Acid-free papers)."
 8340 DATA ".h2 Defining Function Keys"
 8350 DATA "Lines 810-900 of the MENU Program con-"
 8360 DATA "tain definitions of the content of the"
 8370 DATA "ten function keys, and are empty.  These"
 8380 DATA "definitions may be changed to contain"
 8390 DATA "the names and places which are used the"
 8400 DATA "most (e.g. TAYLOR, Wichita, Kansas)."
 8410 DATA ".pa"
 8420 DATA ".h2 Displaying Lists"
 8430 DATA "The five listing programs (LISTPER"
 8440 DATA "LISTMAR, LISTPCI, ALPHAPER, ALPHAMAR)"
 8450 DATA "normally produce lists on the printer."
 8460 DATA ".sp"
 8470 DATA "By changing line 790 in the MENU Program"
 8480 DATA "(from a 1 to a 0), these lists will be"
 8490 DATA "be displayed on the screen instead of"
 8500 DATA "being printed on the printer."
 8510 DATA ".h2 Including Your Name and Address"
 8520 DATA "You may include your name and address"
 8530 DATA "(up to four lines), in the charts pro-"
 8540 DATA "duced by the ANCESTOR, FAMILY and"
 8550 DATA "DESCEND Programs by changing lines"
 8560 DATA "960-990 of the MENU Program."
 8570 DATA ".sp"
 8580 DATA "Information inserted between the two"
 8590 DATA "quotes in each of these four lines of"
 8600 DATA "the MENU Program will appear in the"
 8610 DATA "appropriate places within the body of"
 8620 DATA "the three major charts."
 8630 DATA ".h2 Using LDS Pre-printed Forms"
 8640 DATA "Line 920 in the MENU Program specifies"
 8650 DATA "that LDS Forms will not be used.  By"
 8660 DATA "changing the 0 to a 1, LDS Forms, Stock"
 8670 DATA "Numbers #GA-054 and #GA-032 may be used."
 8680 DATA ".h1 E. TERMS & CONDITIONS"
 8690 DATA ".h2 Terms"
 8700 DATA "If you are using these programs, you are"
 8710 DATA "expected to become a Registered User,"
 8720 DATA "by making a contribution to the Author"
 8730 DATA "of the programs ($49.00 suggested)."
 8740 DATA ".sp"
 8750 DATA "     Melvin O. Duke"
 8760 DATA "     P. O. Box 2048"
 8770 DATA "     Morgan Hill, CA  95038-2048"
 8780 DATA ".sp"
 8790 DATA "Registration is by individual, not by"
 8800 DATA "company or group."
 8810 DATA ".sp"
 8820 DATA "An individual may request a copy of these"
 8830 DATA "programs, for trial, by sending an unfor-"
 8840 DATA "matted, double-sided, double-density,"
 8850 DATA "5-1/4 inch diskette to the Author.  (No"
 8860 DATA "SS, HD or 3-1/2 inch diskettes, please.)"
 8870 DATA ".sp"
 8880 DATA "A self-addressed, postage-paid return"
 8890 DATA "diskette-mailer must accompany the"
 8900 DATA "diskette (no exceptions, please)."
 8910 DATA ".sp"
 8920 DATA "The programs and documentation will be"
 8930 DATA "copied to the requestor's diskette and"
 8940 DATA "returned in the requestor's mailer."
 8950 DATA ".pa"
 8960 DATA ".h2 Conditions"
 8970 DATA "A limited license is granted to Users"
 8980 DATA "of these programs, to make copies of"
 8990 DATA "them, and distribute them to other indi-"
 9000 DATA "viduals, under the following conditions:"
 9010 DATA ".sp"
 9020 DATA "1.  The Genealogy ON DISPLAY Programs"
 9030 DATA "    are not to be distributed to others"
 9040 DATA "    in a modified form."
 9050 DATA ".sp"
 9060 DATA "2.  No fee is to be charged for the Gene-"
 9070 DATA "    alogy ON DISPLAY Programs themselves."
 9080 DATA ".sp"
 9090 DATA "3.  The notices displayed at program"
 9100 DATA "    start-up are not to be bypassed,"
 9110 DATA "    altered, or removed."
 9120 DATA ".h2 Disclaimer"
 9130 DATA "In no event will the Author be liable to"
 9140 DATA "you for any damages, including any lost"
 9150 DATA "profits, lost savings or other inciden-"
 9160 DATA "tal or consequential damages arising out"
 9170 DATA "of the use of or inability to use these"
 9180 DATA "programs, even if the Author has been"
 9190 DATA "advised of the possibility of such"
 9200 DATA "damages, or for any claim by any other"
 9210 DATA "party."
 9220 DATA ".eof"
 9230 END
