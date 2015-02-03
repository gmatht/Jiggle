jsroom
======

A simple library for Javascript based Wigglescopy (and other Stereoscopic 3D too). At the moment I am just collecting the files required in one place without worrying too much about reusability.

This is software that allows you to apply effects to some jpgs, with all the work being done on the client, so you don't have to modify the base JPGs (JPGs are harder to version control than text). I am currently focussing on 3D effects such as RedCyan Dubois and Wigglescopy, but this could be extended to e.g. blur and sharpen, layers etc. using the SVG support in all modern browsers (where modern means basically everything except IE9 and below).

If you want to see it in action, have a look at [the 3D photos of linux.conf.au 2014](http://mccabedj.ucc.asn.au/p/2014Linux

QUICKSTART:
1) Enter album/folder with MPO files
2) run main.sh
3) Make sure the files/album is available on localhost
4) Browse to http://localhost/.../album/w.html in your browser
5) Adjust all the photos to the correct horizontal displacement by dragging them.
   (This will put the correct displacement into your Apache webserver log).
6) run main.sh (in codedump at the moment) again
7) Tweak push.sh to point to your public webserver
8) Run push.sh
DELETING FILES (after ruuning main.sh)
Two basic approaches:
1a) Enter relevant directory.
1b) Make directory named ".bak"
1c) Move unwanted files into ".bak"
1d) rerun make
OR
2) Get delphoto.cgi working in your cgi-bin
(and allow users to delete from website).

DELETING FILES (after ruuning main.sh)
Two basic approaches:
1a) Enter relevant directory.
1b) Make directory named ".bak"
1c) Move unwanted files into ".bak"
1d) rerun make
(I am not sure above instructions work...)
OR
2) Get delphoto.cgi working in your cgi-bin
(and allow users to delete from website).


##TODO

- Clean up
- Implement Missing Comment Features
- Rewrite to use SVG; this should make it a lot faster and not need to have the jpgs on the same server as the javascript.
- Integrate with Flickr
- Add support for more filters and handling 2D photos.
