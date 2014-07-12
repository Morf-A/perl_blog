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

sub form_create {
    my $self = shift;
    my $categoryes = PerlBlog::Model::Category->get_categories();
    
    $self->render(categories=>$categoryes);
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
1;

