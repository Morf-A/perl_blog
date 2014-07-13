package PerlBlog::Model::Tag;
use strict;
use warnings;
use v5.10;
use base qw/PerlBlog::Model::Base/;

sub table_name {'tag'}

sub get_tags {
    my $self= shift;
    return $self->select()->hashes();
}

sub get_tags_by_category_id {
    my $self= shift;
    my($categoryId) = @_;
    return $self->select({category_id => $categoryId})->hashes();
}

1;

