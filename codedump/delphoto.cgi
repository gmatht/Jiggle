#!/usr/bin/perl
use CGI::Carp 'fatalsToBrowser';
use File::Slurp;
use POSIX qw(strftime);
#use URI::Encode qw(uri_encode uri_decode);
use HTML::Entities;


    local ($buffer, @pairs, $pair, $name, $value, %FORM);
    # Read in text
    $ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;
    if ($ENV{'REQUEST_METHOD'} eq "GET")
    {
	$buffer = $ENV{'QUERY_STRING'};
    }
    # Split information into name/value pairs
    @pairs = split(/&/, $buffer);
    foreach $pair (@pairs)
    {



($name, $value) = split(/=/, $pair);
	$value =~ tr/+/ /;
	$value =~ s/%(..)/pack("C", hex($1))/eg;
	$FORM{$name} = $value;
    }
    my $d = $FORM{d};
    my $reason  = $FORM{r};

print "Content-type:text/html\r\n\r\n";
print "<html>";
print "<head>";
print "<title>Photo Comment and Delete Tool</title>";
print "</head>";
print "<body>";

my $error="";

my $date = strftime "%F %X", localtime;

my $encoded = encode_entities($ENV{'QUERY_STRING'}, '^A-Za-z-=&0-9,+-');

if ($FORM{"cmd"}=~/Delete/) {
	if ( $d =~ /^[[:alnum:]]+$/ ) {
		#print "Looks like a photo";
		if ( $reason =~ /./ ) {
			system ("(cd /home/ucc/mccabedj/public-html/p/2014LinuxStaging &&
				 (mv "."$d"."_*.jpg /home/ucc/mccabedj/p/deleted/2014LinuxStaging || true)
				 sed 's/.*\"$d\_.*//' -i.bakk i.html &&
				 sed 's/.*\"$d\_.*//' -i.bakk i.rc.html &&
				 #sed 's/, \"$d\"\(:[[:alnum:]-]*\)?//' -i.bakk w.html &&
				 sed --regexp-extended 's/, \"DSCF3362\"(:[0-9-]*)?//g' -i.bakk w.html &&
				 echo '<br/>Success: Deleted image $d (if not already deleted)' &&
				 echo '<br/>(You will probably still see the image until you refresh your webbrowser)'
				 #./make.sh
				 ) 2>&1 ");
			#print "<br/>\nDELETED!!!";
		} else {
			print "Please add a reason,
			e.g. 4 if you are one of the 4 closest people in the photo or
			c if you are in a crowd shot
			";
			$error="ERR_REASON";
		}
	} else {
		$error="ERR_NOTPHOTO";
		print "not a photo?";
	}
} else {
	print "Your comment is awaiting moderation<br/>\n";
	print "(This may take a while, the moderation code hasn't been written yet...)\n";
}
write_file( '/home/ucc/mccabedj/p/my_logs_agd/delphoto.log', {append => 1 }, "$date $ENV{REMOTE_ADDR} $encoded \n"  ) ;

print "</body>";
print "</html>";
1;
