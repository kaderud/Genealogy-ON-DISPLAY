  100 REM FAMILY Program.
  110 REM Prints Charts of Families
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Charts of Families"
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
  940 DIM PERS(2), FORM$(49)
 1000 REM Produce the first screen
 1010 KEY ON : CLS : KEY OFF
 1020 REM Find the title location
 1030 TITLE.POS = 40 - INT(LEN(TITLE$)/2)
 1040 REM Print the title
 1050 LOCATE 4,TITLE.POS : PRINT TITLE$
 1060 LOCATE 5,40-INT(LEN(VERSION$)/2) :  PRINT VERSION$;
 1070 REM Print the Copyright
 1080 LOCATE 20,40-INT(LEN(COPY1$)/2) :  PRINT COPY1$;
 1090 LOCATE 21,40-INT(LEN(COPY2$)/2) :  PRINT COPY2$;
 1700 REM Display the Copyright
 1710 '
 1720 LOCATE 25,1
 1730 PRINT DATADISK$;
 1740 K$ = INKEY$ : IF K$ = "" THEN 1740
 1750 KEY ON : CLS : KEY OFF
 2000 REM FAMILY Program Starts Here.
 2010 REM Prevent Common User Errors
 2020 IF LEFT.SPACE < 1 THEN LEFT.SPACE = 1
 2030 IF LEFT.SPACE > 18 THEN LEFT.SPACE = 18
 2040 REM Routine to obtain Printer Information
 2050 LOCATE 21,1 : PRINT "Make sure that the Printer is On and Ready"
 2060 LOCATE 22,1 : PRINT "Make sure that the correct Diskette(s) are in place."
 2070 LOCATE 23,1 : PRINT "Then press any key"
 2080 A$ = INKEY$ : IF A$ = "" THEN 2080
 2090 KEY ON : CLS : KEY OFF
 2100 REM Set for Wide Printing.
 2110 WIDTH "lpt1:",132  'For printing Genealogy Forms
 2120 REM Read the Parent/Child Index
 2130 OPEN CC.PCINDEX$ FOR INPUT AS #1
 2140 LOCATE 4,1 : PRINT "Open the Parent/Child Index"
 2150 INPUT #1, PC.COUNT
 2160 IF PC.COUNT <> 0 THEN 2210
 2170 PRINT "Parent/Child Index has no Index Records"
 2180 PRINT "Press any key to return to the Menu"
 2190 A$ = INKEY$ : IF A$ = "" THEN 2190
 2200 GOTO 6790
 2210 DIM PA.ID(PC.COUNT), CH.ID(PC.COUNT)
 2220 FOR I = 1 TO PC.COUNT
 2230 LOCATE 5,1 : PRINT "Reading Index Record #:";I;
 2240  INPUT #1, PA.ID(I), CH.ID(I)
 2250 NEXT I
 2260 CLOSE #1
 2270 REM Read the Marriage Index
 2280 LOCATE 7,1 : PRINT "Open the Marriage Index"
 2290 OPEN CC.MINDEX$ FOR INPUT AS #2
 2300 INPUT #2, M.COUNT
 2310 IF M.COUNT <> 0 THEN 2360
 2320 PRINT "Marriage Index has no Index Records"
 2330 PRINT "Press any key to return to the Menu"
 2340 A$ = INKEY$ : IF A$ = "" THEN 2340
 2350 GOTO 6790
 2360 DIM PERS.NO(M.COUNT), M.NO(M.COUNT)
 2370 FOR I = 1 TO M.COUNT
 2380 LOCATE 8,1 : PRINT "Reading Marriage Index Record #:";I:
 2390  INPUT #2,PERS.NO(I), M.NO(I)
 2400 NEXT I
 2410 CLOSE #2
 2420 REM Open the Persons File
 2430 LOCATE 10,1 : PRINT "Open the Persons File"
 2440 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2450 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2460 REM open the Marriages File
 2470 LOCATE 12,1 : PRINT "Open the Marriage File"
 2480 OPEN CC.MARRFILE$ AS #2 LEN = 128
 2490 FIELD 2, 5 AS M1$, 5 AS M2$, 5 AS M3$, 5 AS M4$, 11 AS M5$, 18 AS M6$, 16 AS M7$, 16 AS M8$, 45 AS M9$
 2500 REM Open the Ordinance File
 2510 IF DD.ORD$ = "no" THEN 2550
 2520 LOCATE 14,1 : PRINT "Open the Ordinances File";
 2530 OPEN CC.ORDFILE$ AS #3 LEN = 256
 2540 FIELD 3,5ASO1$,11ASO2$,11ASO3$,11ASO4$,5ASO5$,5ASO6$,11ASO7$,11ASO8$,11ASO9$,11ASO10$,11ASO11$,5ASO12$,11ASO13$,11ASO14$,11ASO15$,11ASO16$,11ASO17$,11ASO18$,11ASO19$,11ASO20$,11ASO21$,11ASO22$,11ASO23$,26ASO24$
 2550 REM Obtain a Person Record from the User
 2560 LOCATE 20,1
 2570 INPUT "Enter the Record-number of a Marriage (0 to quit)";REPLY$
 2580 IF REPLY$ = "0" THEN 6790
 2590 MARRIAGE = VAL(REPLY$)
 2600 IF MARRIAGE < 1 OR MARRIAGE > MAX.MAR THEN KEY ON : CLS : LOCATE 19,1 : PRINT "Number is out of range;" : KEY OFF : GOTO 2570
 2610 GOSUB 2620 : GOTO 3500
 2620 REM Reset the Printer Characterisitcs for next page if required.
 2630 IF FORMS = 1 THEN 2670  'Don't stop if forms are continuous
 2640 REM Process Single Sheets
 2650 PRINT "Press any key when next form is ready"
 2660 A$ = INKEY$ : IF A$ = "" THEN 2660
 2670 REM Reset paper sensing if required
 2680 IF FORMS = 2 THEN LPRINT PAP.SEN.OFF$;
 2690 REM Reset paper length if required
 2700 IF LENGTH = 1 THEN LPRINT PAP.SHORT$;
 2710 REM Reset Condensed Printing if required
 2720 IF WIDE = 1 THEN LPRINT COMPR.ON$;
 2730 RETURN
 2740 REM Routine to do a Right-trim
 2750 FOR J = 1 TO LEN(TEMP1$)
 2760  IF RIGHT$(TEMP2$,1) = " " THEN TEMP2$ = LEFT$(TEMP2$,LEN(TEMP2$)-1) :ELSE J = LEN(TEMP1$)
 2770 NEXT J
 2780 RETURN
 2790 REM Routine to Extract Personal Information
 2800 T1! = CVS(F1$) : T1 = T1!
 2810 TEMP1$ = F2$ : TEMP2$ = F2$ : GOSUB 2740
 2820 T2$ = TEMP2$
 2830 REM Prefix the Record Number to the Surname
 2840 GOSUB 8250
 2850 TEMP1$ = F3$ : TEMP2$ = F3$ : GOSUB 2740
 2860 T3$ = TEMP2$
 2870 T4$ = " "
 2880 IF LEFT$(F4$,1) = MALE.LTR$   THEN T4$ = MALE.LTR$
 2890 IF LEFT$(F4$,1) = FEMALE.LTR$ THEN T4$ = FEMALE.LTR$
 2900 T6! = CVS(F6$) : T6 = T6!
 2910 T7! = CVS(F7$) : T7 = T7!
 2920 RETURN
 2930 TEMP1$ = F8$ : TEMP2$ = F8$ : GOSUB 2740
 2940 T8$ = TEMP2$ 'Birthdate
 2950 TEMP1$ = F9$ : TEMP2$ = F9$ : GOSUB 2740
 2960 T9$ = TEMP2$
 2970 TEMP1$ = F10$ : TEMP2$ = F10$ : GOSUB 2740
 2980 T10$ = TEMP2$
 2990 TEMP1$ = F11$ : TEMP2$ = F11$ : GOSUB 2740
 3000 T11$ = TEMP2$
 3010 TEMP1$ = F12$ : TEMP2$ = F12$ : GOSUB 2740
 3020 T12$ = TEMP2$ 'Death Date
 3030 RETURN
 3040 TEMP1$ = F13$ : TEMP2$ = F13$ : GOSUB 2740
 3050 T13$ = TEMP2$
 3060 TEMP1$ = F14$ : TEMP2$ = F14$ : GOSUB 2740
 3070 T14$ = TEMP2$
 3080 TEMP1$ = F15$ : TEMP2$ = F15$ : GOSUB 2740
 3090 T15$ = TEMP2$
 3100 TEMP1$ = F16$ : TEMP2$ = F16$ : GOSUB 2740
 3110 T16$ = TEMP2$
 3120 TEMP1$ = F17$ : TEMP2$ = F17$ : GOSUB 2740
 3130 T17$ = TEMP2$
 3140 TEMP1$ = F18$ : TEMP2$ = F18$ : GOSUB 2740
 3150 T18$ = TEMP2$
 3160 TEMP1$ = F19$ : TEMP2$ = F19$ : GOSUB 2740
 3170 T19$ = TEMP2$
 3180 RETURN
 3190 REM Routine to Extract Ordinance Information
 3200 U1! = CVS(O1$) : U1 = U1!
 3210 IF U1 = 0 THEN GOSUB 8160 : GOTO 3350
 3220 TEMP1$ = O2$ : TEMP2$ = O2$ : GOSUB 2740
 3230 U2$ = TEMP2$  'Christening Date
 3240 TEMP1$ = O4$ : TEMP2$ = O4$ : GOSUB 2740
 3250 U4$ = TEMP2$  'Sealed to Parents
 3260 TEMP1$ = O7$ : TEMP2$ = O7$ : GOSUB 2740
 3270 U7$ = TEMP2$  'Baptism
 3280 TEMP1$ = O10$ : TEMP2$ = O10$ : GOSUB 2740
 3290 U10$ = TEMP2$  'Endowment
 3300 TEMP1$ = O11$ : TEMP2$ = O11$ : GOSUB 2740
 3310 U11$ = TEMP2$  'Sealed to Spouse
 3320 U12 = CVS(O12$)
 3330 TEMP1$ = O24$ : TEMP2$ = O24$ : GOSUB 2740
 3340 U24$ = TEMP2$  'Occupation
 3350 RETURN
 3360 REM Extraction of Marriage Information
 3370 TT1! = CVS(M1$) : TT1 = TT1! 'Rec.no
 3380 TT2! = CVS(M2$) : TT2 = TT2! 'Husband
 3390 TT3! = CVS(M3$) : TT3 = TT3! 'Wife
 3400 TEMP1$ = M5$ : TEMP2$ = M5$ : GOSUB 2740
 3410 TT5$ = TEMP2$  'Marriage Date
 3420 RETURN
 3430 TEMP1$ = M6$ : TEMP2$ = M6$ : GOSUB 2740
 3440 TT6$ = TEMP2$   'City
 3450 TEMP1$ = M7$ : TEMP2$ = M7$ : GOSUB 2740
 3460 TT7$ = TEMP2$   'County
 3470 TEMP1$ = M8$ : TEMP2$ = M8$ : GOSUB 2740
 3480 TT8$ = TEMP2$   'State
 3490 RETURN
 3500 REM Routine to Fill with Spaces
 3510 IF X.CHILD$ = "no" AND LAST.MARR = MARRIAGE THEN 3560
 3520 FOR I = 1 TO 49
 3530  FORM$(I) = SPACE$(132)
 3540 NEXT I
 3550 IF DD.ORD$ = "no" THEN FA.COL = 10 : GOTO 3570
 3560 IF PP.FORMS = 1 THEN FA.COL = 12 :ELSE FA.COL = 10
 3570 IF X.CHILD$ = "no" AND LAST.MARR = MARRIAGE THEN GOSUB 6670 : GOTO 2550
 3580 X.CHILD$ = "no"
 3590 IF DD.ORD$ = "no" THEN GOSUB 6880 : GOTO 3610
 3600 IF PP.FORMS = 1 THEN 3610 :ELSE GOSUB 6880
 3610 REM Routine to Produce a Chart of Family
 3620 REM get the marriage record
 3630 GET #2, MARRIAGE
 3640 PRINT "Obtaining Marriage Record"
 3650 GOSUB 3360 : GOSUB 3430 'Extract Marriage Information
 3660 HUSB = TT2 : WIFE = TT3
 3670 REM Verify that record contains information
 3680 IF HUSB = 0 OR WIFE = 0 THEN 6450
 3690 REM
 3700 REM Marriage Information onto line 4
 3710 PRINT "Locate Marriage Information"
 3720 MID$(FORM$(4),7,LEN(TT5$)) = TT5$
 3730 IF TT6$ = "" AND TT7$ = "" AND TT8$ = "" THEN 3750
 3740 MID$(FORM$(4),28,LEN(TT6$+TT7$+TT8$)+4) = TT6$+", "+TT7$+", "+TT8$
 3750 REM
 3760 GET #1, HUSB
 3770 PRINT "Obtaining Husband's Information"
 3780 GOSUB 2790 : GOSUB 2930 : GOSUB 3040  'Extract Husband's Information
 3790 REM Move the Husband's Information
 3800 IF T2$ = "" AND T3$ = "" THEN 3840
 3810 MID$(FORM$(1),FA.COL-2,LEN(T2$+T3$)+2) = T2$ + ", " + T3$
 3820 IF DD.ORD$ = "no" THEN 3840
 3830 MID$(FORM$(1),84,LEN(T2$+T3$)+9) = T2$+", "+T3$+" ("+RIGHT$(T8$,4)+")"
 3840 MID$(FORM$(2),7,LEN(T8$)) = T8$
 3850 IF T9$ = "" AND T10$ = "" AND T11$ = "" THEN 3870
 3860 MID$(FORM$(2),28,LEN(T9$+T10$+T11$)+4) = T9$+", "+T10$+", "+T11$
 3870 MID$(FORM$(5),7,LEN(T12$)) = T12$
 3880 IF T13$ = "" AND T14$ = "" AND T15$ = "" THEN 3900
 3890 MID$(FORM$(5),28,LEN(T13$+T14$+T15$)+4) = T13$+", "+T14$+", "+T15$
 3900 MID$(FORM$(6),7,LEN(T16$)) = T16$
 3910 IF T17$ = "" AND T18$ = "" AND T19$ = "" THEN 3930
 3920 MID$(FORM$(6),28,LEN(T17$+T18$+T19$)+4) = T17$+", "+T18$+", "+T19$
 3930 FATHER = T6 : MOTHER = T7
 3940 IF FATHER = 0 THEN 4000
 3950 GET #1, FATHER
 3960 PRINT "Obtaining Husband's Father"
 3970 GOSUB 2790  'Extract Father's Information
 3980 IF T2$ = "" AND T3$ = "" THEN 4000
 3990 MID$(FORM$(7),FA.COL,LEN(T2$+T3$)+2) = LEFT$(T2$+", "+T3$,38)
 4000 IF MOTHER = 0 THEN 4060
 4010 GET #1, MOTHER
 4020 PRINT "Obtaining Husband's Mother"
 4030 GOSUB 2790  'Extract Mother's Information
 4040 IF T2$ = "" AND T3$ = "" THEN 4060
 4050 MID$(FORM$(7),58,LEN(T2$+T3$)+2) = LEFT$(T2$ + ", " + T3$,38)
 4060 REM
 4070 REM Look for Husband's Other Wives
 4080 PRINT "Look for Other Wives"
 4090 XWIFE.COL = 0
 4100 REM Establish Skip-ahead Start-value and Delta
 4110 START.AT = 1 : DELTA = INT(M.COUNT/10) : IF DELTA = 0 THEN 4160
 4120 REM Add delta and test if too far
 4130 START.AT = START.AT + DELTA
 4140 IF START.AT > 9 * DELTA THEN 4160
 4150 IF HUSB > PERS.NO(START.AT) THEN 4130
 4160 START.AT = START.AT - DELTA
 4170 REM Search Routine
 4180 FOR WW = START.AT TO M.COUNT
 4190  IF HUSB > PERS.NO(WW) THEN 4330  'next ww
 4200  IF HUSB < PERS.NO(WW) THEN WW = M.COUNT : GOTO 4330
 4210  REM found a wife, skip if wife of this marriage
 4220  IF M.NO(WW) = 0 THEN 4330
 4230  GET #2, M.NO(WW)
 4240  GOSUB 3360  'extract marriage info
 4250  IF WIFE = TT3 THEN 4330  'skip if same
 4260  REM found another wife
 4270  IF TT3 = 0 THEN 4330
 4280  GET #1, TT3  'get wife's information
 4290  GOSUB 2790  'extract personal info.
 4300  IF T2$ = "" AND T3$ = "" THEN 4330  'skip if empty
 4310  MID$(FORM$(8),FA.COL-1+XWIFE.COL,LEN(T2$+T3$)+2) = T2$+", "+T3$
 4320  XWIFE.COL = XWIFE.COL + LEN(T2$+T3$)+4
 4330 NEXT WW
 4340 REM
 4350 GET #1, WIFE
 4360 PRINT "Obtaining Wife's Information"
 4370 GOSUB 2790 : GOSUB 2930 : GOSUB 3040  'Extract Wife's Information
 4380 REM Move the Wife's Information
 4390 IF T2$ = "" AND T3$ = "" THEN 4430
 4400 MID$(FORM$(10),FA.COL-2,LEN(T2$+T3$)+2) = T2$ + ", " + T3$
 4410 IF DD.ORD$ = "no" THEN 4430
 4420 MID$(FORM$(2),84,LEN(T2$+T3$)+9) = T2$+", "+T3$+" ("+RIGHT$(T8$,4)+")"
 4430 MID$(FORM$(11),7,LEN(T8$)) = T8$
 4440 IF T9$ = "" AND T10$ = "" AND T11$ = "" THEN 4460
 4450 MID$(FORM$(11),28,LEN(T9$+T10$+T11$)+4) = T9$+", "+T10$+", "+T11$
 4460 MID$(FORM$(13),7,LEN(T12$)) = T12$
 4470 IF T13$ = "" AND T14$ = "" AND T15$ = "" THEN 4490
 4480 MID$(FORM$(13),28,LEN(T13$+T14$+T15$)+4) = T13$+", "+T14$+", "+T15$
 4490 MID$(FORM$(14),7,LEN(T16$)) = T16$
 4500 IF T17$ = "" AND T18$ = "" AND T19$ = "" THEN 4520
 4510 MID$(FORM$(14),28,LEN(T17$+T18$+T19$)+4) = T17$+", "+T18$+", "+T19$
 4520 FATHER = T6 : MOTHER = T7
 4530 IF FATHER = 0 THEN 4590
 4540 GET #1, FATHER
 4550 PRINT "Obtaining Wife's Father"
 4560 GOSUB 2790  'Extract Father's Information
 4570 IF T2$ = "" AND T3$ = "" THEN 4590
 4580 MID$(FORM$(15),FA.COL,LEN(T2$+T3$)+2) = LEFT$(T2$+", "+T3$,38)
 4590 IF MOTHER = 0 THEN 4650
 4600 GET #1, MOTHER
 4610 PRINT "Obtaining Wife's Mother"
 4620 GOSUB 2790  'Extract Mother's Information
 4630 IF T2$ = "" AND T3$ = "" THEN 4650
 4640 MID$(FORM$(15),58,LEN(T2$+T3$)+2) = LEFT$(T2$ + ", " + T3$,38)
 4650 REM
 4660 REM
 4670 REM Look for Wife's Other Husbands
 4680 PRINT "Look for Other Husbands"
 4690 XHUSB.COL = 0
 4700 REM Establish Skip-ahead Start-value and Delta
 4710 START.AT = 1 : DELTA = INT(M.COUNT/10) : IF DELTA = 0 THEN 4760
 4720 REM Add delta and test if too far
 4730 START.AT = START.AT + DELTA
 4740 IF START.AT > 9 * DELTA THEN 4760
 4750 IF WIFE > PERS.NO(START.AT) THEN 4730
 4760 START.AT = START.AT - DELTA
 4770 REM Search Routine
 4780 FOR H = START.AT TO M.COUNT
 4790  IF WIFE > PERS.NO(H) THEN 4930  'next h
 4800  IF WIFE < PERS.NO(H) THEN H = M.COUNT : GOTO 4930
 4810  REM found a husband.  Skip if husband of this marriage
 4820  IF M.NO(H) = 0 THEN 4930
 4830  GET #2, M.NO(H)
 4840  GOSUB 3360  'extract marriage info
 4850  IF HUSB = TT2 THEN 4930  'skip if same
 4860  REM found another husband
 4870  IF TT2 = 0 THEN 4930
 4880  GET #1, TT2  'get husband's information
 4890  GOSUB 2790  'extract personal info.
 4900  IF T2$ = "" AND T3$ = "" THEN 4930  'skip if empty
 4910  MID$(FORM$(16),12+XHUSB.COL,LEN(T2$+T3$)+2) = T2$+", "+T3$
 4920  XHUSB.COL = XHUSB.COL + LEN(T2$+T3$)+4
 4930 NEXT H
 4940 REM Obtain Husband's Ordinances
 4950 IF DD.ORD$ = "no" THEN 5230
 4960 PRINT "Obtaining Husband's Ordinances"
 4970 IF HUSB = 0 THEN 5090
 4980 GET #3, HUSB
 4990 GOSUB 3190  'Extract Ordinances
 5000 MID$(FORM$(3),7,LEN(U2$)) = U2$
 5010 REM Location of Baptism & Endowment
 5020 IF PP.FORMS = 1 THEN WH1 = 100 : WH2 = 111 :ELSE WH1 = 98 : WH2 = 110
 5030 MID$(FORM$(17),WH1,LEN(U7$)) = U7$
 5040 MID$(FORM$(17),WH2,LEN(U10$)) = U10$
 5050 REM get Husband's Occupation
 5060 PRINT "Obtaining Husband's Occupation"
 5070 IF U24$ = "" THEN 5110
 5080 MID$(FORM$(1),55,LEN(U24$)+2) = "("+U24$+")"
 5090 REM Obtain Wife's Ordinances
 5100 IF WIFE = 0 THEN 5230
 5110 GET #3, WIFE
 5120 PRINT "Obtaining Wife's Ordinances"
 5130 GOSUB 3190  'Extract Ordinances
 5140 MID$(FORM$(12),7,LEN(U2$)) = U2$
 5150 MID$(FORM$(19),WH1,LEN(U7$)) = U7$
 5160 MID$(FORM$(19),WH2,LEN(U10$)) = U10$
 5170 IF U12 <> HUSB THEN 5190 'Sealed to another
 5180 MID$(FORM$(17),122,LEN(U11$)) = U11$
 5190 REM get Wife's Occupation
 5200 PRINT "Obtaining Wife's Occupation"
 5210 IF U24$ = "" THEN 5230
 5220 MID$(FORM$(10),55,LEN(U24$)+2) = "("+U24$+")"
 5230 REM Now obtain the information about the Children
 5240 CHILD.COUNT = 0
 5250 REM Search the Parent/Child Index
 5260 PRINT "Look for Children"
 5270 XMARRCT = 0
 5280 REM Establish Skip-ahead Start-value and Delta
 5290 START.AT = 1 : DELTA = INT(PC.COUNT/10) : IF DELTA = 0 THEN 5340
 5300 REM Add delta and test if too far
 5310 START.AT = START.AT + DELTA
 5320 IF START.AT > 9 * DELTA THEN 5340
 5330 IF HUSB > PA.ID(START.AT) THEN 5310
 5340 START.AT = START.AT - DELTA
 5350 REM Search Routine
 5360 FOR LL = START.AT TO PC.COUNT
 5370  IF HUSB > PA.ID(LL) THEN 6440
 5380  IF HUSB < PA.ID(LL) THEN LL = PC.COUNT : GOTO 6440
 5390  REM found a child
 5400  IF CH.ID(LL) = 0 THEN 6420
 5410  GET #1, CH.ID(LL)
 5420  GOSUB 2790 : GOSUB 2930  'Extract Child's Info.
 5430  REM verify that Mother is the same
 5440  IF WIFE <> T7 THEN 6440
 5450  REM Found a valid child
 5460  CHILD.COUNT = CHILD.COUNT + 1
 5470  SHOW.COUNT = CHILD.COUNT
 5480  X11 = 0
 5490  X11 = X11 + 11
 5500  IF CHILD.COUNT > X11 THEN SHOW.COUNT = CHILD.COUNT - X11 : GOTO 5490
 5510  REM test for more than 11 children
 5520  IF CHILD.COUNT = 1 THEN 5690
 5530  IF (CHILD.COUNT-1) MOD 11 = 0 THEN 5540 :ELSE 5690
 5540  GOSUB 6460 'print the current form, then blank out children
 5550  FOR II = 20 TO 49
 5560   FORM$(II) = SPACE$(132)
 5570  NEXT II
 5580  X.CHILD$ = "yes"
 5590  GOSUB 2620  'Next form
 5600  SHOW.COUNT = 1
 5610  XMARRCT = 0
 5620 IF DD.ORD$ = "no" THEN 5640
 5630 IF PP.FORMS = 1 THEN 5690
 5640 REM Redraw Partial Form
 5650 FOR II = 21 TO 41 STEP 2
 5660  FORM$(II) = STRING$(132,95)
 5670 NEXT II
 5680 GOSUB 7130  'Redraw vertical separators
 5690  SEX$ = T4$
 5700  PRINT "Processing Child #";CHILD.COUNT
 5710  MID$(FORM$(19+(2*SHOW.COUNT)),2,1) = T4$
 5720  CH.FM = 1
 5730  IF DD.ORD$ = "no" THEN 5750
 5740  IF PP.FORMS = 1 THEN 5790
 5750  FORM.NO$ = STR$(CHILD.COUNT)
 5760  CH.FM = LEN(FORM.NO$)-1
 5770  FORM.NO$ = RIGHT$(FORM.NO$,CH.FM)
 5780  MID$(FORM$(18+(2*SHOW.COUNT)),2,CH.FM) = FORM.NO$
 5790  MID$(FORM$(18+(2*SHOW.COUNT)),3+CH.FM,LEN(T2$)+1) = LEFT$(T2$+",",25-CH.FM)
 5800  MID$(FORM$(19+(2*SHOW.COUNT)),5,LEN(T3$)) = T3$
 5810  '
 5820  REM Position Birthdate if Drawing the Form
 5830  IF DD.ORD$ = "no" THEN VV = 29 : GOTO 5850
 5840  IF PP.FORMS = 1 THEN VV = 28 :ELSE VV = 29
 5850  MID$(FORM$(18+(2*SHOW.COUNT)),VV,LEN(T8$)) = T8$
 5860  MID$(FORM$(18+(2*SHOW.COUNT)),41,LEN(T9$)) = T9$
 5870  '
 5880  REM Set Width of County and State
 5890  IF DD.ORD$ = "no" THEN V = 5 : GOTO 5910
 5900  IF PP.FORMS = 1 THEN V = 4 :ELSE V = 5
 5910  MID$(FORM$(18+(2*SHOW.COUNT)),60,V) = LEFT$(T10$,V)
 5920  MID$(FORM$(18+(2*SHOW.COUNT)),66,V) = LEFT$(T11$,V)
 5930  MID$(FORM$(18+(2*SHOW.COUNT)),85,LEN(T12$)) = T12$
 5940  REM Now get Child's Ordinances
 5950  IF DD.ORD$ = "no" THEN 6020
 5960  GET #3, CH.ID(LL)
 5970  PRINT "Obtain Child's Ordinances"
 5980  GOSUB 3190  'Extract Ordinances
 5990  MID$(FORM$(18+(2*SHOW.COUNT)),WH1,LEN(U7$)) = U7$
 6000  MID$(FORM$(18+(2*SHOW.COUNT)),WH2,LEN(U10$)) = U10$
 6010  MID$(FORM$(18+(2*SHOW.COUNT)),122,LEN(U4$)) = U4$
 6020  REM Now look for Child's Marriage
 6030  PRINT "Look for Child's Marriage"
 6040 FOUND = 0
 6050 REM Establish Skip-ahead Start-value and Delta
 6060 START.AT = 1 : DELTA = INT(M.COUNT/10) : IF DELTA = 0 THEN 6110
 6070 REM Add delta and test if too far
 6080 START.AT = START.AT + DELTA
 6090 IF START.AT > 9 * DELTA THEN 6110
 6100 IF CH.ID(LL) > PERS.NO(START.AT) THEN 6080
 6110 START.AT = START.AT - DELTA
 6120 REM Search Routine
 6130 FOR L = START.AT TO M.COUNT
 6140   IF CH.ID(LL) > PERS.NO(L) THEN 6430
 6150   IF CH.ID(LL) < PERS.NO(L) THEN L = M.COUNT : GOTO 6430
 6160   REM Found a Marriage
 6170   IF M.NO(L) = 0 THEN 6420
 6180   FOUND = FOUND + 1
 6190   GET #2, M.NO(L)
 6200   GOSUB 3360  'Extract Marriage Information
 6210   IF FOUND <> 1 THEN 6230
 6220   MID$(FORM$(19+(2*SHOW.COUNT)-1),72,LEN(TT5$)) = TT5$
 6230   REM get spouse
 6240   SPOUSE = 0
 6250   IF SEX$ = MALE.LTR$   THEN SPOUSE = TT3
 6260   IF SEX$ = FEMALE.LTR$ THEN SPOUSE = TT2
 6270   IF SPOUSE = 0 THEN 6420
 6280   GET #1, SPOUSE
 6290   GOSUB 2790  'Extract Spouse's Information
 6300   IF FOUND = 1 THEN 6400
 6310   XMARRCT = XMARRCT + 1
 6320   IF XMARRCT > 7 THEN 6420
 6330   CH$ = SPACE$(2)
 6340   RSET CH$ = RIGHT$((STR$(CHILD.COUNT)),2)
 6350   MID$(FORM$(42+XMARRCT),60,4) = CH$+" -"
 6360   IF T2$ = " " AND T3$ = " " THEN 6390
 6370   MID$(FORM$(42+XMARRCT),77,LEN(T2$+T3$)+2) = T2$+", "+T3$
 6380   MID$(FORM$(42+XMARRCT),65,LEN(TT5$)) = TT5$
 6390   GOTO 6420
 6400   IF T2$ = " " AND T3$ = " " THEN 6420
 6410   MID$(FORM$(19+(2*SHOW.COUNT)),72,LEN(T2$+T3$)+2) = T2$+", "+T3$
 6420  REM finished with this child
 6430  NEXT L
 6440 NEXT LL
 6450 GOSUB 6460 : GOTO 6780
 6460 REM enter sources
 6470 IF PP.FORMS = 1 THEN 6480 :ELSE 6520
 6480 MID$(FORM$(4),WH1,LEN(PREP1$)) = PREP1$
 6490 MID$(FORM$(5),WH1,LEN(PREP2$)) = PREP2$
 6500 MID$(FORM$(6),WH1,LEN(PREP3$)) = PREP3$
 6510 MID$(FORM$(7),WH1,LEN(PREP4$)) = PREP4$
 6520 MAR.NUM$ = STR$(MARRIAGE)
 6530 MAR.NUM$ = RIGHT$(MAR.NUM$,LEN(MAR.NUM$)-1)
 6540 MAR.DATA$ = "Marriage Record: " + MAR.NUM$
 6550 MID$(FORM$(43),2,LEN(MAR.DATA$)) = MAR.DATA$
 6560 MID$(FORM$(44),2,22) = "Prepared on " + DATE$
 6570 MID$(FORM$(44),24,12) = " at " + TIME$
 6580 COMM$ = "Using Version 6.0 of Genealogy ON DISPLAY"
 6590 MID$(FORM$(45),2,LEN(COMM$)) = COMM$
 6600 IF PP.FORMS = 1 THEN 6670
 6610 IF PREP1$ = "" THEN 6630
 6620 MID$(FORM$(46),2,3) = "By:"
 6630 MID$(FORM$(46),6,LEN(PREP1$)) = PREP1$
 6640 MID$(FORM$(47),6,LEN(PREP2$)) = PREP2$
 6650 MID$(FORM$(48),6,LEN(PREP3$)) = PREP3$
 6660 MID$(FORM$(49),6,LEN(PREP4$)) = PREP4$
 6670 PRINT "Ready to Print"
 6680 LPRINT
 6690 REM Print the Chart of Family
 6700 FOR I = 1 TO 49
 6710 PRINT "Printing line: ";I
 6720  IF DD.ORD$ = "no" THEN LPRINT TAB(LEFT.SPACE); LEFT$(FORM$(I),133-2*LEFT.SPACE)  :ELSE LPRINT FORM$(I);
 6730 NEXT I
 6740 LAST.MARR = MARRIAGE
 6750 KEY ON : CLS : KEY OFF
 6760 LPRINT FORM.FEED$;
 6770 RETURN
 6780 GOTO 2550  'for Next Group Sheet
 6790 REM Wrapup
 6800 LPRINT COMPR.OFF$;     'Normal Printing
 6810 LPRINT PAP.SEN.ON$;    'Paper Sensing ON
 6820 LPRINT PAP.LONG$;      'Normal Page of 66 Lines
 6830 CLOSE
 6840 WIDTH "lpt1:",80       'Reset for narrow paper
 6850 KEY ON : CLS : KEY OFF : LOCATE 21,1
 6860 PRINT "End of Program"
 6870 RUN CC.MENU$
 6880 REM Draw the Form Itself
 6890 PRINT "Preparing the Form."
 6900 '
 6910 PRINT "Drawing the Horizontal Lines in Rows:"
 6920 FOR II = 1 TO 8
 6930  PRINT II;
 6940  FORM$(II) = STRING$(132,95)
 6950 NEXT II
 6960 PRINT
 6970 IF DD.ORD$ = "no" THEN 7000
 6980 MID$(FORM$(1),83,1) = CHR$(124)
 6990 MID$(FORM$(2),83,1) = CHR$(124)
 7000 FOR II = 10 TO 16
 7010  PRINT II;
 7020  FORM$(II) = STRING$(132,95)
 7030 NEXT II
 7040 IF DD.ORD$ = "no" THEN 7070
 7050 MID$(FORM$(9),98,35) = STRING$(35,95)
 7060 MID$(FORM$(16),98,35) = SPACE$(35)
 7070 PRINT
 7080 FOR II = 17 TO 41 STEP 2
 7090  PRINT II;
 7100  FORM$(II) = STRING$(132,95)
 7110 NEXT II
 7120 PRINT
 7130 '
 7140 PRINT "Drawing the Vertical Lines in Rows:"
 7150 FOR II = 18 TO 41
 7160  PRINT II;
 7170  MID$(FORM$(II),1,1) = CHR$(124)
 7180  MID$(FORM$(II),3,1) = CHR$(124)
 7190  MID$(FORM$(II),28,1) = CHR$(124)
 7200  MID$(FORM$(II),40,1) = CHR$(124)
 7210  MID$(FORM$(II),59,1) = CHR$(124)
 7220  MID$(FORM$(II),65,1) = CHR$(124)
 7230  MID$(FORM$(II),71,1) = CHR$(124)
 7240  IF II MOD 2 = 1 THEN 7260
 7250  MID$(FORM$(II),97,1) = CHR$(124)
 7260  IF DD.ORD$ <> "no" THEN 7280
 7270  MID$(FORM$(II),133-2*LEFT.SPACE,1) = CHR$(124)
 7280 NEXT II
 7290 PRINT
 7300 FOR II = 42 TO 49
 7310  PRINT II;
 7320  MID$(FORM$(II),1,1) = CHR$(124)
 7330  MID$(FORM$(II),59,1) = CHR$(124)
 7340  IF DD.ORD$ <> "no" THEN 7360
 7350  MID$(FORM$(II),133-2*LEFT.SPACE,1) = CHR$(124)
 7360 NEXT II
 7370 PRINT
 7380 PRINT "Drawing Boxes in Rows:"
 7390 FOR II = 18 TO 40 STEP 2
 7400 PRINT II;
 7410  MID$(FORM$(II),72,25) = STRING$(25,95)
 7420 NEXT II
 7430 PRINT
 7440 FOR II = 18 TO 40 STEP 2
 7450  PRINT II;
 7460  MID$(FORM$(II),84,1) = CHR$(124)
 7470 NEXT II
 7480 PRINT
 7490 REM Put the titles in place
 7500 PRINT "Preparing Titles and Numbers"
 7510 MID$(FORM$(18),11,8) = "CHILDREN"
 7520 MID$(FORM$(18),30,9) = "WHEN BORN"
 7530 MID$(FORM$(18),56,10) = "WHERE BORN"
 7540 MID$(FORM$(18),72,11) = "1st MARRIED"
 7550 MID$(FORM$(18),86,9) = "WHEN DIED"
 7560 MID$(FORM$(19),4,20) = "SURNAME, Given Names"
 7570 MID$(FORM$(19),29,11) = "DA MON YEAR"
 7580 MID$(FORM$(19),45,5) = "TOWN"
 7590 MID$(FORM$(19),60,4) = "CNTY"
 7600 MID$(FORM$(19),66,4) = "STA."
 7610 MID$(FORM$(19),72,15) = "TO WHOM MARRIED"
 7620 MID$(FORM$(42),2,16) = "Chart of Family."
 7630 MID$(FORM$(42),60,15) = "OTHER MARRIAGES"
 7640 MID$(FORM$( 1),1,5) = "HUSB:"
 7650 MID$(FORM$(2), 1,5) = "Born:"
 7660 MID$(FORM$(2),20,6) = "Place:"
 7670 MID$(FORM$(3), 1,4) = "Chr:"
 7680 MID$(FORM$(3),20,6) = "Place:"
 7690 MID$(FORM$(4), 1,5) = "Marr:"
 7700 MID$(FORM$(4),20,6) = "Place:"
 7710 MID$(FORM$(5), 1,5) = "Died:"
 7720 MID$(FORM$(5),20,6) = "Place:"
 7730 MID$(FORM$(6), 1,4) = "Bur:"
 7740 MID$(FORM$(6),20,6) = "Place:"
 7750 MID$(FORM$(7), 1,7) = "Father:"
 7760 MID$(FORM$(7),49,7) = "Mother:"
 7770 MID$(FORM$(8), 1,6) = "Wives:"
 7780 MID$(FORM$(10),1,5) = "WIFE:"
 7790 MID$(FORM$(11),1,5) = "Born:"
 7800 MID$(FORM$(11),20,6) = "Place:"
 7810 MID$(FORM$(12), 1,4) = "Chr:"
 7820 MID$(FORM$(12),20,6) = "Place:"
 7830 MID$(FORM$(13), 1,5) = "Died:"
 7840 MID$(FORM$(13),20,6) = "Place:"
 7850 MID$(FORM$(14), 1,4) = "Bur:"
 7860 MID$(FORM$(14),20,6) = "Place:"
 7870 MID$(FORM$(15), 1,7) = "Father:"
 7880 MID$(FORM$(15),49,7) = "Mother:"
 7890 MID$(FORM$(16), 1,9) = "Husbands:"
 7900 FOR II = 3 TO 17
 7910  IF DD.ORD$ <> "no" THEN 7940
 7920  MID$(FORM$(II),133-2*LEFT.SPACE,1) = CHR$(124)
 7930  GOTO 7950
 7940  MID$(FORM$(II),97,1) = CHR$(124)
 7950 NEXT II
 7960 IF DD.ORD$ <> "no" THEN 7990
 7970  MID$(FORM$(1),133-2*LEFT.SPACE,1) = CHR$(124)
 7980  MID$(FORM$(2),133-2*LEFT.SPACE,1) = CHR$(124)
 7990 REM Put in the Descriptions
 8000 IF DD.ORD$ = "no" THEN 8150
 8010 MID$(FORM$(14),106,19) = "LDS ORDINANCE DATA"
 8020 REM Draw Ordinance Separators
 8030 FOR II = 15 TO 41
 8040  MID$(FORM$(II),109,1) = CHR$(124)
 8050  MID$(FORM$(II),121,1) = CHR$(124)
 8060 NEXT II
 8070 MID$(FORM$(15), 99,8) = "BAPTIZED"
 8080 MID$(FORM$(15),111,7) = "ENDOWED"
 8090 MID$(FORM$(15),123,6) = "SEALED"
 8100 MID$(FORM$(16),106,7) = "HUSBAND"
 8110 MID$(FORM$(16),123,10) = "WIFE/HUSB."
 8120 MID$(FORM$(18),107,4) = "WIFE"
 8130 MID$(FORM$(18),123,8) = "CHILDREN"
 8140 MID$(FORM$(19),123,6) = "SEALED"
 8150 RETURN
 8160 REM Blank Ordinances if No Ord Record
 8170 U2$  = "" : U3$  = "" : U4$  = ""
 8180 U5   = 0  : U6   = 0  : U12  = 0
 8190 U7$  = "" : U8$  = "" : U9$  = "" : U10$ = ""
 8200 U11$ = "" : U13$ = "" : U14$ = "" : U15$ = ""
 8210 U16$ = "" : U17$ = "" : U18$ = "" : U19$ = ""
 8220 U20$ = "" : U21$ = "" : U22$ = "" : U23$ = ""
 8230 U24$ = ""
 8240 RETURN
 8250 REM Routine to Obtain a Usable Person Number for the Chart
 8260 REM Skip if LDS Wide, Single Sheet Forms
 8270 IF PP.FORMS = 1 THEN 8390  'return
 8280 IF CHART.NOS$ <> "n" THEN 8390
 8290 REM Convert the Person Number to a String
 8300 PNUM$ = STR$(T1)
 8310 REM Find the Length of the String
 8320 PLEN = LEN(PNUM$)
 8330 REM Get rid of the leading space for algebraic sign
 8340 PNUM$ = RIGHT$(PNUM$,PLEN-1)
 8350 REM Surround with Quotes and add a Trailing Space
 8360 PNUM$ = "(" + PNUM$ + ") "
 8370 REM Prefix Person Number to Surname
 8380 T2$ = PNUM$ + T2$
 8390 RETURN
 8400 REM Clean User Input Area
 8410 LOCATE 19,1 : PRINT SPACE$(79);
 8420 LOCATE 20,1 : PRINT SPACE$(79);
 8430 LOCATE 21,1 : PRINT SPACE$(79);
 8440 LOCATE 22,1 : PRINT SPACE$(79);
 8450 LOCATE 23,1 : PRINT SPACE$(79);
 8460 RETURN
