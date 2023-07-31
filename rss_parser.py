#!/usr/bin/env python3
import feedparser
import sys

uri = sys.argv[1]            # URI för RSS-flöde
lines = int(sys.argv[2])     # Antal rubriker
titlenum = int(sys.argv[3])  # Antal extra rubriker

# Scriptstart
# Kräver en URI som ett minimum
if not uri:
    print("URI har inte specificerats.")
    print("Kolla scriptets kod")
else:
    # Sätt standardvärden om inga angivna
    if not lines:
        lines = 5
    if not titlenum:
        titlenum = 2

    # Hämta RSS-flödet
    feed = feedparser.parse(uri)

    # Processa rubrikerna
    for item in feed.entries[:lines+titlenum]:
        title = item.title.split(" - ", 1)[-1]
        title = title[15:]  # Ta bort de 15 första tecknen
        # Sorry, det tar onödig plats
        title = title.replace(" SWISH: 0720312394", "")
        print(title)
