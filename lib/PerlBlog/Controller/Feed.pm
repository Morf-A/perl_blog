package PerlBlog::Controller::Feed;

use strict;
use warnings;
use v5.10;
use base 'Mojolicious::Controller';
use Data::Dumper;

sub main {
    my $self = shift;
    # Пользователь
    my $currentUserId = $self->session('id');
    my $userName = $self->session('login');
    # Посты
    my $allPosts = PerlBlog::Model::Post->get_posts();
    $self->render(userName => $userName, currentUserId => $currentUserId, posts => $allPosts);  
}


1;

