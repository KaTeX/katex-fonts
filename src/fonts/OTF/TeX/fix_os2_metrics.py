#!/usr/bin/env python2

import fontforge

import sys

if len(sys.argv) < 2:
    print "Usage: %s <font file>" % sys.argv[0]
    sys.exit(1)

font_file = sys.argv[1]

font = fontforge.open(font_file)

boundingBoxes = list(font[c].boundingBox() for c in font)
ascent = int(max(b[3] for b in boundingBoxes))
descent = -int(min(b[1] for b in boundingBoxes))

font.os2_winascent = ascent
font.os2_windescent = descent

font.hhea_ascent = ascent
font.hhea_descent = -descent

font.generate(font_file)
