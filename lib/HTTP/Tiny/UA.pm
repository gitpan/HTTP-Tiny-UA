use v5.10;
use strict;
use warnings;

package HTTP::Tiny::UA;
# ABSTRACT: Higher-level UA features for HTTP::Tiny
our $VERSION = '0.002'; # VERSION

use superclass 'HTTP::Tiny' => 0.036;

use HTTP::Tiny::UA::Response;

# =method new
#
#     $http = HTTP::Tiny::UA->new( %attributes );
#
# This is inherited from L<HTTP::Tiny>.  The only difference so far is that
# C<agent> will be C<HTTP-Tiny-UA/$VERSION>.
#
# =for :list
# * C<agent>
# A user-agent string (defaults to 'HTTP-Tiny-UA/$VERSION'). If C<agent> ends in a space character, the default user-agent string is appended.
# * C<cookie_jar>
# An instance of L<HTTP::CookieJar> or equivalent class that supports the C<add> and C<cookie_header> methods
# * C<default_headers>
# A hashref of default headers to apply to requests
# * C<local_address>
# The local IP address to bind to
# * C<max_redirect>
# Maximum number of redirects allowed (defaults to 5)
# * C<max_size>
# Maximum response size (only when not using a data callback).  If defined,
# responses larger than this will return an exception.
# * C<proxy>
# URL of a proxy server to use (default is C<$ENV{http_proxy}> if set)
# * C<no_proxy>
# List of domain suffixes that should not be proxied.  Must be a comma-separated string or an array reference. (default is C<$ENV{no_proxy}>)
# * C<timeout>
# Request timeout in seconds (default is 60)
# * C<verify_SSL>
# A boolean that indicates whether to validate the SSL certificate of an C<https>
# connection (default is false)
# * C<SSL_options>
# A hashref of C<SSL_*> options to pass through to L<IO::Socket::SSL>
#
# See L<SSL SUPPORT in HTTP::Tiny|HTTP::Tiny/SSL SUPPORT> for more on the
# C<verify_SSL> and C<SSL_options> attributes.
#
# =method get|head|put|post|post_form|mirror|delete
#
# These methods are inherited from L<HTTP::Tiny> and work the same, except they
# invoke the L<HTTP::Tiny::UA request|/request> method and return a
# L<HTTP::Tiny::UA::Response> object.
#
# =method request
#
#     my $res = HTTP::Tiny->new->get( $url );
#
# Just like L<HTTP::Tiny::request|HTTP::Tiny/request>, but returns a
# L<HTTP::Tiny::UA::Reponse> object.  All other C<get>, C<post>, etc. methods
# eventually invoke this one so all such methods return response objects now.
#
# =cut

sub request {
    my ( $self, @args ) = @_;
    my $res = $self->SUPER::request(@args);
    return HTTP::Tiny::UA::Response->new($res);
}

1;


# vim: ts=4 sts=4 sw=4 et:

__END__

=pod

=encoding UTF-8

=head1 NAME

HTTP::Tiny::UA - Higher-level UA features for HTTP::Tiny

=head1 VERSION

version 0.002

=head1 SYNOPSIS

    use HTTP::Tiny::UA;
    
    my $ua = HTTP::Tiny::UA->new(
        ...
    );

=head1 DESCRIPTION

This module extends L<HTTP::Tiny> with higher-level convenience features.

=head1 METHODS

=head2 new

    $http = HTTP::Tiny::UA->new( %attributes );

This is inherited from L<HTTP::Tiny>.  The only difference so far is that
C<agent> will be C<HTTP-Tiny-UA/$VERSION>.

=over 4

=item *

C<agent>

A user-agent string (defaults to 'HTTP-Tiny-UA/$VERSION'). If C<agent> ends in a space character, the default user-agent string is appended.

=item *

C<cookie_jar>

An instance of L<HTTP::CookieJar> or equivalent class that supports the C<add> and C<cookie_header> methods

=item *

C<default_headers>

A hashref of default headers to apply to requests

=item *

C<local_address>

The local IP address to bind to

=item *

C<max_redirect>

Maximum number of redirects allowed (defaults to 5)

=item *

C<max_size>

Maximum response size (only when not using a data callback).  If defined,
responses larger than this will return an exception.

=item *

C<proxy>

URL of a proxy server to use (default is C<$ENV{http_proxy}> if set)

=item *

C<no_proxy>

List of domain suffixes that should not be proxied.  Must be a comma-separated string or an array reference. (default is C<$ENV{no_proxy}>)

=item *

C<timeout>

Request timeout in seconds (default is 60)

=item *

C<verify_SSL>

A boolean that indicates whether to validate the SSL certificate of an C<https>
connection (default is false)

=item *

C<SSL_options>

A hashref of C<SSL_*> options to pass through to L<IO::Socket::SSL>

=back

See L<SSL SUPPORT in HTTP::Tiny|HTTP::Tiny/SSL SUPPORT> for more on the
C<verify_SSL> and C<SSL_options> attributes.

=head2 get|head|put|post|post_form|mirror|delete

These methods are inherited from L<HTTP::Tiny> and work the same, except they
invoke the L<HTTP::Tiny::UA request|/request> method and return a
L<HTTP::Tiny::UA::Response> object.

=head2 request

    my $res = HTTP::Tiny->new->get( $url );

Just like L<HTTP::Tiny::request|HTTP::Tiny/request>, but returns a
L<HTTP::Tiny::UA::Reponse> object.  All other C<get>, C<post>, etc. methods
eventually invoke this one so all such methods return response objects now.

=for Pod::Coverage BUILD

=head1 EXCEPTIONS

Exceptions from C<max_size>, C<timeout> or other error conditions will result
in a pseudo-HTTP status code of 599 and a reason of "Internal Exception". The
content field in the response will contain the text of the exception.

=head1 CONTRIBUTING

Unlike L<HTTP::Tiny>, this module is open to additional features.  Please
discuss new ideas on the bug tracker for feedback before implementing.

While this module is not strictly "Tiny", here are some general guidelines:

=over 4

=item *

The goal for this module is B<not> feature/API equivalence with L<LWP::UserAgent>

=item *

Core module dependencies and "Tiny"-ish module dependencies are OK

=item *

Other CPAN modules should be used sparingly and only for good reasons

=item *

Any XS dependencies must be optional

=back

=head1 SEE ALSO

=over 4

=item *

L<HTTP::Tiny> — the underlying client

=item *

L<HTTP::Thin> — another HTTP::Tiny extension that uses L<HTTP::Message> objects

=item *

L<LWP::UserAgent> — when you outgrow HTTP::Tiny, use this

=back

=for :stopwords cpan testmatrix url annocpan anno bugtracker rt cpants kwalitee diff irc mailto metadata placeholders metacpan

=head1 SUPPORT

=head2 Bugs / Feature Requests

Please report any bugs or feature requests through the issue tracker
at L<https://github.com/dagolden/HTTP-Tiny-UA/issues>.
You will be notified automatically of any progress on your issue.

=head2 Source Code

This is open source software.  The code repository is available for
public review and contribution under the terms of the license.

L<https://github.com/dagolden/HTTP-Tiny-UA>

  git clone https://github.com/dagolden/HTTP-Tiny-UA.git

=head1 AUTHOR

David Golden <dagolden@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2013 by David Golden.

This is free software, licensed under:

  The Apache License, Version 2.0, January 2004

=cut
