"""Copy the nonicons glyphs into CommitMono, as a new family "CommitMono Nonicons".

Usage: patch_nonicons.py <nonicons.ttf> <out_dir> <CommitMono-*.otf>...
"""
import sys
from pathlib import Path

from fontTools.pens.t2CharStringPen import T2CharStringPen
from fontTools.pens.transformPen import TransformPen
from fontTools.ttLib import TTFont

FAMILY = "CommitMono Nonicons"
PS_FAMILY = "CommitMonoNonicons"


def patch(base_path, icons, out_dir):
    font = TTFont(base_path)
    cff = font["CFF "].cff
    top = cff.topDictIndex[0]
    charstrings = top.CharStrings
    advance = font["hmtx"]["space"][0]
    hhea = font["hhea"]
    cell_mid = (hhea.ascent + hhea.descent) / 2

    icon_hhea = icons["hhea"]
    icon_em = icons["head"].unitsPerEm
    icon_mid = (icon_hhea.ascent + icon_hhea.descent) / 2
    # Ghostty lets an icon followed by a space span two cells. The advance stays one
    # cell so the terminal grid holds, and the icon draws over the next cell.
    span = min(2 * advance, font["head"].unitsPerEm)
    scale = span / icon_em

    icon_glyphs = icons.getGlyphSet()
    icon_cmap = icons.getBestCmap()
    order = font.getGlyphOrder()
    added = {}
    for cp, src_name in sorted(icon_cmap.items()):
        if cp < 0xE000:
            continue
        name = f"nonicon.{cp:04X}"
        icon_adv = icons["hmtx"][src_name][0]
        pen = T2CharStringPen(advance, None)
        transform = (scale, 0, 0, scale,
                     advance - scale * icon_adv / 2,
                     cell_mid - scale * icon_mid)
        icon_glyphs[src_name].draw(TransformPen(pen, transform))
        cs = pen.getCharString(private=top.Private, globalSubrs=cff.GlobalSubrs)
        charstrings.charStrings[name] = len(charstrings.charStringsIndex)
        charstrings.charStringsIndex.append(cs)
        order.append(name)
        font["hmtx"][name] = (advance, 0)
        added[cp] = name

    top.charset = order
    font.setGlyphOrder(order)
    for table in font["cmap"].tables:
        if table.isUnicode():
            table.cmap.update(added)

    names = font["name"]
    ps_name = None
    for rec in names.names:
        text = rec.toUnicode()
        if rec.nameID == 6:
            text = text.replace("CommitMono", PS_FAMILY, 1)
            ps_name = text
        elif rec.nameID in (1, 3, 4, 16, 18):
            text = text.replace("CommitMono", FAMILY, 1)
        else:
            continue
        rec.string = text
    cff.fontNames[0] = ps_name
    top.FamilyName = FAMILY
    top.FullName = top.FullName.replace("CommitMono", FAMILY, 1)

    out = out_dir / Path(base_path).name.replace("CommitMono", PS_FAMILY, 1)
    font.save(out)
    print(f"{out}: {len(added)} icons")


def main():
    icons = TTFont(sys.argv[1])
    out_dir = Path(sys.argv[2])
    out_dir.mkdir(parents=True, exist_ok=True)
    for base in sys.argv[3:]:
        patch(base, icons, out_dir)


if __name__ == "__main__":
    main()
