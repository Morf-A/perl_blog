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
    
    #Сохраняем пост

    my $title     = $self->param('title');
    my $content   = $self->param('content');
    my $preview   = $self->param('preview');
    
    my $login = $self->session('login');
    my $author_id = PerlBlog::Model::User->select({login => $login})->hash()->{id};
    
    
    my %post = (
        title     => $title,
        content   => $content,
        preview   => $preview,
        author_id => $author_id
    );
    
    # Проверка
    unless($title) {
        $self->flash(error => 'Title can not be empty')->redirect_to('post_form_create');
        return;
    }
    my $post_id = PerlBlog::Model::Post->insert(\%post);
   
    
    # Теперь привязываем к посту теги
    my @tagIds = $self->param('tagsToController');

    foreach my $tagId (@tagIds){
        PerlBlog::Model::PostsTags->insert({
                tag_id  => $tagId,
                post_id => $post_id
        });
    }
    
    $self->redirect_to('/');
}

sub show {
    
    my $self = shift;
    
}


1;

