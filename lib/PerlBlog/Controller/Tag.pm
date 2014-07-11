package PerlBlog::Controller::Tag;

use strict;
use warnings;
use v5.10;
use base 'Mojolicious::Controller';
use Data::Dumper;

sub main {
    my $self = shift;

    my $userName = $self->session('login');
    my $tagId    = $self->param('id');
    my $tagname  = $self->param('tag_name');
    my $allPosts = PerlBlog::Model::Post->get_posts_by_tag_id($tagId);

    $self->render(userName=>$userName, posts=>$allPosts, tagname=>$tagname);  
}


1;

