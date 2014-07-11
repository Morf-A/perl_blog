package PerlBlog::Controller::Feed;

use strict;
use warnings;
use v5.10;
use base 'Mojolicious::Controller';

sub main {
    my $self = shift;
    $self->render(userName => $self->session('login'));
}


1;

