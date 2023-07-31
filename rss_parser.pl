#!/usr/bin/env perl
use strict;
use warnings;
use XML::FeedPP;
use HTML::Entities;

my $uri = $ARGV[0];         # URI för RSS-flöde
my $lines = $ARGV[1];       # Antal rubriker
my $titlenum = $ARGV[2];    # Antal extra rubriker

# Skriptets start
# Kräver en URI som ett minimum
unless ($uri) {
    print "URI har inte specificerats.\n";
    print "Kolla scriptets kod\n";
    exit;
}

# Sätt standardvärden om inga angivna
$lines ||= 5;
$titlenum ||= 2;

# Hämta RSS-flödet
my $feed = XML::FeedPP->new($uri);

# Bearbeta rubrikerna
my @entries = $feed->get_item();
foreach my $item (@entries[0..$lines+$titlenum-1]) {
    my $title = $item->title;
    $title =~ s/^.*?: //;        # Ta bort allt fram till och med det första ":" tecknet
    $title =~ s/ SWISH: 0720312394//g;   # Ta bort den statiska texten i slutet
    $title = decode_entities($title);   # Avkoda HTML-tecken
    print "$title\n";
}
