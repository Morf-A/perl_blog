package PerlBlog::Controller::Post;

use strict;
use warnings;
use v5.10;
use Data::Dumper;

use base 'Mojolicious::Controller';

sub form_create {
    
    my $self = shift;
    
    my $author = $self->session('login');
    my $categories = PerlBlog::Model::Category->get_categories();
    my $tags = PerlBlog::Model::Tag->get_tags();
  
    $self->render(author=>$author, categories=>$categories, tags=>$tags);
    
}

sub create {
    my $self = shift;
    
    #Получаем параметры
    
    my $title     = $self->param('title');
    my $content   = $self->param('content');
    my $preview   = $self->param('preview');
    my @tagIds       = $self->param('tagsToController');

    
    my $author = $self->session('login');
    
    #  my $user_id = PerlBlog::Model::User->insert(\%post);
    
    $self->redirect_to('/');
}

sub show {
    
    my $self = shift;
    
}


1;

