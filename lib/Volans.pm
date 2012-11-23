package Volans;
use strict;
use warnings;
our $VERSION = '0.01';

use File::Spec;

sub new { 
    my ($class,%args) = @_;
    my $self = bless \%args, $class;
}

sub config {
    my $self = shift;    

    $self->{_config} ||= do 
        $self->{config_file_path} ||  File::Spec->catfile($ENV{HOME}, '.volans', 'config.pl');
}

sub run_hooks {
    my ($self,$hook_name) = @_;

    my @hooks =  @{$self->config->{groups}->{$self->{group_name}}->{$hook_name . "_hooks"}||[]};

    for my $hook ( @hooks ) {
        system($self->config->{hooks}->{$hook});
    }
}

#FIXME: parallels 
sub run_cmd {
    my $self = shift;

    my ($cmd,$hosts) = map {  $self->config->{groups}->{$self->{group_name}}->{$_} } qw/cmd hosts/;

    for my $host ( @{$hosts} ) {
        system($cmd->($host));
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
