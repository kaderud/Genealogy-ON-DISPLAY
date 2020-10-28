  100 REM OVERVIEW Program
  110 REM Screen Overview of Genealogy ON DISPLAY
  120 REM Copyright 1986 ... 1989 by:  Melvin O. Duke
  130 KEY OFF
  140 SCREEN 0,1,0
  150 SCREEN 1 : COLOR 1 : CLS
  160 LOCATE  4,10 : PRINT "Genealogy ON DISPLAY";
  170 LOCATE  6,14 : PRINT "Version 6.0";
  180 LOCATE 10, 8 : PRINT "A User-Supported Program";
  190 LOCATE 14,10 : PRINT "By:  Melvin O. Duke";
  200 LOCATE 16,13 : PRINT "P.O. Box 2048";
  210 LOCATE 18, 6 : PRINT "Morgan Hill, CA  95038-2048";
  220 LOCATE 23, 1 : PRINT "Press the escape key (Esc) to end, or";
  230 LOCATE 24, 1 : PRINT "Press any key to continue at each pause";
  240 GOSUB 3870 'pause
  250 CLS
  260 LOCATE  1,10 : PRINT "CAPABILITIES";
  270 LOCATE  4, 2 : PRINT "CHARTS:";
  280 LOCATE  4,15 : PRINT "Ancestors";
  290 LOCATE  6,15 : PRINT "Families";
  300 LOCATE  8,15 : PRINT "Descendants";
  310 GOSUB 3870 'pause
  320 LOCATE 11, 2 : PRINT "LISTS:";
  330 LOCATE 11,15 : PRINT "Persons (numeric)";
  340 LOCATE 13,15 : PRINT "Persons (alphabetic)";
  350 LOCATE 15,15 : PRINT "Marriages (numeric)";
  360 LOCATE 17,15 : PRINT "Marriages (alphabetic)";
  370 LOCATE 19,15 : PRINT "Parent/Child Index";
  380 GOSUB 3870 'pause
  390 LOCATE 22, 2 : PRINT "DETAILS:";
  400 LOCATE 22,15 : PRINT "About Persons";
  410 LOCATE 24,15 : PRINT "About Marriages";
  420 GOSUB 3870 'pause
  430 CLS
  440 LOCATE  1,10 : PRINT "CAPABILITIES, Cont.";
  450 LOCATE  4, 2 : PRINT "SCREEN:";
  460 LOCATE  4,15 : PRINT "(This is where";
  470 LOCATE  6,15 : PRINT "Genealogy ON DISPLAY";
  480 LOCATE  8,15 : PRINT "Got its Name)";
  490 LOCATE 12,15 : PRINT "Ancestors";
  500 LOCATE 14,15 : PRINT "Families";
  510 LOCATE 16,15 : PRINT "Descendants";
  520 LOCATE 18,15 : PRINT "Personal Detail";
  530 LOCATE 20,15 : PRINT "LDS Ordinances";
  540 GOSUB 3870 'pause
  550 CLS
  560 LOCATE  2,10 : PRINT "DATA STORAGE PRINCIPLE";
  570 LOCATE  6, 2 : PRINT "Information Must be Recorded one time";
  580 LOCATE  8, 2 : PRINT "only.";
  590 GOSUB 3870 'pause
  600 LOCATE 13,10 : PRINT "DATA BASE PRINCIPLE";
  610 LOCATE 17, 2 : PRINT "Data Storage Must be Separated from";
  620 LOCATE 19, 2 : PRINT "Data Presentation.";
  630 GOSUB 3870 'pause
  640 CLS
  650 LOCATE  2,10 : PRINT "FILES";
  660 LOCATE  7, 2 : PRINT "DATA FILES:";
  670 LOCATE  7,15 : PRINT "Persons File";
  680 LOCATE  9,15 : PRINT "Marriages File";
  690 LOCATE 11,15 : PRINT "Ordinances File (LDS)";
  700 GOSUB 3870 'pause
  710 LOCATE 17, 2 : PRINT "INDEXES:";
  720 LOCATE 17,15 : PRINT "Parent/Child Index";
  730 LOCATE 19,15 : PRINT "Marriage Index";
  740 GOSUB 3870 'pause
  750 CLS
  760 LOCATE  2,10 : PRINT "RECORDS";
  770 LOCATE  6, 2 : PRINT "Person Record";
  780 R1 = 7 : C1 =  1 : R2 = 9 : C2 = 40 : GOSUB 3970 'box
  790 R1 = 7 : C1 =  7 : R2 = 9 : C2 =  7 : GOSUB 4020 'line
  800 R1 = 7 : C1 = 30 : R2 = 9 : C2 = 30 : GOSUB 3970 'line
  810 R1 = 7 : C1 = 35 : R2 = 9 : C2 = 35 : GOSUB 3970 'line
  820 LOCATE  8, 3 : PRINT "P.No";
  830 LOCATE  8,10 : PRINT "Vital Statistics";
  840 LOCATE  8,31 : PRINT "F.No";
  850 LOCATE  8,36 : PRINT "M.No";
  860 GOSUB 3870 'pause
  870 LOCATE 13, 2 : PRINT "Marriage Record"
  880 R1 = 14 : C1 =  1 : R2 = 16 : C2 = 40 : GOSUB 3970 'box
  890 R1 = 14 : C1 =  7 : R2 = 16 : C2 =  7 : GOSUB 4020 'line
  900 R1 = 14 : C1 = 30 : R2 = 16 : C2 = 30 : GOSUB 4020 'line
  910 R1 = 14 : C1 = 35 : R2 = 16 : C2 = 35 : GOSUB 4020 'line
  920 LOCATE 15, 3 : PRINT "M.No";
  930 LOCATE 15,10 : PRINT "Vital Statistics";
  940 LOCATE 15,31 : PRINT "H.No";
  950 LOCATE 15,36 : PRINT "W.No";
  960 GOSUB 3870 'pause
  970 LOCATE 20, 2 : PRINT "Ordinance Record"
  980 R1 = 21 : C1 = 1 : R2 = 23 : C2 = 40 : GOSUB 3970 'box
  990 R1 = 21 : C1 = 7 : R2 = 23 : C2 =  7 : GOSUB 4020 'box
 1000 LOCATE 22, 3 : PRINT "P.No";
 1010 LOCATE 22,10 : PRINT "LDS Ordinances";
 1020 GOSUB 3870 'pause
 1030 CLS
 1040 LOCATE  2,10 : PRINT "BUILDING A CHART OF ANCESTORS";
 1050 REM Person
 1060 LOCATE 14, 2 : PRINT "P       F M";
 1070 R1 = 13 : C1 =  1 : R2 = 15 : C2 = 13 : GOSUB 3970 'box
 1080 R1 = 13 : C1 =  9 : R2 = 15 : C2 =  9 : GOSUB 4020 'line
 1090 R1 = 13 : C1 = 11 : R2 = 15 : C2 = 11 : GOSUB 4020 'line
 1100 GOSUB 3870 'pause
 1110 REM Father
 1120 LOCATE  8,10 : PRINT "P       F M";
 1130 R1 =  7 : C1 =  9 : R2 = 9 : C2 = 21 : GOSUB 3970 'box
 1140 R1 =  7 : C1 = 17 : R2 = 9 : C2 = 17 : GOSUB 4020 'line
 1150 R1 =  7 : C1 = 19 : R2 = 9 : C2 = 19 : GOSUB 4020 'line
 1160 R1 = 13 : C1 = 10 : R2 = 9 : C2 = 10 : GOSUB 4020 'line
 1170 GOSUB 3870 'pause
 1180 REM Mother
 1190 LOCATE 20,12 : PRINT "P       F M";
 1200 R1 = 19 : C1 = 11 : R2 = 21 : C2 = 23 : GOSUB 3970 'box
 1210 R1 = 19 : C1 = 19 : R2 = 21 : C2 = 19 : GOSUB 4020 'line
 1220 R1 = 19 : C1 = 21 : R2 = 21 : C2 = 21 : GOSUB 4020 'line
 1230 R1 = 15 : C1 = 12 : R2 = 19 : C2 = 12 : GOSUB 4020 'line
 1240 GOSUB 3870 'pause
 1250 REM Paternal Grandfather
 1260 LOCATE  5,18 : PRINT "P       F M";
 1270 R1 =  4 : C1 = 17 : R2 =  6 : C2 = 29 : GOSUB 3970 'box
 1280 R1 =  4 : C1 = 25 : R2 =  6 : C2 = 25 : GOSUB 4020 'line
 1290 R1 =  4 : C1 = 27 : R2 =  6 : C2 = 27 : GOSUB 4020 'line
 1300 R1 =  6 : C1 = 18 : R2 =  7 : C2 = 18 : GOSUB 4020 'line
 1310 GOSUB 3870 'pause
 1320 REM Paternal Grandmother
 1330 LOCATE 11,20 : PRINT "P       F M";
 1340 R1 = 10 : C1 = 19 : R2 = 12 : C2 = 31 : GOSUB 3970 'box
 1350 R1 = 10 : C1 = 27 : R2 = 12 : C2 = 27 : GOSUB 4020 'line
 1360 R1 = 10 : C1 = 29 : R2 = 12 : C2 = 29 : GOSUB 4020 'line
 1370 R1 =  9 : C1 = 20 : R2 = 10 : C2 = 20 : GOSUB 4020 'line
 1380 GOSUB 3870 'pause
 1390 REM Maternal Grandfather
 1400 LOCATE 17,20 : PRINT "P       F M";
 1410 R1 = 16 : C1 = 19 : R2 = 18 : C2 = 31 : GOSUB 3970 'box
 1420 R1 = 16 : C1 = 27 : R2 = 18 : C2 = 27 : GOSUB 4020 'line
 1430 R1 = 16 : C1 = 29 : R2 = 18 : C2 = 29 : GOSUB 4020 'line
 1440 R1 = 18 : C1 = 20 : R2 = 19 : C2 = 20 : GOSUB 4020 'line
 1450 GOSUB 3870 'pause
 1460 REM Maternal Grandmother
 1470 LOCATE 23,22 : PRINT "P       F M";
 1480 R1 = 22 : C1 = 21 : R2 = 24 : C2 = 33 : GOSUB 3970 'box
 1490 R1 = 22 : C1 = 29 : R2 = 24 : C2 = 29 : GOSUB 4020 'line
 1500 R1 = 22 : C1 = 31 : R2 = 24 : C2 = 31 : GOSUB 4020 'line
 1510 R1 = 22 : C1 = 22 : R2 = 21 : C2 = 22 : GOSUB 4020 'line
 1520 GOSUB 3870 'pause
 1530 CLS
 1540 LOCATE  2,10 : PRINT "INDEXES";
 1550 LOCATE  6, 2 : PRINT "Parent/Child Index";
 1560 R1 =  7 : C1 =  8 : R2 = 13 : C2 = 28 : GOSUB 3970 'box
 1570 R1 =  7 : C1 = 15 : R2 = 13 : C2 = 15 : GOSUB 4020 'line
 1580 R1 =  7 : C1 = 21 : R2 = 13 : C2 = 21 : GOSUB 4020 'line
 1590 R1 =  9 : C1 =  8 : R2 =  9 : C2 = 28 : GOSUB 4020 'line
 1600 R1 = 11 : C1 =  8 : R2 = 11 : C2 = 28 : GOSUB 4020 'line
 1610 LOCATE  8, 9 : PRINT "Parent";
 1620 LOCATE  8,16 : PRINT "Child";
 1630 LOCATE  8,22 : PRINT "B-Date";
 1640 LOCATE 10, 9 : PRINT "Parent";
 1650 LOCATE 10,16 : PRINT "Child";
 1660 LOCATE 10,22 : PRINT "B-Date";
 1670 LOCATE 12, 9 : PRINT "Parent";
 1680 LOCATE 12,16 : PRINT "Child";
 1690 LOCATE 12,22 : PRINT "B-Date";
 1700 GOSUB 3870 'pause
 1710 LOCATE 16, 2 : PRINT "Marriages Index";
 1720 R1 = 17 : C1 =  8 : R2 = 23 : C2 = 28 : GOSUB 3970 'box
 1730 R1 = 19 : C1 =  8 : R2 = 19 : C2 = 28 : GOSUB 4020 'line
 1740 R1 = 21 : C1 =  8 : R2 = 21 : C2 = 28 : GOSUB 4020 'line
 1750 R1 = 17 : C1 = 15 : R2 = 23 : C2 = 15 : GOSUB 4020 'line
 1760 R1 = 17 : C1 = 21 : R2 = 23 : C2 = 21 : GOSUB 4020 'line
 1770 LOCATE 18, 9 : PRINT "Person";
 1780 LOCATE 18,16 : PRINT "Marr.";
 1790 LOCATE 18,22 : PRINT "M-Date";
 1800 LOCATE 20, 9 : PRINT "Person";
 1810 LOCATE 20,16 : PRINT "Marr.";
 1820 LOCATE 20,22 : PRINT "M-Date";
 1830 LOCATE 22, 9 : PRINT "Person";
 1840 LOCATE 22,16 : PRINT "Marr.";
 1850 LOCATE 22,22 : PRINT "M-Date";
 1860 GOSUB 3870 'pause
 1870 CLS
 1880 LOCATE  4,14 : PRINT "DATA BASE";
 1890 LOCATE 10, 8 : PRINT "A Relationship-Indexed";
 1900 LOCATE 12, 8 : PRINT "Data-base Organization";
 1910 LOCATE 20, 9 : PRINT "Ties it all together";
 1920 GOSUB 3870 'pause
 1930 CLS
 1940 LOCATE  2,10 : PRINT "BUILDING A CHART OF A FAMILY";
 1950 R1 = 10 : C1 = 2 : R2 = 12 : C2 = 11 : GOSUB 3970 'box
 1960 LOCATE 11, 3 : PRINT "Marriage";
 1970 GOSUB 3870 'pause
 1980 R1 =  5 : C1 =  2 : R2 =  7 : C2 = 11 : GOSUB 3970 'box
 1990 LOCATE  6, 3 : PRINT "Person";
 2000 R1 =  7 : C1 = 20 : R2 = 10 : C2 = 29 : GOSUB 3970 'box
 2010 LOCATE  8,21 : PRINT "Marriage";
 2020 LOCATE  9,21 : PRINT "Index";
 2030 R1 =  7 : C1 = 11 : R2 =  7 : C2 = 20 : GOSUB 4020 'line
 2040 R1 = 10 : C1 = 20 : R2 = 10 : C2 = 11 : GOSUB 4020 'line
 2050 GOSUB 3870 'pause
 2060 R1 = 12 : C1 = 20 : R2 = 16 : C2 = 29 : GOSUB 3970 'box
 2070 LOCATE 13,21 : PRINT "Parent/";
 2080 LOCATE 14,21 : PRINT " Child";
 2090 LOCATE 15,21 : PRINT "Index";
 2100 R1 = 16 : C1 =  2 : R2 = 18 : C2 = 11 : GOSUB 3970 'box
 2110 LOCATE 17, 3 : PRINT "Child";
 2120 R1 = 12 : C1 = 11 : R2 = 12 : C2 = 20 : GOSUB 4020 'line
 2130 R1 = 16 : C1 = 20 : R2 = 16 : C2 = 11 : GOSUB 4020 'line
 2140 GOSUB 3870 'pause
 2150 R1 = 18 : C1 =  2 : R2 = 20 : C2 = 11 : GOSUB 3970 'box
 2160 LOCATE 19, 3 : PRINT "Child";
 2170 GOSUB 3870 'pause
 2180 R1 = 20 : C1 =  2 : R2 = 22 : C2 = 11 : GOSUB 3970 'box
 2190 LOCATE 21, 3 : PRINT "Child";
 2200 GOSUB 3870 'pause
 2210 R1 = 22 : C1 =  2 : R2 = 24 : C2 = 11 : GOSUB 3970 'box
 2220 LOCATE 23, 3 : PRINT "Child";
 2230 GOSUB 3870 'pause
 2240 CLS
 2250 LOCATE  2,10 : PRINT "GETTING STARTED";
 2260 LOCATE  8, 2 : PRINT "List of Persons";
 2270 LOCATE 12, 2 : PRINT "List of Marriages";
 2280 LOCATE 16, 2 : PRINT "Available Space for Data";
 2290 GOSUB 3870 'pause
 2300 CLS
 2310 LOCATE  2,10 : PRINT "LIST OF PERSONS";
 2320 LOCATE  5, 2 : PRINT "Number  Name            F.No  M.No"
 2330 LOCATE  7, 2 : PRINT "  1";
 2340 LOCATE  9, 2 : PRINT "  2";
 2350 LOCATE 11, 2 : PRINT "  3";
 2360 LOCATE 13, 2 : PRINT "  4";
 2370 LOCATE 15, 2 : PRINT "  5";
 2380 LOCATE 17, 2 : PRINT "  6";
 2390 LOCATE 19, 2 : PRINT "  7";
 2400 LOCATE 21, 2 : PRINT "  8";
 2410 GOSUB 3870 'pause
 2420 LOCATE  7,10 : PRINT "You";
 2430 GOSUB 3870 'pause
 2440 LOCATE  9,10 : PRINT "Your Father";
 2450 GOSUB 3870 'pause
 2460 LOCATE 11,10 : PRINT "Your Mother";
 2470 GOSUB 3870 'pause
 2480 LOCATE  7,26 : PRINT "  2";
 2490 LOCATE  7,32 : PRINT "  3";
 2500 GOSUB 3870 'pause
 2510 LOCATE 13,10 : PRINT "Your Spouse";
 2520 GOSUB 3870 'pause
 2530 CLS
 2540 LOCATE  2,10 : PRINT "LIST OF MARRIAGES";
 2550 LOCATE  5, 2 : PRINT "M.No.  H.No  Husband    W.No  Wife";
 2560 LOCATE  7, 2 : PRINT "  1";
 2570 LOCATE  9, 2 : PRINT "  2";
 2580 LOCATE 11, 2 : PRINT "  3";
 2590 LOCATE 13, 2 : PRINT "  4";
 2600 LOCATE 15, 2 : PRINT "  5";
 2610 LOCATE 17, 2 : PRINT "  6";
 2620 LOCATE 19, 2 : PRINT "  7";
 2630 LOCATE 21, 2 : PRINT "  8";
 2640 GOSUB 3870 'pause
 2650 LOCATE  7, 9 : PRINT "  2   Dad";
 2660 LOCATE  7,26 : PRINT "  3   Mom";
 2670 GOSUB 3870 'pause
 2680 LOCATE  9, 9 : PRINT "  1   Mel";
 2690 LOCATE  9,26 : PRINT "  4   Helen";
 2700 GOSUB 3870 'pause
 2710 CLS
 2720 LOCATE 10,10 : PRINT "LET'S GET STARTED";
 2730 GOSUB 3870 'pause
 2740 CLS
 2750 LOCATE  3, 6 : PRINT "BRING UP BASIC";
 2760 LOCATE  7, 2 : PRINT "Type:   basic/s:256";
 2770 LOCATE  9, 4 : PRINT "and press the 'enter' key.";
 2780 LOCATE 13, 4 : PRINT "(Need a 256 byte file buffer"
 2790 LOCATE 15, 4 : PRINT " for the Genealogy Records)"
 2800 GOSUB 3870 'pause
 2810 CLS
 2820 LOCATE  3, 6 : PRINT "BRING UP THE GENEALOGY MENU";
 2830 LOCATE  7, 2 : PRINT "Type:   run ";CHR$(34);"menu";CHR$(34);
 2840 LOCATE  9, 4 : PRINT "and press the 'enter' key.";
 2850 GOSUB 3870 'pause
 2860 CLS
 2870 LOCATE  2,10 : PRINT "CREATE THE DATA FILES";
 2880 LOCATE  7, 2 : PRINT "Create (format) the Persons File";
 2890 LOCATE  9, 4 : PRINT "Select the CREATPER Program";
 2900 GOSUB 3870 'pause
 2910 LOCATE 13, 2 : PRINT "Create (format) the Marriages File";
 2920 LOCATE 15, 4 : PRINT "Select the CREATMAR Program";
 2930 GOSUB 3870 'pause
 2940 LOCATE 19, 2 : PRINT "Create (format) the Ordinances File";
 2950 LOCATE 21, 4 : PRINT "Select the CREATORD Program";
 2960 GOSUB 3870 'pause
 2970 CLS
 2980 LOCATE  2,10 : PRINT "ENTER YOUR DATA";
 2990 LOCATE  6, 2 : PRINT "Enter Personal Information";
 3000 LOCATE  8, 4 : PRINT "Select the UPDATPER Program";
 3010 GOSUB 3870 'pause
 3020 LOCATE 12, 2 : PRINT "Enter Marriage Information";
 3030 LOCATE 14, 4 : PRINT "Select the UPDATMAR Program";
 3040 GOSUB 3870 'pause
 3050 LOCATE 18, 2 : PRINT "Enter Ordinances Information";
 3060 LOCATE 20, 4 : PRINT "Select the UPDATORD Program";
 3070 GOSUB 3870 'pause
 3080 CLS
 3090 LOCATE  2,10 : PRINT "FORM THE INDEXES";
 3100 LOCATE  6, 2 : PRINT "Form the Parent/Child Index";
 3110 LOCATE  8, 4 : PRINT "Select the INDEXPC Program";
 3120 LOCATE 10, 6 : PRINT "(Run when Person Records Change)";
 3130 GOSUB 3870 'pause
 3140 LOCATE 16, 2 : PRINT "Form the Marriages Index";
 3150 LOCATE 18, 4 : PRINT "Select the INDEXMAR Program";
 3160 LOCATE 20, 6 : PRINT "(Run when Marriage Records Change)";
 3170 GOSUB 3870 'pause
 3180 CLS
 3190 LOCATE 11,10 : PRINT "NOW THE FUN BEGINS";
 3200 GOSUB 3870 'pause
 3210 CLS
 3220 LOCATE  2,10 : PRINT "VIEW YOUR GENEALOGY";
 3230 LOCATE  5, 2 : PRINT "Select the DISPLAY Program";
 3240 LOCATE  7, 4 : PRINT "View Personal Information";
 3250 LOCATE  9, 4 : PRINT "View Ancestors";
 3260 LOCATE 11, 4 : PRINT "View Families";
 3270 LOCATE 13, 4 : PRINT "View Ordinances";
 3280 GOSUB 3870 'pause
 3290 LOCATE 18, 2 : PRINT "Select the DESCEND Program";
 3300 LOCATE 20, 4 : PRINT "View Descendants";
 3310 GOSUB 3870 'pause
 3320 CLS
 3330 LOCATE  2,10 : PRINT "PAPER FOR THE CHARTS";
 3340 LOCATE  5, 2 : PRINT "Narrow (8-1/2 inch), or"
 3350 LOCATE  7, 2 : PRINT "Wide (14 inch) Paper";
 3360 LOCATE 11, 2 : PRINT "Long (11 inch), or";
 3370 LOCATE 13, 2 : PRINT "Short (8-1/2 inch) Paper";
 3380 LOCATE 17, 2 : PRINT "Continuous Forms, or";
 3390 LOCATE 19, 2 : PRINT "Single Sheets";
 3400 GOSUB 3870 'pause
 3410 CLS
 3420 LOCATE  2,10 : PRINT "PRINT THE CHARTS";
 3430 LOCATE  5, 2 : PRINT "Print Charts of Ancestors";
 3440 LOCATE  7, 4 : PRINT "Select the ANCESTOR Program";
 3450 GOSUB 3870 'pause
 3460 LOCATE 11, 2 : PRINT "Print Charts of Families";
 3470 LOCATE 13, 4 : PRINT "Select the FAMILY Program";
 3480 GOSUB 3870 'pause
 3490 LOCATE 17, 2 : PRINT "Print Charts of Descendants";
 3500 LOCATE 19, 4 : PRINT "Select the DESCEND Program";
 3510 GOSUB 3870 'pause
 3520 CLS
 3530 LOCATE  2,10 : PRINT "LISTS";
 3540 LOCATE  5, 2 : PRINT "List of Persons by Number";
 3550 LOCATE  7, 4 : PRINT "Select the LISTPER Program";
 3560 GOSUB 3870 'pause
 3570 LOCATE  9, 2 : PRINT "Alphabetized List of Persons";
 3580 LOCATE 11, 4 : PRINT "Select the ALPHAPER Program";
 3590 GOSUB 3870 'pause
 3600 LOCATE 13, 2 : PRINT "List of Marriages by Number";
 3610 LOCATE 15, 4 : PRINT "Select the LISTMAR Program";
 3620 GOSUB 3870 'pause
 3630 LOCATE 17, 2 : PRINT "Alphabetized List of Marriages";
 3640 LOCATE 19, 4 : PRINT "Select the ALPHAMAR Program";
 3650 GOSUB 3870 'pause
 3660 LOCATE 21, 2 : PRINT "List the Parent/Child Index";
 3670 LOCATE 23, 4 : PRINT "Select the LISTPCI Program";
 3680 GOSUB 3870 'pause
 3690 CLS
 3700 LOCATE  2, 5 : PRINT "PRINT DETAILED INFORMATION";
 3710 LOCATE  6, 2 : PRINT "Print Detailed Personal Data";
 3720 LOCATE  9, 4 : PRINT "Select the PRINTPER Program";
 3730 GOSUB 3870 'pause
 3740 LOCATE 14, 2 : PRINT "Print Detailed Marriage Data";
 3750 LOCATE 17, 4 : PRINT "Select the PRINTMAR Program";
 3760 GOSUB 3870 'pause
 3770 CLS
 3780 LOCATE  4,10 : PRINT "Genealogy ON DISPLAY";
 3790 LOCATE  6,14 : PRINT "Version 6.0";
 3800 LOCATE 10, 8 : PRINT "A User-Supported Program";
 3810 LOCATE 14,10 : PRINT "By:  Melvin O. Duke";
 3820 LOCATE 16,13 : PRINT "P.O. Box 2048";
 3830 LOCATE 18, 6 : PRINT "Morgan Hill, CA  95038-2048";
 3840 LOCATE 23, 1
 3850 GOSUB 3870 'pause
 3860 GOTO 3900
 3870 REM Generalized Pause Routine
 3880 A$ = INKEY$
 3890 IF A$ = CHR$(27) THEN 3900 :ELSE 3940
 3900 CLS
 3910 SCREEN 0,0,0,0
 3920 WIDTH "scrn:",80
 3930 GOTO 4070
 3940 IF A$ = "" THEN 3880
 3950 RETURN
 3960 '
 3970 REM Generalized Box Routine
 3980 REM Entry is R1, C1, R2, C2
 3990 LINE (8*C1-4,8*R1-4)-(8*C2-4,8*R2-4),,B
 4000 RETURN
 4010 '
 4020 REM Generalized Line Routine
 4030 REM Entry is R1, C1, R2, C2
 4040 LINE (8*C1-4,8*R1-4)-(8*C2-4,8*R2-4)
 4050 RETURN
 4060 '
 4070 END
