{
    hooks => {
        echo => sub { [qq{echo "hello $_[0]"}] },
    },
    commands => {
        'deploy' => {
            'before_hooks' => [qw/echo/],
            'after_hooks'  => [qw/echo/],
            'hosts'        => [qw/127.0.0.1/],
            'cmd'          => sub {
                my ($host,$project) = @_;
                [q{ssh %s 'echo "hello %s"'},$host,$project]; 
            },
        },
    },
};
