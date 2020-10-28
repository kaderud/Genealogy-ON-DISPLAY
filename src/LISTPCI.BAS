  100 REM LISTPCI Program.
  110 REM Prints the Parent/Child Index
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "List the Parent/Child Index"
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
 2000 REM LISTPCI Program Starts Here.
 2010 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2020 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
  2030 IF WHERE.LIST = 1 THEN OPEN "LISTPCI.CSV" FOR OUTPUT AS #3 :ELSE OPEN "scrn:" FOR OUTPUT AS #3
 2040 REM Read all records, and print the actual ones
 2050 OPEN CC.PCINDEX$ FOR INPUT AS #2
 2060 KEY ON : CLS : KEY OFF
 2070 LOCATE  4,1 : PRINT "Open the Parent/Child Index"
 2080 INPUT #2, PC.COUNT
 2090 IF PC.COUNT <> 0 THEN 2140
 2100 PRINT "Parent/Child Index has no Index Records"
 2110 PRINT "Press any key to continue"
 2120 A$ = INKEY$ : IF A$ = "" THEN 2120
 2130 GOTO 2750
 2140 IF WHERE.LIST <> 1 THEN 2180
 2150 LOCATE 19,1
 2160 COLOR W,K
 2170 PRINT "There are";PC.COUNT;"Parent/Child Index Records in the File"
 2180 IF WHERE.LIST <> 1 THEN KEY ON : CLS : KEY OFF
 2190 GOSUB 2210
 2200 GOTO 2300
 2210 COLOR O,K
 2220 PRINT #3, "Listing of the Parent/Child Index Records ";DATE$;"  ";TIME$
 2230 PRINT #3, " "
 2240 PRINT #3, "PARENT PARENT-NAME";
 2250 PRINT #3, TAB(40);"CHILD  CHILD-NAME"
 2260 COLOR P,K
 2270 PRINT #3, "------ ------------------------";
 2280 PRINT #3, TAB(40);"-----  ------------------------"
 2290 RETURN
 2300 FOR I = 1 TO PC.COUNT
 2310  INPUT #2, PAR.ID
 2320  IF WHERE.LIST <> 1 THEN 2350
 2330  COLOR W,K
 2340  LOCATE 23,1 : PRINT "Listing Parent/Child Index Record";I
 2350  COLOR W,K
 2360  PRINT #3, USING "#####"; PAR.ID;
 2370  IF PAR.ID = PREV.PAR.ID THEN 2500
 2380  GET #1, PAR.ID
 2390  REM Extract information from the file for use
 2400  T2$ = F2$
 2410  T3$ = F3$
 2420  FOR J = 1 TO LEN(F2$)-1
 2430   IF RIGHT$(T2$,1)=" "THEN T2$ = LEFT$(T2$,LEN(T2$)-1) :ELSE J = LEN(F2$)-1
 2440  NEXT J
 2450  FOR J = 1 TO LEN(F3$)-1
 2460   IF RIGHT$(T3$,1)=" "THEN T3$ = LEFT$(T3$,LEN(T3$)-1) :ELSE J = LEN(F3$)-1
 2470  NEXT J
 2480  PAR.NAME$ = LEFT$(T2$+", "+T3$,31)
 2490  PREV.PAR.ID = PAR.ID
 2500  COLOR G,K
 2510  PRINT #3, TAB(8); PAR.NAME$;
 2520  INPUT #2, CHI.ID
 2530  COLOR W,K
 2540  PRINT #3, TAB(40);: PRINT #3, USING "#####"; CHI.ID;
 2550  GET #1, CHI.ID
 2560  T2$ = F2$
 2570  T3$ = F3$
 2580  FOR J = 1 TO LEN(F2$)-1
 2590   IF RIGHT$(T2$,1)=" "THEN T2$ = LEFT$(T2$,LEN(T2$)-1) :ELSE J = LEN(F2$)-1
 2600  NEXT J
 2610  FOR J = 1 TO LEN(F3$)-1
 2620   IF RIGHT$(T3$,1)=" "THEN T3$ = LEFT$(T3$,LEN(T3$)-1) :ELSE J = LEN(F3$)-1
 2630  NEXT J
 2640  COLOR G,K
 2650  PRINT #3, TAB(47); LEFT$(T2$+", "+T3$,32)
 2660  COLOR W,K
 2670  IF WHERE.LIST <> 1 THEN 2690
 2680  IF I MOD 55 = 0 THEN PRINT #3, FORM.FEED$;: GOSUB 2210
 2690 NEXT I
 2700 IF WHERE.LIST <> 1 THEN 2730
 2710 PRINT #3, FORM.FEED$;
 2720 GOTO 2750
 2730 COLOR W,K : LOCATE 25,1 : PRINT "Press any key to continue";
 2740 A$ = INKEY$ : IF A$ = "" THEN 2740
 2750 CLOSE
 2760 KEY ON : CLS : KEY OFF : LOCATE 21,1
 2770 PRINT "End of Program"
 2780 RUN CC.MENU$
