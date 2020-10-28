  100 REM PRINTPER Program.
  110 REM Prints Detailed Personal Information
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Print the Persons "
  611 IF DD.ORD$ = "no" THEN 613
  612 TITLE$ = TITLE$ + "and Ordinances "
  613 TITLE$ = TITLE$ + "File"
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
 1730 rem PRINT DATADISK$;
 1740 rem K$ = INKEY$ : IF K$ = "" THEN 1740
 1750 KEY ON : CLS : KEY OFF
 2000 REM PRINTPER Program Starts Here.
 2010 IF DD.ORD$ = "no" THEN 2050
 2020 OPEN CC.ORDFILE$ AS #2 LEN = 256
 2030 FIELD 2,5ASO1$,11ASO2$,11ASO3$,11ASO4$,5ASO5$,5ASO6$,11ASO7$,11ASO8$,11ASO9$,11ASO10$,11ASO11$,5ASO12$,11ASO13$,11ASO14$,11ASO15$,11ASO16$,11ASO17$,11ASO18$,11ASO19$,11ASO20$,11ASO21$,11ASO22$,11ASO23$,26ASO24$
 2040 REM
 2050 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2060 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2061 IF WHERE.LIST = 1 THEN OPEN "PRINTPER.csv" FOR OUTPUT AS #3 :ELSE OPEN "scrn:" FOR OUTPUT AS #3
 2070 REM Read all records, and print the actual ones
 2080 KEY ON : CLS : KEY OFF
 2090 LOCATE 22,1
 2100 rem PRINT "Enter the Record Number to be Printed (0 to quit) or 'all': ";
 2110 rem LINE INPUT REPLY$
 2120 rem IF LEFT$(REPLY$,1) = "a" OR LEFT$(REPLY$,1) = "A" THEN 2180
 2121 GOTO 2180
 2130 IF REPLY$ = "0" THEN 3770
 2140 I = VAL(REPLY$)
 2150 IF I < 1 OR I > MAX.PER THEN KEY ON : CLS : KEY OFF : LOCATE 22,1 : PRINT "Number is out of range"; : GOTO 2090
 2160 GOSUB 2230  'to print
 2170 GOTO 2080
 2180 IF START.PER < 1 THEN START.PER = 1
 2190 KEY ON : CLS : KEY OFF
 2191 PRINT #3, "ID,Surname,Given Names,Sex,Father ID,Father Name,Mother ID,Mother Name,Birth Date,Birth City,Birth County,Birth State,Death Date,Death City,Death County,Death State,Burial Date,Burial City,Burial County,Burial State"
 2192 rem PRINT #3, CHR$(34);"ID,Surname,Given Names,Sex,Father ID,Father Name,Mother ID,Mother Name,Birth Date,Birth City,Birth County,Birth State,Death Date,Death City,Death County,Death State,Burial Date,Burial City,Burial County,Burial State"
 2200 FOR I = START.PER TO MAX.PER
 2210 GOSUB 2230
 2220 GOTO 3760
 2230 GET #1, I
 2240 LOCATE 23,1 : PRINT "Processing Record #";I
 2250 REM Extract information from the file for use
 2260 T1! = CVS(F1$) : T1 = T1!
 2270 IF T1 < 1 THEN 3750  'return
 2280 REM Print a Title on Each Page
 2290 rem PRINT #3 ,"Content of the Persons ";
 2300 IF DD.ORD$ = "no" THEN 2320
 2310 rem PRINT #3, "and Ordinances ";
 2320 rem IF DD.ORD$ = "no" THEN PRINT #3, "File" :ELSE PRINT #3, "Files"
 2330 rem PRINT #3 ,DATE$, TIME$
 2340 rem PRINT #3, ""
 2350 T2$ = F2$
 2360 T3$ = F3$
 2370 FOR J = 1 TO LEN(F3$)-1
 2380  IF RIGHT$(T3$,1)=" "THEN T3$ = LEFT$(T3$,LEN(T3$)-1) :ELSE J = LEN(F3$)-1
 2390 NEXT J
 2400 T4$ = F4$
 2410 rem IF LEFT$(T4$,1) = MALE.LTR$   THEN T4$ = MALE.SEX$
 2411 IF LEFT$(T4$,1) = MALE.LTR$   THEN T4$ = "0"
 2420 rem IF LEFT$(T4$,1) = FEMALE.LTR$ THEN T4$ = FEMALE.SEX$
 2421 IF LEFT$(T4$,1) = FEMALE.LTR$ THEN T4$ = "1"
 2430 T5! = CVS(F5$)
 2440 T6! = CVS(F6$) : T6 = T6!
 2450 T7! = CVS(F7$) : T7 = T7!
 2460 T8$ = F8$
 2470 T9$ = F9$
 2480 T10$ = F10$
 2490 T11$ = F11$
 2500 T12$ = F12$
 2510 T13$ = F13$
 2520 T14$ = F14$
 2530 T15$ = F15$
 2540 T16$ = F16$
 2550 T17$ = F17$
 2560 T18$ = F18$
 2570 T19$ = F19$
 2580 IF DD.ORD$ = "no" THEN 2870
 2590 REM Extract Ordinance Information
 2600 GET #2, I
 2610 U1! = CVS(O1$) : U1 = U1!
 2620 REM bypass if no Ordinances Record Present
 2630 IF U1 = 0 THEN GOSUB 3880 : GOTO 2870
 2640 U2$ = O2$
 2650 U3$ = O3$
 2660 U4$ = O4$
 2670 U5! = CVS(O5$) : U5 = U5!
 2680 U6! = CVS(O6$) : U6 = U6!
 2690 U7$ = O7$
 2700 U8$ = O8$
 2710 U9$ = O9$
 2720 U10$ = O10$
 2730 U11$ = O11$
 2740 U12! = CVS(O12$) : U12 = U12!
 2750 U13$ = O13$
 2760 U14$ = O14$
 2770 U15$ = O15$
 2780 U16$ = O16$
 2790 U17$ = O17$
 2800 U18$ = O18$
 2810 U19$ = O19$
 2820 U20$ = O20$
 2830 U21$ = O21$
 2840 U22$ = O22$
 2850 U23$ = O23$
 2860 U24$ = O24$
 2870 REM Print out of Personal Information
 2880 rem PRINT #3, ""
 2890 rem PRINT #3 ,"Personal Information"
 2900 rem PRINT #3, ""
 2910 rem PRINT #3, ""
 2920 rem PRINT #3 ,"Record-Number:",T1
 2921 PRINT #3 ,T1;",";
 2930 PRINT #3 ,T2$;",";
 2940 PRINT #3 ,T3$;",";
 2950 PRINT #3 ,T4$;",";
 2960 IF CODE$ = "no" THEN 2980
 2970 PRINT #3 ,T5!;",";
 2980 PRINT #3 ,T6;",";
 2990 rem PRINT #3 ,"Father's Name: ",
 3000 IF T6 = 0 THEN PRINT #3, "";","; : GOTO 3050
 3010 GET #1, T6
 3020 TMP$ = F2$ : GOSUB 3820 : TT2$ = TMP$
 3030 TMP$ = F3$ : GOSUB 3820 : TT3$ = TMP$
 3040 PRINT #3, LEFT$(TT3$ + " " + TT2$,33);","; : rem Fathers Name
 3050 PRINT #3 ,T7;",";
 3060 rem PRINT #3 ,"Mother's Name: ",
 3070 IF T7 = 0 THEN PRINT #3, "";","; : GOTO 3120
 3080 GET #1, T7
 3090 TMP$ = F2$ : GOSUB 3820 : TT2$ = TMP$
 3100 TMP$ = F3$ : GOSUB 3820 : TT3$ = TMP$
 3110 PRINT #3, LEFT$(TT3$ + " " + TT2$,33);","; : rem Mothers Name
 3120 PRINT #3 ,T8$;",";
 3130 PRINT #3 ,T9$;",";
 3140 PRINT #3 ,T10$;",";
 3150 PRINT #3 ,T11$;",";
 3160 PRINT #3 ,T12$;",";
 3170 PRINT #3 ,T13$;",";
 3180 PRINT #3 ,T14$;",";
 3190 PRINT #3 ,T15$;",";
 3200 PRINT #3 ,T16$;",";
 3210 PRINT #3 ,T17$;",";
 3220 PRINT #3 ,T18$;",";
 3230 PRINT #3 ,T19$
 3240 rem PRINT #3, "" : PRINT #3, "" : PRINT #3, ""
 3250 IF DD.ORD$ = "no" THEN 3740
 3260 PRINT #3, ""
 3270 PRINT #3 ,"Ordinance Information"
 3280 PRINT #3 , ""
 3290 PRINT #3, ""
 3300 REM Print the Ordinance Information
 3310 PRINT #3 ,"Christening Date:",U2$
 3320 PRINT #3 ,"Blessing Date:",U3$
 3330 PRINT #3 ,"Sealed to Parents:",U4$
 3340 PRINT #3 ,"Father's Record-Number:",U5
 3350 PRINT #3 ,"Father's Name: ",
 3360 IF U5 = 0 THEN PRINT #3, "" : GOTO 3410
 3370 GET #1, U5
 3380 TMP$ = F2$ : GOSUB 3820 : TT2$ = TMP$
 3390 TMP$ = F3$ : GOSUB 3820 : TT3$ = TMP$
 3400 PRINT #3, LEFT$(TT3$ + " " + TT2$,33)
 3410 PRINT #3 ,"Mother's Record-Number:",U6
 3420 PRINT #3 ,"Mother's Name: ",
 3430 IF U6 = 0 THEN PRINT #3,"" : GOTO 3480
 3440 GET #1, U6
 3450 TMP$ = F2$ : GOSUB 3820 : TT2$ = TMP$
 3460 TMP$ = F3$ : GOSUB 3820 : TT3$ = TMP$
 3470 PRINT #3, LEFT$(TT3$ + " " + TT2$,33)
 3480 PRINT #3 ,"Baptism Date:",,U7$
 3490 PRINT #3 ,"Confirmation Date:",U8$
 3500 PRINT #3 ,"Patriarchal Blessing:",U9$
 3510 PRINT #3 ,"Endowment Date:",U10$
 3520 IF LEFT$(T4$,1) = "M" THEN 3610
 3530 PRINT #3 ,"Sealed to Husband Date:",U11$
 3540 PRINT #3 ,"Husband's Record-Number:",U12
 3550 PRINT #3 ,"Husband's Name: ",
 3560 IF U12 = 0 THEN PRINT #3,"" : GOTO 3610
 3570 GET #1, U12
 3580 TMP$ = F2$ : GOSUB 3820 : TT2$ = TMP$
 3590 TMP$ = F3$ : GOSUB 3820 : TT3$ = TMP$
 3600 PRINT #3, LEFT$(TT3$ + " " + TT2$,33)
 3610 IF LEFT$(T4$,1) <> "M" THEN 3730
 3620 PRINT #3 ,"Aaronic Priesthood Date:",U13$
 3630 PRINT #3 ,"Deacon Date:",,U14$
 3640 PRINT #3 ,"Teacher Date:",,U15$
 3650 PRINT #3 ,"Priest Date:",,U16$
 3660 PRINT #3 ,"Melchizedek Priesthood:",U17$
 3670 PRINT #3 ,"Elder Date:",,U18$
 3680 PRINT #3 ,"Seventy Date:",,U19$
 3690 PRINT #3 ,"High Priest Date:",U20$
 3700 PRINT #3 ,"Bishop Date:",,U21$
 3710 PRINT #3 ,"Patriarch Date:",U22$
 3720 PRINT #3 ,"Apostle Date:",,U23$
 3730 PRINT #3 ,"Occupation:",,U24$
 3740 rem PRINT #3 ," "
 3750 RETURN
 3760 NEXT I
 3770 CLOSE #1
 3780 CLOSE #2
 3790 KEY ON : CLS : KEY OFF : LOCATE 21,1
 3800 rem PRINT "End of Program"
 3810 RUN CC.MENU$
 3820 REM Right-trim routine
 3830 TMP2$ = TMP$
 3840 FOR TRM = 1 TO LEN(TMP$)-1
 3850  IF RIGHT$(TMP$,1) = " " THEN TMP$ = LEFT$(TMP$,LEN(TMP$)-1) :ELSE TRM = LEN(TMP2$)-1
 3860 NEXT TRM
 3870 RETURN
 3880 REM Blank Ordinances if No Ord Record
 3890 U2$  = "" : U3$  = "" : U4$  = ""
 3900 U5   = 0  : U6   = 0  : U12  = 0
 3910 U7$  = "" : U8$  = "" : U9$  = "" : U10$ = ""
 3920 U11$ = "" : U13$ = "" : U14$ = "" : U15$ = ""
 3930 U16$ = "" : U17$ = "" : U18$ = "" : U19$ = ""
 3940 U20$ = "" : U21$ = "" : U22$ = "" : U23$ = ""
 3950 U24$ = ""
 3960 RETURN
