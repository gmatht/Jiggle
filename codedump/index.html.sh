#!/bin/bash
set -e
#set -x
#OUTHTML=index
GEOM=196x196
UP_URL="/3D" # URL for main gallery of albums
QUALITY=75

OUTHTML=i

INSUFFIX=_r
SUFFIX=_w
TYPE="&t=w"

ALTHTML=$OUTHTML.rc
ALTTEXT="switch to Red/Cyan glasses mode"
DISABLE=""


do_one_html () {
OUTHTML="$1";  shift;
INSUFFIX=$1;  
SUFFIX="$1"s;   shift;
TYPE="$1";     shift;
ALTHTML="$1";  shift;
ALTTEXT="$*";

[ -e 800x600/.done ] || (resizepics.sh 800x600 *_l.jpg *_r.jpg *_d.jpg
( cd 800x600 && for f in *.jpg; do new="../${f/.jpg/m.jpg}"; [ -e "$new" ] || ln "$f" "$new"; done )
touch 800x600/.done )

[ -e $GEOM/.done ] || (
resizepics.sh $GEOM *_l.jpg         *_d.jpg
( cd $GEOM   && for f in *.jpg; do new="../${f/.jpg/s.jpg}"; [ -e "$new" ] || ln "$f" "$new"; done )
touch $GEOM/.done )
#( cd $GEOM   && for f in *.jpg; do ln "$f" ../${f/.jpg/s.jpg}; done )

(
	echo "<html><h1>Index <a href=\"$ALTHTML.html\">($ALTTEXT)</a> <a href="/3D">(UP)</a></h1>";
	(i=0;
		for ff in *_l.jpg
		do 
			f=${ff/_l.jpg/};
			file=$f""$SUFFIX.jpg
			if [ ! -e $f""$SUFFIX.jpg ]
			then
				file=$f""_ls.jpg
			fi
			echo "<a href=\"w.html?i=$f$TYPE\"><img src=\"$file\" `identify $file | sed '
s/.* JPEG /width="/
s/ .*/" /
s/x/" height="/'`></a>";
			 # -e  $DISABLE$f""$SUFFIX.jpg || convert -normalize -scale $GEOM -quality $QUALITY $f""$INSUFFIX.jpg $f""$SUFFIX.jpg;
			 i=$(($i + 1));
		 done
	)
) > $OUTHTML.html;
chmod a+r $OUTHTML.html;
head $OUTHTML.html

}


#ls *.[jJ][pP][Gg] | xargs -P4 -I FILE  --verbose convert -normalize -scale $GEOM -quality $QUALITY FILE $GEOM/tmp_FILE
#ls *.[jJ][pP][Gg] | xargs -P4 -I FILE --verbose jpegrescan2013  $GEOM/tmp_FILE $GEOM/FILE; rm $GEOM/tmp_FILE && rm $GEOM/tmp_*.[jJ][pP][Gg]

#echo "OUTHTML INSUFFIX SUFFIX TYPE
echo  "$OUTHTML $INSUFFIX $TYPE $ALTHTML $ALTTEXT
       $ALTHTML _d        &t=d $OUTHTML switch to No glasses mode" |
while read L
do echo $L
	do_one_html $L
done
      exit 0 
do
(
	echo "<html><h1>Index <a href=\"$ALTHTML.html\">($ALTTEXT)</a></h1>";
	(i=0;
		for f in *_l.jpg
		do 
			f=${ff/_l.jpg/};
			echo "<a href=\"Wigglescopy.html?i=$f$TYPE\"><img src=\"$f""$SUFFIX.jpg\" `identify $f""$SUFFIX.jpg | sed '
s/.* JPEG /width="/
s/ .*/" /
s/x/" height="/'`></a>";
			 test -e  $DISABLE$f""$SUFFIX.jpg || convert -normalize -scale $GEOM -quality $QUALITY $f""$INSUFFIX.jpg $f""$SUFFIX.jpg;
			 i=$(($i + 1));
		 done
	)
) > $OUTHTML.html;
chmod a+r $OUTHTML.html;
head $OUTHTML.html

ALTHTML=$OUTHTML
OUTHTML=$OUTHTML.rc

TYPE="&t=d"
INSUFFIX=
SUFFIX=_s
ALTTEXT="switch to No glasses mode"

(echo "<html><h1>Index <a href=\"$ALTHTML.html\">($ALTTEXT)</a></h1>"; (i=0; grep '^var allimages' Wigglescopy.html | grep -o '"[^"]*"' | sed s/\"//g | while read f; do echo "<a href=\"Wigglescopy.html?i=$i$TYPE\"><img src=\"$f""$SUFFIX.jpg\" `identify $f""$SUFFIX.jpg | sed 's/.* JPEG /width="/' | sed 's/ .*/" /' | sed 's/x/" height="/'`></a>"; test -e  $DISABLE$f""$SUFFIX.jpg || convert -normalize -scale $GEOM -quality $QUALITY $f""$INSUFFIX.jpg $f""$SUFFIX.jpg;  i=$(($i + 1)); done)) > $OUTHTML.html ; chmod a+r $OUTHTML.html ; head $OUTHTML.html
#(echo "<html><h1>Index<a href=\"$ALTHTML\">$ALTTEXT</a></h1>"; (i=0; grep '^var allimages' Wigglescopy.html | grep -o '"[^"]*"' | sed s/\"//g | while read f; do echo "<a href=\"Wigglescopy.html?i=$i$TYPE\"><img src=\"$f""$SUFFIX.jpg\"></a>"; test -e  XXX$f""$SUFFIX.jpg || convert -normalize -scale $GEOM -quality $QUALITY $f""$INSUFFIX.jpg $f""$SUFFIX.jpg;  i=$(($i + 1)); done)) > $OUTHTML.html ; chmod a+r $OUTHTML.html ; head $OUTHTML.html
#(echo '<html><h1>Index</h1>'; (i=0; grep '^var allimages' Wigglescopy.html | grep -o '"[^"]*"' | sed s/\"//g | while read f; do echo "<a href=\"Wigglescopy.html?i=$i$TYPE\"><img src=\"$f""$SUFFIX.jpg\"></a>"; test -e  $f""$SUFFIX.jpg || convert -normalize -scale $GEOM -quality $QUALITY $f""$INSUFFIX.jpg $f""$SUFFIX.jpg;  i=$(($i + 1)); done); echo "<p/><a href=\"$ALTHTML\">$ALTTEXT</a>" ) > $OUTHTML.html ; chmod a+r $OUTHTML.html ; head $OUTHTML.html

