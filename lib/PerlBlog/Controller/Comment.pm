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
    PerlBlog::Model::Comment->insert(\%comment);
    return 1;
}


1;

