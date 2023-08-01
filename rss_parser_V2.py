#!/usr/bin/env python3
import feedparser
import sys
from html import unescape

uri = sys.argv[1]            # URI for RSS feed
lines = int(sys.argv[2])     # Num titles
titlenum = int(sys.argv[3])  # Num extra titles

# Require an URI
if not uri:
    print("URI needed")
else:
    # Set defaults
    if not lines:
        lines = 5
    if not titlenum:
        titlenum = 2

    # Get RSS feed
    feed = feedparser.parse(uri)

    # Process titles
    for item in feed.entries[:lines + titlenum]:
        title = item.title
        print(unescape(title))
