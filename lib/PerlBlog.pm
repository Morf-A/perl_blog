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
  
  
    my $rn = $r->bridge('/')->to('auths#check')->name('initial_form');
    
    $rn->route->to('feed#main')->name('feed'); #viewable
  
    #авторизация и создание пользователя
    $rn->route('/login')->via('post')->to('auths#create')->name('auths_create');
    $rn->route('/logout')->to('auths#delete')->name('auths_delete');
    $rn->route('/signup')->via('post')->to('users#create')->name('users_create');

    #post

    $rn->route('/post/new')->via('get')->to('post#form_create')->name('post_form_create'); #viewable
    $rn->route('/post/new')->via('post')->to('post#create')->name('post_create');
    $rn->route('/post/:id')->over(id => qr/^\d+$/)->via('get')->to('post#show')->name('post_show'); #viewable
    
    #comment
    $rn->route('/comment')->via('post')->to('comment#create')->name('comment_create');
    
    
    
    # Init Model
    PerlBlog::Model->init({
        dsn      => 'dbi:SQLite:dbname=' . $self->home->rel_dir('storage') . '/blog.db',
        user     => '',
        password =>''
    });
}

1;
