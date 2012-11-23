use strict;
use Test::More;
use Volans;
use File::Spec;
use File::Basename qw(dirname);
my $basedir = File::Spec->rel2abs(File::Spec->catdir(dirname(__FILE__)));

subtest 'run' => sub {

    my $volans = Volans->new(
        [],{},{}
    );

    ok($volans,'new with config_file_path');

    $volans->run();
};


done_testing();
