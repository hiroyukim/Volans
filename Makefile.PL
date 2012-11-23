use inc::Module::Install;
name 'Volans';
all_from 'lib/Volans.pm';

requires 'Try::Tiny';

tests 't/*.t';

test_requires 'Test::More';
auto_include;
install_script('bin/volans');
WriteAll;
