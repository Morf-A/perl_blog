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
  
    $r->route('/')                   ->to('initial_form')->name('initial_form');
    
    
    #$r->route('/login')              ->to('auths#create')     ->name('auths_create');
    #$r->route('/logout')             ->to('auths#delete')     ->name('auths_delete');
    
    $r->route('/signup')->via('post')->to('users#create')     ->name('users_create');
    #$r->route('/main')  ->via('get') ->to('users#show')       ->name('users_show');
    
    # Init Model
    
    PerlBlog::Model->init({
        dsn      => 'dbi:SQLite:dbname=' . $self->home->rel_dir('storage') . '/blog.db',
        user     => '',
        password =>''
    });
}

1;
