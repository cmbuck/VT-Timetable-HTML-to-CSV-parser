VT-Timetable-HTML-to-CSV-parser
===============================

Parses Printer-Friendly HTML timetable of classes to CSV format

Dependency: sed

Usage: In Windows, simply drag and drop a saved HTML file of the printer-friendly VT Timetable onto the parser
batch file.  The parser will create a file called "output.csv" in the same directory.


Written for use on windows but theoretically cross-platform since it just uses sed which is a linux/unix tool.
For use on linux/unix systems, just replace all "REM"s with "#"s and change "%1" to "$1".
