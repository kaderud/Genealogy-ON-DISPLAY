  100 REM UPDATMAR Program
  110 REM Data Entry to the Marriages File
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Update the Marriages File"
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
 1280 GOTO 1700
 1300 REM subroutine to print a double box
 1310 COLOR P
 1320 FOR I = R1 + 1 TO R2 - 1
 1330  LOCATE I, C1 : PRINT CHR$(186);
 1340  LOCATE I, C2 : PRINT CHR$(186);
 1350 NEXT I
 1360  LOCATE R1, C1+1 : PRINT STRING$(C2-C1-1,205);
 1390  LOCATE R2, C1+1 : PRINT STRING$(C2-C1-1,205);
 1400  LOCATE R1, C1 : PRINT CHR$(201);
 1410  LOCATE R1, C2 : PRINT CHR$(187);
 1420  LOCATE R2, C1 : PRINT CHR$(200);
 1430  LOCATE R2, C2 : PRINT CHR$(188);
 1440 COLOR W
 1450 RETURN
 1700 REM Display the Copyright
 1710 '
 1720 LOCATE 25,1
 1730 PRINT DATADISK$;
 1740 K$ = INKEY$ : IF K$ = "" THEN 1740
 1750 KEY ON : CLS : KEY OFF
 2000 REM UPDATMAR Program Starts Here.
 2010 REM Open the Marriages File
 2020 OPEN CC.MARRFILE$ AS #2 LEN = 128
 2030 FIELD 2, 5 AS M1$, 5 AS M2$, 5 AS M3$, 5 AS M4$, 11 AS M5$, 18 AS M6$, 16 AS M7$, 16 AS M8$, 45 AS M9$
 2040 REM Open the Persons File
 2050 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2060 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2070 REM ask the user for input
 2080 LOCATE 23,1 : PRINT SPACE$(79);
 2090 LOCATE 23,1 : PRINT "(0 to quit, ? to locate unused record)";
 2100 LOCATE 22,1 : PRINT SPACE$(79) : LOCATE 22,1
 2110 LINE INPUT "Enter Record Number of Marriage to Update: "; REPLY$
 2120 IF REPLY$ <> "?" THEN 2270
 2130 REM Locate an unused record
 2140 FOUND = 0 : IF REC.NO = 0 THEN REC.NO = 1
 2150 FOR LOOK = REC.NO TO MAX.MAR
 2160  GET #2, LOOK
 2170  LOCATE 15,1 : PRINT "Searching Record";LOOK;
 2180  TT1 = CVS(M1$)
 2190  IF TT1 > 0 THEN 2210
 2200  FOUND = 1 : REC.NO = LOOK : LOOK = MAX.MAR
 2210 NEXT LOOK
 2220 IF FOUND = 1 THEN 2360
 2230 PRINT "Unable to find an unused record above record";REC.NO
 2240 PRINT "Either start from record 1 or extend the file"
 2250 PRINT "Press any key to continue"
 2260 GOTO 2070
 2270 IF REPLY$ = "0" THEN 4950
 2280 REC.NO = VAL(REPLY$)
 2290 IF REC.NO < 1 OR REC.NO > MAX.MAR THEN 2300 :ELSE 2350
 2300 PRINT : PRINT "Number is out of range"
 2310 PRINT "Press any key to continue"
 2320 A$ = INKEY$ : IF A$ = "" THEN 2320
 2330 KEY ON : CLS : KEY OFF
 2340 GOTO 2070
 2350 GET #2, REC.NO
 2360 REM Extract information from the file for use
 2370 TT1! = CVS(M1$) : TT1 = TT1!
 2380 REM Disallow Update if Rec.no is Zero (never Created)
 2390 IF TT1 <> 0 THEN 2460
 2400 LOCATE 22,1 : PRINT SPACE$(79);
 2410 LOCATE 23,1 : PRINT SPACE$(79); : LOCATE 22,1
 2420 PRINT "Record Number is Zero.  Must run the CREATMAR Program First."
 2430 KEY OFF : LOCATE 25,1 : PRINT "Press any key to continue";
 2440 A$ = INKEY$ : IF A$ = "" THEN 2440
 2450 GOTO 4950  'Close the Files and return to the Menu
 2460 TT2! = CVS(M2$) : TT2 = TT2!
 2470 TT3! = CVS(M3$) : TT3 = TT3!
 2480 TT4! = CVS(M4$)
 2490 TT5$ = M5$
 2500 TT6$ = M6$
 2510 TT7$ = M7$
 2520 TT8$ = M8$
 2530 TT9$ = M9$
 2540 KEY ON : CLS : KEY OFF
 2550 R1 = 1 : C1 = 1 : R2 = 21 : C2 = 79 : GOSUB 1300  'Double box
 2560 R1 = 3 : C1 = 1 : R2 = 3 : C2 = 79 : GOSUB 3330  'Horizontal double
 2570 R1 = 19 : C1 = 1 : R2 = 19 : C2 = 79 : GOSUB 3330  'Horizontal double
 2580 LOCATE  2,33 : PRINT "Marriage Record"
 2590 LOCATE  5, 3 : COLOR O : PRINT "Marriage Record-number:";
 2600 LOCATE  7, 3 : PRINT "Male Spouse:";
 2610 LOCATE  8, 3 : PRINT "Male Spouse's Name:";
 2620 LOCATE 10, 3 : PRINT "Female Spouse:";
 2630 LOCATE 11, 3 : PRINT "Female Spouse's Name:";
 2640 LOCATE 20, 3 : PRINT "Comments:";
 2650 IF CODE$ = "no" THEN 2670
 2660 LOCATE  5,42 : PRINT "Marriage Code:";
 2670 LOCATE 13, 3 : COLOR N : PRINT "Marriage Statistics:"; : COLOR O
 2680 LOCATE 14, 3 : PRINT "Marriage-date:";
 2690 LOCATE 15, 3 : PRINT "Marriage-city:";
 2700 LOCATE 16, 3 : PRINT "Marriage-county:";
 2710 LOCATE 17, 3 : PRINT "State/Country:";
 2720 GOSUB 2740 'To print the current information
 2730 GOTO 3400 'For User Input
 2740 REM Print the Information Currently Present
 2750 LOCATE  5,27 : PRINT SPACE$(5);
 2760 LOCATE  5,27 : COLOR G : PRINT TT1;
 2770 LOCATE  7,27 : PRINT SPACE$(5);
 2780 LOCATE  7,27 : COLOR G : PRINT TT2;
 2790 LOCATE  8,27 : PRINT SPACE$(51);
 2800 REM Obtain the Husband's Record
 2810 IF TT2 = 0 THEN GOSUB 5220 : GOTO 2970 :ELSE GET #1, TT2 : GOSUB 5100
 2820 REM Disallow if not Male
 2830 IF LEFT$(T4$,1) = MALE.LTR$ THEN 2970
 2840 COLOR W
 2850 LOCATE 23,1 : PRINT SPACE$(79);
 2860 LOCATE 24,1 : PRINT SPACE$(70);
 2870 REM Test for Undefined Sex
 2880 IF LEFT$(T4$,1) <> " " THEN 2910
 2890 LOCATE 22,1 : PRINT "The Sex of the Male Spouse is Undefined"
 2900 GOTO 2920
 2910 LOCATE 22,1 : PRINT "The Sex of the Male Spouse is shown as: "; T4$;
 2920 LOCATE 23,1 : PRINT "Cannot Save this Marriage Record";
 2930 KEY OFF : LOCATE 25,1 : PRINT "Press any key to continue";
 2940 A$ = INKEY$ : IF A$ = "" THEN 2940
 2950 REM Blank the Record and start over
 2960 TT1 = -TT1 : GOSUB 5000 : GOSUB 2740 : GOTO 3400
 2970 LOCATE  8,27 : COLOR G : PRINT LEFT$(T3$+" "+T2$,51);
 2980 LOCATE 10,27 : PRINT SPACE$(5);
 2990 LOCATE 10,27 : COLOR G : PRINT TT3;
 3000 LOCATE 11,27 : PRINT SPACE$(51);
 3010 REM Obtain the Wife's Record
 3020 IF TT3 = 0 THEN GOSUB 5220 : GOTO 3180 :ELSE GET #1, TT3 : GOSUB 5100
 3030 REM Disallow if not Female
 3040 IF LEFT$(T4$,1) = FEMALE.LTR$ THEN 3180
 3050 COLOR W
 3060 LOCATE 23,1 : PRINT SPACE$(79);
 3070 LOCATE 24,1 : PRINT SPACE$(70);
 3080 REM Test for Undefined Sex
 3090 IF LEFT$(T4$,1) <> " " THEN 3120
 3100 LOCATE 22,1 : PRINT "The Sex of the Female Spouse is Undefined"
 3110 GOTO 3130
 3120 LOCATE 22,1 : PRINT "The Sex of the Female Spouse is shown as: "; T4$;
 3130 LOCATE 23,1 : PRINT "Cannot Save this Marriage Record";
 3140 KEY OFF : LOCATE 25,1 : PRINT "Press any key to continue";
 3150 A$ = INKEY$ : IF A$ = "" THEN 3150
 3160 REM Blank the Record and start over
 3170 TT1 = -TT1 : GOSUB 5000 : GOSUB 2740 : GOTO 3400
 3180 LOCATE 11,27 : COLOR G : PRINT LEFT$(T3$+" "+T2$,51);
 3190 IF CODE$ = "no" THEN 3220
 3200 LOCATE  5,57 : PRINT SPACE$(15);
 3210 LOCATE  5,57 : COLOR G : PRINT TT4!;
 3220 LOCATE 14,28 : PRINT SPACE$(11);
 3230 LOCATE 14,28 : COLOR G : PRINT TT5$;
 3240 LOCATE 15,28 : PRINT SPACE$(18);
 3250 LOCATE 15,28 : COLOR G : PRINT TT6$;
 3260 LOCATE 16,28 : PRINT SPACE$(16);
 3270 LOCATE 16,28 : COLOR G : PRINT TT7$;
 3280 LOCATE 17,28 : PRINT SPACE$(16);
 3290 LOCATE 17,28 : COLOR G : PRINT TT8$;
 3300 LOCATE 20,20 : PRINT SPACE$(45);
 3310 LOCATE 20,20 : COLOR G : PRINT TT9$; : COLOR W
 3320 RETURN
 3330 REM Subroutine to draw a double horizontal line.  Attach to double.
 3340 COLOR P
 3350 LOCATE R1,C1+1 : PRINT STRING$(C2-C1-1,205);
 3360 LOCATE R1,C1 : PRINT CHR$(204);
 3370 LOCATE R1,C2 : PRINT CHR$(185);
 3380 COLOR W
 3390 RETURN
 3400 REM Routines to Obtain information from the User
 3410 LOCATE 22,1 : PRINT SPACE$(79);
 3420 LOCATE 23,1 : PRINT SPACE$(79);
 3430 LOCATE 24,1 : PRINT SPACE$(79);
 3440 KEY ON
 3450 LOCATE 24,1 : PRINT "('enter' to leave alone, '/ enter' to end record, or reply as shown)";
 3460 LOCATE 23,1
 3470 LINE INPUT "Enter the Record Number: ";REPLY$
 3480 IF REPLY$ = "/" THEN 4580
 3490 IF REPLY$ = "" THEN 3600
 3500 IF ABS(VAL(REPLY$)) = ABS(TT1) THEN 3570 :ELSE 3510
 3510 REM Prevent Change of Rec.no
 3520 LOCATE 24,1 : PRINT SPACE$(79); : LOCATE 22,1
 3530 PRINT "Cannot Change the Record Number to another number.";
 3540 KEY OFF : LOCATE 25,1 : PRINT "Press any key to continue";
 3550 A$ = INKEY$ : IF A$ = "" THEN 3550
 3560 GOTO 3400
 3570 TT1 = VAL(REPLY$)
 3580 IF TT1 < 1 THEN GOSUB 5000 : GOSUB 2740 : GOTO 4580  'Null Record
 3590 GOSUB 2740
 3600 LOCATE 23,1 : PRINT SPACE$(79);
 3610 REM Terminate record update if negative
 3620 IF TT1 < 1 THEN 4580
 3630 LOCATE 23,1 : COLOR W
 3640 LINE INPUT "Enter the Male Spouse's Record-Number: ";REPLY$
 3650 IF REPLY$ = "/" THEN 4580
 3660 IF REPLY$ = "" THEN 3730
 3670 TT2 = VAL(REPLY$)
 3680 IF TT2 >= 0 AND TT2 <= MAX.PER THEN 3710
 3690 TT2 = 0
 3700 LOCATE 22,1 : PRINT "Number out of range"; : GOTO 3600
 3710 LOCATE 22,1 : PRINT SPACE$(79);
 3720 GOSUB 2770
 3730 LOCATE 23,1 : PRINT SPACE$(79);
 3740 REM Disallow if Male Spouse's Record-number is zero
 3750 IF TT2 <> 0 THEN 3830
 3760 COLOR W : LOCATE 24,1 : PRINT SPACE$(79);
 3770 LOCATE 22,1 : PRINT "Male Spouse's Record Number Cannot be Zero";
 3780 LOCATE 23,1 : PRINT "Cannot Save this Marriage Record";
 3790 KEY OFF : LOCATE 25,1 : PRINT "Press any key to continue";
 3800 A$ = INKEY$ : IF A$ = "" THEN 3800
 3810 REM Blank the Record and start over
 3820 TT1 = -TT1 : GOSUB 5000 : GOSUB 2740 : GOTO 3400
 3830 LOCATE 23,1 : PRINT SPACE$(79);
 3840 LOCATE 23,1 : COLOR W
 3850 LINE INPUT "Enter the Female Spouse's Record-Number: ";REPLY$
 3860 IF REPLY$ = "/" THEN 4580
 3870 IF REPLY$ = "" THEN 3940
 3880 TT3 = VAL(REPLY$)
 3890 IF TT3 >= 0 AND TT3 <= MAX.PER THEN 3920
 3900 TT3 = 0
 3910 LOCATE 22,1 : PRINT "Number out of range"; : GOTO 3830
 3920 LOCATE 22,1 : PRINT SPACE$(79);
 3930 GOSUB 2980
 3940 LOCATE 23,1 : PRINT SPACE$(79);
 3950 REM Disallow if Female Spouse's Record-number is zero
 3960 IF TT3 <> 0 THEN 4040
 3970 COLOR W : LOCATE 24,1 : PRINT SPACE$(79);
 3980 LOCATE 22,1 : PRINT "Female Spouse's Record Number Cannot be Zero";
 3990 LOCATE 23,1 : PRINT "Cannot Save this Marriage Record";
 4000 KEY OFF : LOCATE 25,1 : PRINT "Press any key to continue";
 4010 A$ = INKEY$ : IF A$ = "" THEN 4010
 4020 REM Blank the Record and start over
 4030 TT1 = -TT1 : GOSUB 5000 : GOSUB 2740 : GOTO 3400
 4040 LOCATE 23,1 : COLOR W
 4050 IF CODE$ = "no" THEN 4110
 4060 LINE INPUT "Enter the Marriage Code: ";REPLY$
 4070 IF REPLY$ = "/" THEN 4580
 4080 IF REPLY$ = "" THEN 4110
 4090 TT4! = VAL(REPLY$)
 4100 GOSUB 3200
 4110 LOCATE 23,1 : PRINT SPACE$(79);
 4120 LOCATE 23,1 : COLOR W
 4130 PRINT "Enter the Marriage-Date as: dd Mmm yyyy: ";
 4140 LINE INPUT REPLY$
 4150 IF REPLY$ = CHR$(34)+" "+CHR$(34) THEN REPLY$ = " "
 4160 IF REPLY$ = "/" THEN 4580
 4170 IF REPLY$ = "" THEN 4210
 4180 REPLY$ = LEFT$(REPLY$,11)
 4190 RSET TT5$ = REPLY$
 4200 GOSUB 3220
 4210 LOCATE 23,1 : PRINT SPACE$(79);
 4220 LOCATE 23,1 : COLOR 7
 4230 PRINT "Enter the Marriage-City: ";
 4240 LINE INPUT REPLY$
 4250 IF REPLY$ = CHR$(34)+" "+CHR$(34) THEN REPLY$ = " "
 4260 IF REPLY$ = "/" THEN 4580
 4270 IF REPLY$ = "" THEN 4300
 4280 TT6$ = LEFT$(REPLY$,18)
 4290 GOSUB 3240
 4300 LOCATE 23,1 : PRINT SPACE$(79);
 4310 LOCATE 23,1 : COLOR 7
 4320 PRINT "Enter the Marriage-County: ";
 4330 LINE INPUT REPLY$
 4340 IF REPLY$ = CHR$(34)+" "+CHR$(34) THEN REPLY$ = " "
 4350 IF REPLY$ = "/" THEN 4580
 4360 IF REPLY$ = "" THEN 4390
 4370 TT7$ = LEFT$(REPLY$,16)
 4380 GOSUB 3260
 4390 LOCATE 23,1 : PRINT SPACE$(79);
 4400 LOCATE 23,1 : COLOR 7
 4410 PRINT "Enter the Marriage-State or Country: ";
 4420 LINE INPUT REPLY$
 4430 IF REPLY$ = CHR$(34)+" "+CHR$(34) THEN REPLY$ = " "
 4440 IF REPLY$ = "/" THEN 4580
 4450 IF REPLY$ = "" THEN 4480
 4460 TT8$ = LEFT$(REPLY$,16)
 4470 GOSUB 3280
 4480 LOCATE 23,1 : PRINT SPACE$(79);
 4490 LOCATE 23,1 : COLOR 7
 4500 PRINT "Enter any Comments: ";
 4510 LINE INPUT REPLY$
 4520 IF REPLY$ = CHR$(34)+" "+CHR$(34) THEN REPLY$ = " "
 4530 IF REPLY$ = "/" THEN 4580
 4540 IF REPLY$ = "" THEN 4570
 4550 TT9$ = LEFT$(REPLY$,45)
 4560 GOSUB 3300
 4570 REM
 4580 REM Completed this Record
 4590 LOCATE 24,1 : PRINT SPACE$(79);
 4600 LOCATE 23,1 : PRINT SPACE$(79);
 4610 LOCATE 23,1 : COLOR W
 4620 LINE INPUT "Type s (save), m (more), or f (forget): ";REPLY$
 4630 IF LEFT$(REPLY$,1) = "m" THEN LOCATE 23,1 : PRINT SPACE$(79); : GOTO 3400
 4640 IF LEFT$(REPLY$,1) = "M" THEN LOCATE 23,1 : PRINT SPACE$(79); : GOTO 3400
 4650 IF LEFT$(REPLY$,1) = "f" THEN KEY ON : CLS : KEY OFF : GOTO 2070
 4660 IF LEFT$(REPLY$,1) = "F" THEN KEY ON : CLS : KEY OFF : GOTO 2070
 4670 IF LEFT$(REPLY$,1) = "s" THEN LOCATE 23,1 : PRINT SPACE$(79); : GOTO 4710
 4680 IF LEFT$(REPLY$,1) = "S" THEN LOCATE 23,1 : PRINT SPACE$(79); : GOTO 4710
 4690 LOCATE 22,1 : PRINT "Error in reply";
 4700 GOTO 4600
 4710 REM Routine to SAVE the newly updated record
 4720 REM Prevent saving of Person/non-Person Marriage
 4730 IF TT1 < 0 THEN 4830  'ok if empty
 4740 IF TT2 = 0 OR TT3 = 0 THEN 4750 :ELSE 4830
 4750 LOCATE 22,1 : PRINT SPACE$(79);
 4760 LOCATE 22,1
 4770 PRINT "Cannot s (save) unless both spouses have numbers that are not zero."
 4780 REM Ask for More or Forget, but not Save
 4790 LOCATE 23,1 : PRINT SPACE$(79);
 4800 LOCATE 23,1 : COLOR W
 4810 LINE INPUT "Type m (more), or f (forget): "; REPLY$
 4820 GOTO 4630
 4830 TT1! = TT1 : LSET M1$  = MKS$(TT1!)
 4840 TT2! = TT2 : LSET M2$  = MKS$(TT2!)
 4850 TT3! = TT3 : LSET M3$  = MKS$(TT3!)
 4860 LSET M4$  = MKS$(TT4!)
 4870 RSET M5$  = TT5$
 4880 LSET M6$  = TT6$
 4890 LSET M7$  = TT7$
 4900 LSET M8$  = TT8$
 4910 LSET M9$  = TT9$
 4920 PUT #2, REC.NO
 4930 KEY ON : CLS : KEY OFF
 4940 GOTO 2070
 4950 CLOSE #2
 4960 CLOSE #1
 4970 KEY ON : CLS : KEY OFF : LOCATE 21,1
 4980 PRINT "End of Program"
 4990 RUN CC.MENU$
 5000 REM Blank a Negative Record
 5010 TT2 = 0
 5020 TT3 = 0
 5030 TT4! = 0
 5040 TT5$ = SPACE$(11)
 5050 TT6$ = ""
 5060 TT7$ = ""
 5070 TT8$ = ""
 5080 TT9$ = ""
 5090 RETURN
 5100 REM Routine to Extract Personal Information
 5110 T1! = CVS(F1$) : T1 = T1!
 5120 T2$ = F2$
 5130 FOR J = 1 TO LEN(F2$) -1
 5140  IF RIGHT$(T2$,1)=" " THEN T2$ = LEFT$(T2$,LEN(T2$)-1) :ELSE J = LEN(F2$)-1
 5150 T3$ = F3$
 5160 NEXT J
 5170 FOR J = 1 TO LEN(F3$) -1
 5180  IF RIGHT$(T3$,1)=" " THEN T3$ = LEFT$(T3$,LEN(T3$)-1) :ELSE J = LEN(F3$)-1
 5190 NEXT J
 5200 T4$ = F4$
 5210 RETURN
 5220 REM Blank out a Record
 5230 T1 = 0
 5240 T2$ = ""
 5250 T3$ = ""
 5260 T4$ = ""
 5270 RETURN
