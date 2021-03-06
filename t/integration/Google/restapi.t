#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use lib "$FindBin::RealBin/..";
use lib "$FindBin::RealBin/../../../lib";

use Log::Log4perl qw(:easy);
use YAML::Any qw(Dump);
use Test::Most tests => 4;

use Utils;
use aliased "Google::RestApi";
use Google::RestApi::Auth::OAuth2Client;

Utils::init_logger();

my $config_file = Utils::rest_api_config();

my ($api, $about);
lives_ok sub {
  $api = RestApi->new(config_file => $config_file);
}, "New api should succeed";
lives_ok sub { $about = $api->api(
  uri => 'https://www.googleapis.com/drive/v3/about',
  params => {
    fields => 'user',
  },
); }, "Api login should succeed";
is ref($about), 'HASH', "About drive should return a hash";
is ref($about->{user}), 'HASH', "About drive.user should return a hash";
