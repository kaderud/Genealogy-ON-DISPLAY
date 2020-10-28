  100 REM GENERAL Program.
  110 REM Documentation.  General Information.
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
 1850 GOTO 6600
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
 3000 DATA ".h1 GENERAL INFORMATION"
 3010 DATA ".pn 9"
 3020 DATA ".h2 DATA ACCESS REQUIREMENT"
 3030 DATA "All of the data files and indexes used"
 3040 DATA "by Genealogy ON DISPLAY are expected to"
 3050 DATA "be available to any of the programs at"
 3060 DATA "the same time.  Also, no data-file or"
 3070 DATA "index can be split across drives."
 3080 DATA ".h2 DESCRIPTION OF FUNCTIONS"
 3090 DATA ".h3 File Formatting."
 3100 DATA "Programs are provided to permit the user"
 3110 DATA "to format one data file which contains"
 3120 DATA "information about persons, another data"
 3130 DATA "file which contains information about"
 3140 DATA "marriages, and a third data file which"
 3150 DATA "contains information about ordinances."
 3160 DATA ".h3 File Maintenance."
 3170 DATA "Programs are provided for the maintenance"
 3180 DATA "of the three data files.  The user is free"
 3190 DATA "to change any information, or to add new"
 3200 DATA "information at any time."
 3210 DATA ".h3 File Indexes."
 3220 DATA "Programs are provided for the formatting"
 3230 DATA "of two indexes, one of which relates"
 3240 DATA "parents and their children, and the other"
 3250 DATA "which relates persons by marriage."
 3260 DATA ".h3 Summary Lists."
 3270 DATA "Programs are provided which will produce"
 3280 DATA "summary lists of the records in the file"
 3290 DATA "which contain the personal information,"
 3300 DATA "or of the records in the file which con-"
 3310 DATA "tain the marriages information."
 3320 DATA ".h3 Detailed Data."
 3330 DATA "One program is provided which will print"
 3340 DATA "either individual records or the entire"
 3350 DATA "contents of the Persons File, together"
 3360 DATA "with the Ordinances File.  A second"
 3370 DATA "program is provided which will print"
 3380 DATA "either individual records or the entire"
 3390 DATA "contents of the Marriages File."
 3400 DATA ".h3 Displaying the Genealogy"
 3410 DATA "Once the data files are as complete as"
 3420 DATA "possible, and the indexes have been"
 3430 DATA "prepared, then the DISPLAY Program can be"
 3440 DATA "used to display the information about a"
 3450 DATA "person (including personal information"
 3460 DATA "and church-related information), the"
 3470 DATA "information about ancestors, and the"
 3480 DATA "information about families."
 3490 DATA ".pa
 3500 DATA ".h3 Printing Charts of Ancestors"
 3510 DATA "Once the data files are as complete as"
 3520 DATA "possible, and the indexes have been"
 3530 DATA "prepared, then the ANCESTOR Program"
 3540 DATA "can be used to print a chart of the"
 3550 DATA "ancestors of any person who is iden-"
 3560 DATA "tified by the user."
 3570 DATA ".h3 Printing Charts of Families"
 3580 DATA "Once the data files are as complete as"
 3590 DATA "possible, and the indexes have been"
 3600 DATA "prepared, then the FAMILY Program can"
 3610 DATA "be used to print a chart of the family"
 3620 DATA "for any marriage which is identified"
 3630 DATA "by the user."
 3640 DATA ".h3 Producing Charts of Descendants"
 3650 DATA "Once the data files are as complete as"
 3660 DATA "possible, and the indexes have been"
 3670 DATA "prepared, then the DESCEND Program can"
 3680 DATA "be used to display (and optionally"
 3690 DATA "print) a chart of the descendants of"
 3700 DATA "any person who is identified by the"
 3710 DATA "user."
 3720 DATA ".pa"
 3730 DATA ".h2 DEFINITION OF TERMS"
 3740 DATA ".h3 Information About Persons."
 3750 DATA "Personal information is that information"
 3760 DATA "that is unique to a person.  It includes"
 3770 DATA "the person's name, his date of birth, the"
 3780 DATA "location of his birth, and his parents."
 3790 DATA "It also contains (if appropriate) the"
 3800 DATA "same type of information about a person's"
 3810 DATA "death and burial."
 3820 DATA ".h3 Information About Ancestors."
 3830 DATA "Ancestor information is that information"
 3840 DATA "which shows the parents, grandparents,"
 3850 DATA "etc., about a person.  It encompases the"
 3860 DATA "direct ancestry of the person."
 3870 DATA ".h3 Information About Families."
 3880 DATA "Family information is that information"
 3890 DATA "about a marriage, and the children of the"
 3900 DATA "marriage.  It includes the location and"
 3910 DATA "date of the marriage, as well as birth-"
 3920 DATA "dates, birth-places, and other informa-"
 3930 DATA "tion about the children, such as marriage"
 3940 DATA "dates, and names of the spouse of each"
 3950 DATA "child."
 3960 DATA ".pa"
 3970 DATA ".h3 Information About Descendants."
 3980 DATA "Descendants information is that infor-"
 3990 DATA "mation about a person, that person's"
 4000 DATA "marriages, that person's children, the"
 4010 DATA "marriages of those children, the child-"
 4020 DATA "ren of those children, etc., etc."
 4030 DATA ".sp"
 4040 DATA "It includes references to each person's"
 4050 DATA "birthdate and deathdate, each marriage,"
 4060 DATA "and the date of that marriage."
 4070 DATA ".h2 Information About Ordinances."
 4080 DATA "Ordinance information is information"
 4090 DATA "about (LDS) church-related events in a"
 4100 DATA "person's life."
 4110 DATA ".pa"
 4120 DATA ".h2 EXPLANATION OF GENERAL CONCEPTS"
 4130 DATA "Genealogy is concerned with information"
 4140 DATA "about any number of direct ancestors,"
 4150 DATA "reaching backward as many generations"
 4160 DATA "as possible.  It is also concerned with"
 4170 DATA "family groups, with spouses, and with"
 4180 DATA "children within the family groups."
 4190 DATA ".sp"
 4200 DATA "Keeping track of the broad and varied"
 4210 DATA "relationships is a tedious manual task."
 4220 DATA ".sp"
 4230 DATA "Genealogy ON DISPLAY provides the basis"
 4240 DATA "for recording and relating these varied"
 4250 DATA "relationships by utilizing two data"
 4260 DATA "files and two indexes.  The first data"
 4270 DATA "file contains information about persons."
 4280 DATA "The second data file contains informa-"
 4290 DATA "tion about marriages.  The first index"
 4300 DATA "relates parents and their children."
 4310 DATA "The second index relates people with"
 4320 DATA "marriages."
 4330 DATA ".sp"
 4340 DATA "With these two files, and two indexes,"
 4350 DATA "Genealogy ON DISPLAY is able to"
 4360 DATA "associate every person with every other"
 4370 DATA "person, both with parent/child rela-"
 4380 DATA "tionships, and with husband/wife"
 4390 DATA "relationships."
 4400 DATA ".sp"
 4410 DATA "A third data file contains additional"
 4420 DATA "personal information which is church-"
 4430 DATA "related.  It contains all of the LDS"
 4440 DATA "ordinance information about a person."
 4450 DATA ".pa"
 4460 DATA ".h3 Persfile"
 4470 DATA "The first data file, named PERSFILE,"
 4480 DATA "contains all of the personal information"
 4490 DATA "about an individual.  It also contains a"
 4500 DATA "reference to that person's father and"
 4510 DATA "mother.  Its format and content are:"
 4520 DATA ".sp"
 4530 DATA "Size  Content"
 4540 DATA "----  --------------------------"
 4550 DATA "  5   Record Number for a Person"
 4560 DATA " 20   Surname of person"
 4570 DATA " 30   Given names of person"
 4580 DATA "  2   Sex"
 4590 DATA "  5   Code"
 4600 DATA "  5   Father's Record Number"
 4610 DATA "  5   Mother's Record Number"
 4620 DATA " 11   Birth-date of person"
 4630 DATA " 18   Birth-city"
 4640 DATA " 16   Birth-county"
 4650 DATA " 16   Birth-state or country"
 4660 DATA " 11   Death-date"
 4670 DATA " 18   Death-city"
 4680 DATA " 16   Death-county"
 4690 DATA " 16   Death-state or country"
 4700 DATA " 11   Burial-date"
 4710 DATA " 18   Burial-city"
 4720 DATA " 16   Burial-county"
 4730 DATA " 16   Burial-state or country"
 4740 DATA ".sp"
 4750 DATA "Note: Code is available to the user"
 4760 DATA "for any special user identification,"
 4770 DATA "such as differentiating between"
 4780 DATA "natural parents and adoptive parents."
 4790 DATA "It is unused by the programs."
 4800 DATA ".pa"
 4810 DATA ".h3 Marrfile"
 4820 DATA "The second data file, named MARRFILE,"
 4830 DATA "contains all of the records of marr-"
 4840 DATA "iages.Its contents are as follows:"
 4850 DATA ".sp"
 4860 DATA "Size  Content"
 4870 DATA "----  --------------------------"
 4880 DATA "  5   Record Number of the Marriage"
 4890 DATA "  5   Husband's Record-number"
 4900 DATA "  5   Wife's Record-number"
 4910 DATA "  5   Code"
 4920 DATA " 11   Marriage-date"
 4930 DATA " 18   Marriage-city"
 4940 DATA " 16   Marriage-county"
 4950 DATA " 16   Marriage-state or country"
 4960 DATA " 45   Comments"
 4970 DATA ".sp"
 4980 DATA "Note: Code is available to the user"
 4990 DATA "for any special user identification,"
 5000 DATA "such as differentiating between"
 5010 DATA "first and second marriage of spouses."
 5020 DATA "It is unused by the programs."
 5030 DATA ".pa
 5040 DATA ".h3 Pcindex"
 5050 DATA "The first index, named PCINDEX,"
 5060 DATA "provides the relationships between"
 5070 DATA "parents and children.  It contains:"
 5080 DATA ".sp"
 5090 DATA "The Number of Records in the Index."
 5100 DATA ".sp"
 5110 DATA "For each index record:"
 5120 DATA "Parent's Record-number, and Child's"
 5130 DATA "Record-number."
 5140 DATA ".sp"
 5150 DATA "Note:  Index records are in sequence"
 5160 DATA "by Child's Birthdate within Parent's"
 5170 DATA "Record-number."
 5180 DATA ".h3 Mindex"
 5190 DATA "The second index, named MINDEX,"
 5200 DATA "provides the relationships between"
 5210 DATA "husbands and wives.  It contains:"
 5220 DATA ".sp"
 5230 DATA "The Number of Records in the Index."
 5240 DATA ".sp"
 5250 DATA "For each index record:"
 5260 DATA "Person's Record-number in the Person's"
 5270 DATA "File, followed by the Marriage-number"
 5280 DATA "within the Marriage-file."
 5290 DATA ".sp"
 5300 DATA "Note:  Index records are in sequence"
 5310 DATA "by Marriage-date within the Person's"
 5320 DATA "Record-number."
 5330 DATA ".pa"
 5340 DATA ".h3 Ordfile"
 5350 DATA "The third data file, named ORDFILE"
 5360 DATA "contains all (LDS) church-related"
 5370 DATA "information about an individual,"
 5380 DATA "including all of the ordinance infor-"
 5390 DATA "mation.  Its contents are as follows:"
 5400 DATA "Size  Content"
 5410 DATA "----  --------------------------"
 5420 DATA "  5   Record Number for a Person"
 5430 DATA " 11   Christening Date"
 5440 DATA " 11   Blessing Date"
 5450 DATA " 11   Sealed to Parents Date"
 5460 DATA "  5   Father's Record Number"
 5470 DATA "  5   Mother's Record Number"
 5480 DATA " 11   Baptism Date"
 5490 DATA " 11   Confirmation Date"
 5500 DATA " 11   Patriarchal Blessing Date"
 5510 DATA " 11   Endowment Date"
 5520 DATA " 11   Sealed to Spouse Date"
 5530 DATA "  5   Spouse's Record Number"
 5540 DATA " 11   Aaronic Priesthood Date"
 5550 DATA " 11   Deacon Date"
 5560 DATA " 11   Teacher Date"
 5570 DATA " 11   Priest Date"
 5580 DATA " 11   Melchizedek Priesthood Date"
 5590 DATA " 11   Elder Date"
 5600 DATA " 11   Seventy Date"
 5610 DATA " 11   High Priest Date"
 5620 DATA " 11   Bishop Date"
 5630 DATA " 11   Patriarch Date"
 5640 DATA " 11   Apostle Date"
 5650 DATA " 26   Occupation"
 5660 DATA ".pa"
 5670 DATA ".h3 Relationships."
 5680 DATA "Because of the relationships carried"
 5690 DATA "within the Persons File, ancestor"
 5700 DATA "information may be associated backward"
 5710 DATA "for any number of generations.  There"
 5720 DATA "is no specific limit to the number of"
 5730 DATA "generations that the Genealogy ON"
 5740 DATA "DISPLAY programs will handle."
 5750 DATA ".sp"
 5760 DATA "Because of the indexes, which relate"
 5770 DATA "parents with their children, coupled"
 5780 DATA "with the information in the Marriages"
 5790 DATA "File, and the index to that file, it"
 5800 DATA "is possible to relate any number of"
 5810 DATA "persons together in families, showing"
 5820 DATA "them in chronological order by the"
 5830 DATA "dates of their births."
 5840 DATA ".sp"
 5850 DATA "(Note: there is no specific limit to"
 5860 DATA "the number of families that the"
 5870 DATA "Genealogy ON DISPLAY programs will"
 5880 DATA "handle, other than the total number"
 5890 DATA "of marriages defined.)
 5900 DATA ".sp"
 5910 DATA "(There is also no limit to the number"
 5920 DATA "of children per family.)"
 5930 DATA ".pa"
 5940 DATA ".h2 BEFORE YOU START"
 5950 DATA ".h3 List of Persons"
 5960 DATA "Begin by making a numbered list, which"
 5970 DATA "contains the people who will be in your"
 5980 DATA "Persons File."
 5990 DATA ".sp"
 6000 DATA "This may look somewhat like:"
 6010 DATA ".sp"
 6020 DATA "No.  Surname      Given-Names"
 6030 DATA "---  -----------  -----------"
 6040 DATA "  1  ABLE         Melvin Otto"
 6050 DATA "  2  LOVELY       Helen Lillian"
 6060 DATA "  3  ABLE         Melvin Kent"
 6070 DATA "  4  ABLE         Ronald Robert"
 6080 DATA "  5  ABLE         Carolyn Elizabeth"
 6090 DATA "  6  ABLE         Linda Ann"
 6100 DATA "  7  ABLE         Otto"
 6110 DATA "  8  BAKER        Beatrice"
 6120 DATA "etc.  etc.         etc."
 6130 DATA ".pa"
 6140 DATA "Now go back and add the number which you"
 6150 DATA "have assigned, which represents each"
 6160 DATA "person's father and mother, such as:"
 6170 DATA ".sp"
 6180 DATA ".pk No.  Surname      Given-Names        Father  Mother"
 6190 DATA ".pk ---  -----------  -----------        ------  ------"
 6200 DATA ".pk   1  ABLE         Melvin Otto           7       8"
 6210 DATA ".pk   2  LOVELY       Helen Lillian"
 6220 DATA ".pk   3  ABLE         Melvin Kent           1       2"
 6230 DATA ".pk   4  ABLE         Ronald Robert         1       2"
 6240 DATA ".pk   5  ABLE         Carolyn Elizabeth     1       2"
 6250 DATA ".pk   6  ABLE         Linda Ann             1       2"
 6260 DATA ".pk   7  ABLE         Otto"
 6270 DATA ".pk   8  BAKER        Beatrice"
 6280 DATA ".pk etc.  etc.         etc.                etc.    etc."
 6290 DATA ".sp"
 6300 DATA "Note:  This is your master list of"
 6310 DATA "persons. It will continue to grow as you"
 6320 DATA "add more and more names.  After you have"
 6330 DATA "updated the Persons File with these"
 6340 DATA "people, you can produce the list by"
 6350 DATA "selecting the LISTPER Program to be"
 6360 DATA "run."
 6370 DATA ".pa"
 6380 DATA ".h3 List of Marriages"
 6390 DATA "Now make a second numbered list.  Enter"
 6400 DATA "the record-numbers of the persons who"
 6410 DATA "are married.  This may appear as:"
 6420 DATA ".sp"
 6430 DATA "Marriage     Husband's   Wife's"
 6440 DATA "Number       Record-no.  Record-no."
 6450 DATA "--------     ----------  ----------"
 6460 DATA "  1            1           2"
 6470 DATA "  2            7           8"
 6480 DATA " etc.         etc.        etc."
 6490 DATA ".sp"
 6500 DATA "If you find it convenient, you may also"
 6510 DATA "want to include names in this list."
 6520 DATA ".sp"
 6530 DATA "Note:  This is your master list of"
 6540 DATA "marriages. It will continue to grow as"
 6550 DATA "you add more and more marriages.  After"
 6560 DATA "you have updated the Marriages File,"
 6570 DATA "you can produce the list by selecting"
 6580 DATA "the LISTMAR Program to be run."
 6590 DATA ".eof"
 6600 END
