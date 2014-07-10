package PerlBlog::Controller::Feed;

use strict;
use warnings;
use v5.10;

use base 'Mojolicious::Controller';
use PerlBlog::Controller::Auths;

sub main {
    
    my $self = shift;
    PerlBlog::Controller::Auths::check($self);
    
    $self->render(userName => $self->session('login'));
}


1;
