  100 REM ALPHAMAR Program.
  110 REM Prints an Alphabetic List of Marriages
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Alphabetic List of Marriages"
  620 TITLE$ = TITLE$ + " ON DISPLAY"
  700 REM Terminate if not called from the Menu
  710 IF COPY2$ = "Melvin O. Duke" THEN 770
  720 COLOR 7,0 : KEY ON : CLS : LOCATE 15,1
  730 PRINT "Cannot run the"
  740 PRINT TITLE$
  750 PRINT "Program, unless selected from the MENU"
  760 END
  770 REM OK
  900 REM Dimension Statements
  910 DIM PERS.ID(2*MAX.MAR), MARR.ID(2*MAX.MAR), IDX$(2*MAX.MAR)
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
 2000 REM ALPHAMAR Program Starts Here.
 2010 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2020 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2030 IF WHERE.LIST = 1 THEN OPEN "lpt1:" FOR OUTPUT AS #3 :ELSE OPEN "scrn:" FOR OUTPUT AS #3
 2040 REM Read the Marriage Index and then the Person File
 2050 KEY ON : CLS : KEY OFF
 2060 LOCATE 7,1 : PRINT "Open the Marriage Index"
 2070 OPEN CC.MINDEX$ FOR INPUT AS #2
 2080 INPUT #2, CX
 2090 IF CX <> 0 THEN 2140
 2100 PRINT "Marriage Index has no Index Records"
 2110 PRINT "Press any key to return to the Menu"
 2120 A$ = INKEY$ : IF A$ = "" THEN 2120
 2130 GOTO 3220
 2140 LOCATE 19,1 : PRINT "There are:";CX;"Marriage Index Records"
 2150 C = 0
 2160 FOR I = 1 TO CX
 2170 C = C + 1
 2180  INPUT #2, PERS.ID(I), MARR.ID(I)
 2190  LOCATE 23,1 : PRINT "Processing Marriage Index Record:";I,"Freespace";FRE(0)
 2200  REM get the personal information
 2210  GET #1, PERS.ID(I)
 2220  REM Extract information from the file for use
 2230  T2$ = F2$
 2240  REM Convert to Upper Case
 2250  ONE$ = LEFT$(T2$,1)
 2260  ONE = ASC(ONE$)
 2270  IF ONE >= 97 AND ONE <= 122 THEN ONE = ONE - 32
 2280  ONE$ = CHR$(ONE)
 2290  REM Test if out of range
 2300  IF ONE$ < BEGIN.LTR$ OR ONE$ > END.LTR$ THEN 2430
 2310  REM Right-trim t2$
 2320  FOR J = 1 TO LEN(F2$) -1
 2330   IF RIGHT$(T2$,1)=" " THEN T2$=LEFT$(T2$,LEN(T2$)-1) :ELSE J=LEN(F2$)-1
 2340  NEXT J
 2350  T3$ = F3$
 2360  FOR J = 1 TO LEN(F3$) -1
 2370   IF RIGHT$(T3$,1)=" " THEN T3$=LEFT$(T3$,LEN(T3$)-1) :ELSE J=LEN(F3$)-1
 2380  NEXT J
 2390  PERS.ID(C) = PERS.ID(I)
 2400  MARR.ID(C) = MARR.ID(I)
 2410  IDX$(C) = T2$+" "+T3$+STR$(I)
 2420 C = C + 1
 2430 C = C - 1
 2440 NEXT I
 2450 LOCATE 23,1 : PRINT SPACE$(79)
 2460 REM Sort the index into ascending sequence
 2470 LOCATE 19,1 : PRINT SPACE$(79);
 2480 LOCATE 19,1 : PRINT "Sorting";C;"Records";
 2490 FOR I = 1 TO 6
 2500  B(I) = B(I-1)*4+1
 2510  IF B(I) <= C/2 THEN K1 = I
 2520 NEXT I
 2530 B(K1) = INT(C/5)+1
 2540 B(1) = 1
 2550 FOR I = K1 TO 1 STEP -1
 2560 LOCATE 23,1 : PRINT "Sorting Group:";I
 2570  K1 = B(I)
 2580  K2$ = SPACE$(1)
 2590  TEMP1 = 0
 2600  TEMP2 = 0
 2610  FOR J = K1 TO C
 2620   LOCATE 23,20 : PRINT "J:";J;
 2630   SWAP K2$, IDX$(J)
 2640   SWAP TEMP1, PERS.ID(J)
 2650   SWAP TEMP2, MARR.ID(J)
 2660   FOR K4 = J-K1 TO 0 STEP -K1
 2670   'LOCATE 23,30 : PRINT "Freespace:";FRE(0)
 2680    IF K2$ > IDX$(K4) THEN 2730
 2690    SWAP IDX$(K4+K1), IDX$(K4)
 2700    SWAP PERS.ID(K4+K1), PERS.ID(K4)
 2710    SWAP MARR.ID(K4+K1), MARR.ID(K4)
 2720   NEXT K4
 2730   SWAP IDX$(K4+K1), K2$
 2740   SWAP PERS.ID(K4+K1), TEMP1
 2750   SWAP MARR.ID(K4+K1), TEMP2
 2760  NEXT J
 2770 NEXT I
 2780 LOCATE 21,1
 2790 IF WHERE.LIST <> 1 THEN KEY ON : CLS : KEY OFF : GOTO 2820
 2800 COLOR W,K
 2810 PRINT "Printing the Alphabetical List"
 2820 GOSUB 2840
 2830 GOTO 2920
 2840 COLOR O,K
 2850 PRINT #3, "   Alphabetic Listing of the Marriages File   ";DATE$;"   ";TIME$
 2860 PRINT #3, " "
 2870 PRINT #3, "  REC    SURNAME              GIVEN-NAMES";TAB(62);"BIRTHDATE"
 2880 COLOR P,K
 2890 PRINT #3, " ----    -------------------  -----------------------------";
 2900 PRINT #3, TAB(62);"-----------"
 2910 RETURN
 2920 REM Read all records, and print the actual ones
 2930 FF = 0
 2940 IF WHERE.LIST <> 1 THEN 2970
 2950 LOCATE 24,1 : PRINT SPACE$(79);
 2960 LOCATE 23,1 : PRINT SPACE$(79);
 2970 FOR I = 1 TO C
 2980  GET #1, ABS(PERS.ID(I))
 2990  IF WHERE.LIST <> 1 THEN 3020
 3000  COLOR W,K
 3010  LOCATE 23,1 : PRINT "Printing Record:"; I, "Freespace:";FRE(0)
 3020  REM Print the information in Alphabetical Order.
 3030  T1! = CVS(F1$) : T1 = T1!
 3040  IF T1 < 1 THEN 3150
 3050  FF = FF + 1
 3060  T2$ = F2$
 3070  T3$ = F3$
 3080  T8$ = F8$
 3090  COLOR W,K
 3100  PRINT #3, USING "#####";MARR.ID(I);
 3110  COLOR G,K
 3120  PRINT #3, TAB(10); T2$; " "; T3$; TAB(62); T8$
 3130  IF WHERE.LIST <> 1 THEN 3150
 3140  IF FF MOD 55 = 0 THEN PRINT #3, FORM.FEED$;: GOSUB 2840
 3150 NEXT I
 3160 IF WHERE.LIST <> 1 THEN PRINT #3, " ": PRINT #3, " ": GOTO 3190
 3170 PRINT #3, FORM.FEED$;
 3180 KEY ON : CLS : KEY OFF
 3190 COLOR W,K : LOCATE 24,1 : PRINT "y (yes) or n (no)";
 3200 LOCATE 23,1 : INPUT "Would you like another copy"; REPLY$
 3210 IF LEFT$(REPLY$,1) = "y" OR LEFT$(REPLY$,1) = "Y" THEN 2780
 3220 CLOSE
 3230 KEY ON : CLS : KEY OFF : LOCATE 21,1
 3240 PRINT "End of Program
 3250 RUN CC.MENU$
