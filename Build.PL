use strict;
use warnings FATAL => 'all';
use Module::Build;

my $build = Module::Build->new(
    license              => 'perl',
    recursive_test_files => 1,
    dynamic_config       => 1,
    build_requires       => {
        'Test::Requires' => '0.06',
        'Test::More'     => '0.98',
    },
    configure_requires => { 'Module::Build' => '0.38' },
    requires           => {
        'perl'                       => '5.008001',
        'parent'                     => '0.223',
        'Try::Tiny'                  => '0.06',
    },
    no_index    => { 'directory' => [ 'eg', 'inc', 't', 'xt' ] },
    name        => 'Volans',
    module_name => 'Volans',

    script_files => ['script/volans.pl'],

    test_files => ( -d '.git' || $ENV{RELEASE_TESTING} ) ? 't/ xt/' : 't/',

    create_readme  => 1,
    create_license => 1,
);
$build->create_build_script();
