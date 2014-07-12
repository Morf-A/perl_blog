package PerlBlog::Model;
use strict;
use warnings;
use v5.10;
use DBIx::Simple;
use SQL::Abstract;
use Carp qw/croak/;

use Mojo::Loader;

# Reloadable Model
my $modules = Mojo::Loader->search('PerlBlog::Model');
for my $module (@$modules) {
    Mojo::Loader->load($module)
}

my $DB;

sub init {
    my ($class, $config) = @_;

    unless ( $DB ) {
        $DB = DBIx::Simple->connect(@$config{qw/dsn user password/},
            {
                 RaiseError     => 1,
                 sqlite_unicode => 1,
            } )  or die DBIx::Simple->error;
        $DB->abstract = SQL::Abstract->new(
               case          => 'lower',
               logic         => 'and',
               convert       => 'upper'
        );

        # Создаем таблицы для работы
        unless ( eval {$DB->select('user')} ) {
            $class->create_db_user();
        }
        unless ( eval {$DB->select('post')} ) {
            $class->create_db_post();
        }
        unless ( eval {$DB->select('posts_tags')} ) {
            $class->create_db_posts_tags();
        }
        unless ( eval {$DB->select('category')} ) {
            $class->create_db_category();
        }
        unless ( eval {$DB->select('tag')} ) {
            $class->create_db_tag();
        }
        unless ( eval {$DB->select('comment')} ) {
            $class->create_db_comment();
        }
    }

    return $DB;
}

sub db {
    return $DB if $DB;
    croak "You should init model first!";
}

#user
sub create_db_user {
    my $class = shift;
    
    
    $class->db->query(
        'CREATE TABLE user (
            id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            login text NOT NULL UNIQUE,
            password text NOT NULL
        )'
    );
}

#post
sub create_db_post {
    my $class = shift;
    
    
    $class->db->query(
        'CREATE TABLE post (
            id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            title text NOT NULL,content text,preview text,
            author_id integer NOT NULL
        )'
    );
}

#posts_tags
sub create_db_posts_tags {
    my $class = shift;
    
    
    $class->db->query(
        'CREATE TABLE posts_tags (
            post_id integer,
            tag_id integer,
            PRIMARY KEY (post_id,tag_id)
        )'
    );
}

#tags
sub create_db_tag {
    my $class = shift;
    
    
    $class->db->query(
        'CREATE TABLE tag (
            id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            category_id integer,
            name text NOT NULL
        )'
    );
    
        
    #Создание тестовых тегов
    my $carsCatId = $class->db->query("SELECT * FROM category WHERE name = 'Cars'")->hash()->{'id'};
    $class->db->query(qq{INSERT INTO tag (category_id, name) VALUES ($carsCatId, 'old cars')});
    $class->db->query(qq{INSERT INTO tag (category_id, name) VALUES ($carsCatId, 'russian cars')});
    $class->db->query(qq{INSERT INTO tag (category_id, name) VALUES ($carsCatId, 'big cars')});
    $class->db->query(qq{INSERT INTO tag (category_id, name) VALUES ($carsCatId, 'bad cars')});
    
    my $girlsCatId = $class->db->query("SELECT * FROM category WHERE name = 'Girls'")->hash()->{'id'};
    $class->db->query(qq{INSERT INTO tag (category_id, name) VALUES ($girlsCatId, 'beautiful')});
    $class->db->query(qq{INSERT INTO tag (category_id, name) VALUES ($girlsCatId, 'terrible')});
    $class->db->query(qq{INSERT INTO tag (category_id, name) VALUES ($girlsCatId, 'blonde')});
    $class->db->query(qq{INSERT INTO tag (category_id, name) VALUES ($girlsCatId, 'brunette')});
    
}

#category
sub create_db_category {
    my $class = shift;
    
    
    $class->db->query(
        'CREATE TABLE category (
            id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            name text NOT NULL
        )'
    );
    
    #Создание тестовыы категорий
    $class->db->query("INSERT INTO category (name) VALUES  ('Cars')");
    $class->db->query("INSERT INTO category (name) VALUES  ('Girls')");
}

#commetn
sub create_db_comment {
    my $class = shift;
    
    $class->db->query(
        'CREATE TABLE comment (
            id integer NOT NULL PRIMARY KEY AUTOINCREMENT,
            text text,
            author_id integer NOT NULL,
            post_id integer NOT NULL
        )'
    );
}

1;

