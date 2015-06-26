use warnings;
use strict;

my ($matrix_fn, @roles) = @ARGV;

my $header;
open IN, "$matrix_fn" or die;
$header = <IN>;
close IN;
chomp $header;

my %r = map { $_ => 1 } @roles;

my @vector;
foreach my $rh (split "\t", $header) {
    push @vector, (defined $r{$rh}) ? sprintf("%.1f", 1.0) : sprintf("%.1f", 0.0);
}
print join "\t", @vector;
print "\n";
	
