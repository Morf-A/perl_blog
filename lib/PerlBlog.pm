package PerlBlog;

use strict;
use warnings;
use Mojo::Base 'Mojolicious';
use PerlBlog::Model;

# This method will run once at server start
sub startup {
    my $self = shift;


    # Router
    my $r = $self->routes;

    $r->namespaces(['PerlBlog::Controller']);
  
    #авторизация и создание пользователя
    $r->route('/index')->to('initial_form')->name('initial_form'); #viewable
    $r->route('/login')->via('post')->to('auths#create')->name('auths_create');
    $r->route('/logout')->to('auths#delete')->name('auths_delete');
    $r->route('/signup')->via('post')->to('users#create')->name('users_create');

    # Часть сайта после авторизации
    
    #feed
    $r->route('/')->to('feed#main')->name('feed'); #viewable
    
    #post

    $r->route('/post/new')->via('get')->to('post#form_create')->name('post_form_create'); #viewable
    $r->route('/post/new')->via('post')->to('post#create')->name('post_create');
    $r->route('/post/:id')->over(id => qr/^\d+$/)->via('get')->to('post#show')->name('post_show'); #viewable
    
    #comment
    $r->route('/comment')->via('post')->to('comment#create')->name('comment_create');
    
    
    
    # Init Model
    PerlBlog::Model->init({
        dsn      => 'dbi:SQLite:dbname=' . $self->home->rel_dir('storage') . '/blog.db',
        user     => '',
        password =>''
    });
}

1;
