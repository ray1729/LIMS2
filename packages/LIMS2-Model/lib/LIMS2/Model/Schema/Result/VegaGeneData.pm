use utf8;
package LIMS2::Model::Schema::Result::VegaGeneData;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

LIMS2::Model::Schema::Result::VegaGeneData

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

=head1 TABLE: C<vega_gene_data>

=cut

__PACKAGE__->table("vega_gene_data");

=head1 ACCESSORS

=head2 vega_gene_id

  data_type: 'text'
  is_nullable: 0

=head2 vega_gene_chromosome

  data_type: 'text'
  is_nullable: 0

=head2 vega_gene_start

  data_type: 'integer'
  is_nullable: 0

=head2 vega_gene_end

  data_type: 'integer'
  is_nullable: 0

=head2 vega_gene_strand

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "vega_gene_id",
  { data_type => "text", is_nullable => 0 },
  "vega_gene_chromosome",
  { data_type => "text", is_nullable => 0 },
  "vega_gene_start",
  { data_type => "integer", is_nullable => 0 },
  "vega_gene_end",
  { data_type => "integer", is_nullable => 0 },
  "vega_gene_strand",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</vega_gene_id>

=back

=cut

__PACKAGE__->set_primary_key("vega_gene_id");

=head1 RELATIONS

=head2 mgi_vega_gene_maps

Type: has_many

Related object: L<LIMS2::Model::Schema::Result::MgiVegaGeneMap>

=cut

__PACKAGE__->has_many(
  "mgi_vega_gene_maps",
  "LIMS2::Model::Schema::Result::MgiVegaGeneMap",
  { "foreign.vega_gene_id" => "self.vega_gene_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2012-01-05 09:46:51
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Bj23t0nB92EuCjO/NYfoqw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
