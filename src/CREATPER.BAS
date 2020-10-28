  100 REM CREATPER Program
  110 REM Creates (Formats) a Persons File
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Create a Persons File"
  620 TITLE$ = TITLE$ + " ON DISPLAY"
  700 REM Terminate if not called from the Menu
  710 IF COPY2$ = "Melvin O. Duke" THEN 770
  720 COLOR 7,0 : KEY ON : CLS : LOCATE 15,1
  730 PRINT "Cannot run the"
  740 PRINT TITLE$
  750 PRINT "Program, unless selected from the MENU"
  760 END
  770 REM OK
 1000 REM Produce the first screen
 1010 KEY ON : CLS : KEY OFF
 1040 REM Find the title location
 1050 TITLE.POS = 40 - INT(LEN(TITLE$)/2)
 1080 REM Print the title
 1090 LOCATE 4,TITLE.POS : PRINT TITLE$
 1100 LOCATE 5,40-INT(LEN(VERSION$)/2) :  PRINT VERSION$;
 1250 REM Print the Copyright
 1260 LOCATE 20,40-INT(LEN(COPY1$)/2) :  PRINT COPY1$;
 1270 LOCATE 21,40-INT(LEN(COPY2$)/2) :  PRINT COPY2$;
 1700 REM Display the Copyright
 1710 '
 1720 LOCATE 25,1
 1730 PRINT DATADISK$;
 1740 K$ = INKEY$ : IF K$ = "" THEN 1740
 1750 KEY ON : CLS : KEY OFF
 1760 REM Give the User one more chance to protect himself.
 1770 LOCATE 10,1
 1780 PRINT "This program FORMATS a Persons-file by writing new, empty records."
 1790 PRINT "It will destroy any data which exists with the same record-numbers."
 1800 PRINT
 1810 PRINT "If this is REALLY what you want to do,"
 1820 PRINT "type  y  to continue, and press the 'enter' key."
 1830 PRINT "Otherwise, type anything else, and press the 'enter' key."
 1840 PRINT
 1850 LINE INPUT "Enter your desired action: ",REPLY$
 1860 IF LEFT$(REPLY$,1) = "y" THEN 2000
 1870 IF LEFT$(REPLY$,1) = "Y" THEN 2000
 1880 PRINT
 1890 PRINT "File was NOT Created."
 1900 PRINT
 1910 PRINT "Press any key to continue"
 1920 A$ = INKEY$ : IF A$ = "" THEN 1920
 1930 GOTO 2330  'to end the program
 2000 REM CREATPER Program Starts Here
 2010 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2020 FIELD 1,5ASF1$,20ASF2$,30ASF3$,2ASF4$,5ASF5$,5ASF6$,5ASF7$,11ASF8$,18ASF9$,16ASF10$,16ASF11$,11ASF12$,18ASF13$,16ASF14$,16ASF15$,11ASF16$,18ASF17$,16ASF18$,16ASF19$
 2030 REM Write the Persons Records
 2040 FOR I = OLD.MAX.PER + 1 TO MAX.PER
 2050  TEMP! = -I
 2060  TEMP$ = MKS$(TEMP!)
 2070  LSET F1$ = TEMP$          'Record Number
 2080  TEMP$ = " "
 2090  TEMP! = 0
 2100  LSET F2$ = TEMP$          'Surname
 2110  LSET F3$ = TEMP$          'Given Names
 2120  LSET F4$ = TEMP$          'Sex
 2130  LSET F5$ = MKS$(TEMP!)    'Code
 2140  LSET F6$ = MKS$(TEMP!)    'Father
 2150  LSET F7$ = MKS$(TEMP!)    'Mother
 2160  REM all the rest are string
 2170  LSET F8$ = TEMP$          'Birth Date
 2180  LSET F9$ = TEMP$          'Birth City
 2190  LSET F10$ = TEMP$         'Birth County
 2200  LSET F11$ = TEMP$         'Birth State
 2210  LSET F12$ = TEMP$         'Death Date
 2220  LSET F13$ = TEMP$         'Death City
 2230  LSET F14$ = TEMP$         'Death County
 2240  LSET F15$ = TEMP$         'Death State
 2250  LSET F16$ = TEMP$         'Burial Date
 2260  LSET F17$ = TEMP$         'Burial City
 2270  LSET F18$ = TEMP$         'Burial County
 2280  LSET F19$ = TEMP$         'Burial State
 2290  LOCATE 23,1 : PRINT "Writing Record Number:";I
 2300  PUT #1,I
 2310 NEXT I
 2320 CLOSE #1
 2330 KEY ON : CLS : KEY OFF : LOCATE 21,1
 2340 PRINT "End of Program"
 2350 RUN CC.MENU$
