package PerlBlog::Model::Post;
use strict;
use warnings;
use v5.10;
use base qw/PerlBlog::Model::Base/;

sub table_name {'post'}

sub get_posts {
    my $self = shift;
    return $self->select()->hashes();
}

sub get_posts_by_tag_id {
    my $self = shift;
    my ($tagId) = @_;
    return $self->plain_query('
        SELECT 
            post.id as id,
            post.title as title,
            post.preview as preview,
            post.author_id as author_id
        FROM 
            post,
            posts_tags
        WHERE 
            posts_tags.post_id = post.id AND
            posts_tags.tag_id =' .  $tagId . ';'
    )->hashes();
}

sub get_all_posts_info {

    my $self = shift;
    my ($postId) = @_;

    
    return $self->plain_query('
        SELECT 
            post.id as postId,
            post.title as title,
            post.content as content,
            post.preview as preview,
            post.author_id as authorid,
            tag.id as tagId,
            tag.name as tagName,
            category.id as categoryid,
            category.name as categoryname,
            user.login as authorname
        FROM 
            post,
            posts_tags,
            tag,
            category,
            user
        WHERE 
            postId =' . $postId . ' AND
            posts_tags.post_id = ' . $postId . ' AND
            posts_tags.tag_id = tagId AND
            tag.category_id = categoryid AND
            user.id = authorid;
    ')->hashes();
}

1;

