my $fh;
open($fh, "<", "/var/log/apache2/access.log") or die "Cannot open access.log";

my %ox=();

while (<$fh>) {
	#print $_;
	if ($_ =~ /.*i=([[:alnum:]]*)&t=(.)&ox=([0-9-]*)/) {
		#print "$1 $2 $3\n";
		$ox{$1}=$3;
	}
}

print "var ox_default={";
for (keys %ox) {
        print "\"$_\":$ox{$_}, ";
}
print "null:0}";
