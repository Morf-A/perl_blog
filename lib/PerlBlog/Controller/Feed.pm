package PerlBlog::Controller::Feed;

use strict;
use warnings;
use v5.10;
use base 'Mojolicious::Controller';
use Data::Dumper;

sub main {
    my $self = shift;
    # Пользователь
    my $userName = $self->session('login');

    # Посты
    my $allPosts = PerlBlog::Model::Post->get_posts();
    
    print Dumper($allPosts);
    
    $self->render(userName=>$userName, posts=>$allPosts);  
}


1;

