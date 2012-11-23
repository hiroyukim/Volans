use inc::Module::Install;
name 'Volans';
all_from 'lib/Volans.pm';

# requires '';

tests 't/*.t';
#author_tests 'xt';

test_requires 'Test::More';
#auto_set_repository;
auto_include;
WriteAll;
