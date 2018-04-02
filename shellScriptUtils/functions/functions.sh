#!/bin/bash
#-------------------------------------------
#-- FUNCTION.: LOG TRACE
#-- ARGS.....: [1] LOG TRACE MESSAGE
#-------------------------------------------
LogTrace()
{
    echo [$(date '+%Y-%m-%d %H:%M:%S')][TRACE] $1>>$LOG_FILE
}
#!/bin/bash
#-------------------------------------------
#-- FUNCTION.: LOG TRACE ECHO
#-- ARGS.....: [1] LOG TRACE MESSAGE
#-------------------------------------------
LogTraceEcho()
{
    echo "$1"
	echo [$(date '+%Y-%m-%d %H:%M:%S')][TRACE] "$1">>$LOG_FILE
}

#-------------------------------------------
#-- FUNCTION.: LOG ERROR
#-- ARGS.....: [1] LOG ERROR MESSAGE
#-------------------------------------------
LogError()
{
    echo [$(date '+%Y-%m-%d %H:%M:%S')][ERROR] $1>>$LOG_FILE
}

#-------------------------------------------
#-- FUNCTION.: LOG WARNING
#-- ARGS.....: [1] LOG WARNING MESSAGE
#-------------------------------------------
LogWarning()
{
    echo [$(date '+%Y-%m-%d %H:%M:%S')][WARNING] $1>>$LOG_FILE
}

#-------------------------------------------
#-- FUNCTION.: LOG FILE
#-- ARGS.....: [1] File Name
#-------------------------------------------
LogFile()
{
	if [ -s $1 ]; then
		echo [$(date '+%Y-%m-%d %H:%M:%S')] Start contents of file $1>>$LOG_FILE
		cat $1>>$LOG_FILE
		echo "End contents of file ${1} ">>$LOG_FILE
	else
		echo "${1} is empty">>$LOG_FILE
	fi
}

#-------------------------------------------
#-- FUNCTION.: RETURNS PREVIOUS EXIT CODE AND LOGS FAIL MESSAGE
#-- ARGS.....: [1] STEP DESCRIPTION
#-------------------------------------------
CheckErrorWhile()
{
    # Get previous exit code
    COD_ERROR=$?

    # If error log and exit with error
    if [ $COD_ERROR -ne "0" ]; then
        LogError "Failed while "$1
        exit $COD_ERROR
    fi
}

#-------------------------------------------
#-- FUNCTION.: SHOWS USAGE IN CASE OF WRONG NUMBER OF PARAMETERS AND EXIT
#-- ARGS.....: [1] NUMBER_OF_PARAMETERS [2] EXPECTED_NUMBER_OF_PARAMETERS [3] PARAMETER_NAMES
#-- USAGE ...: CheckAllParameters $# 2 "[PARAM1] [PARAM2]"
#-------------------------------------------
CheckAllParameters()
{
	NUMBER_OF_PARAMETERS=$1
	EXPECTED_NUMBER_OF_PARAMETERS=$2
	PARAMETER_NAMES=$3
    
    if [ $NUMBER_OF_PARAMETERS -ne $EXPECTED_NUMBER_OF_PARAMETERS ]; then
        echo -e "Wrong number of parameters.\n\tUsage: "$0 $PARAMETER_NAMES
        exit 1
    fi
}

#-------------------------------------------
#-- FUNCTION.: CHECKS IF PATH EXISTS, IF IT IS A FILE AND IF IT IS READABLE
#-- ARGS.....: [1] FILE NAME WITH PATH
#-------------------------------------------
CheckReadableFile()
{
	FILE_TO_COPY=$1
	if [ ! -e $FILE_TO_COPY ]; then
		LogTrace "File "$FILE_TO_COPY" does no exist"
		exit 1
	else 
		if [ ! -f $FILE_TO_COPY ]; then
			LogError $FILE_TO_COPY" is not a file"
			exit 1
		else
			if [ ! -r $FILE_TO_COPY ]; then
				LogError $FILE_TO_COPY" is not readable"
				exit 1
			else
				if [ ! -s $FILE_TO_COPY ]; then
                    LogWarning $FILE_TO_COPY" is zero size"
	            fi
			fi
		fi	
	fi
}

#-------------------------------------------
#-- FUNCTION.: CHECKS IF PATH EXISTS, IF IT IS A DIR AND IF IT IS WRITABLE
#-- ARGS.....: [1] DIR NAME WITH PATH
#-------------------------------------------
CheckWritableDir()
{
	DIR_TO_WRITE=$1
	if [ ! -e $DIR_TO_WRITE ]; then
		LogTrace "Directory "$DIR_TO_WRITE" does no exist"
		exit 1
	else 
		if [ ! -d $DIR_TO_WRITE ]; then
			LogError $DIR_TO_WRITE" is not a directory"
			exit 1
		else
			if [ ! -w $DIR_TO_WRITE ]; then
				LogError $DIR_TO_WRITE" is not writable"
				exit 1
			fi
		fi	
	fi
}


CheckIfAlreadyRunning()
{
	ALREADY_RUNNING="false"
	count=$(ps -e -oargs | egrep -v "grep|$0" | grep -c "java.*${1}.*-i${2}")
	
	if [ "$count" -ne 0 ]; then
		ALREADY_RUNNING="true"
	fi
	echo $ALREADY_RUNNING
}

#############################################
# Usage: get_property FILE KEY DEFAULT
function get_property
{
   PROPERTY=`grep -e "^$2=" -e "^$2 =" "$1" | cut -d'=' -f2 | sed -e 's/\\r//g'  -e 's/\\n//g'`
   if [[ $PROPERTY == "" ]];then
     echo $3
   else
     echo $PROPERTY
   fi   
}

