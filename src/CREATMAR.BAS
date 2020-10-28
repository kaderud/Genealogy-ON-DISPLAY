  100 REM CREATMAR Program
  110 REM Creates (Formats) a Marriages File
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Create a Marriages File"
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
 1780 PRINT "This program FORMATS a Marriages-file by writing new, empty records."
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
 1930 GOTO 2220  'to end the program
 2000 REM CREATMAR Program Starts Here
 2010 OPEN CC.MARRFILE$ AS #2 LEN = 128
 2020 FIELD 2, 5 AS M1$, 5 AS M2$, 5 AS M3$, 5 AS M4$, 11 AS M5$, 18 AS M6$, 16 AS M7$, 16 AS M8$, 45 AS M9$
 2030 '
 2040 REM Write the Marriage Records
 2050 FOR I = OLD.MAX.MAR + 1 TO MAX.MAR
 2060  LOCATE 22,1 : PRINT "Writing Record:"; I
 2070  TEMP! = -I
 2080  LSET M1$ = MKS$(TEMP!)    'Record Number
 2090  TEMP! = 0
 2100  LSET M2$ = MKS$(TEMP!)    'Husband
 2110  LSET M3$ = MKS$(TEMP!)    'Wife
 2120  LSET M4$ = MKS$(TEMP!)    'Code
 2130  TEMP$ = " "
 2140  LSET M5$ = TEMP$          'Marriage Date
 2150  LSET M6$ = TEMP$          'Marriage City
 2160  LSET M7$ = TEMP$          'Marriage County
 2170  LSET M8$ = TEMP$          'Marriage State
 2180  LSET M9$ = TEMP$          'Comments
 2190  PUT #2, I
 2200 NEXT I
 2210 CLOSE #2
 2220 KEY ON : CLS : KEY OFF : LOCATE 21,1
 2230 PRINT "End of Program"
 2240 RUN CC.MENU$
