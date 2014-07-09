package PerlBlog::Controller::Users;

use strict;
use warnings;
use v5.10;

use base 'Mojolicious::Controller';

sub create {

    my %user = (
        login    => 'uniqueLogin',
        password => 'uniquePass',
    );

    PerlBlog::Model->db->query(
        "INSERT INTO user(login, password) VALUES('uniqueLogin', 'uniquePass');"
    );
    
    my $self = shift;
    $self->redirect_to('initial_form');
    
    # my $self = shift;

    # my $login     = $self->param('login');
    # my $password  = $self->param('password');
    # my $password2 = $self->param('password2');

    # # Validation
    # my $err_msg;
# CHECK: {

        # unless ( $login && $password && $password2 ) {
            # $err_msg = 'Please, fill all fields!';
            # last CHECK;
        # }

        # my $user = PerlBlog::Model::User->select({login => $login})->hash();

        # if ( $user->{user_id} ) {
            # $err_msg = 'User with such login already exists!';
            # last CHECK;
        # }

        # if ( $password ne $password2 ) {
            # $err_msg = 'Passwords do not coincide!';
            # last CHECK;
        # }

    # }

    # # Show error
    # if ($err_msg) {
        # $self->flash(
            # error        => $err_msg,
            # login        => $login,

        # )->redirect_to('users_create_form');

        # return;
    # }

    # # Save User
    # my %user = (
        # login    => $login,
        # password => $password,
    # );

    # my $user_id = PerlBlog::Model::User->insert(\%user);

    # # Login User
    # $self->session(
        # user_id => $user_id,
        # login   => $login
    # )->redirect_to('users_show') if $user_id #TODO ;
    
 
}


1;

