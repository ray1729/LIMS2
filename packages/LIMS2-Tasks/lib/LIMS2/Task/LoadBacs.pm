package LIMS2::Task::LoadBacs;

use strict;
use warnings FATAL => 'all';

use Moose;
use LIMS2::Util::YAMLIterator;
use namespace::autoclean;

extends 'LIMS2::Task';

sub execute {
    my ( $self, $opts, $args ) = @_;

    die "No input file given\n"
        unless @{$args};

    my $model = $self->model;

    $model->txn_do(
        sub {
            for my $input_file ( @{$args} ) {
                my $it = iyaml( $input_file );
                while ( my $bac = $it->next ) {
                    $model->create_bac_clone( $bac );
                }
            }
            unless ( $self->commit ) {
                warn "Rollback\n";
                $model->txn_rollback;
            }
        }
    );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

    
