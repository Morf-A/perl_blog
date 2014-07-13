package PerlBlog::Controller::Tag;

use strict;
use warnings;
use v5.10;
use base 'Mojolicious::Controller';
use Data::Dumper;

sub main {
    my $self = shift;

    my $currentUserId = $self->session('id');
    my $userName      = $self->session('login');
    my $tagId         = $self->param('id');
    my $tagname       = $self->param('tag_name');
    my $allPosts      = PerlBlog::Model::Post->get_posts_by_tag_id($tagId);

    $self->render(userName=>$userName, posts=>$allPosts, tagname=>$tagname, currentUserId=>$currentUserId);  
}

sub form_create {
    my $self = shift;
    my $categories = PerlBlog::Model::Category->get_categories();
    
    unless ($categories->[0]) {
        $self->flash(error => 'Create a categories')->redirect_to('feed');
    }
    
    $self->render(categories=>$categories);
}

sub create {
    my $self = shift;
    my $name        = $self->param('name');
    my $categoryId  = $self->param('categoryId');
    
    # Проверка
    unless($name) {
        $self->flash(error => 'Title can not be empty')->redirect_to('tag_form_create');
        return;
    }
    
    my %tag = (
        category_id => $categoryId,
        name => $name
    );
    
    PerlBlog::Model::Tag->insert(\%tag);  
    
    $self->redirect_to('/');
}


sub form_delete {
    my $self   = shift; 
    my $tags = PerlBlog::Model::Tag->get_tags();
    $self->render(tags => $tags);
}

sub delete {
    my $self   = shift; 
    
    my $tagId = $self->param('tagId');
    
    
    # Проверка 
    my $posts = PerlBlog::Model::Post->get_posts_by_tag_id($tagId);

    if ( $posts->[0] ) {
        $self->flash(
            error        => 'Delete the associated posts!',
        )->redirect_to('tag_form_delete');
        return;
    }
    
    PerlBlog::Model::Tag->delete({id=>$tagId});
    $self->redirect_to('/');
}


1;

