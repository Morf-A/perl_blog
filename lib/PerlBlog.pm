package PerlBlog;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
    my $self = shift;

    # Documentation browser under "/perldoc"
    $self->plugin('PODRenderer');

    # Router
    my $r = $self->routes;

    $r->namespaces(['PerlBlog::Controller']);
  
    $r->route('/')                   ->to('initial_form')->name('initial_form');
    
    
    $r->route('/login')              ->to('auths#create')     ->name('auths_create');
    $r->route('/logout')             ->to('auths#delete')     ->name('auths_delete');
    $r->route('/signup')->via('post')->to('users#create')     ->name('users_create');
    $r->route('/main')  ->via('get') ->to('users#show')       ->name('users_show');
}

1;
