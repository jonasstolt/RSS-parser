#!/usr/bin/env perl
use strict;
use warnings;
use XML::FeedPP;
use HTML::Entities;

my $uri = $ARGV[0];         # URI 
my $lines = $ARGV[1];       # Num titles
my $titlenum = $ARGV[2];    # Num extra titles

# Require URI
unless ($uri) {
    print "URI neede\n";
    exit;
}

# Set defaults if $lines and/or $titlenum missing
$lines ||= 5;
$titlenum ||= 2;

# Get RSS feed
my $feed = XML::FeedPP->new($uri);

# Process
my @entries = $feed->get_item();
foreach my $item (@entries[0..$lines+$titlenum-1]) {
    my $title = $item->title;
    $title = decode_entities($title); 
    print "$title\n";
}
