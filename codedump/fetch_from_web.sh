git add .
for f in w.html make.sh index.html.sh oldbuggy.html
do
	wget http://mccabedj.ucc.asn.au/p/2014LinuxStaging/$f
	git add $f
done
