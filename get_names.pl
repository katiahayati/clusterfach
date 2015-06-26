use warnings;
use strict;

use LWP::Simple;

binmode STDOUT, ":encoding(UTF-8)";

my @letters = @ARGV or die;

my @prefixes;
#my $l1 = 'a';
foreach my $l1 (@letters) {
    for my $l2 ('a' .. 'z') {
	for my $l3 ('a' .. 'z') {
	    my $prefix = $l1 . $l2 . $l3;
	    push @prefixes, $prefix;
	}
    }
}

foreach my $prefix (@prefixes) {
    print STDERR "Doing $prefix\n";
    my $url = "http://operabase.com/listart.cgi?name=$prefix*";
    my $content = get($url);
    if ($content) {
	my @lines = split "\n", $content;
	@lines = grep { $_ =~ /input type=radio name="name"/ } @lines;
	foreach my $l (@lines) {
	    $l =~ s/.*value="(.*?)".*/$1/;
	    print $l, "\n" unless (not $l or $l =~ /^\s*$/);
	}
    } else {
	print STDERR "no content\n";
    }
    sleep(3);
}

