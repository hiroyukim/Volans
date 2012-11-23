use strict;
use Test::More;
use Volans;
use File::Spec;
use File::Basename qw(dirname);
my $basedir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__)));

subtest 'new' => sub {
    ok( Volans->new, 'new' );
};

subtest 'config' => sub {

    my $volans = Volans->new(
        config_file_path => "$basedir/config.pl",
    );

    ok($volans,'new with config_file_path');
};


done_testing();
