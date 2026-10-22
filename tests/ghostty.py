"""Run from the repository root: python3 tests/ghostty.py."""

from pathlib import Path
import re


COLOR_KEYS = {
    "background",
    "foreground",
    "cursor-color",
    "cursor-text",
    "selection-background",
    "selection-foreground",
}


def luminance(color):
    channels = [int(color[i : i + 2], 16) / 255 for i in (1, 3, 5)]
    linear = [c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4 for c in channels]
    return sum(c * weight for c, weight in zip(linear, (0.2126, 0.7152, 0.0722)))


def contrast(first, second):
    low, high = sorted((luminance(first), luminance(second)))
    return (high + 0.05) / (low + 0.05)


def check_theme(path):
    colors = {}
    palette = {}
    for number, line in enumerate(path.read_text().splitlines(), 1):
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        key, value = (part.strip() for part in line.split("=", 1))
        if key == "palette":
            index, value = (part.strip() for part in value.split("=", 1))
            index = int(index)
            assert index not in palette, f"{path}:{number}: duplicate ANSI slot {index}"
            target, key = palette, index
        elif key in COLOR_KEYS:
            assert key not in colors, f"{path}:{number}: duplicate {key}"
            target = colors
        else:
            continue
        assert re.fullmatch(r"#[0-9A-Fa-f]{6}", value), f"{path}:{number}: invalid color {value!r}"
        target[key] = value

    assert colors.keys() == COLOR_KEYS, f"{path}: missing colors {COLOR_KEYS - colors.keys()}"
    assert palette.keys() == set(range(16)), f"{path}: expected exactly ANSI slots 0-15"

    pairs = [(f"ANSI {index}", color, colors["background"]) for index, color in palette.items()]
    pairs.extend(
        [
            ("default text", colors["foreground"], colors["background"]),
            ("cursor text", colors["cursor-text"], colors["cursor-color"]),
            ("selected text", colors["selection-foreground"], colors["selection-background"]),
            ("ANSI 0/7", palette[0], palette[7]),
            ("ANSI 0/15", palette[0], palette[15]),
        ]
    )
    for label, foreground, background in pairs:
        ratio = contrast(foreground, background)
        assert ratio >= 3, f"{path}: {label} contrast {ratio:.2f}:1 is below 3:1"
    print(f"PASS: {path}: complete palette, valid colors, and contrast >= 3:1")


if __name__ == "__main__":
    for style in ("light", "dark"):
        check_theme(Path(f"extras/ghostty/alabaster-{style}"))
