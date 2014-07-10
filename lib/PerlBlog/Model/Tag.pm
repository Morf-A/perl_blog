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

1;

