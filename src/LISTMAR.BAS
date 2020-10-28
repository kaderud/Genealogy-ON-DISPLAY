  100 REM LISTMAR Program.
  110 REM Prints a List of Marriages
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "List the Marriages File"
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
 2000 REM LISTMAR Program Starts Here.
 2010 REM Prevent common user errors
 2020 IF START.MAR < 1 THEN START.MAR = 1
 2030 IF START.MAR > MAX.MAR THEN START.MAR = MAX.MAR
 2040 REM Open the Persons File
 2050 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2060 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2070 REM open the Marriages File
  2080 IF WHERE.LIST = 1 THEN OPEN "LISTMAR.CSV" FOR OUTPUT AS #3 :ELSE OPEN "scrn:" FOR OUTPUT AS #3
 2090 OPEN CC.MARRFILE$ AS #2 LEN = 128
 2100 FIELD 2, 5 AS M1$, 5 AS M2$, 5 AS M3$, 5 AS M4$, 11 AS M5$, 18 AS M6$, 16 AS M7$, 16 AS M8$, 45 AS M9$
 2110 REM Read the Marriage Records
 2120 KEY ON : CLS : KEY OFF : LOCATE 21,1
 2130 IF WHERE.LIST <> 1 THEN KEY ON : CLS : KEY OFF : GOTO 2160
 2140 COLOR W,K
 2150 PRINT "Listing the Records in the Marriages File"
 2160 FF = 0
 2170 GOSUB 2190
 2180 GOTO 2290
 2190 COLOR O,K
 2200 PRINT #3, "  List of the Records in the Marriages File  ";DATE$;"  ";TIME$
 2210 PRINT #3, " "
 2220 PRINT #3, "  REC   No.   MALE SPOUSE";
 2230 PRINT #3, TAB(42);" No.   FEMALE SPOUSE"
 2240 COLOR P,K
 2250 PRINT #3, "  ---   ----  --------------------------";
 2260 PRINT #3, TAB(42);" ----  --------------------------"
 2270 COLOR W,K
 2280 RETURN
 2290 REM Get all the records and print them
 2300 FOR I = START.MAR TO MAX.MAR
 2310  GET #2,I
 2320  REM verify if valid record
 2330  TT1! = CVS(M1$) : TT1 = TT1!
 2340  IF WHERE.LIST <> 1 THEN 2370
 2350  COLOR W,K
 2360  LOCATE 23,1 : PRINT "Listing Record:";  I;
 2370  IF TT1 < 1 THEN 2620
 2380  FF = FF + 1
 2390  COLOR W,K
 2400  PRINT #3, USING "#####"; TT1;
 2410  COLOR G,K
 2420  REM Male Spouse
 2430  TT2! = CVS(M2$) : TT2 = TT2!
 2440  IF TT2 = 0 THEN GOSUB 2750 :ELSE GET #1, TT2 : GOSUB 2640
 2450  REM Print the Male Spouse
 2460  PRINT #3, TAB(8);
 2470  COLOR W,K
 2480  PRINT #3, USING "#####"; TT2;
 2490  COLOR G,K
 2500  PRINT #3, LEFT$("  "+T2$+", "+T3$,28);
 2510  REM Female Spouse
 2520  TT3! = CVS(M3$) : TT3 = TT3!
 2530  IF TT3 = 0 THEN GOSUB 2750 :ELSE GET #1, TT3 : GOSUB 2640
 2540  REM Print the Female Spouse
 2550  PRINT #3, TAB(42);
 2560  COLOR W,K
 2570  PRINT #3, USING "#####"; TT3;
 2580  COLOR G,K
 2590  PRINT #3, LEFT$("  "+T2$+", "+T3$,28)
 2600  IF WHERE.LIST <> 1 THEN 2620
 2610  IF FF MOD 55 = 0 THEN PRINT #3, FORM.FEED$;: GOSUB 2190
 2620 NEXT I
 2630 GOTO 2800
 2640 REM Routine to Extract Personal Information
 2650 T1! = CVS(F1$) : T1 = T1!
 2660 T2$ = F2$
 2670 FOR J = 1 TO LEN(F2$) -1
 2680  IF RIGHT$(T2$,1)=" " THEN T2$ = LEFT$(T2$,LEN(T2$)-1) :ELSE J = LEN(F2$)-1
 2690 T3$ = F3$
 2700 NEXT J
 2710 FOR J = 1 TO LEN(F3$) -1
 2720  IF RIGHT$(T3$,1)=" " THEN T3$ = LEFT$(T3$,LEN(T3$)-1) :ELSE J = LEN(F3$)-1
 2730 NEXT J
 2740 RETURN
 2750 REM Blank out a Record
 2760 T1 = 0
 2770 T2$ = ""
 2780 T3$ = ""
 2790 RETURN
 2800 IF WHERE.LIST <> 1 THEN 2830
 2810 PRINT #3, FORM.FEED$;
 2820 GOTO 2850
 2830 COLOR W,K : LOCATE 25,1 : PRINT "Press any key to continue";
 2840 A$ = INKEY$ : IF A$ = "" THEN 2840
 2850 CLOSE
 2860 KEY ON : CLS : KEY OFF : LOCATE 21,1
 2870 PRINT "End of Program"
 2880 RUN CC.MENU$
