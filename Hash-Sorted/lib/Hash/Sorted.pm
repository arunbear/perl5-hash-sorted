package Hash::Sorted;

require v5.6.0;
use Attribute::Handlers;
use Carp;
use DB_File;
use strict;
use vars qw( $VERSION );

$VERSION = '0.01';

sub UNIVERSAL::Sorted : ATTR(HASH) {
    my ($package, $symbol, $referent, $attr, $data) = @_;
    if(ref $data eq 'ARRAY') {
        if(ref $data->[0] eq 'CODE') {
            $DB_BTREE->{'compare'} = $data->[0];
        } 
        else {
            croak('Not a coderef');
        }
    } 
    elsif($data) {
        croak("Invalid argument $data given to attribute");
    }
    tie %$referent, "DB_File", undef, undef, undef, $DB_BTREE;
} 

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Hash::Sorted - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Hash::Sorted;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Hash::Sorted, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

A. U. Thor, E<lt>a.u.thor@a.galaxy.far.far.awayE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by A. U. Thor

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
