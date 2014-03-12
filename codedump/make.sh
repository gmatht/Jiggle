#!/bin/bash
v=`echo -n 'var allimages=['; ls *_l.jpg | sed s/_l.jpg// | sed 's/^/"/' | sed 's/$/",/' |tr '\n' ' ' | sed s/,.$// ; echo -n ]\;`
sed -i.bak "s/^var.allimages.*/$v/" w.html
diff  w.html{.bak,}

#./resizepics.sh
./index.html.sh
chmod a+r *

exit 0
./index.html.sh

chmod a+rx 1920x1080
chmod a+r 1920x1080/*
chmod a+rx 800x600
chmod a+r 800x600/*

ln * 1920x1080
ln * 800x600

ln *html -f 800x600/
ln *html -f 1920x1080/

