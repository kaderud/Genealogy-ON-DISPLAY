  100 REM PRINTMAR Program.
  110 REM Prints Detailed Marriage Information
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Print the Marriages File"
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
 2000 REM PRINTMAR Program Starts Here
 2010 REM Prevent common user errors
 2020 IF START.MAR < 1 THEN START.MAR = 1
 2030 IF START.MAR > MAX.MAR THEN START.MAR = MAX.MAR
 2040 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2050 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2060 OPEN CC.MARRFILE$ AS #2 LEN = 128
 2070 FIELD 2, 5 AS M1$, 5 AS M2$, 5 AS M3$, 5 AS M4$, 11 AS M5$, 18 AS M6$, 16 AS M7$, 16 AS M8$, 45 AS M9$
 2071 IF WHERE.LIST = 1 THEN OPEN "PRINTMAR.CSV" FOR OUTPUT AS #3 :ELSE OPEN "scrn:" FOR OUTPUT AS #3
 2080 REM Determine User Wants
 2090 KEY ON : CLS : KEY OFF : LOCATE 21,1
 2091 PRINT #3, "ID,Male Spouse ID,Male Spouse Name,Female Spouse ID,Female Spouse Name,Marriage Date,Marriage City,Marriage County,Marriage State,Comments"
 2100 PRINT "Enter the Marriage Number to be Printed (0 to quit), or 'all': ";
 2110 LINE INPUT REPLY$
 2120 IF REPLY$ = "0" THEN 2930
 2130 FF = 0
 2140 GOTO 2190
 2150 rem PRINT header
 2170 rem LPRINT
 2180 RETURN
 2190 IF LEFT$(REPLY$,1) = "a" OR LEFT$(REPLY$,1) = "A" THEN 2250
 2200 FF = 4
 2210 I = VAL(REPLY$)
 2220 IF I < 1 OR I > MAX.MAR THEN KEY ON : CLS : KEY OFF : LOCATE 20,1 : PRINT "Number is out of range"; : GOTO 2100
 2230 GOSUB 2150
 2240 GOSUB 2300 : GOTO 2090
 2250 REM Read all records, and print the actual ones
 2260 FOR I = START.MAR TO MAX.MAR
 2270 LOCATE 22,1 : PRINT "Processing Record";I;
 2280 GOSUB 2300
 2290 GOTO 2860
 2300 GET #2, I
 2310 REM Extract information from the file for use
 2320 T1! = CVS(M1$) : T1 = T1!
 2330 IF T1 < 1 THEN 2850
 2340 FF = FF + 1
 2350 IF FF MOD 5 = 1 THEN GOSUB 2150
 2360 T2! = CVS(M2$) : T2 = T2!
 2370 T3! = CVS(M3$) : T3 = T3!
 2380 T4! = CVS(M4$)
 2390 T5$ = M5$
 2400 T6$ = M6$
 2410 T7$ = M7$
 2420 T8$ = M8$
 2430 T9$ = M9$
 2440 REM Obtain the name of the Male Spouse
 2450 GET #1, T2
 2460 REM Obtain the last and given names
 2470 TEMP$ = F2$   'Male Spouse`s last name
 2480 TMP$ = F2$
 2490 GOSUB 2880
 2500 TT2$ = TMP$
 2510 TEMP$ = F3$   'Male Spouse's given names
 2520 TMP$ = F3$
 2530 GOSUB 2880
 2540 TT3$ = TMP$
 2550 REM Obtain the name of the Female Spouse
 2560 GET #1, T3
 2570 REM Obtain the last and given names
 2580 TEMP$ = F2$   'Female Spouse`s last name
 2590 TMP$ = F2$
 2600 GOSUB 2880
 2610 TT4$ = TMP$
 2620 TEMP$ = F3$   'Female Spouse's given names
 2630 TMP$ = F3$
 2640 GOSUB 2880
 2650 TT5$ = TMP$
 2660 REM Now Print the Information
 2670 rem PRINT #3, TAB(10);"Marriage Record-number : ";
 2680 rem PRINT #3, USING "####"; T1
 2681 PRINT #3, T1;",";T2;",";TT3$+" "+TT2$;",";T3;",";TT5$+" "+TT4$;
 2690 rem PRINT #3, TAB(10);"Male Spouse            : ";
 2700 rem PRINT #3, USING "####"; T2;
 2710 rem PRINT #3, TAB(42); LEFT$(TT2$+", "+TT3$,37)
 2720 rem PRINT #3, TAB(10);"Female Spouse          : ";
 2730 rem PRINT #3, USING "####"; T3;
 2740 rem PRINT #3, TAB(42); LEFT$(TT4$+", "+TT5$,37)
 2750 IF CODE$ = "no" THEN 2771
 2760 rem PRINT #3, TAB(10);"Marriage-code          : ";T4!
 2761 PRINT #3, ",";T4!;
 2770 rem PRINT #3, TAB(10);"Marriage-date          : ";T5$
 2771 PRINT #3, ",";T5$;",";T6$;",";T7$;",";T8$;","CHR$(34);T9$;CHR$(34)
 2780 rem PRINT #3, TAB(10);"Marriage-city          : ";T6$
 2790 rem PRINT #3, TAB(10);"Marriage-county        : ";T7$
 2800 rem PRINT #3, TAB(10);"Marriage-state         : ";T8$
 2810 rem PRINT #3, TAB(10);"Comments: ";T9$
 2820 rem IF CODE$ = "no" THEN PRINT #3, ""
 2830 rem PRINT #3, "" : PRINT #3, ""
 2850 RETURN
 2860 NEXT I
 2870 GOTO 2930
 2880 REM rtrim$ subroutine
 2890 FOR J = 1 TO LEN(TEMP$)-1
 2900  IF RIGHT$(TMP$,1)=" " THEN TMP$ = LEFT$(TMP$,LEN(TMP$)-1) :ELSE J = LEN(TEMP$)-1
 2910 NEXT J
 2920 RETURN
 2930 CLOSE #1
 2940 KEY ON : CLS : KEY OFF : LOCATE 21,1
 2960 IF (LEFT$(REPLY$,1) = "a" OR LEFT$(REPLY$,1) = "A") AND FF MOD 5 <> 0 THEN 2970 :ELSE 2980
 2970 rem FORMFEED
 2980 RUN CC.MENU$
