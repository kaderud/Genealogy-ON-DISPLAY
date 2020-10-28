  100 REM USINGTHE Program.
  110 REM Documentation.  Using the Programs.
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
 1850 GOTO 9550
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
 3000 DATA ".h1 USING THE PROGRAMS"
 3010 DATA ".pn 23"
 3020 DATA ".h2 GETTING STARTED"
 3030 DATA "Whatever the environment, the User"
 3040 DATA "should be working with a copy of the"
 3050 DATA "Distribution Diskette, not from the"
 3060 DATA "original, which should not be changed."
 3070 DATA ".sp"
 3080 DATA "Whether the User is starting for the"
 3090 DATA "first time, or running at a later time,"
 3100 DATA "the procedure is the same.  BASIC is"
 3110 DATA "required (with a record size set to"
 3120 DATA "256), and the MENU Program must be run."
 3130 DATA ".sp"
 3140 DATA "A few differences exist, depending upon"
 3150 DATA "the User's Hardware.  The following"
 3160 DATA "sections describe First Time Usage for"
 3170 DATA "three different configurations, as well"
 3180 DATA "as Operating within those environments."
 3190 DATA ".pa"
 3200 DATA ".h2 First Time Usage - One-Drive System"
 3210 DATA "Begin with two formatted diskettes."
 3220 DATA "(These should be formatted without in-"
 3230 DATA "cluding the System.)"
 3240 DATA ".sp"
 3250 DATA "Label one of them your Data Diskette,"
 3260 DATA "and the other your Program Diskette."
 3270 DATA ".sp"
 3280 DATA "Copy the contents of the Genealogy ON"
 3290 DATA "DISPLAY Distribution Diskette to the"
 3300 DATA "diskette labeled 'Program Diskette'."
 3310 DATA "(Note:  Refer to the DISKCOPY Command"
 3320 DATA "in your DOS Manual.)"
 3330 DATA ".sp"
 3340 DATA "Copy MENU.BAS and VERIFILE from the"
 3350 DATA "Distribution Diskette to your Data"
 3360 DATA "Diskette.  (Note:  Refer to the COPY"
 3370 DATA "Command in your DOS Manual.)"
 3380 DATA ".sp"
 3390 DATA "(Skip to the section on First Time"
 3400 DATA "Usage for all Systems, below.)"
 3410 DATA ".pa"
 3420 DATA ".h2 First Time Usage - Two-Drive System"
 3430 DATA "Begin with two formatted diskettes."
 3440 DATA "(These should be formatted without in-"
 3450 DATA "cluding the System.)"
 3460 DATA ".sp"
 3470 DATA "Label one of them your Data Diskette,"
 3480 DATA "and the other your Program Diskette."
 3490 DATA ".sp"
 3500 DATA "Copy the contents of the Genealogy ON"
 3510 DATA "DISPLAY Distribution Diskette to the"
 3520 DATA "diskette labeled 'Program Diskette'."
 3530 DATA "(Note:  Refer to the DISKCOPY Command"
 3540 DATA "in your DOS Manual.)"
 3550 DATA ".sp"
 3560 DATA "Next, with your DOS Diskette (which"
 3570 DATA "contains BASIC in your a: drive,"
 3580 DATA "bring up BASIC by typing:"
 3590 DATA ".sp"
 3600 DATA "   basic/s:256   (and press 'enter')"
 3610 DATA ".sp"
 3620 DATA "Now, replace the DOS Diskette with"
 3630 DATA "your new Program Diskette, and edit"
 3640 DATA "the MENU.BAS Program to identify"
 3650 DATA "where your files will be.  Type:"
 3660 DATA ".sp"
 3670 DATA "  load ~menu~  (and press 'enter')"
 3680 DATA ".sp"
 3690 DATA "Next, type:"
 3700 DATA ".sp"
 3710 DATA "  edit 440       (and press 'enter')"
 3720 DATA ".sp"
 3730 DATA "Insert a b:\ between the two quotes"
 3740 DATA "    (i.e.  440 DD.PERS$  = ~b:\~"
 3750 DATA "     and press 'enter')"
 3760 DATA ".pa"
 3770 DATA "Do the same thing for lines 450, 470,"
 3780 DATA "and 480."
 3790 DATA ".sp"
 3800 DATA "If you want an LDS Ordinance File,"
 3810 DATA "change the ~no~ in line 460 to ~b:\~"
 3820 DATA "as well."
 3830 DATA ".sp"
 3840 DATA "Save the changed MENU Program.  Type:"
 3850 DATA ".sp"
 3860 DATA "  save ~menu~  (and press 'enter')"
 3870 DATA ".sp"
 3880 DATA "(Skip to the section on First Time"
 3890 DATA "Usage for all Systems, below.)"
 3900 DATA ".pa"
 3910 DATA ".h2 First Time Usage - Hard-Disk System"
 3920 DATA "Begin by making a Sub-directory on your"
 3930 DATA "hard-disk for the Genealogy ON DISPLAY"
 3940 DATA "Programs, and their data files.  Type:"
 3950 DATA ".sp"
 3960 DATA "   mkdir \genondis  (and press 'enter')"
 3970 DATA ".sp"
 3980 DATA "Copy the BASIC Processor into the new"
 3990 DATA "Sub-directory.  Type:"
 4000 DATA ".sp"
 4010 DATA "  copy c:\basic.com  c:\genondis"
 4020 DATA "  (and press 'enter')"
 4030 DATA ".sp"
 4040 DATA "Next, copy the contents of the Distri-"
 4050 DATA "bution Diskette of Genealogy ON DISPLAY"
 4060 DATA "to that Sub-directory.  Type:"
 4070 DATA ".sp"
 4080 DATA "  copy a:\*.*  c:\genondis"
 4090 DATA "  (and press 'enter')"
 4100 DATA ".pa"
 4110 DATA ".h2 First Time Usage - All Systems"
 4120 DATA ".h3 Formatting the Data Files"
 4130 DATA "Each of the Data Files which you will"
 4140 DATA "be using must be formatted (created)"
 4150 DATA "initially, before you can enter any"
 4160 DATA "genealogical information.  This will"
 4170 DATA "mean bringing up BASIC, running the"
 4180 DATA "MENU Program, and selecting options"
 4190 DATA "1 and 2 (and 3 if you want an LDS"
 4200 DATA "Ordinance File)."
 4210 DATA ".sp"
 4220 DATA "Refer to the next section, 'HOW TO"
 4230 DATA "OPERATE'."
 4240 DATA ".h3 Caution
 4250 DATA "A word of extreme caution:  Once you"
 4260 DATA "have run the CREATPER Program, the"
 4270 DATA "CREATMAR Program, and the CREATORD"
 4280 DATA "Programs, you do NOT, repeat NOT, want"
 4290 DATA "to run them again (at least not"
 4300 DATA "against the same files)."
 4310 DATA ".sp"
 4320 DATA "To do so would mean that you would"
 4330 DATA "wipe-out any previous data that was in"
 4340 DATA "the files at the time that you ran the"
 4350 DATA "programs again."
 4360 DATA ".pa"
 4370 DATA ".h2 HOW TO OPERATE."
 4380 DATA "Operation is slightly different, de-"
 4390 DATA "pending upon the hardware that you"
 4400 DATA "are using."
 4410 DATA ".sp"
 4420 DATA "Essentially, it is necessary to turn"
 4430 DATA "on your computer, bring up DOS,"
 4440 DATA "establish the date and time (if you"
 4450 DATA "do not already have that as part of"
 4460 DATA "your system), bring up BASIC, and"
 4470 DATA "RUN the MENU.BAS Program."
 4480 DATA ".sp"
 4490 DATA ".h2 How to Operate - One-Drive System"
 4500 DATA "With your DOS System in your Diskette"
 4510 DATA "Drive, turn on your system."
 4520 DATA ".sp"
 4530 DATA "Respond to any messages about date"
 4540 DATA "and time that may occur."
 4550 DATA ".sp"
 4560 DATA "Next, bring up BASIC by typing:"
 4570 DATA ".sp"
 4580 DATA "   basic/s:256   (and press 'enter')"
 4590 DATA ".sp~
 4600 DATA "Now, place your Genealogy ON DISPLAY"
 4610 DATA "Program Diskette in your Diskette"
 4620 DATA "Drive, and type:"
 4630 DATA ".sp"
 4640 DATA "  run ~menu~"
 4650 DATA ".sp"
 4660 DATA "Follow any directions that appear at"
 4670 DATA "the bottom of the display screen."
 4680 DATA ".pa"
 4690 DATA ".h2 How to Operate - Two-Drive System"
 4700 DATA "With your DOS System in your a: Disk-"
 4710 DATA "ette Drive, turn on your system."
 4720 DATA ".sp"
 4730 DATA "Respond to any messages about date"
 4740 DATA "and time that may occur."
 4750 DATA ".sp"
 4760 DATA "Next, bring up BASIC by typing:"
 4770 DATA ".sp"
 4780 DATA "   basic/s:256   (and press 'enter')"
 4790 DATA ".sp~
 4800 DATA "Now, place your Genealogy ON DISPLAY"
 4810 DATA "Program Diskette in your a: Diskette"
 4820 DATA "Drive, and your Data Diskette in your"
 4830 DATA "b: Diskette Drive.  Then type:"
 4840 DATA ".sp"
 4850 DATA "  run ~menu~     (and press 'enter')"
 4860 DATA ".sp"
 4870 DATA "Follow any directions that appear at"
 4880 DATA "the bottom of the display screen."
 4890 DATA ".pa"
 4900 DATA ".h2 How to Operate - Hard-Disk System"
 4910 DATA "Turn on your system."
 4920 DATA ".sp"
 4930 DATA "Change to the Genealogy ON DISPLAY"
 4940 DATA "Sub-directory.  Type:"
 4950 DATA ".sp"
 4960 DATA "  cd\genondis    (and press 'enter')"
 4970 DATA ".sp"
 4980 DATA "Now, bring up BASIC and start the"
 4990 DATA "MENU Program.  Type:"
 5000 DATA ".sp"
 5010 DATA "  basic menu/s:256"
 5020 DATA "                 (and press 'enter')"
 5030 DATA ".sp"
 5040 DATA "Follow any directions that appear at"
 5050 DATA "the bottom of the display screen."
 5060 DATA ".pa"
 5070 DATA ".h3 Operating the CREATPER Program.
 5080 DATA "After selecting the CREATPER Program,"
 5090 DATA "the user sees the program Title and"
 5100 DATA "Copyright displayed on the screen."
 5110 DATA "He should then press any key to cause"
 5120 DATA "the program to continue."
 5130 DATA ".sp"
 5140 DATA "The record numbers of the records to"
 5150 DATA "be written are controlled by the"
 5160 DATA "contents of lines 610 and 630 in the"
 5170 DATA "MENU Program.  Initially these are"
 5180 DATA "set to 500 and 0 respectively.  This"
 5190 DATA "means that records from 1 through 500"
 5200 DATA "will be written, if the user chooses"
 5210 DATA "to do so."
 5220 DATA ".sp"
 5230 DATA "A second screen is displayed, to give"
 5240 DATA "the user a chance to change his mind."
 5250 DATA "If he REALLY wants to format these"
 5260 DATA "records, he replies by typing:"
 5270 DATA ".sp"
 5280 DATA "   yes      (and presses 'enter')"
 5290 DATA ".sp"
 5300 DATA "and the records are written to the"
 5310 DATA "Persons File."
 5320 DATA ".pa"
 5330 DATA ".h3 Operating the CREATMAR Program.
 5340 DATA "After selecting the CREATMAR Program,"
 5350 DATA "the user sees the program Title and"
 5360 DATA "Copyright displayed on the screen."
 5370 DATA "He should then press any key to cause"
 5380 DATA "the program to continue."
 5390 DATA ".sp"
 5400 DATA "The record numbers of the records to"
 5410 DATA "be written are controlled by the"
 5420 DATA "contents of lines 620 and 640 in the"
 5430 DATA "MENU Program.  Initially these are"
 5440 DATA "set to 200 and 0 respectively.  This"
 5450 DATA "means that records from 1 through 200"
 5460 DATA "will be written, if the user chooses"
 5470 DATA "to do so."
 5480 DATA ".sp"
 5490 DATA "A second screen is displayed, to give"
 5500 DATA "the user a chance to change his mind."
 5510 DATA "If he REALLY wants to format these"
 5520 DATA "records, he replies by typing:"
 5530 DATA ".sp"
 5540 DATA "   yes      (and presses 'enter')"
 5550 DATA ".sp"
 5560 DATA "and the records are written to the"
 5570 DATA "Marriages File."
 5580 DATA ".pa"
 5590 DATA ".h3 Operating the CREATORD Program.
 5600 DATA "After selecting the CREATORD Program,"
 5610 DATA "the user sees the program Title and"
 5620 DATA "Copyright displayed on the screen."
 5630 DATA "He should then press any key to cause"
 5640 DATA "the program to continue."
 5650 DATA ".sp"
 5660 DATA "The record numbers of the records to"
 5670 DATA "be written are controlled by the"
 5680 DATA "contents of lines 610 and 630 in the"
 5690 DATA "MENU Program.  Initially these are"
 5700 DATA "set to 500 and 0 respectively.  This"
 5710 DATA "means that records from 1 through 500"
 5720 DATA "will be written, if the user chooses"
 5730 DATA "to do so."
 5740 DATA ".sp"
 5750 DATA "A second screen is displayed, to give"
 5760 DATA "the user a chance to change his mind."
 5770 DATA "If he REALLY wants to format these"
 5780 DATA "records, he replies by typing:"
 5790 DATA ".sp"
 5800 DATA "   yes      (and presses 'enter')"
 5810 DATA ".sp"
 5820 DATA "and the records are written to the"
 5830 DATA "Ordinances File."
 5840 DATA ".pa"
 5850 DATA ".h3 Operating the UPDATPER Program."
 5860 DATA "After selecting the UPDATPER Program,"
 5870 DATA "the user sees the program Title and"
 5880 DATA "Copyright on the screen.  He should"
 5890 DATA "then press any key to continue."
 5900 DATA ".sp"
 5910 DATA "After the logo is displayed, the user"
 5920 DATA "is asked which record he wants to up-"
 5930 DATA "date.  He should respond with a valid"
 5940 DATA "number in the range of 1 to 500."
 5950 DATA ".sp"
 5960 DATA "(Note:  If you just want to find an"
 5970 DATA "unused record, you may type a question-"
 5980 DATA "mark.  A search will be made from the"
 5990 DATA "the beginning of the file, or from the"
 6000 DATA "last record which you referenced, until"
 6010 DATA "an unused record is found, or the top"
 6020 DATA "of the file is reached.)"
 6030 DATA ".sp"
 6040 DATA "The current content of the record is"
 6050 DATA "shown.  If the record has never been"
 6060 DATA "used, the record-number shown will be"
 6070 DATA "negative.  As long as this number is"
 6080 DATA "negative, it will be bypassed for any"
 6090 DATA "further processing.  The user should"
 6100 DATA "enter the record-number."
 6110 DATA ".sp"
 6120 DATA "The user is prompted for input.  He may"
 6130 DATA "bypass any field by pressing the enter"
 6140 DATA "key.  He may also bypass all remaining"
 6150 DATA "fields by typing / and then pressing"
 6160 DATA "the enter key."
 6170 DATA ".sp"
 6180 DATA "Note:  Dates should be entered as:"
 6190 DATA "dd Mmm yyyy, such as: 16 Jan 1943."
 6200 DATA ".pa"
 6210 DATA "When finished with his updating, he is"
 6220 DATA "asked to indicate what he wants to do"
 6230 DATA "with the record.  He may either 'save'"
 6240 DATA "it, he may 'forget' it, or he may make"
 6250 DATA "'more' changes to the record.  As soon"
 6260 DATA "as he says 'save', the record is saved"
 6270 DATA "and he is once more prompted about the"
 6280 DATA "next record to update."
 6290 DATA ".sp"
 6300 DATA "When he is through, he should indicate"
 6310 DATA "that he wants to update record 0."
 6320 DATA ".pa"
 6330 DATA ".h3 Operating the UPDATMAR Program."
 6340 DATA "After selecting the UPDATMAR Program,"
 6350 DATA "the user sees the Program Title and"
 6360 DATA "Copyright on the screen.  He should"
 6370 DATA "then press any key to continue."
 6380 DATA ".sp"
 6390 DATA "After the logo is displayed, the user"
 6400 DATA "is asked which record he wants to up-"
 6410 DATA "date.  He should respond with a valid"
 6420 DATA "number in the range of 1 to 200."
 6430 DATA ".sp"
 6440 DATA "(Note:  If you just want to find an"
 6450 DATA "unused record, you may type a question-"
 6460 DATA "mark.  A search will be made from the"
 6470 DATA "the beginning of the file, or from the"
 6480 DATA "last record which you referenced, until"
 6490 DATA "an unused record is found, or the top"
 6500 DATA "of the file is reached.)"
 6510 DATA ".sp"
 6520 DATA "The current content of the record is"
 6530 DATA "shown.  If the record has never been"
 6540 DATA "used, the record-number shown will be"
 6550 DATA "negative.  As long as this number is"
 6560 DATA "negative, it will be bypassed for any"
 6570 DATA "further processing.  The user should"
 6580 DATA "enter the record-number."
 6590 DATA ".sp"
 6600 DATA "The user is prompted for input.  He may"
 6610 DATA "bypass any field by pressing the enter"
 6620 DATA "key.  He may also bypass all remaining"
 6630 DATA "fields by typing / and then pressing"
 6640 DATA "the enter key."
 6650 DATA ".pa"
 6660 DATA "When finished with his updating, he is"
 6670 DATA "asked to indicate what he wants to do"
 6680 DATA "with the record.  He may either 'save'"
 6690 DATA "it, he may 'forget' it, or he may make"
 6700 DATA "'more' changes to the record.  As soon"
 6710 DATA "as he says 'save', the record is saved"
 6720 DATA "and he is once more prompted about the"
 6730 DATA "next record to update."
 6740 DATA ".sp"
 6750 DATA "When he is through, he should indicate"
 6760 DATA "that he wants to update record 0."
 6770 DATA ".pa"
 6780 DATA ".h2 Operating the UPDATORD Program."
 6790 DATA "After selecting the UPDATORD Program,"
 6800 DATA "the user sees the Program Title and"
 6810 DATA "Copyright on the screen.  He should"
 6820 DATA "then press any key to continue."
 6830 DATA ".sp"
 6840 DATA "After the logo is displayed, the user"
 6850 DATA "is asked which record he wants to up-"
 6860 DATA "date.  He should respond with a valid"
 6870 DATA "number in the range of 1 to 500."
 6880 DATA ".sp"
 6890 DATA "(Note:  You cannot search for an unused"
 6900 DATA "ordinances record, since it is always"
 6910 DATA "associated with a person's record.)"
 6920 DATA ".sp"
 6930 DATA "The user is prompted for input.  He may"
 6940 DATA "bypass any field by pressing the enter"
 6950 DATA "key.  He may also bypass all remaining"
 6960 DATA "fields by typing / and then pressing"
 6970 DATA "the enter key."
 6980 DATA ".sp"
 6990 DATA "Dates should be entered as: dd Mmm yyyy,"
 7000 DATA "such as:  22 Aug 1922."
 7010 DATA ".sp"
 7020 DATA "When finished with his updating, he is"
 7030 DATA "asked to indicate what he wants to do"
 7040 DATA "with the record.  He may either 'save'"
 7050 DATA "it, he may 'forget' it, or he may make"
 7060 DATA "'more' changes to the record.  As soon"
 7070 DATA "as he says 'save', the record is saved"
 7080 DATA "and he is once more prompted about the"
 7090 DATA "next record to update."
 7100 DATA ".sp"
 7110 DATA "When he is through, he should indicate"
 7120 DATA "that he wants to update record 0."
 7130 DATA ".pa"
 7140 DATA ".h3 Operating the INDEXPC Program."
 7150 DATA "The INDEXPC Program is fundamental to"
 7160 DATA "the preparation of a parent/child index,"
 7170 DATA "which associates parents with their"
 7180 DATA "children."
 7190 DATA ".sp"
 7200 DATA "It should be run after any additions"
 7210 DATA "of persons to the Persons File, when-"
 7220 DATA "ever birthdates are added or changed,"
 7230 DATA "or when identification of parents have"
 7240 DATA "been added or changed."
 7250 DATA ".sp"
 7260 DATA "After selecting the INDEXPC Program,"
 7270 DATA "the user sees the Program Title and"
 7280 DATA "Copyright on the screen.  He should"
 7290 DATA "then press any key to continue."
 7300 DATA ".sp"
 7310 DATA "A data file named PCINDEX will be"
 7320 DATA "created."
 7330 DATA ".pa"
 7340 DATA ".h3 Operating the INDEXMAR Program."
 7350 DATA "The INDEXMAR program is fundamental to"
 7360 DATA "the preparation of a marriages index,"
 7370 DATA "which associates spouses with each"
 7380 DATA "other."
 7390 DATA ".sp"
 7400 DATA "It should be run after marriages are"
 7410 DATA "added to the Marriages File, whenever"
 7420 DATA "marriage-dates are added or changed,"
 7430 DATA "or whenever changes are made which re-"
 7440 DATA "identify spouses."
 7450 DATA ".sp"
 7460 DATA "After selecting the INDEXMAR Program,"
 7470 DATA "the user sees the Program Title and"
 7480 DATA "Copyright on the screen.  He should"
 7490 DATA "then press any key to continue."
 7500 DATA ".sp"
 7510 DATA "A data file named MINDEX will be"
 7520 DATA "created."
 7530 DATA ".pa"
 7540 DATA ".h3 Operating the DISPLAY Program."
 7550 DATA "Before running the DISPLAY Program,"
 7560 DATA "the user should know that any changes"
 7570 DATA "that he has made to the data files may"
 7580 DATA "have made his indexes out-of-date."
 7590 DATA "This will have happened if the user"
 7600 DATA "has entered a new person, a new"
 7610 DATA "marriage, a new relationship (such as"
 7620 DATA "a reference to a parent), a new"
 7630 DATA "birth-date, a new marriage-date, or"
 7640 DATA "a new Name."
 7650 DATA ".sp"
 7660 DATA "The indexes are still correct if the"
 7670 DATA "user has entered new death-dates,"
 7680 DATA "burial-dates, or any information about"
 7690 DATA "locations (cities, counties, states)"
 7700 DATA "of births, deaths, ordinances, etc."
 7710 DATA ".sp"
 7720 DATA "If the indexes are out-of-date, the"
 7730 DATA "user should update them before running"
 7740 DATA "the DISPLAY Program, by running the"
 7750 DATA "INDEXPER and INDEXMAR Programs."
 7760 DATA ".sp"
 7770 DATA "After selecting the DISPLAY Program,"
 7780 DATA "the user sees the Program Title and"
 7790 DATA "Copyright on the screen.  He should"
 7800 DATA "then press any key to continue."
 7810 DATA ".sp"
 7820 DATA "After the logo is displayed, the user"
 7830 DATA "is asked for the record-number of the"
 7840 DATA "person that he wants to locate.  He"
 7850 DATA "should enter a number which he knows to"
 7860 DATA "be valid."
 7870 DATA ".pa"
 7880 DATA "The personal information about that"
 7890 DATA "person will then be shown on the display."
 7900 DATA ".sp"
 7910 DATA "The user may then enter 'ps' (print"
 7920 DATA "the screen), he may enter 'an' (for an"
 7930 DATA "ancestor chart), he may enter 'fg' (for"
 7940 DATA "a family group), he may enter 'o' (for"
 7950 DATA "ordinance information), he may enter 'p'"
 7960 DATA "followed by a valid number (requesting"
 7970 DATA "information about a person), he may enter"
 7980 DATA "'m' followed by a valid number (requesting"
 7990 DATA "information about a marriage), or he may"
 8000 DATA "enter 'q' (asking to quit)."
 8010 DATA ".sp"
 8020 DATA "When the ancestor information appears,"
 8030 DATA "the user may then enter 'ps' (print the"
 8040 DATA "screen, he may enter 'fg' (requesting"
 8050 DATA "a family group), he may enter 'o' (for"
 8060 DATA "ordinance information), He may enter 'an'"
 8070 DATA "(asking that the chart of ancestors be"
 8080 DATA "re-drawn), he may enter 'l' followed by"
 8090 DATA "a valid number (requesting personal"
 8100 DATA "information about a person on the stated"
 8110 DATA "line), he may enter 'm' followed by a"
 8120 DATA "valid number (requesting information"
 8130 DATA "about a marriage), or he may enter 'q'"
 8140 DATA "(asking to quit)."
 8150 DATA ".pa"
 8160 DATA "When the family group information appears,"
 8170 DATA "the user may enter 'ps' (print the"
 8180 DATA "screen), he may enter 'f' (asking for the"
 8190 DATA "father), he may enter 'm' (asking for the"
 8200 DATA "mother), he may enter 'p' followed by a"
 8210 DATA "valid number (asking for about a person),"
 8220 DATA "he may enter 'c' followed by a valid"
 8230 DATA "number (asking for information about a"
 8240 DATA "child), he may enter 'm' followed by a"
 8250 DATA "valid number (requesting information"
 8260 DATA "about a marriage, or he may enter 'q'"
 8270 DATA "(asking to quit)."
 8280 DATA ".sp"
 8290 DATA "When the ordinance information appears,"
 8300 DATA "The user may then enter 'ps' (print"
 8310 DATA "the screen), he may enter 'an' (for an"
 8320 DATA "ancestor chart), he may enter 'fg' (for"
 8330 DATA "a family group), he may enter 'o' (for"
 8340 DATA "ordinance information), he may enter 'p'"
 8350 DATA "followed by a valid number (requesting"
 8360 DATA "information about a person), he may enter"
 8370 DATA "'m' followed by a valid number (request-"
 8380 DATA "ing information about a marriage), or he"
 8390 DATA "may enter 'q' (asking to quit)."
 8400 DATA ".pa"
 8410 DATA ".h2 Operating the ANCESTOR Program"
 8420 DATA "After selecting the ANCESTOR Program,"
 8430 DATA "the user sees the Program Title and"
 8440 DATA "Copyright on the screen.  He should"
 8450 DATA "then press any key to continue."
 8460 DATA ".sp"
 8470 DATA "He should then follow any instructions"
 8480 DATA "which appear at the bottom of the screen,"
 8490 DATA "specifying the person-number of the per-"
 8500 DATA "son whose Chart of Ancestors is desired."
 8510 DATA "(Note:  If the record selected is empty,"
 8520 DATA "a blank ancestor chart will be printed.)"
 8530 DATA ".sp"
 8540 DATA "Note:  Any available printer paper which"
 8550 DATA "fits your printer may be used."
 8560 DATA ".pa"
 8570 DATA ".h2 Operating the FAMILY Program"
 8580 DATA "After selecting the FAMILY Program,"
 8590 DATA "the user sees the Program Title and"
 8600 DATA "Copyright on the screen.  He should"
 8610 DATA "then press any key to continue."
 8620 DATA ".sp"
 8630 DATA "He should then follow any instructions"
 8640 DATA "which appear at the bottom of the screen,"
 8650 DATA "specifying the marriage-number of the"
 8660 DATA "marriage whose Chart of Family is de-"
 8670 DATA "sired.  (Note:  If the record selected"
 8680 DATA "is empty, a blank Chart of Family will"
 8690 DATA "be be printed.)"
 8700 DATA ".sp"
 8710 DATA "Note:  Any available printer paper which"
 8720 DATA "fits your printer may be used."
 8730 DATA ".pa"
 8740 DATA ".h3 Operating the DESCEND Program"
 8750 DATA "After selecting the DESCEND Program,"
 8760 DATA "the user sees the Program Title and"
 8770 DATA "Copyright on the screen.  He should"
 8780 DATA "then press any key to continue."
 8790 DATA ".sp"
 8800 DATA "He should then follow any instructions"
 8810 DATA "which appear at the bottom of the screen,"
 8820 DATA "specifying the person-number of the"
 8830 DATA "person whose Chart of Descendants is"
 8840 DATA "desired."
 8850 DATA ".h3 Operating the Other Programs."
 8860 DATA "After selecting one of the other pro-"
 8870 DATA "grams, the user sees the Program Title"
 8880 DATA "and Copyright on the screen.  He should"
 8890 DATA "then press any key to continue."
 8900 DATA ".sp"
 8910 DATA "Note:  See the Summary (in Appendix B)"
 8920 DATA "for the names of the other programs."
 8930 DATA ".sp"
 8940 DATA "After the logo is displayed, the user"
 8950 DATA "observes the information that is being"
 8960 DATA "shown on the display screen, and waits"
 8970 DATA "for the program to complete."
 8980 DATA ".pa"
 8990 DATA ".h2 HOW TO STOP."
 9000 DATA "The user may stop at any time, by"
 9010 DATA "pressing (and holding down) the Function"
 9020 DATA "(FN) key, and then pressing the Break"
 9030 DATA "(B) key on the PCjr."
 9040 DATA ".sp"
 9050 DATA "The user may stop at any time, by"
 9060 DATA "pressing (and holding down) the control"
 9070 DATA "(Ctrl) key, and then pressing the Break"
 9080 DATA "key on the other members of the IBM PC"
 9090 DATA "Family of Computers."
 9100 DATA ".sp"
 9110 DATA ".h3 Stopping the Update Programs."
 9120 DATA "The user may stop one of the update"
 9130 DATA "programs (UPDATPER, UPDATMAR, or"
 9140 DATA "UPDATORD) by requesting an update of"
 9150 DATA "record 0."
 9160 DATA ".h3 Stopping the DISPLAY Program."
 9170 DATA "The user may stop the DISPLAY Program"
 9180 DATA "by typing 'q' or 'quit' when he is asked"
 9190 DATA "for his next action, or he may type"
 9200 DATA "'p0', to request person-number 0."
 9210 DATA ".h3 Stopping the ANCESTOR Program."
 9220 DATA "The user may stop the ANCESTOR Program"
 9230 DATA "by asking for a printout of the ances-"
 9240 DATA "tors of person-number 0."
 9250 DATA ".pa"
 9260 DATA ".h3 Stopping the FAMILY Program."
 9270 DATA "The user may stop the FAMILY Program"
 9280 DATA "by asking for a printout of the family"
 9290 DATA "whose marriage-number is 0."
 9300 DATA ".h3 Stopping the DESCEND Program."
 9310 DATA "The user may stop the DESCEND Program"
 9320 DATA "by asking for the display or printout"
 9330 DATA "of the descendants of the person whose"
 9340 DATA "person-number is 0."
 9350 DATA ".h3 Stopping the Other Programs."
 9360 DATA "The other programs may only be stopped"
 9370 DATA "with the 'function-break' or the"
 9380 DATA "'control-break' sequence, as indicated"
 9390 DATA "above.  However, the user is cautioned"
 9400 DATA "that if he does this while writing new"
 9410 DATA "indexes to the diskette (during the"
 9420 DATA "running of the INDEXPC or INDEXMAR"
 9430 DATA "programs), the index that is currently"
 9440 DATA "being written may be destroyed, and"
 9450 DATA "will have to be re-built before the"
 9460 DATA "DISPLAY, PEDIGREE, FAMILY and ALPHAMAR"
 9470 DATA "programs are run."
 9480 DATA ".sp"
 9490 DATA "The damaged index can be re-built by"
 9500 DATA "re-running the INDEXPC or INDEXMAR"
 9510 DATA "program which was stopped with the"
 9520 DATA "'function-break' or 'control-break'"
 9530 DATA "sequence."
 9540 DATA ".pa"
 9550 DATA ".eof"
 9560 END
