package PerlBlog::Controller::Comment;

use strict;
use warnings;
use v5.10;
use Data::Dumper;
use base 'Mojolicious::Controller';

sub create {
    my $self = shift;

    my %comment = (
        text  => $self->param('comment'),
        author_id => $self->param('authorId'),
        post_id   => $self->param('postId')
    );
    
    my $commentId = PerlBlog::Model::Comment->insert(\%comment);
    #Возвращаем json данные обратно на страницу
    $self->render(json => {commentId => $commentId});
    
    return 1;
}

sub delete {
    my $self = shift;
    my $commentId = $self->param('commentId');
    PerlBlog::Model::Comment->delete({id=>$commentId});
}

1;

