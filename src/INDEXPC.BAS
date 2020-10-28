  100 REM INDEXPC Program
  110 REM Forms the Parent/Child Index
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Prepare the Parent/Child Index"
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
  920 MAX.STACK = 2*INT(SQR(MAX.PER)+1)
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
 2000 REM INDEXPC Program Starts Here
 2010 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2020 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2030 REM Read all records, and count the parents.
 2040 KEY ON : CLS : KEY OFF
 2050 LOCATE 9,1 : PRINT "Counting the number of Actual Parents";
 2060 FOR I = 1 TO MAX.PER
 2070  GET #1, I
 2080  LOCATE 10,1 : PRINT "Processing Person Record:"; I;
 2090  REM Extract information from the file
 2100  T1! = CVS(F1$) : T1 = T1! 'Child-id
 2110  IF T1 <> I THEN 2160
 2120  T6! = CVS(F6$) : T6 = T6!
 2130  T7! = CVS(F7$) : T7 = T7!
 2140  IF T6 <> 0 AND T7 <> 0 THEN PC.COUNT = PC.COUNT + 2 : GOTO 2160
 2150  IF T6 <> 0  OR T7 <> 0 THEN PC.COUNT = PC.COUNT + 1
 2160 NEXT I
 2170 '
 2180 LOCATE 12,1 : PRINT "Reserving Index Space"
 2190 DIM PA.ID(PC.COUNT+1), CH.ID(PC.COUNT+1), B.DATE!(PC.COUNT+1)
 2200 '
 2210 REM Read all records, and create the index.
 2220 C = 0
 2230 LOCATE 14,1 : PRINT "Forming Parent/Child Index Records";
 2240 FOR I = 1 TO MAX.PER
 2250  GET #1, I
 2260  LOCATE 15,1 : PRINT "Processing Person Record:"; I;
 2270  REM Extract information from the file
 2280  T1! = CVS(F1$) : T1 = T1! 'Child-id
 2290  IF T1! <> I THEN 2620
 2300  T6! = CVS(F6$) : T6 = T6! 'Father-id
 2310  T7! = CVS(F7$) : T7 = T7! 'Mother-id
 2320  T8$ = F8$  'Birthdate as dd mmm yyyy
 2330  IF T8$ = "           " THEN BD! = 0 : GOTO 2500
 2340  REM convert Birthdate
 2350  BD! = VAL(RIGHT$(T8$,4))*10000!
 2360  MO$ = MID$(T8$,4,3)
 2370  IF MO$ = "Jan" THEN BD! = BD! +  100 : GOTO 2490
 2380  IF MO$ = "Feb" THEN BD! = BD! +  200 : GOTO 2490
 2390  IF MO$ = "Mar" THEN BD! = BD! +  300 : GOTO 2490
 2400  IF MO$ = "Apr" THEN BD! = BD! +  400 : GOTO 2490
 2410  IF MO$ = "May" THEN BD! = BD! +  500 : GOTO 2490
 2420  IF MO$ = "Jun" THEN BD! = BD! +  600 : GOTO 2490
 2430  IF MO$ = "Jul" THEN BD! = BD! +  700 : GOTO 2490
 2440  IF MO$ = "Aug" THEN BD! = BD! +  800 : GOTO 2490
 2450  IF MO$ = "Sep" THEN BD! = BD! +  900 : GOTO 2490
 2460  IF MO$ = "Oct" THEN BD! = BD! + 1000 : GOTO 2490
 2470  IF MO$ = "Nov" THEN BD! = BD! + 1100 : GOTO 2490
 2480  IF MO$ = "Dec" THEN BD! = BD! + 1200 : GOTO 2490
 2490  BD! = BD! + VAL(LEFT$(T8$,2))
 2500  REM create the father/child index record
 2510  IF T6 = 0 THEN 2560  'skip if zero
 2520  C = C + 1
 2530  CH.ID(C) = T1
 2540  PA.ID(C) = T6
 2550  B.DATE!(C) = BD!
 2560  REM create the mother/child index record
 2570  IF T7 = 0 THEN 2620  'skip if zero
 2580  C = C + 1
 2590  CH.ID(C) = T1
 2600  PA.ID(C) = T7
 2610  B.DATE!(C) = BD!
 2620 NEXT I
 2630 CLOSE #1
 2640 LOCATE 17,1 : PRINT "There are:"; C; "Index Records"
 2650 PRINT "Sort the Index Records into ascending sequence"
 2660 REM ***  QUICKSORT Begins Here ***
 2670 '
 2680 REM Establish Initial Constants
 2690 PA.ID(C+1) = 32766      'Maximum Integer in BASIC
 2700 K1 = 0
 2710 K2 = C
 2720 K3 = 0
 2730 LOCATE 20,1 : PRINT "Stack size:";
 2740 LOCATE 20,15 : PRINT K3;
 2750 '
 2760 REM
 2770 IF K1 >= K2 THEN 3370
 2780 '
 2790 REM
 2800 J = K2 + 1
 2810 I = K1
 2820 K5 = INT((K2-K1)/2) + K1
 2830 K4  = PA.ID(K5)
 2840 XK4! = B.DATE!(K5)
 2850 YK4 = CH.ID(K5)
 2860 PA.ID(K5)  = PA.ID(K1)
 2870 B.DATE!(K5)= B.DATE!(K1)
 2880 CH.ID(K5)  = CH.ID(K1)
 2890 PA.ID(K1)  = K4
 2900 B.DATE!(K1)= XK4!
 2910 CH.ID(K1)  = YK4
 2920 '
 2930 REM Increment I
 2940 I = I + 1
 2950 IF PA.ID(I) < K4 THEN 2930
 2960 IF PA.ID(I) = K4  AND B.DATE!(I) < XK4! THEN 2930
 2970 '
 2980 REM Decrement J
 2990 J = J - 1
 3000 IF PA.ID(J) > K4 THEN 2980
 3010 IF PA.ID(J) = K4 AND B.DATE!(J) > XK4! THEN 2980
 3020 '
 3030 REM Compare I and J
 3040 IF J <= I THEN 3120
 3050 '
 3060 REM Interchange Elements
 3070 SWAP PA.ID(I),   PA.ID(J)
 3080 SWAP B.DATE!(I), B.DATE!(J)
 3090 SWAP CH.ID(I),   CH.ID(J)
 3100 GOTO 2930
 3110 '
 3120 REM Interchange and Test
 3130 PA.ID(K1)  = PA.ID(J)
 3140 B.DATE!(K1)= B.DATE!(J)
 3150 CH.ID(K1)  = CH.ID(J)
 3160 PA.ID(J)   = K4
 3170 B.DATE!(J) = XK4!
 3180 CH.ID(J)   = YK4
 3190 IF J-K1 < K2-J THEN 3270
 3200 '
 3210 REM Change the Stack Array
 3220 STACK(K3+1) = K1
 3230 STACK(K3+2) = J - 1
 3240 K1 = J + 1
 3250 GOTO 3320
 3260 '
 3270 REM Change the Stack Array
 3280 STACK(K3+1) = J + 1
 3290 STACK(K3+2) = K2
 3300 K2 = J - 1
 3310 '
 3320 REM Increment K3 by 2
 3330 K3 = K3 + 2
 3340 LOCATE 20,15 : PRINT K3;
 3350 GOTO 2760
 3360 '
 3370 REM Test for Sort Complete
 3380 IF K3 = 0 THEN 3470
 3390 '
 3400 REM Remove from Stack
 3410 K2 = STACK(K3)
 3420 K1 = STACK(K3-1)
 3430 K3 = K3 - 2
 3440 LOCATE 20,15 : PRINT K3;
 3450 GOTO 2760
 3460 '
 3470 REM Sort is Complete
 3480 '
 3490 REM Write the Parent/Child Index
 3500 LOCATE 22,1 : PRINT "Writing the Parent/Child Index"
 3510 OPEN CC.PCINDEX$ FOR OUTPUT AS #2
 3520 WRITE #2,C
 3530 FOR I = 1 TO C
 3540  WRITE #2, PA.ID(I)
 3550  WRITE #2, CH.ID(I)
 3560 NEXT I
 3570 CLOSE
 3580 PRINT "End of Program"
 3590 RUN CC.MENU$
