#!/bin/bash
set -e
#set -x
#GEOM=720x540 #For facebook
#GEOM=2000x1500 #For Google Web
GEOM=1920x1080
QUALITY=68 

export GEOM
export QUALITY

if [[ "$1" =~ [0-9][0-9]*x[0-9][0-9]* ]]
then 
	GEOM="$1"
	shift
fi

mkdir -p $GEOM

if [ -z "$1" ]
then
	FILES=*.[jJ][pP][Gg]
else
	FILES=$*
fi


ls $FILES | xargs -P5 -I FILE --verbose sh -c '[ $GEOM/FILE -nt FILE ] || (
convert -normalize -scale $GEOM -quality $QUALITY FILE "$GEOM/tmp_FILE" &&
jpegrescan2013  "$GEOM/tmp_FILE" "$GEOM/FILE" &&
ls -l "$GEOM/tmp_FILE" "$GEOM/FILE" &&
if [ `stat -c %s "$GEOM/FILE"` -lt `stat -c %s "$GEOM/tmp_FILE"` ]
then rm "$GEOM/tmp_FILE"
else mv -f "$GEOM/tmp_FILE" "$GEOM/FILE"
fi)'

#ls $FILES | xargs -P4 -I FILE --verbose jpegrescan2013  $GEOM/tmp_FILE $GEOM/FILE; 

