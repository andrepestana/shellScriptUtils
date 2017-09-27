#!/bin/bash
# The commands in subscript don't need to be escaped!

grep -H "" app_20170101.log | \ 				# keep file name with -H
sed ':a;N;$!ba;s/\n//g' | \     				# removes all \n
sed -e "s/\r//g" | \            				# removes all \r
sed -E 's|(</[^/]*:Envelope>)|\1\n|g' | \		# put a line break at the right place
perl -ne 'print "$1;$2;\n" if /app_(.*?)\.log.*?&lt;To&gt;(.*?)&lt;/To/;' | \ # gets date from filename and value from <To> tag
sort| uniq -c 									# sorts and removes duplicates 