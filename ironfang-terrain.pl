#!/usr/bin/perl

use JSON;
use Data::Dumper;

my $bonuses_filename = "terrain-bonuses.json";

my $bonuses_json = &get_json($bonuses_filename);
my $bonuses_json_data = $bonuses_json;

my @list_to_pull_from;

foreach my $row (@{$bonuses_json_data}) {
    for my $i (0..$row->{'count'}) {
        push(@list_to_pull_from,$row);
    }
}

my $upper_limit = (scalar @list_to_pull_from)-1;
my $pick_index = &rng($upper_limit,0,0);
my $pick = $list_to_pull_from[$pick_index];

print $pick->{'title'}." // ".$pick->{'desc'}."\n";

# ----------
sub get_json {
  my ($filename) = @_;
  my $file_data;
  open my $h, '<:encoding(UTF-8)', $filename;
    $file_data = <$h>;
  close $h;

  my $json_enc = decode_json($file_data);

  return $json_enc;
}

# ----------
sub rng {
  my ($dice,$floor,$bonus) = @_;
  $dice = int($dice);
  unless($floor) { $floor = 1; }
  unless($bonus) { $bonus = 0; }

  return int(rand($dice)+$floor+$bonus);
}