package LIMS2::Model::Plugin::User;

use strict;
use warnings FATAL => 'all';

use Moose::Role;
use Hash::MoreUtils qw( slice );
use namespace::autoclean;

requires qw( schema check_params throw );

has _role_id_for => (
    isa        => 'HashRef',
    traits     => [ 'Hash' ],
    lazy_build => 1,
    handles    => {
        role_id_for => 'get'
    }
);

sub _build__role_id_for {
    my $self = shift;

    return +{ map { $_->role_name => $_->role_id } $self->schema->resultset( 'Role' )->all };
}

sub user_id_for {
    my ( $self, $user_name ) = @_;

    my %search = ( user_name => $user_name );
    my $user = $self->schema->resultset( 'User' )->find( \%search )
        or $self->throw(
            NotFound => {
                entity_class  => 'User',
                search_params => \%search
            }
        );

    return $user->user_id;
}

sub create_user {
    my ( $self, $params ) = @_;

    my $validated_params = $self->check_params( 'create_user', $params );

    my $user = $self->schema->resultset( 'User' )->create( { slice $validated_params, 'user_name' } );

    if ( $validated_params->{roles} ) {
        for my $r ( @{ $validated_params->{roles} } ) {
            $user->create_related(
                user_roles => {
                    role_id => $self->role_id_for( $r )
                }
            );
        }
    }

    return $user->as_hash;
}

sub delete_user {
    my ( $self, $params ) = @_;

    my $validated_params = $self->check_params( 'delete_user', $params );

    my $user = $self->schema->resultset( 'User' )->find( $validated_params )
        or $self->throw(
            NotFound => {
                entity_class  => 'User',
                search_params => $validated_params
            }
        );

    $user->user_roles_rs->delete;
    $user->delete;

    return 1;
}

1;

__END__
