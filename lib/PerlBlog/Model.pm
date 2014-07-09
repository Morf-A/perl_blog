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

        unless ( eval {$DB->select('user')} ) {
            $class->create_db_structure();
        }
    }

    return $DB;
}

sub db {
    return $DB if $DB;
    croak "You should init model first!";
}

sub create_db_structure {
    my $class = shift;
    
    
    $class->db->query(
            'CREATE TABLE user (
                id integer NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
                login text NOT NULL UNIQUE,
                password text NOT NULL
            )'
    );
    
    # $class->db->query(
            # 'CREATE TABLE notes (note_id INTEGER NOT NULL PRIMARY KEY ASC AUTOINCREMENT,
                                      # user_id INTEGER NOT NULL
                                              # CONSTRAINT fk_user_id
                                              # REFERENCES user(user_id)
                                              # ON DELETE RESTRICT,
                                      # is_important INTEGER NOT NULL DEFAULT(0),
                                      # is_todo      INTEGER NOT NULL DEFAULT(0),
                                      # is_deleted   INTEGER NOT NULL DEFAULT(0),
                                      # text     TEXT NOT NULL,
                                      # date INTEGER NOT NULL);'
    # );

    # $class->db->query(
        # "INSERT INTO users(login, password) VALUES('user', 'password');"
    # );
}

1;

