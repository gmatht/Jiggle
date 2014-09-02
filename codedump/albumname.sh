#!/bin/bash
album=`pwd| sed 's,/1920x1080$,,
s,/out,,'`

echo -n `basename "$album"`
