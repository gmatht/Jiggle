set -e
set -x
#OUTHTML=index
GEOM=128x128
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

ls | grep -Fxvf - <(ls *_l.jpg *_r.jpg *_d.jpg | sed "s/.jpg$/m.jpg/") | sed "s/..jpg$//" |
xargs -P4 -I FILE  --verbose sh -c "
		convert -normalize -scale 800x600 -quality $QUALITY FILE.jpg tmp_FILEm.jpg &&
		jpegrescan2013  tmp_FILEm.jpg FILEm_tmp.jpg &&
		mv FILEm_tmp.jpg FILEm.jpg &&
		rm tmp_FILEm.jpg"
# files_missing=`ls *$SUFFIX.jpg`
false && ls | grep -Fxvf - <(ls *$INSUFFIX.jpg | sed "s/$INSUFFIX.jpg$/$SUFFIX.jpg/") | sed "s/..jpg$//" |
	xargs -P4 -I FILE  --verbose sh -c "
		convert -normalize -scale $GEOM -quality $QUALITY FILE.jpg FILEs.jpg"
# &&
#		convert -normalize -scale $GEOM -quality $QUALITY FILE.jpg tmp_FILEs.jpg"
#		jpegrescan2013  tmp_FILEs.jpg FILEs.jpg &&
#		rm tmp_FILEs.jpg"
(
	echo "<html><h1>Index <a href=\"$ALTHTML.html\">($ALTTEXT)</a></h1>";
	(i=0;
		for ff in *_l.jpg
		do 
			f=${ff/_l.jpg/};
			echo "<a href=\"w.html?i=$f$TYPE\"><img src=\"$f""$SUFFIX.jpg\" `identify $f""$SUFFIX.jpg | sed '
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

