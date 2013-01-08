REM Timetable parser using sed

REM USAGE: Give this script the HTML timetable (printer-friendly) as input parameter
sed -r -e "1,/<TABLE/Id" %1 | sed -r -e "/<\/TABLE/I,$d" | sed -r -e "s/<TD[^>]+>//g" | sed -r -e "s/<\/?(FONT|IMG|p|b|B)[^>]*>//g" | sed -r -e "1,1d" | sed -r -e "s/&nbsp;<\/TD>//g" | sed -r -e "/^$/d" | sed -r -e "/<TR>/N; /\n\* Additional Times \*/D" | sed -r -e "/,.*<\/TD>/s/^([^>]*)<\/TD>/\"\1\"<\/TD>/g" | sed -r -e "s/^([^\/]+)\/([^<>]+)$/\1\/\/\2/g" | sed -r -e "s/<\/TD>/,/g" | sed ":a;N;$!ba;s/\n//g" | sed -r -e "s/<TR>/\n/g" > output.csv

REM okay, heres what each sed statement does:
REM sed -r -e "1,/<TABLE/Id"   		--> Deletes everything up to and including fist "<TABLE" found
REM										--> This removes the headers and stuff above the table
REM sed -r -e "/<\/TABLE/I,$d"		--> Deletes everything after first "</TABLE" is found
REM 								--> Now we just have the HTML table of courses
REM sed -r -e "s/<TD[^>]+>//g"	--> Replaces <TD> tags with empty strings (i.e. deletes them)
REM								--> However, this doesn't delete </TD> tags; we need those later
REM sed -r -e "s/<\/?(FONT|IMG|p|b|B)[^>]*>//g"		--> Deletes all FONT, IMG, p, b, or B tags
REM													--> This deletes the closing tags too (<B> and </B>)
REM sed -r -e "1,1d"	--> Removes first line, which is now blank
REM sed -r -e "s/&nbsp;<\/TD>//g"	--> Replaces "&nbsp;</TD>" with empty strings
REM sed -r -e "/^$/d"	--> Deletes empty lines
REM sed -r -e "/<TR>/N; /\n\* Additional Times \*/D"	--> Deletes the <TR> break between sections and
REM														--> their additional time listings
REM sed -r -e "/,.*<\/TD>/s/^([^>]*)<\/TD>/\"\1\"<\/TD>/g"	--> Find fields containing commas and surround
REM															--> them with quotes
REM sed -r -e "s/^([^\/]+)\/([^<>]+)$/\1\/\/\2/g"	--> Make the "/" into "//" for the capacity field
REM													--> so that excel doesn't interpret it as a date
REM sed -r -e "s/<\/TD>/,/g"	--> Turns all the </TD> tags into commas
REM sed ":a;N;$!ba;s/\n//g"		--> Reads the whole file and removes newlines.
REM						--> http://stackoverflow.com/questions/1251999/sed-how-can-i-replace-a-newline-n
REM sed -r -e "s/<TR>/\n/g"	--> Replace the <TR> tags with newlines
