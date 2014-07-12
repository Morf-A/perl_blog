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

    #авторизация и создание пользователя
    $rn->route('/login')->via('post')->to('auths#create')->name('auths_create');
    $rn->route('/logout')->to('auths#delete')->name('auths_delete');
    $rn->route('/signup')->via('post')->to('users#create')->name('users_create');
    
    #список постов
    $rn->route->to('feed#main')->name('feed'); #viewable
    $rn->route('/tag/show/:id')->to('tag#main')->name('tag_feed'); #viewable
    
    #post

    $rn->route('/post/new')->via('get')->to('post#form_create')->name('post_form_create'); #viewable
    $rn->route('/post/new')->via('post')->to('post#create')->name('post_create');
    $rn->route('/post/show/:id')->via('get')->to('post#show')->name('post_show'); #viewable
    $rn->route('/post/delete')->via('get')->to('post#form_delete')->name('post_form_create');
    $rn->route('/post/delete')->via('post')->to('post#delete')->name('post_delete');
    
    #comment
    $rn->route('/comment')->via('post')->to('comment#create')->name('comment_create');
    $rn->route('/comment/delete')->via('post')->to('comment#delete')->name('comment_delete');
    
    #tags
    $rn->route('/tag/new')->via('get')->to('tag#form_create')->name('tag_form_create');
    $rn->route('/tag/new')->via('post')->to('tag#create')->name('tag_create');
    $rn->route('/tag/delete')->via('get')->to('tag#form_delete')->name('tag_form_delete');
    $rn->route('/tag/delete')->via('post')->to('tag#delete')->name('tag_create');
    
    #category
    $rn->route('/category/new')->via('get')->to('category#form_create')->name('category_form_create');
    $rn->route('/category/new')->via('post')->to('category#form_create')->name('category_create');
    $rn->route('/category/delete')->via('get')->to('category#form_delete')->name('category_form_delete');
    $rn->route('/category/delete')->via('post')->to('category#form_delete')->name('category_delete');
    
    # Init Model
    PerlBlog::Model->init({
        dsn      => 'dbi:SQLite:dbname=' . $self->home->rel_dir('storage') . '/blog.db',
        user     => '',
        password =>''
    });
}

1;
