use warnings;
use strict;

my ($matrix_fn, $singer_fn) = @ARGV;

my $header;
open IN, "$matrix_fn" or die;
$header = <IN>;
close IN;
chomp $header;

my @roles = split "\t", $header;

my %result;

open IN, "$singer_fn" or die;
while (<IN>) {
    chomp;
    my @r = split "\t";
    foreach my $num (@r) {
	my $role = shift @roles;
	$result{$role} = $num;
    }
}
close IN;


my @s = sort { $result{$b} <=> $result{$a} } keys %result;

print join "\n", map { $_ . "\t" . $result{$_} } @s;
	
