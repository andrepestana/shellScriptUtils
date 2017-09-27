#!/bin/bash
# Main Script iterates over a list of servers and call a sub_script.sh to be executed remotely. 
# The result is saved to result.csv

for server in SERVER01 SERVER02
do
	echo "Running on $server..."
	ssh -q $USER@$server  'bash -s' < sub_script.sh >> result.csv
	
done