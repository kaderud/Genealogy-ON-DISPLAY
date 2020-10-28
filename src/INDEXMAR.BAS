  100 REM INDEXMAR Program
  110 REM Forms the Marriages Index
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Prepare the Marriages Index"
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
  920 MAX.STACK = 2*INT(SQR(MAX.MAR)+1)
  930 IF MAX.STACK < 10 THEN MAX.STACK = 10
  940 DIM STACK(MAX.STACK)
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
 2000 REM INDEXMAR Program Starts Here
 2010 OPEN CC.MARRFILE$ AS #2 LEN = 128
 2020 FIELD 2, 5 AS M1$, 5 AS M2$, 5 AS M3$, 5 AS M4$, 11 AS M5$, 18 AS M6$, 16 AS M7$, 16 AS M8$, 45 AS M9$
 2030 REM Read all records, and count the actual marriages
 2040 KEY ON : CLS : KEY OFF
 2050 LOCATE 9,1 : PRINT "Counting the number of actual marriages";
 2060 FOR I = 1 TO MAX.MAR
 2070  GET #2, I
 2080  LOCATE 10,1 : PRINT "Processing Marriage Record:"; I;
 2090  REM Extract information from the file
 2100  T1! = CVS(M1$) : T1 = T1! 'Marriage-id
 2110  IF T1 <> I THEN 2150
 2120  T2! = CVS(M2$) : T2 = T2! 'Husband-id
 2130  T3! = CVS(M3$) : T3 = T3! 'Wife-id
 2140  IF T2 <> 0 AND T3 <> 0 THEN M.COUNT = M.COUNT + 1
 2150 NEXT I
 2160 '
 2170 LOCATE 12,1 : PRINT "Reserving Index Space"
 2180 DIM REC.NO(2*M.COUNT+1), PERS.ID(2*M.COUNT+1), M.DATE!(2*M.COUNT+1)
 2190 '
 2200 REM Read all records, and create the index.
 2210 C = 0
 2220 LOCATE 14,1 : PRINT "Forming Marriage Index Records";
 2230 FOR I = 1 TO MAX.MAR
 2240  GET #2, I
 2250  LOCATE 15,1 : PRINT "Processing Marriage Record:"; I;
 2260  REM Extract information from the file
 2270  T1! = CVS(M1$) : T1 = T1! 'Marriage-id
 2280  IF T1 <> I THEN 2610
 2290  T2! = CVS(M2$) : T2 = T2! 'Husband-id
 2300  T3! = CVS(M3$) : T3 = T3! 'Wife-id
 2310  T5$ = M5$  'Marriage-date as dd mmm yyyy
 2320  IF T5$ = "           " THEN MD! = 0 : GOTO 2490
 2330  REM convert Marriage Date
 2340  MD! = VAL(RIGHT$(T5$,4))*10000!
 2350  MO$ = MID$(T5$,4,3)
 2360  IF MO$ = "Jan" THEN MD! = MD! +  100 : GOTO 2480
 2370  IF MO$ = "Feb" THEN MD! = MD! +  200 : GOTO 2480
 2380  IF MO$ = "Mar" THEN MD! = MD! +  300 : GOTO 2480
 2390  IF MO$ = "Apr" THEN MD! = MD! +  400 : GOTO 2480
 2400  IF MO$ = "May" THEN MD! = MD! +  500 : GOTO 2480
 2410  IF MO$ = "Jun" THEN MD! = MD! +  600 : GOTO 2480
 2420  IF MO$ = "Jul" THEN MD! = MD! +  700 : GOTO 2480
 2430  IF MO$ = "Aug" THEN MD! = MD! +  800 : GOTO 2480
 2440  IF MO$ = "Sep" THEN MD! = MD! +  900 : GOTO 2480
 2450  IF MO$ = "Oct" THEN MD! = MD! + 1000 : GOTO 2480
 2460  IF MO$ = "Nov" THEN MD! = MD! + 1100 : GOTO 2480
 2470  IF MO$ = "Dec" THEN MD! = MD! + 1200 : GOTO 2480
 2480  MD! = MD! + VAL(LEFT$(T5$,2))
 2490  REM create the male spouse's index record
 2500  IF T2 = 0 THEN 2550  'skip if zero
 2510  C = C + 1
 2520  REC.NO(C) = T1
 2530  PERS.ID(C) = T2
 2540  M.DATE!(C) = MD!
 2550  REM create the female spouse's index record
 2560  IF T3 = 0 THEN 2610  'skip if zero
 2570  C = C + 1
 2580  REC.NO(C) = T1
 2590  PERS.ID(C) = T3
 2600  M.DATE!(C) = MD!
 2610 NEXT I
 2620 CLOSE #2
 2630 LOCATE 17,1 : PRINT "There are:"; C; "Index Records"
 2640 PRINT "Sort the Index Records into ascending sequence"
 2650 REM ***  MQUIKSOR Begins Here ***
 2660 '
 2670 REM Establish Initial Constants
 2680 PERS.ID(C+1) = 32766      'Maximum Integer in BASIC
 2690 K1 = 0
 2700 K2 = C
 2710 K3 = 0
 2720 LOCATE 20,1 : PRINT "Stack size:";
 2730 LOCATE 20,15 : PRINT K3;
 2740 '
 2750 REM
 2760 IF K1 >= K2 THEN 3360
 2770 '
 2780 REM
 2790 J = K2 + 1
 2800 I = K1
 2810 K5   = INT((K2-K1)/2) + K1
 2820 K4   = PERS.ID(K5)
 2830 XK4! = M.DATE!(K5)
 2840 YK4  = REC.NO(K5)
 2850 PERS.ID(K5) = PERS.ID(K1)
 2860 M.DATE!(K5) = M.DATE!(K1)
 2870 REC.NO(K5)  = REC.NO(K1)
 2880 PERS.ID(K1) = K4
 2890 M.DATE!(K1) = XK4!
 2900 REC.NO(K1)  = YK4
 2910 '
 2920 REM Increment I
 2930 I = I + 1
 2940 IF PERS.ID(I) < K4 THEN 2920
 2950 IF PERS.ID(I) = K4  AND M.DATE!(I) < XK4! THEN 2920
 2960 '
 2970 REM Decrement J
 2980 J = J - 1
 2990 IF PERS.ID(J) > K4 THEN 2970
 3000 IF PERS.ID(J) = K4 AND M.DATE!(J) > XK4! THEN 2970
 3010 '
 3020 REM Compare I and J
 3030 IF J <= I THEN 3110
 3040 '
 3050 REM Interchange Elements
 3060 SWAP PERS.ID(I), PERS.ID(J)
 3070 SWAP M.DATE!(I), M.DATE!(J)
 3080 SWAP REC.NO(I),  REC.NO(J)
 3090 GOTO 2920
 3100 '
 3110 REM Interchange and Test
 3120 PERS.ID(K1) = PERS.ID(J)
 3130 M.DATE!(K1) = M.DATE!(J)
 3140 REC.NO(K1)  = REC.NO(J)
 3150 PERS.ID(J)  = K4
 3160 M.DATE!(J)  = XK4!
 3170 REC.NO(J)   = YK4
 3180 IF J-K1 < K2-J THEN 3260
 3190 '
 3200 REM Change the Stack Array
 3210 STACK(K3+1) = K1
 3220 STACK(K3+2) = J - 1
 3230 K1 = J + 1
 3240 GOTO 3310
 3250 '
 3260 REM Change the Stack Array
 3270 STACK(K3+1) = J + 1
 3280 STACK(K3+2) = K2
 3290 K2 = J - 1
 3300 '
 3310 REM Increment K3 by 2
 3320 K3 = K3 + 2
 3330 LOCATE 20,15 : PRINT K3;
 3340 GOTO 2750
 3350 '
 3360 REM Test for Sort Complete
 3370 IF K3 = 0 THEN 3460
 3380 '
 3390 REM Remove from Stack
 3400 K2 = STACK(K3)
 3410 K1 = STACK(K3-1)
 3420 K3 = K3 - 2
 3430 LOCATE 20,15 : PRINT K3;
 3440 GOTO 2750
 3450 '
 3460 REM Sort is Complete
 3470 '
 3480 REM Write the Marriage Index
 3490 LOCATE 22,1 : PRINT "Writing the Marriage Index"
 3500 OPEN CC.MINDEX$ FOR OUTPUT AS #3
 3510 WRITE #3,C
 3520 FOR I = 1 TO C
 3530  WRITE #3, PERS.ID(I)
 3540  WRITE #3, REC.NO(I)
 3550 NEXT I
 3560 CLOSE
 3570 PRINT "End of Program"
 3580 RUN CC.MENU$
