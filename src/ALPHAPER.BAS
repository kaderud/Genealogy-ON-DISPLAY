  100 REM ALPHAPER Program.
  110 REM Prints an Alphabetic List of Persons
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Alphabetic Person Name Listing"
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
  910 DIM IDX$(MAX.PER), WHERE(MAX.PER)
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
 2000 REM ALPHAPER Program Starts Here.
 2010 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2020 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2030 IF WHERE.LIST = 1 THEN OPEN "lpt1:" FOR OUTPUT AS #3 :ELSE OPEN "scrn:" FOR OUTPUT AS #3
 2040 KEY ON : CLS : KEY OFF
 2050 REM Read all records, and print the actual ones
 2060 N.ACT = 1
 2070 FOR I = 1 TO MAX.PER
 2080 GET #1, I
 2090 LOCATE 23,1 : PRINT "Processing Record:";I,"Freespace:";FRE(0)
 2100 REM Extract Information from the File
 2110  TEMP! = CVS(F1$) : WHERE(N.ACT) = TEMP!
 2120  IF WHERE(N.ACT) < 1 THEN 2480
 2130  T2$ = F2$  'Surname
 2140  REM Convert to Upper Case
 2150  ONE$ = LEFT$(T2$,1)
 2160  ONE = ASC(ONE$)
 2170  IF ONE >= 97 AND ONE <= 122 THEN ONE = ONE - 32
 2180  ONE$ = CHR$(ONE)
 2190  REM Test if out of range
 2200  IF ONE$ < BEGIN.LTR$ OR ONE$ > END.LTR$ THEN 2480
 2210  REM Right-trim t2$
 2220  FOR J = 1 TO LEN(F2$)-1
 2230   IF RIGHT$(T2$,1)=" "THEN T2$=LEFT$(T2$,LEN(T2$)-1) :ELSE J=LEN(F2$)-1
 2240  NEXT J
 2250  T3$ = F3$  'Given Names
 2260  REM Right-trim t3$
 2270  FOR J = 1 TO LEN(F3$)-1
 2280   IF RIGHT$(T3$,1)=" "THEN T3$=LEFT$(T3$,LEN(T3$)-1) :ELSE J=LEN(F3$)-1
 2290  NEXT J
 2300  T8$ = F8$  'Birthdate
 2310  REM convert to yyyymmdd
 2320  TEMP$ = RIGHT$(T8$,4)
 2330  IF MID$(T8$,4,3)="Jan" THEN TEMP$=TEMP$+"01"
 2340  IF MID$(T8$,4,3)="Feb" THEN TEMP$=TEMP$+"02"
 2350  IF MID$(T8$,4,3)="Mar" THEN TEMP$=TEMP$+"03"
 2360  IF MID$(T8$,4,3)="Apr" THEN TEMP$=TEMP$+"04"
 2370  IF MID$(T8$,4,3)="May" THEN TEMP$=TEMP$+"05"
 2380  IF MID$(T8$,4,3)="Jun" THEN TEMP$=TEMP$+"06"
 2390  IF MID$(T8$,4,3)="Jul" THEN TEMP$=TEMP$+"07"
 2400  IF MID$(T8$,4,3)="Aug" THEN TEMP$=TEMP$+"08"
 2410  IF MID$(T8$,4,3)="Sep" THEN TEMP$=TEMP$+"09"
 2420  IF MID$(T8$,4,3)="Oct" THEN TEMP$=TEMP$+"10"
 2430  IF MID$(T8$,4,3)="Nov" THEN TEMP$=TEMP$+"11"
 2440  IF MID$(T8$,4,3)="Dec" THEN TEMP$=TEMP$+"12"
 2450  TEMP$=TEMP$+LEFT$(T8$,2)  'add day
 2460  IDX$(N.ACT) = T2$+" "+T3$+TEMP$
 2470  N.ACT = N.ACT + 1
 2480 NEXT I
 2490 N.ACT = N.ACT - 1
 2500 LOCATE 23,1 : PRINT SPACE$(79)
 2510 REM Sort the index into ascending sequence
 2520 KEY ON : CLS : KEY OFF
 2530 FOR I = 1 TO 6
 2540  B(I) = B(I-1)*4+1
 2550  IF B(I) <= N.ACT/2 THEN K1 = I
 2560 NEXT I
 2570 B(K1) = INT(N.ACT/5) +1
 2580 B(1) = 1
 2590 LOCATE 21,1 : PRINT "Total Records:";N.ACT;
 2600 FOR I = K1 TO 1 STEP -1
 2610  LOCATE 23,1 : PRINT "Sorting Group:";I
 2620  K1 = B(I)
 2630  K2$ = SPACE$(1)
 2640  K3 = 0
 2650  FOR J = K1 TO N.ACT
 2660   LOCATE 23,20 : PRINT "J:";J;
 2670   SWAP K2$, IDX$(J)
 2680   SWAP K3, WHERE(J)
 2690   FOR K4 = J-K1 TO 0 STEP -K1
 2700   'LOCATE 23,30 : PRINT "Freespace:";FRE(0)
 2710    IF K2$ >= IDX$(K4) THEN 2750
 2720    SWAP IDX$(K4+K1), IDX$(K4)
 2730    SWAP WHERE(K4+K1), WHERE(K4)
 2740   NEXT K4
 2750   SWAP IDX$(K4+K1), K2$
 2760   SWAP WHERE(K4+K1), K3
 2770  NEXT J
 2780 NEXT I
 2790 LOCATE 24,1 : PRINT SPACE$(79);
 2800 LOCATE 23,1 : PRINT SPACE$(79);
 2810 LOCATE 23,1
 2820 IF WHERE.LIST <> 1 THEN KEY ON : CLS : KEY OFF : GOTO 2850
 2830 COLOR W,K
 2840 PRINT "Printing the Alphabetical List"
 2850 GOSUB 2870
 2860 GOTO 2950
 2870 COLOR O,K
 2880 PRINT #3, "     Alphabetic Listing of the Persons File   ";DATE$;"  ";TIME$
 2890 PRINT #3, " "
 2900 PRINT #3, "  REC    SURNAME              GIVEN-NAMES";TAB(62);"BIRTHDATE"
 2910 COLOR P,K
 2920 PRINT #3, " ----    -------------------  -----------------------------";
 2930 PRINT #3, TAB(62);"-----------"
 2940 RETURN
 2950 REM Read all records, and print the actual ones
 2960 FF = 0
 2970 IF WHERE.LIST <> 1 THEN 3010
 2980 KEY ON : CLS : KEY OFF
 2990 COLOR W,K
 3000 LOCATE 21,1 : PRINT "There are";N.ACT;"records."
 3010 FOR I = 1 TO N.ACT
 3020  GET #1, ABS(WHERE(I))
 3030  IF WHERE.LIST <> 1 THEN 3060
 3040  COLOR W,K
 3050  LOCATE 23,1 : PRINT "Printing Record:"; I, "Freespace:";FRE(0)
 3060  REM Print the information in Alphabetical Order.
 3070  T1 = CVS(F1$)
 3080  IF T1 < 1 THEN 3190
 3090  FF = FF + 1
 3100  T2$ = F2$
 3110  T3$ = F3$
 3120  T8$ = F8$
 3130  IF WHERE.LIST <> 1 THEN 3150
 3140  IF FF MOD 55 = 0 THEN PRINT #3, FORM.FEED$;: GOSUB 2870
 3150  COLOR W,K
 3160  PRINT #3, USING "#####";T1,
 3170  COLOR G,K
 3180  PRINT #3, TAB(10); T2$; " "; T3$; TAB(62); T8$
 3190 NEXT I
 3200 IF WHERE.LIST <> 1 THEN PRINT #3, " ": PRINT #3, " ": GOTO 3230
 3210 PRINT #3, FORM.FEED$;
 3220 KEY ON : CLS : KEY OFF
 3230 COLOR W,K : LOCATE 24,1 : PRINT "y (yes) or n (no)";
 3240 LOCATE 23,1 : INPUT "Would you like another copy"; REPLY$
 3250 IF LEFT$(REPLY$,1) = "y" OR LEFT$(REPLY$,1) = "Y" THEN 2790
 3260 CLOSE
 3270 KEY ON : CLS : KEY OFF : LOCATE 21,1
 3280 PRINT "End of Program"
 3290 RUN CC.MENU$
