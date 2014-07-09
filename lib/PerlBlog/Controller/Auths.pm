package PerlBlog::Controller::Auths;

use strict;
use warnings;
use v5.10;

use base 'Mojolicious::Controller';

sub create{
    my ($self) = @_;
    $self->render();
}

1;