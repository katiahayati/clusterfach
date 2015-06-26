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

my @roles = grep { $role_counts{$_} > 5 } keys %role_counts;
@roles = grep { $_ !~ /recital/i and $_ !~ /concert/i } @roles;

print join "\t", @roles;
print "\n";
foreach (@lines) {
    my $decoded = decode_entities($_);
    my %r = map { $_ => 1 } split ";", $decoded;
    my @binary;
    foreach my $role (@roles) {
	push @binary, (defined $r{$role}) ? 1:0;
    }
    print join "\t", @binary;
    print "\n";
}
