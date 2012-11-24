package Volans::CLI;
use strict;
use warnings;

use File::Spec;
use Getopt::Long;

use Volans;
use Try::Tiny;

sub new {
    my $class = shift;
    my $config_file_path = shift;
    bless {
        config_file_path => $config_file_path,
    }, $class;
}

sub config {
    my $self = shift;    

    $self->{_config} ||= do (
        $self->{config_file_path} ||  File::Spec->catfile($ENV{HOME}, '.volans', 'config.pl') 
    );
}

sub run {
    my($self, @args) = @_;

    # copy form carton
    local @ARGV = @args;
    my @command_args;
    my $p = Getopt::Long::Parser->new();
    $p->getoptions(
        "h|help"    => sub { unshift @command_args, 'help' },
        "v|version" => sub { unshift @command_args, 'version' },
    );

    push @command_args, @ARGV;
    my $cmd  = shift @command_args || 'usage';
    my $call = $self->can("cmd_$cmd");

    if ($call) {
        try {
            $self->$call(@command_args);
        } catch {
            die $_;
        }
    } elsif ( $self->config->{commands}->{$cmd} ) {
        Volans->new([@command_args],$self->config->{commands}->{$cmd},$self->config->{hooks})->run() 
    } else {
        Carp::croak("Could not find command '$cmd'\n");
    }
}

sub cmd_help {
    my $self = shift;
    system "perldoc", "Volans";
}

sub cmd_version {
    my $self = shift;
    $self->print("volans $Volans::VERSION\n");
}

1;
