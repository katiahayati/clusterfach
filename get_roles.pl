use warnings;
use strict;

use LWP::Simple;
use List::MoreUtils qw(uniq);

$| = 1;
binmode STDOUT, ":encoding(UTF-8)";
    
my ($name_fn) = @ARGV;

my $counter = 0;
open IN, "$name_fn" or die $!;
while (<IN>) {
    chomp;
    my $name = $_;
    print STDERR "Doing $name\n";
    my $url = "http://operabase.com/listart.cgi?name=$name&acts=+Schedule+";
    my $content = get($url);
    if ($content and $content !~ m|<!-- Performances: 0 -->|) {
	my $content_fn = "content_" . int(rand(1000000000000));
	open OUT, ">>/mnt/data/roles/$content_fn" or warn "Couldn't create content file: $!";
	print OUT $content;
	close OUT;
	$counter++;
	my @lines = split "\n", $content;
	@lines = grep { $_ =~ /redperf\.gif/ } @lines;
	my @roles;
	foreach my $line (@lines) {
	    $line =~ 's/.*redperf\.gif.*?<\/td>(.*)/$1/';
	    if ($line =~ m|<td align=right valign=top></td><td valign=top>(.*?)</td><td valign=top>(.*?)</td>.*|) {
		my $role = $2; 
		my $opera = $1;
		if ($role =~ /nbsp/) {
		    my ($role_name, $junk) = split /\&/, $role;
		    $role = $role_name;
		}
		if ($role !~ /NoRole/) {
		    push @roles, join "|", $role, $opera;
		}
	    }
	}
	if (@roles) {
	    print join ";",  uniq @roles;
	    print "\n";
	}
    }
    sleep(3);
}

	
