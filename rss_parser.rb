#!/usr/bin/env ruby
require 'rss'
require 'open-uri'

uri = ARGV[0]            # URI
lines = ARGV[1].to_i     # Num titles
titlenum = ARGV[2].to_i  # Nu extra titles

# Require URI
if uri.nil? || uri.empty?
    puts "URI needed"
else
    # Set defaults
    lines = 5 if lines.zero?
    titlenum = 2 if titlenum.zero?

    # Get RSS
    rss_content = URI.open(uri).read
    feed = RSS::Parser.parse(rss_content)

    # Process titles
    feed.items.first(lines + titlenum).each do |item|
        puts title
    end
end
