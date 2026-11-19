"""Build CommitMono from the commitmono.com source fonts, like the website's download wizard.

Usage: build_commit_mono.py <out_dir>

The settings below are the ones picked on commitmono.com. The website bakes them into
static fonts in the browser (src/js/download_wizard.js). This script does the same with
fontTools, but keeps the GPOS and GDEF tables that the website's opentype.js drops.
"""
import io
import sys
import urllib.request
from pathlib import Path

from fontTools.ttLib import TTFont
from fontTools.ttLib.tables import otTables

VERSION = "V143"
BASE_URL = "https://commitmono.com/src/fonts/fontlab/"
FAMILY = "CommitMono"
STYLES = {
    "Regular": (300, False),
    "Italic": (300, True),
    "Bold": (700, False),
    "Bold Italic": (700, True),
}
# cv01-cv11: character alternates, swapped in as the default glyphs.
ALTERNATES = []
# ss01-ss05: features that the website turns on by default through calt.
FEATURES = ["ss01", "ss02", "ss03", "ss04", "ss05"]


def feature_lookups(gsub, tags):
    return [i for rec in gsub.FeatureList.FeatureRecord if rec.FeatureTag in tags
            for i in rec.Feature.LookupListIndex]


def swap_alternates(font):
    gsub = font["GSUB"].table
    charstrings = font["CFF "].cff.topDictIndex[0].CharStrings
    # Reversed, so that the alternate g wins over the italic g, as on the website.
    for tag in reversed(ALTERNATES):
        for index in feature_lookups(gsub, [tag]):
            for sub in gsub.LookupList.Lookup[index].SubTable:
                for orig, alt in sub.mapping.items():
                    a, b = charstrings.charStrings[orig], charstrings.charStrings[alt]
                    charstrings.charStrings[orig], charstrings.charStrings[alt] = b, a


def add_calt(font):
    gsub = font["GSUB"].table
    record = otTables.FeatureRecord()
    record.FeatureTag = "calt"
    record.Feature = otTables.Feature()
    record.Feature.FeatureParams = None
    record.Feature.LookupListIndex = feature_lookups(gsub, FEATURES)
    record.Feature.LookupCount = len(record.Feature.LookupListIndex)
    features = gsub.FeatureList.FeatureRecord
    features.append(record)
    gsub.FeatureList.FeatureCount = len(features)
    for script in gsub.ScriptList.ScriptRecord:
        langs = [script.Script.DefaultLangSys] + [r.LangSys for r in script.Script.LangSysRecord]
        for lang in filter(None, langs):
            lang.FeatureIndex.append(len(features) - 1)
            lang.FeatureCount = len(lang.FeatureIndex)


def rename(font, style, weight, italic):
    bold = style.startswith("Bold")
    ps_name = f"{FAMILY}-{style.replace(' ', '')}"
    full_name = f"{FAMILY} {style}"
    version = font["name"].getDebugName(5)
    names = font["name"]
    names.removeNames(nameID=16)
    names.removeNames(nameID=17)
    for rec in names.names:
        value = {
            1: FAMILY,
            2: style,
            3: f"{version};;{ps_name};2023;FL820",
            4: full_name,
            6: ps_name,
        }.get(rec.nameID)
        if value is not None:
            rec.string = value

    cff = font["CFF "].cff
    cff.fontNames[0] = ps_name
    top = cff.topDictIndex[0]
    top.FamilyName = FAMILY
    top.FullName = full_name
    top.Weight = "Bold" if bold else "Regular"

    font["head"].macStyle = int(bold) | int(italic) << 1
    os2 = font["OS/2"]
    os2.usWeightClass = weight
    use_typo_metrics = os2.fsSelection & (1 << 7)
    os2.fsSelection = int(italic) | int(bold) << 5 | int(not italic and not bold) << 6 | use_typo_metrics
    return ps_name


def build(out_dir, style, weight, italic):
    slant = "Italic" if italic else "Regular"
    url = f"{BASE_URL}{FAMILY}{VERSION}-{weight}{slant}.otf"
    with urllib.request.urlopen(url) as resp:
        font = TTFont(io.BytesIO(resp.read()))
    swap_alternates(font)
    add_calt(font)
    rename(font, style, weight, italic)
    # The signature is not valid after the changes above.
    if "DSIG" in font:
        del font["DSIG"]
    # The website's file names, which patch_nonicons.py and windows-fonts.sh expect.
    out = out_dir / f"{FAMILY}-{weight}-{slant}.otf"
    font.save(out)
    print(out)


def main():
    out_dir = Path(sys.argv[1])
    out_dir.mkdir(parents=True, exist_ok=True)
    for style, (weight, italic) in STYLES.items():
        build(out_dir, style, weight, italic)


if __name__ == "__main__":
    main()
