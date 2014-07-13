package PerlBlog::Model::Comment;
use strict;
use warnings;
use v5.10;
use base qw/PerlBlog::Model::Base/;
use Data::Dumper;


sub table_name {'comment'}

sub get_comments_by_post_id {
    my $self  = shift;
    my ($postId) = @_;
    return $self->plain_query('
        SELECT 
            comment.text as comment_text,
            user.login as author_name,
            user.id as author_id,
            comment.id as comment_id
        FROM 
            comment, user
        WHERE 
            comment.post_id = ' . $postId . ' AND
            comment.author_id = user.id
    ')->hashes();
}

1;

