#! /usr/bin/perl
use Template::Mustache::Trim;
use Test::More;
use 5.10.0;
use strict;
use warnings;
no warnings 'qw';

sub M (;$) {
    state $s = Template::Mustache::Trim->new;
    @_ ? "{{$_[0]}}" : $s
}

is_deeply
( [ 'this', M"test", 'bar' ]
, [ 'this', '{{test}}', 'bar' ]
, "interpolation done" );

use YAML ();
diag YAML::Dump
    [M|[ request =>
        ["yes"],
        ["no"]
    ]];

my @r = M|[request => ["yes"], ["no"] ];

ok
( (@r>1)
, "overloaded operator returns a list" );

is_deeply \@r,
    [ '{{#request}}'
    , 'yes'
    , '{{/request}}'
    , '{{^request}}'
    , 'no'
    , '{{/request}}' ]; 

done_testing;
