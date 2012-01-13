use utf8;
package LIMS2::Model::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

LIMS2::Model::Schema::Result::User

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_user_id_seq'

=head2 user_name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "user_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_user_id_seq",
  },
  "user_name",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<users_user_name_key>

=over 4

=item * L</user_name>

=back

=cut

__PACKAGE__->add_unique_constraint("users_user_name_key", ["user_name"]);

=head1 RELATIONS

=head2 design_comments

Type: has_many

Related object: L<LIMS2::Model::Schema::Result::DesignComment>

=cut

__PACKAGE__->has_many(
  "design_comments",
  "LIMS2::Model::Schema::Result::DesignComment",
  { "foreign.created_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 design_well_recombineering_results

Type: has_many

Related object: L<LIMS2::Model::Schema::Result::DesignWellRecombineeringResult>

=cut

__PACKAGE__->has_many(
  "design_well_recombineering_results",
  "LIMS2::Model::Schema::Result::DesignWellRecombineeringResult",
  { "foreign.created_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 designs

Type: has_many

Related object: L<LIMS2::Model::Schema::Result::Design>

=cut

__PACKAGE__->has_many(
  "designs",
  "LIMS2::Model::Schema::Result::Design",
  { "foreign.created_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 gene_comments

Type: has_many

Related object: L<LIMS2::Model::Schema::Result::GeneComment>

=cut

__PACKAGE__->has_many(
  "gene_comments",
  "LIMS2::Model::Schema::Result::GeneComment",
  { "foreign.created_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 plate_comments

Type: has_many

Related object: L<LIMS2::Model::Schema::Result::PlateComment>

=cut

__PACKAGE__->has_many(
  "plate_comments",
  "LIMS2::Model::Schema::Result::PlateComment",
  { "foreign.created_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 plates

Type: has_many

Related object: L<LIMS2::Model::Schema::Result::Plate>

=cut

__PACKAGE__->has_many(
  "plates",
  "LIMS2::Model::Schema::Result::Plate",
  { "foreign.created_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_roles

Type: has_many

Related object: L<LIMS2::Model::Schema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "LIMS2::Model::Schema::Result::UserRole",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 well_distribute_overrides

Type: has_many

Related object: L<LIMS2::Model::Schema::Result::WellDistributeOverride>

=cut

__PACKAGE__->has_many(
  "well_distribute_overrides",
  "LIMS2::Model::Schema::Result::WellDistributeOverride",
  { "foreign.created_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 wells

Type: has_many

Related object: L<LIMS2::Model::Schema::Result::Well>

=cut

__PACKAGE__->has_many(
  "wells",
  "LIMS2::Model::Schema::Result::Well",
  { "foreign.created_by" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-01-13 15:49:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:NM6bpBTFqM+rMHqDD/qzVw


# You can replace this text with custom code or comments, and it will be preserved on regeneration

=head2 roles

Type: many_to_many

Related object: L<LIMS2::Model::Schema::Result::Role>

=cut

__PACKAGE__->many_to_many( 'roles' => 'user_roles' => 'role' );

sub as_hash {
    my $self = shift;

    return {
        user_name => $self->user_name,
        roles     => [ map { $_->role_name } $self->roles ]
    };
}
    
__PACKAGE__->meta->make_immutable;
1;
