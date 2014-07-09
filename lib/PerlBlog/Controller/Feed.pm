package PerlBlog::Controller::Feed;

use strict;
use warnings;
use v5.10;

use base 'Mojolicious::Controller';

sub check_auths {
    
    my $self = shift;
    unless($self->session('id')) {
        $self->redirect_to('initial_form');
     
    }
     
    $self->render();
    
    #my $user = PerlBlog::Controller::Auths

}


1;

