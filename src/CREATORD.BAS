  100 REM CREATORD Program
  110 REM Creates (Formats) an (LDS) Ordinances File
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Create an Ordinances File"
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
 1780 PRINT "This program FORMATS an Ordinances-file by writing new, empty records."
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
 1930 GOTO 2370  'to end the program
 2000 REM CREATORD Program Starts Here
 2010 OPEN CC.ORDFILE$ AS #2 LEN = 256
 2020 FIELD 2,5ASO1$,11ASO2$,11ASO3$,11ASO4$,5ASO5$,5ASO6$,11ASO7$,11ASO8$,11ASO9$,11ASO10$,11ASO11$,5ASO12$,11ASO13$,11ASO14$,11ASO15$,11ASO16$,11ASO17$,11ASO18$,11ASO19$,11ASO20$,11ASO21$,11ASO22$,11ASO23$,26ASO24$
 2030 '
 2040 REM Write the Ordinances Records
 2050 FOR I = OLD.MAX.PER + 1 TO MAX.PER
 2060  TEMP! = I
 2070  LSET O1$ = MKS$(TEMP!)    'Record Number
 2080  TEMP! = 0
 2090  TEMP$ = " "
 2100  LSET O2$ = TEMP$          'Christening
 2110  LSET O3$ = TEMP$          'Blessing
 2120  LSET O4$ = TEMP$          'Sealed to Parents
 2130  LSET O5$ = MKS$(TEMP!)    'Sealed to Father
 2140  LSET O6$ = MKS$(TEMP!)    'Sealed to Mother
 2150  LSET O7$ = TEMP$          'Baptism
 2160  LSET O8$ = TEMP$          'Confirmation
 2170  LSET O9$ = TEMP$          'Patriarchal Blessing
 2180  LSET O10$ = TEMP$         'Endowment
 2190  LSET O11$ = TEMP$         'Sealed to Spouse
 2200  LSET O12$ = MKS$(TEMP!)   'Spouse
 2210  LSET O13$ = TEMP$         'Aaronic Priesthood
 2220  LSET O14$ = TEMP$         'Deacon
 2230  LSET O15$ = TEMP$         'Teacher
 2240  LSET O16$ = TEMP$         'Priest
 2250  LSET O17$ = TEMP$         'Melchizedek Priesthood
 2260  LSET O18$ = TEMP$         'Elder
 2270  LSET O19$ = TEMP$         'Seventy
 2280  LSET O20$ = TEMP$         'High Priest
 2290  LSET O21$ = TEMP$         'Bishop
 2300  LSET O22$ = TEMP$         'Patriarch
 2310  LSET O23$ = TEMP$         'Apostle
 2320  LSET O24$ = TEMP$         'Occupation
 2330  LOCATE 23,1 : PRINT "Writing Record Number:";I
 2340  PUT #2,I
 2350 NEXT I
 2360 CLOSE #2
 2370 KEY ON : CLS : KEY OFF : LOCATE 21,1
 2380 PRINT "End of Program"
 2390 RUN CC.MENU$
