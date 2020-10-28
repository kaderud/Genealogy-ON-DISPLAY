  100 LPRINT TAB(10);"Changes to Documentation Programs to support Other Printers."
  110 LPRINT
  120 LPRINT TAB(10);"Each of the documentation programs contains its own text"
  130 LPRINT TAB(10);"processor.  There is a determination of whether each line"
  140 LPRINT TAB(10);"is a command (begun with a period) or is normal text."
  150 LPRINT TAB(10);"If it is a command, then additional processing is done,"
  160 LPRINT TAB(10);"including the use of some of the characterists of the"
  170 LPRINT TAB(10);"printer."
  180 LPRINT
  190 LPRINT TAB(10);"The definitions for the characters which control the"
  200 LPRINT TAB(10);"printer are found in lines 180 to 220 in each of the"
  210 LPRINT TAB(10);"documentation programs.  They are:"
  220 LPRINT
  230 LPRINT TAB(10);"Variable Name    Purpose"
  240 LPRINT TAB(10);"--------------   -------------------------------"
  250 LPRINT TAB(10);"FORM.FEED$       Moves Paper to Top of Next Page"
  260 LPRINT TAB(10);"COMPR.ON$        Sets Compressed Printing On"
  270 LPRINT TAB(10);"COMPR.OFF$       Sets Compressed Printing Off"
  280 LPRINT TAB(10);"BOLD.ON$         Sets Emphasized Printing On"
  290 LPRINT TAB(10);"BOLD.OFF$        Sets Emphasized Printing Off"
  300 LPRINT TAB(10);"EXPAND.ON$       Sets Expanded Printing On"
  310 LPRINT TAB(10);"EXPAND.OFF$      Sets Expanded Printing Off"
  320 LPRINT
  330 LPRINT TAB(10);"The definitions in the lines of the programs should be"
  340 LPRINT TAB(10);"changed to the definitions for the printer which you"
  350 LPRINT TAB(10);"will be using."
  360 FOR I = 1 TO 40 : LPRINT : NEXT I
  370 END
