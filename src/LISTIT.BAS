  100 REM LISTPER Program.
  110 REM Prints a List of Persons
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "List the Persons File"
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
 2000 REM LISTPER Program Starts Here
 2010 REM Prevent common users errors
 2020 IF START.PER < 1 THEN START.PER = 1
 2030 IF START.PER > MAX.PER THEN START.PER = MAX.PER
 2040 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2050 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2060 IF WHERE.LIST = 1 THEN OPEN "lpt1:" FOR OUTPUT AS #3 :ELSE OPEN "scrn:" FOR OUTPUT AS #3
 2070 REM Read all records, and print the actual ones
 2080 FF = 0
 2090 IF WHERE.LIST <> 1 THEN 2130
 2100 KEY ON : CLS : KEY OFF : LOCATE 21,1
 2110 COLOR W,K
 2120 PRINT "Printing a List of Records in the Persons File"
 2130 GOSUB 2150
 2140 GOTO 2230
 2150 COLOR O,K
 2160 PRINT #3, "       List of the Records in the Persons File  ";DATE$;"  ";TIME$
 2170 PRINT #3, " "
 2180 PRINT #3, "     REC GIVEN NAMES-SURNAME";TAB(50);"BIRTHDATE    FATHER  MOTHER
 2190 COLOR P,K
 2200 PRINT #3, "     --- -------------------";TAB(50);"-----------  ------  ------
 2210 COLOR W,K
 2220 RETURN
 2230 REM Get all the records and print them
 2240 FOR I = START.PER TO MAX.PER
 2250 GET #1, I
 2260 IF WHERE.LIST <> 1 THEN 2290
 2270 COLOR W,K
 2280 LOCATE 23,1 : PRINT "Printing Record:";I
 2290 REM Extract information from the file for use
 2300 T1! = CVS(F1$) : T1 = T1!
 2310 IF T1 < 1 THEN 2540
 2320 FF = FF + 1
 2330 T2$ = F2$
 2340 FOR J = 1 TO LEN(F2$)-1
 2350  IF RIGHT$(T2$,1)=" "THEN T2$ = LEFT$(T2$,LEN(T2$)-1) :ELSE J = LEN(F2$)-1
 2360 NEXT J
 2370 T3$ = F3$
 2380 FOR J = 1 TO LEN(F3$)-1
 2390  IF RIGHT$(T3$,1)=" "THEN T3$ = LEFT$(T3$,LEN(T3$)-1) :ELSE J = LEN(F3$)-1
 2400 NEXT J
 2410 T6! = CVS(F6$) : T6 = T6!
 2420 T7! = CVS(F7$) : T7 = T7!
 2430 T8$ = F8$
 2440 COLOR W,K
 2450 PRINT #3, USING "########";T1;
 2460 COLOR G,K
 2470 PRINT #3, " "; LEFT$(T3$+" "+T2$,39); TAB(50); T8$;
 2480 COLOR W,K
 2490 PRINT #3, USING " ######  ######";T6, T7
 2500 COLOR G,K
 2510 IF WHERE.LIST <> 1 THEN 2540
 2520 IF FF MOD 55 = 0 THEN PRINT #3, FORM.FEED$;: GOSUB 2150
 2530 COLOR W,K
 2540 NEXT I
 2550 IF WHERE.LIST <> 1 THEN 2580
 2560 PRINT #3, FORM.FEED$;
 2570 GOTO 2600
 2580 COLOR W,K : LOCATE 25,1 : PRINT "Press any key to continue";
 2590 A$ = INKEY$ : IF A$ = "" THEN 2590
 2600 CLOSE
 2610 KEY ON : CLS : KEY OFF : LOCATE 21,1
 2620 PRINT "End of Program"
 2630 RUN CC.MENU$
