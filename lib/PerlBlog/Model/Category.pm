package PerlBlog::Model::Category;
use strict;
use warnings;
use v5.10;
use base qw/PerlBlog::Model::Base/;

sub table_name {'category'}

sub get_categories {
    my $self = shift;
    return $self->select()->hashes();
}

1;

