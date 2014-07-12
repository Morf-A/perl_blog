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
1;

