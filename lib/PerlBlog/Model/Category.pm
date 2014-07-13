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

sub gat_categories_with_tags {
    my $self = shift;
    return $self->plain_query('
        SELECT DISTINCT
            category.id as id,
            category.name as name 
        FROM 
            category JOIN tag 
        ON 
            category.id = tag.category_id;
    ')->hashes();
}

1;

