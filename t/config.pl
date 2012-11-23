{
    hooks => {
        echo => sub { qq{echo "hello $_[0]"} },
    },
    groups => {
        'group_01' => {
            'before_hooks' => [qw/echo/],
            'after_hooks'  => [qw/echo/],
            'hosts'        => [qw/127.0.0.1/],
            'cmd'          => sub {
                return sprintf(qq{ssh %s 'echo "hello"'},$_[0]); 
            },
        },
    },
};
