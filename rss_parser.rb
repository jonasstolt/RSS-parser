#!/usr/bin/env ruby
require 'rss'
require 'open-uri'

uri = ARGV[0]            # URI för RSS-flöde
lines = ARGV[1].to_i     # Antal rubriker
titlenum = ARGV[2].to_i  # Antal extra rubriker

# Skriptets start
# Kräver en URI som ett minimum
if uri.nil? || uri.empty?
    puts "URI har inte specificerats."
    puts "Kolla scriptets källkod"
else
    # Sätt standardvärden om inga angivna
    lines = 5 if lines.zero?
    titlenum = 2 if titlenum.zero?

    # Hämta RSS-flödet
    rss_content = URI.open(uri).read
    feed = RSS::Parser.parse(rss_content)

    # Process rubrikerna
    feed.items.first(lines + titlenum).each do |item|
        title = item.title.split(" - ", 2).last
        title = title[15..-1]  # Ta bort de 15 första tecknen
        title = title.gsub(" SWISH: 0720312394", "") # Sorry, det tar onödig plats
        puts titleS
    end
end
