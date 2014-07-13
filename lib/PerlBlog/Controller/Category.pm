package PerlBlog::Controller::Category;

use strict;
use warnings;
use v5.10;
use base 'Mojolicious::Controller';
use Data::Dumper;

sub create {
    my $self = shift;
    my $name = $self->param('name');
    
    # Проверка
    unless($name) {
        $self->flash(error => 'Name can not be empty')->redirect_to('category_form_create');
        return;
    }
    
    my %category = (
        name => $name
    );
    
    PerlBlog::Model::Category->insert(\%category);  
    
    $self->redirect_to('/');
}



sub form_delete {
    my $self   = shift; 
    
    my $categories = PerlBlog::Model::Category->get_categories();
    $self->render(categories => $categories);
}


sub delete {
    my $self   = shift; 
    my $categoryId = $self->param('categoryId');
    
    # Проверка 
    my $tags = PerlBlog::Model::Tag->get_tags_by_category_id($categoryId);


    
    if ( $tags->[0] ) {
        $self->flash(
            error        => 'Delete the associated tags!',
        )->redirect_to('category_form_delete');
        return;
    }
    
    PerlBlog::Model::Category->delete({id=>$categoryId});
    $self->redirect_to('/');
}

1;