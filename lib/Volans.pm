package Volans;
use strict;
use warnings;
our $VERSION = '0.02';

use Carp ();
use File::Spec;

sub new {  
    my ($class,$command_args,$command,$hooks) = @_;

    unless( ref $command_args eq 'ARRAY' ) {
        Carp::croak("command_args"); 
    }

    unless( ref $command eq 'HASH' ) {
        Carp::croak('command');
    }

    unless( ref $hooks eq 'HASH' ) {
        Carp::croak('hooks');
    }

    bless {
        command_args   => $command_args,
        command      => $command,
        hooks      => $hooks
    }, $class;
}

sub command_args    { $_[0]->{command_args}   }
sub command       { $_[0]->{command}      }
sub hooks       { $_[0]->{hooks}      }

sub run_hooks {
    my ($self,$hook_name) = @_;

    my @hooks =  @{$self->command->{$hook_name . "_hooks"}||[]};

    for my $hook ( @hooks ) {
        my ($format,@list) = @{$self->hooks->{$hook}->(@{$self->command_args})};
        system(sprintf($format,@list));
    }
}

#FIXME: parallels 
sub run_cmd {
    my $self = shift;

    my ($cmd,$hosts) = map {  $self->command->{$_} } qw/cmd hosts/;

    for my $host ( ( ref $hosts eq 'CODE' ) ? @{$hosts->(@{$self->command_args})} : @{$hosts} ) {
        my ($format,@list) = @{$cmd->($host,@{$self->command_args})};
        system( sprintf($format,@list) );
    }
}

sub run {
    my $self = shift;

    $self->run_hooks('before'); 
    $self->run_cmd();    
    $self->run_hooks('after'); 
}

1;
__END__

=head1 NAME

Volans -

=head1 SYNOPSIS

  use Volans;

=head1 DESCRIPTION

Volans is

=head1 AUTHOR

hiroyuki yamanaka E<lt>default {at} example.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
