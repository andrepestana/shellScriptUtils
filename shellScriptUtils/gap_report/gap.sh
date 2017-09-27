#!/bin/bash

#Join 2 files by the id
join <(sort outbound.txt) <(sort inbound.txt) -t ";" >gap.tmp

gawk -F";" 'BEGIN {	line=1;} {  line++; print $1";"$2";"$3";=C"line"-B"line }; ' gap.tmp | tr "." "," >> gap.tmp2

echo "ID;Outbound time;Inbound time;Diff" >gap_report.csv
cat  gap.tmp2 >> gap_report.txt
 
rm gap.tmp gap.tmp2 
