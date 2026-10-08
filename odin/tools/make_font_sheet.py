#!/usr/bin/env python3
"""Builds web/font.png, the tile sheet the game draws its text from, out of Daniel Linssen's m6x11.ttf.

Usage: tools/make_font_sheet.py /path/to/m6x11.ttf [out.png]

The TTF is not kept in this repo (see NOTICE.md); get it from https://managore.itch.io/m6x11.

Sheet layout (must match display.odin's char_to_tile and web/index.html):
  tiles are 10 by 14 px, 32 per row, numbered from 1 in row-major order
  tiles   1..64   highlight set: bright green ink on dark green (headers and the N) keys)
  tiles  65..128  normal set:    dark ink on bright green
  within a set, ASCII 64..95 ('@' A-Z [ \\ ] ^ _) come first, then ASCII 32..63 (space ! " ... ?)
Glyphs are drawn at m6x11's design size (16 px), unmodified, centred in the cell, with the baseline on row 12:
capitals take rows 1..11 and descenders ( ) [ ] $ , ; take rows 12..13.
"""
import sys
from PIL import Image, ImageDraw, ImageFont

CELL_W, CELL_H, BASELINE, PER_ROW = 10, 14, 12, 32
HIGHLIGHT = {"ink": (0, 255, 0), "bg": (0, 68, 0)}
NORMAL = {"ink": (24, 48, 24), "bg": (0, 255, 0)}


def glyph_for_tile(index):
    """ASCII code for a 0-based tile index within one set of 64."""
    return 64 + index if index < 32 else 32 + (index - 32)


def render_glyph(font, ch):
    """Returns (mask, left, top): an 'L' mask of the ink and where it goes in the cell."""
    scratch = Image.new("L", (40, 40), 0)
    draw = ImageDraw.Draw(scratch)
    draw.fontmode = "1"
    draw.text((10, 20), ch, font=font, fill=255, anchor="ls")
    box = scratch.getbbox()
    if box is None:
        return None
    ink = scratch.crop(box)
    left = (CELL_W - ink.width) // 2
    top = BASELINE + (box[1] - 20)
    return ink, left, top


def main():
    if len(sys.argv) < 2:
        sys.exit(__doc__)
    font = ImageFont.truetype(sys.argv[1], 16)
    out = sys.argv[2] if len(sys.argv) > 2 else "web/font.png"
    sheet = Image.new("RGB", (PER_ROW * CELL_W, 4 * CELL_H))
    for scheme_index, scheme in enumerate((HIGHLIGHT, NORMAL)):
        for i in range(64):
            ch = chr(glyph_for_tile(i))
            tile = Image.new("RGB", (CELL_W, CELL_H), scheme["bg"])
            glyph = render_glyph(font, ch)
            if glyph is not None:
                ink, left, top = glyph
                assert left >= 0 and left + ink.width <= CELL_W, f"{ch!r} is too wide for the cell"
                assert top >= 0 and top + ink.height <= CELL_H, f"{ch!r} does not fit the cell vertically"
                tile.paste(Image.new("RGB", ink.size, scheme["ink"]), (left, top), ink)
            t = scheme_index * 64 + i
            sheet.paste(tile, ((t % PER_ROW) * CELL_W, (t // PER_ROW) * CELL_H))
    sheet.save(out, optimize=True)
    print(f"wrote {out}: {sheet.width}x{sheet.height}, 128 tiles of {CELL_W}x{CELL_H}")


if __name__ == "__main__":
    main()
