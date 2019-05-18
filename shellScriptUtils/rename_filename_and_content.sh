#!/bin/bash

# dir to go into and replace file names and content:
dir="sta"


function traverse() {

	oldString="$2"
	newString="$3"
	for file in "$1"/*
	do
	
		echo "Analyzing "${file}
		if [ ! -d "${file}" ] ; then 
			
			if [[ ${file} == *.* ]] ; then
			
				# REPLACE CONTENTS
				sed -i "s/${oldString}/${newString}/g" ${file}
								
				# RENAME FILE
				resulting_file_name=$( echo ${file} | sed -re "s/\/${oldString}(.*)/\/${newString}\1/" )
				echo "Renaming "${file}" by "${resulting_file_name}
				mv ${file} ${resulting_file_name}
			fi
		else
			traverse "${file}" ${oldString} ${newString}
		fi

	done
}

#Add as many replacements as you want:
traverse ${dir}  "P_Trfa" "P_Tmgt"

traverse ${dir}  "p_Trfa" "p_Tmgt"

traverse ${dir}  "p_trfa" "p_tmgt"

traverse ${dir} "P_TRFA" "P_TMGT" 
