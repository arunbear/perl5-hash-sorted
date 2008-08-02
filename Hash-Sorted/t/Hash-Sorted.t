use strict;
use warnings;
 
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Hash-Sorted.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More qw(no_plan);
#use Test::More tests => 1;
BEGIN { use_ok('Hash::Sorted') };

my %capital : Sorted;

$capital{'France'}  = 'Paris';
$capital{'England'} = 'London';
$capital{'Hungary'} = 'Budapest';
$capital{'Ireland'} = 'Dublin';
$capital{'Egypt'}   = 'Cairo';
$capital{'Germany'} = 'Berlin';

my @keys = qw/Egypt England France Germany Hungary Ireland/;
is_deeply([keys %capital], \@keys, 'check keys list');
is_deeply([values %capital], [qw/Cairo London Paris Berlin Budapest Dublin/], 'check values list');
__END__


$capital{'France'} = 'Paris';

ok(exists $capital{'France'}, 'exists after insert');
is($capital{'France'}, 'Paris', 'STORE and FETCH work');

my $deleted = delete $capital{'France'};
ok(keys %capital == 0, 'Size check after deleting sole element');
isa_ok($deleted, 'Tree::RB::Node');
ok($deleted->key eq 'France' && $deleted->val eq 'Paris', 'check deleted node');

$capital{'France'} = 'Paris';
$capital{'England'} = 'London';
$capital{'Hungary'} = 'Budapest';
$capital{'Ireland'} = 'Dublin';
$capital{'Egypt'}   = 'Cairo';
$capital{'Germany'} = 'Berlin';

ok(keys %capital == 6, 'Size check (keys) after inserts');
ok(scalar %capital == 6, 'Size check (scalar) after inserts');

my @keys = qw/Egypt England France Germany Hungary Ireland/;
is_deeply([keys %capital], \@keys, 'check keys list');

is_deeply([values %capital], [qw/Cairo London Paris Berlin Budapest Dublin/], 'check values list');

my ($key, $val);

($key, $val) = each %capital;
ok($key eq 'Egypt' && $val eq 'Cairo', 'each check');

($key, $val) = each %capital;
ok($key eq 'England' && $val eq 'London', 'each check');

($key, $val) = each %capital;
ok($key eq 'France' && $val eq 'Paris', 'each check');

($key, $val) = each %capital;
ok($key eq 'Germany' && $val eq 'Berlin', 'each check');

($key, $val) = each %capital;
ok($key eq 'Hungary' && $val eq 'Budapest', 'each check');

($key, $val) = each %capital;
ok($key eq 'Ireland' && $val eq 'Dublin', 'each check');

($key, $val) = each %capital;
ok(!defined $key && !defined $val , 'each check - no more keys');

undef %capital; 
ok(keys   %capital == 0, 'no keys after clearing hash');
ok(scalar %capital == 0, 'size zero after clearing hash');

untie %capital;
ok(@$tied == 0, 'underlying array is empty after untie');

# Custom sorting

$tied = tie(%capital, 'Tree::RB', sub { $_[1] cmp $_[0] });

isa_ok($tied, 'Tree::RB');

$capital{'France'}  = 'Paris';
$capital{'England'} = 'London';
$capital{'Hungary'} = 'Budapest';
$capital{'Ireland'} = 'Dublin';
$capital{'Egypt'}   = 'Cairo';
$capital{'Germany'} = 'Berlin';

is_deeply([keys %capital], [reverse @keys], 'check keys list (reverse sort)');
