# Genealogy ON DISPLAY (v6.0)

_This software is Copyright (c) 1982-1989 by Melvin O. Duke_


## Introduction

This geneaology program was written in **BASIC**, during the age of **DOS** and _line printers_.

There is no way of exporting the data saved in the program for use in modern geneaology software, and I came across a use-case where the data in the program needed to be exported to a format so it could be processed and converted into a standard **GEDCOM** file. So I rewrote parts of the code that handles printing, to save the output to a CSV-file instead.

I'm sharing this, so that if there is someone else that has their old geneaology database made with **Genealogy ON DISPLAY** and need a way to export their data, this little _hack_ may be useful.

All credit and thanks goes to _Melvin O. Duke_ for writing the program.

## Usage

If no physical machine running **DOS** is available, the program works just fine under **DOSBox** with [GW-BASIC](https://archive.org/details/gwbasic.exe) from Archive.org; it is also included in the zip file for _**Genealogy ON DISPLAY**_ found on archive.org

To start the program, type the following command:
```
C:\GOD> gwbasic.exe /s:256 menu.bas
```

At the moment the following functions have been changed to export to a CSV-file:

**9 PRINTPER** - Prints Detailed Information about Persons. (Exports to **PRINTPER.csv**)
**10 PRINTMAR** - Prints Detailed Information about Marriages. (Exports to **PRINTMAR.csv**)

## Source

This version was aquired from [archive.org/details/MicroCom_351_Geneology](https://archive.org/details/MicroCom_351_Geneology)


## Screenshots

_Welcome screen_
![Welcome Screen](/img/god-welcomescreen.png)

_Main screen_
![Main Screen](/img/god-mainscreen.png)
