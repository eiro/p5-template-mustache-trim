package Template::Mustache::Trim;
use 5.10.0;
use strict;
use warnings;
no warnings 'qw';
our $VERSION = '0.000';
# ABSTRACT: trim your mustache templates 

our @stack;

use overload
((map {
        my ($op,$sym) = @$_;
        $op => sub {
            my ( $k, @t ) = @{$_[1]};
            join '', "{{$sym$k}}",@t, "{{/$k}}"
        }
    } [qw( ^  ^ )]
    , [qw( .  # )] )
, '|' => sub {
    my ($k, $if, $else ) = @{ $_[1] };
      "{{#$k}}", @$if   , "{{/$k}}"
    , "{{^$k}}", @$else , "{{/$k}}"
});

sub new {
    state $singleton = bless {}, __PACKAGE__;
    $singleton
}

1;
