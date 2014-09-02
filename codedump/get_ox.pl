#!/usr/bin/perl
my $fh;
open($fh, "<", "/var/log/apache2/access.log") or die "Cannot open access.log";

my $ox_s="ox";
$ox_s=$ARGV[0];
my %ox=();

my $album=`albumname.sh`;
#print $album;

while (<$fh>) {
	#print $_;
	#if ($_ =~ /.*$album.*i=([[:alnum:]]*)&t=(.)&$ox_s=([0-9-]*)/) {
	if ($_ =~ /.*$album.*i=([[:alnum:]]*)&t=(.).*&$ox_s=([0-9-]*)/) {
		#print "$1 $2 $3\n";
		$ox{$1}=$3;
	}
}

print "var $ox_s"."_default={";
for (keys %ox) {
        print "\"$_\":$ox{$_}, ";
}
print "null:0}";
