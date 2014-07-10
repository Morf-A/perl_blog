package PerlBlog::Controller::Auths;

use strict;
use warnings;
use v5.10;

use base 'Mojolicious::Controller';


sub create {
    my ($self) = @_;

    my $login    = $self->param('login');
    my $password = $self->param('password');

    my $user = PerlBlog::Model::User->select({login => $login, password=>$password})->hash();

    if ( $login  && $user->{id} ) {
        $self->session(
            id => $user->{id},
            login   => $user->{login}
        )->redirect_to('feed');
    }
    else {
        $self->flash( error => 'Wrong password or user does not exist!' )->redirect_to('initial_form');
    }
}

sub delete {
    shift->session( id => '', login => '' )->redirect_to('initial_form');
}


sub check {

    my $self = shift;
    unless($self->session('id')) {
        $self->redirect_to('initial_form');
     
    }
    #shift->session('id') ? 1 : 0;
}

1;