  100 REM DESCEND Program.
  110 REM Prints (and Displays) Charts of Descendants
  120 REM Copyright (c) 1982 ... 1989 by: Melvin O. Duke.
  130 OPTION BASE 0
  140 DEFINT A-Z
  600 REM Titles
  610 TITLE$ = "Charts of Descendants"
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
  940 DIM PERSATLVL(MAX.GEN+1), SEXATLVL$(MAX.GEN+1)
  950 DIM MARRATLVL(MAX.GEN+1), SPOUSATLVL(MAX.GEN+1)
  960 DIM TEMPMAR(MAX.GEN+1), TEMPCHILD(MAX.GEN+1)
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
 2000 REM DESCEND Program Starts Here.
 2010 REM Prevent Common User Errors
 2020 IF MAX.GEN < 1 THEN MAX.GEN = 1
 2030 IF MAX.LINES < 20 THEN MAX.LINES = 20
 2040 REM set initial color
 2050 COLOR W,K
 2060 REM Ask about whether to print
 2070 PRT.SW = 0
 2080 LOCATE 19,1
 2090 PRINT "Charts of Descendants will be Displayed."
 2100 INPUT "Do you want to Print as well as to Display";REPLY$
 2110 IF LEFT$(REPLY$,1)="y" OR LEFT$(REPLY$,1) ="Y"THEN PRT.SW = 1
 2120 ON PRT.SW+1 GOTO 2230, 2140
 2130 STOP
 2140 LOCATE 1,1 : PRINT "Charts will be Printed"
 2150 GOSUB 6110 'Clean
 2160 REM Routine to obtain Printer Information
 2170 LOCATE 21,1 : PRINT "Make sure that the Printer is on and Ready"
 2180 LOCATE 22,1 : PRINT "Make sure that the correct Diskette(s) are in place."
 2190 LOCATE 23,1 : PRINT "Then press any key"
 2200 A$ = INKEY$ : IF A$ = "" THEN 2200
 2210 REM reset all Printer Defaults
 2220 WIDTH "lpt1:", 132  'For printing Genealogy Forms
 2230 KEY ON : CLS : KEY OFF
 2240 REM Read the Parent/Child Index
 2250 OPEN CC.PCINDEX$ FOR INPUT AS #1
 2260 LOCATE 4,1 : PRINT "Open the Parent/Child Index"
 2270 INPUT #1, PC.COUNT
 2280 IF PC.COUNT <> 0 THEN 2330
 2290 PRINT "Parent/Child Index has no Index Records"
 2300 PRINT "Press any key to return to the Menu"
 2310 A$ = INKEY$ : IF A$ = "" THEN 2310
 2320 GOTO 5680
 2330 DIM PA.ID(PC.COUNT), CH.ID(PC.COUNT)
 2340 FOR I = 1 TO PC.COUNT
 2350 LOCATE 5,1 : PRINT "Reading Index Record #:";I;
 2360  INPUT #1, PA.ID(I), CH.ID(I)
 2370 NEXT I
 2380 CLOSE #1
 2390 REM Read the Marriage Index
 2400 LOCATE 7,1 : PRINT "Open the Marriage Index"
 2410 OPEN CC.MINDEX$ FOR INPUT AS #2
 2420 INPUT #2, M.COUNT
 2430 IF M.COUNT <> 0 THEN 2480
 2440 PRINT "Marriage Index has no Index Records"
 2450 PRINT "Press any key to return to the Menu"
 2460 A$ = INKEY$ : IF A$ = "" THEN 2460
 2470 GOTO 5680
 2480 DIM PERS.NO(M.COUNT), M.NO(M.COUNT)
 2490 FOR I = 1 TO M.COUNT
 2500 LOCATE 8,1 : PRINT "Reading Marriage Index Record #:";I;
 2510  INPUT #2,PERS.NO(I), M.NO(I)
 2520 NEXT I
 2530 CLOSE #2
 2540 REM Open the Persons File
 2550 LOCATE 10,1 : PRINT "Open the Persons File"
 2560 OPEN CC.PERSFILE$ AS #1 LEN = 256
 2570 FIELD 1, 5 AS F1$, 20 AS F2$, 30 AS F3$, 2 AS F4$, 5 AS F5$, 5 AS F6$, 5 AS F7$, 11 AS F8$, 18 AS F9$, 16 AS F10$, 16 AS F11$, 11 AS F12$, 18 AS F13$, 16 AS F14$, 16 AS F15$, 11 AS F16$, 18 AS F17$, 16 AS F18$, 16 AS F19$
 2580 REM open the Marriages File
 2590 LOCATE 12,1 : PRINT "Open the Marriage File"
 2600 OPEN CC.MARRFILE$ AS #2 LEN = 128
 2610 FIELD 2, 5 AS M1$, 5 AS M2$, 5 AS M3$, 5 AS M4$, 11 AS M5$, 18 AS M6$, 16 AS M7$, 16 AS M8$, 45 AS M9$
 2620 REM Obtain a Person Record from the User
 2630 LOCATE 20,1
 2640 INPUT "Enter the Record-number of a Person (0 to quit)"; REPLY$
 2650 IF REPLY$ = "0" THEN 5680
 2660 PERSON = VAL(REPLY$)
 2670 IF PERSON < 1 OR PERSON > MAX.PER THEN KEY ON : CLS : LOCATE 19,1 : PRINT "Number is out of range"; : KEY OFF : GOTO 2620
 2680 ON PRT.SW + 1 GOTO 3120, 2690
 2690 GOSUB 2700 : GOTO 3120
 2700 REM Reset the Printer Characteristics for next page if required.
 2710 IF FORMS = 1 THEN 2750  'Don't stop if forms are continuous
 2720 REM Process Single Sheets
 2730 PRINT "Press any key when next form is ready"
 2740 A$ = INKEY$ : IF A$ = "" THEN 2740
 2750 REM Reset paper sensing if required
 2760 IF FORMS = 2 THEN LPRINT PAP.SEN.OFF$;
 2770 REM Reset paper length if required
 2780 IF LENGTH = 1 THEN LPRINT PAP.SHORT$;
 2790 IF LENGTH = 1 AND MAX.LINES = 55 THEN MAX.LINES = 43
 2800 REM Reset Condensed Printing if required
 2810 IF WIDE = 1 THEN LPRINT COMPR.ON$;
 2820 RETURN
 2830 REM Routine to do a Right-trim
 2840 TEMP2$ = ""
 2850 FOR J = LEN(TEMP1$) TO 1 STEP -1
 2860  IF MID$(TEMP1$,J,1) = " " THEN 2880
 2870  TEMP2$ = LEFT$(TEMP1$,J) : J = 1
 2880 NEXT J
 2890 RETURN
 2900 REM Routine to Extract Personal Information
 2910 T1! = CVS(F1$) : T1 = T1!
 2920 TEMP1$ = F2$ : TEMP2$ = F2$ : GOSUB 2830
 2930 T2$ = TEMP2$
 2940 IF CHART.NOS$ = "n" THEN GOSUB 5870
 2950 TEMP1$ = F3$ : TEMP2$ = F3$ : GOSUB 2830
 2960 T3$ = TEMP2$
 2970 T4$ = " "
 2980 IF LEFT$(F4$,1) = MALE.LTR$   THEN T4$ = MALE.LTR$
 2990 IF LEFT$(F4$,1) = FEMALE.LTR$ THEN T4$ = FEMALE.LTR$
 3000 T6! = CVS(F6$) : T6 = T6! 'Father
 3010 T7! = CVS(F7$) : T7 = T7! 'Mother
 3020 T8$ = F8$
 3030 T12$ = F12$
 3040 RETURN
 3050 RETURN
 3060 REM Extraction of Marriage Information
 3070 TT1! = CVS(M1$) : TT1 = TT1! 'Rec.no
 3080 TT2! = CVS(M2$) : TT2 = TT2! 'Husband
 3090 TT3! = CVS(M3$) : TT3 = TT3! 'Wife
 3100 TT5$ = M5$  'Marriage Date
 3110 RETURN
 3120 REM Routine to Produce a Chart of Descendants
 3130 REM First of all, set all numbers to 0 and letters to -
 3140 FOR ATLVL = 1 TO MAX.GEN
 3150  PERSATLVL(ATLVL) = 0
 3160  SEXATLVL$(ATLVL) = "-"
 3170  MARRATLVL(ATLVL) = 0
 3180  SPOUSATLVL(ATLVL) = 0
 3190 NEXT ATLVL
 3200 REM Establish a starting-point for level 1
 3210 LEVEL = 1
 3220 PERSATLVL(LEVEL) = PERSON
 3230 GET #1, PERSATLVL(LEVEL)
 3240 GOSUB 2900  'for Person's Information
 3250 REM Test if Empty
 3260 IF T1 > 0 THEN 3290
 3270 KEY ON : CLS : KEY OFF : LOCATE 20,1 : PRINT "Record";PERSON;"is Empty"
 3280 GOTO 4010
 3290 SEXATLVL$(LEVEL) = T4$
 3300 PERSON$ = T3$+" "+T2$
 3310 PAGE.NO = 1 : PAGE.LEN = 0
 3320 ON PRT.SW+1 GOTO 3720, 3330
 3330 REM Print the Title on the First Page, Date, Time, and Person Indicated
 3340 GOSUB 3350 : GOSUB 3390 : GOTO 3670
 3350 LPRINT
 3360 LPRINT TAB(11);"Chart of Descendants of ";PERSON$;
 3370 LPRINT TAB(112); "Page"; PAGE.NO
 3380 RETURN
 3390 LPRINT TAB(11);"Person Record"; T1
 3400 LPRINT TAB(11);"Prepared on ";DATE$;" at ";TIME$
 3410 LPRINT TAB(11);"Using Version 6.0 of Genealogy ON DISPLAY"
 3420 IF PREP1$ = "" THEN 3460
 3430 LPRINT TAB(11);"By: ";
 3440 LPRINT PREP1$
 3450 PAGE.LEN = PAGE.LEN + 1
 3460 IF PREP2$ = "" THEN 3490
 3470 LPRINT TAB(15); PREP2$
 3480 PAGE.LEN = PAGE.LEN + 1
 3490 IF PREP3$ = "" THEN 3520
 3500 LPRINT TAB(15); PREP3$
 3510 PAGE.LEN = PAGE.LEN + 1
 3520 IF PREP4$ = "" THEN 3550
 3530 LPRINT TAB(15); PREP4$
 3540 PAGE.LEN = PAGE.LEN + 1
 3550 LPRINT
 3560 LPRINT TAB(11);"  d-Descendant Generation Name";
 3570 LPRINT TAB( 83);"Date of";
 3580 LPRINT TAB( 96);"Date of";
 3590 LPRINT TAB(109);"Date of"
 3600 LPRINT TAB(11);"   s-Spouse     Generation Name";
 3610 LPRINT TAB( 83);"Birth";
 3620 LPRINT TAB( 96);"Marriage";
 3630 LPRINT TAB(109);"Death"
 3640 LPRINT TAB(11);
 3650 FOR VERT = 1 TO 109 : LPRINT "-";: NEXT VERT : LPRINT
 3660 RETURN
 3670 LPRINT TAB(11);
 3680 LPRINT " -1 "+LEFT$(T3$+" "+T2$,69);
 3690 LPRINT TAB( 83);T8$;
 3700 LPRINT TAB(109);T12$
 3710 PAGE.LEN = PAGE.LEN + 10
 3720  KEY ON : CLS : KEY OFF : COLOR O,K
 3730  PRINT "Chart of Descendants for "; T3$;" ";T2$
 3740  PRINT
 3750  PRINT "Prepared on ";DATE$;" at ";TIME$
 3760  PRINT "Using Version 6.0 of Genealogy ON DISPLAY"
 3770  PRINT
 3780 IF PREP1$ = "" THEN 3820
 3790  PRINT "By: ";
 3800  PRINT PREP1$
 3810 '
 3820  IF PREP2$ = "" THEN 3850
 3830  PRINT TAB(5); PREP2$
 3840 '
 3850  IF PREP3$ = "" THEN 3880
 3860  PRINT TAB(5); PREP3$
 3870 '
 3880  IF PREP4$ = "" THEN 3910
 3890  PRINT TAB(5); PREP4$
 3900 '
 3910  PRINT : COLOR O,K
 3920  PRINT "  d-Descendant Generation Name"
 3930  PRINT "   s-Spouse     Generation Name"
 3940 COLOR P,K : FOR VERT = 1 TO 79 :  PRINT "-";: NEXT VERT :  PRINT
 3950 COLOR G,K : PRINT " -1 "+LEFT$(T3$+" "+T2$,76)
 3960 COLOR W,K
 3970 MLEVEL=0
 3980 GOTO 4060  'look for marriage
 3990 ON PRT.SW+1 GOTO 4010,4000
 4000 LPRINT FORM.FEED$;
 4010 PRINT
 4020 PRINT "Press any key to continue"
 4030 A$ = INKEY$ : IF A$ = "" THEN 4030
 4040 KEY ON : CLS : KEY OFF
 4050 GOTO 2620
 4060 REM Locate an unreported marriage, if present
 4070 MLEVEL = MLEVEL + 1
 4080 REM Establish Skip-ahead Start-value and Delta
 4090 MRECATLVL = 1 : DELTA = INT(M.COUNT/10) : IF DELTA = 0 THEN 4140
 4100 REM Add delta and test if too far
 4110 MRECATLVL = MRECATLVL + DELTA
 4120 IF MRECATLVL > 9 * DELTA THEN 4140
 4130 IF PERS.NO(MRECATLVL) < PERSATLVL(LEVEL) THEN 4110 'Not there yet
 4140 MRECATLVL = MRECATLVL - DELTA -1
 4150 REM Search Routine
 4160 MRECATLVL = MRECATLVL + 1
 4170  IF PERS.NO(MRECATLVL) < PERSATLVL(LEVEL) THEN 4880 'Not there yet
 4180  IF PERS.NO(MRECATLVL) > PERSATLVL(LEVEL) THEN MRECATLVL = M.COUNT : GOTO 4880
 4190  REM found a marriage.  Try to accept it.
 4200  IF MARRATLVL(LEVEL) <> 0 AND MARRATLVL(LEVEL) = M.NO(MRECATLVL) THEN 4880
 4210  IF MARRATLVL(LEVEL) = 0 THEN MARRATLVL(LEVEL) = M.NO(MRECATLVL)
 4220  REM get the marriage record, and the spouse
 4230  GET #2, M.NO(MRECATLVL)
 4240  GOSUB 3060  'to Extract Marriage Information
 4250  IF SEXATLVL$(LEVEL) = MALE.LTR$   THEN SELF = TT2 : SPOUSE = TT3
 4260  IF SEXATLVL$(LEVEL) = FEMALE.LTR$ THEN SELF = TT3 : SPOUSE = TT2
 4270  SPOUSATLVL(LEVEL) = SPOUSE
 4280  PERSATLVL(LEVEL) = SELF
 4290  GET #1, SPOUSE
 4300  GOSUB 2900  'to Extract Personal Information
 4310 IF CHART.NOS$ = "n" THEN GOSUB 5990
 4320 ON PRT.SW+1 GOTO 4490, 4330
 4330  REM Now print the Spouse
 4340  LPRINT TAB(11);
 4350  FOR VERT = 2 TO LEVEL
 4360   LPRINT "| ";
 4370  NEXT VERT
 4380  LPRINT " ";
 4390  LPRINT "s"+LEFT$(STR$(-VERT+1)+" "+T3$+" "+T2$,119-(2*VERT));
 4400  IF T8$ = SPACE$(11) THEN 4420
 4410  LPRINT TAB( 83);T8$;
 4420  IF TT5$ = SPACE$(11) THEN 4440
 4430  LPRINT TAB( 96);TT5$;
 4440  IF T12$ = SPACE$(11) THEN 4460
 4450  LPRINT TAB(109);T12$;
 4460  LPRINT
 4470  PAGE.LEN = PAGE.LEN + 1
 4480  GOSUB 5780  'test page-break
 4490  COLOR P,K
 4500  FOR VERT = 2 TO LEVEL
 4510    PRINT "| ";
 4520  NEXT VERT
 4530   PRINT " ";
 4540   COLOR G,K : PRINT "s"+STR$(-VERT+1)+" "+T3$+" "+T2$
 4550   COLOR W,K
 4560  REM Line After the Spouse
 4570 ON PRT.SW+1 GOTO 4690, 4580
 4580  LPRINT TAB(11);
 4590  FOR VERT = 2 TO LEVEL
 4600   LPRINT "| ";
 4610  NEXT VERT
 4620  LPRINT "+";
 4630  FOR VERT = LEVEL*2 TO 109
 4640   LPRINT "-";
 4650  NEXT VERT
 4660  LPRINT
 4670  PAGE.LEN = PAGE.LEN + 1
 4680  GOSUB 5780  'test page-break
 4690  COLOR P,K : FOR VERT = 2 TO LEVEL
 4700    PRINT "| ";
 4710  NEXT VERT
 4720   PRINT "+";
 4730  FOR VERT = LEVEL*2 TO 79
 4740    PRINT "-";
 4750  NEXT VERT
 4760   PRINT : COLOR W,K
 4770  TEMPMAR(LEVEL) = MRECATLVL        'Save the Index
 4780  REM now look for children
 4790  LEVEL = LEVEL + 1
 4800  GOTO 4910                         'Look for Children of this Marriage
 4810  REM blank prior level
 4820  PERSATLVL(LEVEL) = 0
 4830  SEXATLVL$(LEVEL) = "-"
 4840  MARRATLVL(LEVEL) = 0
 4850  SPOUSATLVL(LEVEL) = 0
 4860  LEVEL = LEVEL -1
 4870  MRECATLVL = TEMPMAR(LEVEL)        'Restore the Index
 4880 IF MRECATLVL < M.COUNT THEN 4160
 4890 MLEVEL = MLEVEL - 1
 4900 IF MLEVEL = 0 THEN 3990 :ELSE 5430
 4910 REM Search for Children of the Marriage
 4920 IF LEVEL > MAX.GEN THEN 5670  'return
 4930 REM Establish Skip-ahead Start-value and Delta
 4940 LL = 1 : DELTA = INT(PC.COUNT/10) : IF DELTA = 0 THEN 4990
 4950 REM Add delta and test if too far
 4960 LL = LL + DELTA
 4970 IF LL > 9 * DELTA THEN 4990
 4980 IF PERSATLVL(LEVEL-1) > PA.ID(LL) THEN 4960
 4990 LL = LL -DELTA -1
 5000 REM Search Routine
 5010 LL = LL + 1
 5020  IF PERSATLVL(LEVEL-1) > PA.ID(LL) THEN 5440
 5030  IF PERSATLVL(LEVEL-1) < PA.ID(LL) THEN LL = PC.COUNT : GOTO 5440
 5040  REM found a child.  Try to accept.
 5050  PERSATLVL(LEVEL) = CH.ID(LL)
 5060  GET #1, CH.ID(LL)
 5070  GOSUB 2900  'To extract personal information
 5080  REM identify that both parents match
 5090  IF SEXATLVL$(LEVEL-1) = MALE.LTR$ THEN 5120
 5100  IF SEXATLVL$(LEVEL-1) = FEMALE.LTR$ THEN 5160
 5110  STOP
 5120  REM Male Parent in Direct Line
 5130  IF PERSATLVL(LEVEL-1) <> T6 THEN 5440
 5140  IF SPOUSATLVL(LEVEL-1) <> T7 THEN 5440
 5150  GOTO 5190
 5160  REM Female Parent in Direct Line
 5170  IF PERSATLVL(LEVEL-1) <> T7 THEN 5440
 5180  IF SPOUSATLVL(LEVEL-1) <> T6 THEN 5440
 5190  REM Passed All Tests, so print this child
 5200 ON PRT.SW+1 GOTO 5330, 5210
 5210  LPRINT TAB(11);
 5220  FOR VERT = 2 TO LEVEL
 5230   LPRINT "| ";
 5240  NEXT VERT
 5250  LPRINT "d"+LEFT$(STR$(-VERT+1)+" "+T3$+" "+T2$,120-(2*VERT));
 5260  IF T8$ = SPACE$(11) THEN 5280
 5270  LPRINT TAB( 83);T8$;
 5280  IF T12$ = SPACE$(11) THEN 5300
 5290  LPRINT TAB(109);T12$;
 5300  LPRINT
 5310  PAGE.LEN = PAGE.LEN + 1
 5320  GOSUB 5780  'test page-break
 5330  COLOR P,K : FOR VERT = 2 TO LEVEL
 5340    PRINT "| ";
 5350  NEXT VERT
 5360   COLOR G,K : PRINT "d"+STR$(-VERT+1)+" "+T3$+" "+T2$
 5370   COLOR W,K
 5380  REM save information at this level
 5390  SEXATLVL$(LEVEL) = T4$
 5400  REM Search for Spouse
 5410  TEMPCHILD(LEVEL) = LL             'Save the Index
 5420  GOTO 4060  'for Marriage Search
 5430  LL = TEMPCHILD(LEVEL)             'Restore the Index
 5440 IF LL < PC.COUNT THEN 5010
 5450 REM Print a line after last child
 5460 ON PRT.SW+1 GOTO 5580, 5470
 5470  LPRINT TAB(11);
 5480  FOR VERT = 1 TO 2*LEVEL-4 STEP 2
 5490   LPRINT "| ";
 5500  NEXT VERT
 5510  LPRINT "+";
 5520  FOR VERT = 2*LEVEL-2 TO 109
 5530   LPRINT "-";
 5540  NEXT VERT
 5550  LPRINT
 5560  PAGE.LEN = PAGE.LEN + 1
 5570  GOSUB 5780  'test page-break
 5580 COLOR P
 5590  FOR VERT = 1 TO 2*LEVEL-4 STEP 2
 5600    PRINT "| ";
 5610  NEXT VERT
 5620   PRINT "+";
 5630  FOR VERT = 2*LEVEL-2 TO 79
 5640    PRINT "-";
 5650  NEXT VERT
 5660   PRINT : COLOR W,K
 5670 GOTO 4810  'return
 5680 REM Wrapup
 5690 ON PRT.SW+1 GOTO 5740, 5700
 5700 LPRINT PAP.SENS.OFF$;
 5710 LPRINT PAP.LONG$;
 5720 LPRINT COMPR.OFF$;
 5730 WIDTH "lpt1:",80
 5740 CLOSE
 5750 KEY ON : CLS : KEY OFF : LOCATE 21,1
 5760 PRINT "End of Program"
 5770 RUN CC.MENU$
 5780 REM Page-break Test
 5790 IF PAGE.LEN < MAX.LINES THEN 5850
 5800 REM Page eject,and reset parms
 5810 LPRINT FORM.FEED$;
 5820 GOSUB 2700  'Reset Printer
 5830 PAGE.NO = PAGE.NO + 1 : PAGE.LEN = 6
 5840 GOSUB 3350 : GOSUB 3550 'top of next page
 5850 RETURN
 5860 END
 5870 REM Routine to Obtain a Usable Person Number for the Chart
 5880 REM Convert the Person Number to a String
 5890 PNUM$ = STR$(T1)
 5900 REM Find the Length of the String
 5910 PLEN = LEN(PNUM$)
 5920 REM Get rid of the leading space for algebraic sign
 5930 PNUM$ = RIGHT$(PNUM$,PLEN-1)
 5940 REM Surround with Quotes and add a Leading Space
 5950 PNUM$ = " (P-" + PNUM$ + ")"
 5960 REM Suffix Person Number to Surname
 5970 T2$ = T2$ + PNUM$
 5980 RETURN
 5990 REM Routine to Obtain a Usable Marriage Number for the Chart
 6000 REM Convert the Marriage Number to a String
 6010 PNUM$ = STR$(TT1)
 6020 REM Find the Length of the String
 6030 PLEN = LEN(PNUM$)
 6040 REM Get rid of the leading space for algebraic sign
 6050 PNUM$ = RIGHT$(PNUM$,PLEN-1)
 6060 REM Surround with Quotes and add a Leading Space
 6070 PNUM$ = " (M-" + PNUM$ + ")"
 6080 REM Suffix Person Number to Surname
 6090 T2$ = T2$ + PNUM$
 6100 RETURN
 6110 REM Clean User Input Area
 6120 LOCATE 19,1 : PRINT SPACE$(79);
 6130 LOCATE 20,1 : PRINT SPACE$(79);
 6140 LOCATE 21,1 : PRINT SPACE$(79);
 6150 LOCATE 22,1 : PRINT SPACE$(79);
 6160 LOCATE 23,1 : PRINT SPACE$(79);
 6170 RETURN
