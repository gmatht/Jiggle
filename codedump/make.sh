#!/bin/bash
v=`echo -n 'var allimages=['; ls *_l.jpg | sed s/_l.jpg// | sed 's/^/"/' | sed 's/$/",/' |tr '\n' ' ' | sed s/,.$// ; echo -n ]\;`
for ox_s in ox oy
do
	ox=`get_ox.pl $ox_s`
	sed -i.bak "s/^var.allimages.*/$v/
	s/^var.$ox_s.default.*/$ox/
	s/\(name=\"a\" value=\"\)[^\"]*/\1$(albumname.sh)/" w.html
	diff  w.html{.bak,}
done

#./resizepics.sh
index.html.sh
chmod a+r *
chmod a+x .

exit 0
./index.html.sh

chmod a+rx 1920x1080
chmod a+r 1920x1080/*
chmod a+rx 800x600
chmod a+r 800x600/*
chmod a+rx .
chmod a+r * 

ln * 1920x1080
ln * 800x600

ln *html -f 800x600/
ln *html -f 1920x1080/

