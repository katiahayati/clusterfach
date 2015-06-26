use warnings;
use strict;

use HTML::Entities;
binmode STDOUT, ":encoding(UTF-8)";

my @lines;
my %role_counts;

while (<>) {
    next if (/conductor/i or /lighting/i or /sets/i or /director/i or /costumes/i);
    chomp;
    my $decoded = decode_entities($_);
    my @roles = split ";", $decoded;
    $role_counts{$_}++ foreach @roles;
    push @lines, $_;
}

my %edges;
foreach (@lines) {
    my $decoded = decode_entities($_);
    my @roles = split ";", $decoded;
    next if (@roles == 1);
    @roles = grep { $_ !~ /recital/i } @roles;
    for (my $i = 0; $i <= $#roles - 1; $i++) {
	for (my $j = $i+1; $j <= $#roles; $j++) {
#	    if ($role_counts{$roles[$i]} >= 10 and $role_counts{$roles[$j]} >= 10) {
		my ($v1, $v2) = sort { $a cmp $b } ($roles[$i], $roles[$j]);
		$edges{$v1}->{$v2}++;
#		print join "\t", sort { $a cmp $b } ($roles[$i], $roles[$j]);
#		print "\n";
#	    }
	}
    }
}

foreach my $v1 (keys %edges) {
    foreach my $v2 (keys %{$edges{$v1}}) {
	if ($edges{$v1}->{$v2} > 1) {
	    print join "\t", $v1, $v2;
	    print "\n";
	}
    }
}

use Data::Dumper;
my @kept_roles = sort grep { $role_counts{$_} >= 10 } keys %role_counts;
print STDERR scalar @kept_roles, "\n"; #Dumper(\@kept_roles);
