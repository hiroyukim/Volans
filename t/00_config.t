use strict;
use Test::More;
use Volans;
use Volans::CLI;
use File::Spec;
use File::Basename qw(dirname);
my $basedir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__)));

subtest 'new' => sub {
    ok( Volans->new([],{},{}), 'new' );
};

subtest 'config' => sub {

    my $volans = Volans::CLI->new(
        "$basedir/config.pl",
    );

    ok($volans,'new with config_file_path');

    ok($volans->config);
};

subtest 'bad config' => sub {

    my $volans = Volans::CLI->new(
        "$basedir/bad_config.pl",
    );

    ok($volans,'new with config_file_path');

    eval { $volans->config };

    if( $@ ) {
        ok( 1, "bad config");
    }
};


done_testing();
