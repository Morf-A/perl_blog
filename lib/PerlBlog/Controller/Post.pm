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
    my $self   = shift;
    
    my $currentUserId = $self->session('id');
    my $currentUserName  = $self->session('login');

    
    my $postId = $self->param('id');

    my $postData = PerlBlog::Model::Post->get_all_posts_info($postId);
    
    my %preparedPost;
    for(my $i = 0; $i < scalar keys $postData; $i++) {       
        $preparedPost{'tags'}{$postData->[$i]->{'tagid'}}  = $postData->[$i]->{'tagname'}; 
    }
    $preparedPost{'id'}       = $postData->[0]->{'id'}; 
    $preparedPost{'title'}       = $postData->[0]->{'title'}; 
    $preparedPost{'preview'}     = $postData->[0]->{'preview'}; 
    $preparedPost{'content'}     = $postData->[0]->{'content'}; 
    $preparedPost{'author_id'}   = $postData->[0]->{'authorid'}; 
    $preparedPost{'category_id'} = $postData->[0]->{'categoryid'}; 
    $preparedPost{'category_name'} = $postData->[0]->{'categoryname'}; 
    $preparedPost{'author_name'} = $postData->[0]->{'authorname'}; 
    
    $self->render(post => \%preparedPost, currentUserName => $currentUserName, currentUserId =>$currentUserId);
}


1;

