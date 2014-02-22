use v5.10;
use strict;
use warnings;

package HTTP::Tiny::UA::Response;
# ABSTRACT: Wrap HTTP::Tiny response as objects with accessors
our $VERSION = '0.002'; # VERSION

use Class::Tiny qw( success url status reason content headers protocol );

# =attr success
#
# =attr url
#
# =attr protocol
#
# =attr status
#
# =attr reason
#
# =attr content
#
# =attr headers
#
# =method header
#
#     $response->header( "Content-Length" );
#
# Return a header out of the headers hash.  The field is case-insensitive.  If
# the header was repeated, the value returned will be an array reference.
# Otherwise it will be a scalar value.
#
# =cut

sub header {
    my ( $self, $field ) = @_;
    return $self->headers->{ lc $field };
}

1;


# vim: ts=4 sts=4 sw=4 et:

__END__

=pod

=encoding UTF-8

=head1 NAME

HTTP::Tiny::UA::Response - Wrap HTTP::Tiny response as objects with accessors

=head1 VERSION

version 0.002

=head1 SYNOPSIS

    my $res = HTTP::Tiny->new->get( $url );

    if ( $res->success ) {
        say "Got " . $res->header("Content-Length") . " bytes";
    }

=head1 DESCRIPTION

This module wraps an L<HTTP::Tiny> response as an object to provide some
accessors and convenience methods.

=head1 ATTRIBUTES

=head2 success

=head2 url

=head2 protocol

=head2 status

=head2 reason

=head2 content

=head2 headers

=head1 METHODS

=head2 header

    $response->header( "Content-Length" );

Return a header out of the headers hash.  The field is case-insensitive.  If
the header was repeated, the value returned will be an array reference.
Otherwise it will be a scalar value.

=for Pod::Coverage BUILD

=head1 AUTHOR

David Golden <dagolden@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by David Golden.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut
