#!/usr/bin/env python3
"""Create a new song folder under 音樂/ from templates."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path


def music_root() -> Path:
    return Path(__file__).resolve().parents[1]


def main() -> int:
    p = argparse.ArgumentParser(description="Create song folder under 音樂/")
    p.add_argument("--number", type=int, required=True)
    p.add_argument("--title", required=True)
    p.add_argument("--key", default="C")
    p.add_argument("--time", default="4/4")
    p.add_argument("--scripture", default="")
    p.add_argument("--tempo-mark", default="")
    p.add_argument("--tempo-bpm", type=int, default=80)
    p.add_argument("--version", default="01")
    p.add_argument("--accompaniment", default="")
    args = p.parse_args()

    root = music_root()
    ver = args.version if str(args.version).startswith("v") else f"v{args.version}"
    folder_name = f"{args.number}-{args.title}"
    song_dir = root / folder_name
    if song_dir.exists():
        print(f"Already exists: {song_dir}", file=sys.stderr)
        return 1

    acc = args.accompaniment
    if not acc:
        acc = "waltz-3/4" if args.time == "3/4" else "block"

    (song_dir / "來源").mkdir(parents=True)

    meta = f"""number: {args.number}
title: "{args.title}"
key: {args.key}
time: "{args.time}"
tempo_mark: "{args.tempo_mark}"
tempo_bpm: {args.tempo_bpm}
scripture: "{args.scripture}"
accompaniment: {acc}
recommended_version: "{ver}"
notes: "旋律依官方主旋律譜；左手為個人練習編配"
"""
    (song_dir / "song-meta.yaml").write_text(meta, encoding="utf-8", newline="\n")

    replacements = {
        "{{NUMBER}}": str(args.number),
        "{{TITLE}}": args.title,
        "{{KEY}}": args.key,
        "{{TIME}}": args.time,
        "{{VERSION}}": ver,
        "{{FOLDER}}": folder_name,
        "{{SCRIPTURE}}": args.scripture,
        "{{TEMPO_MARK}}": args.tempo_mark or " ",
        "{{TEMPO_BPM}}": str(args.tempo_bpm),
    }

    readme_tpl = (root / "_templates" / "README.md").read_text(encoding="utf-8")
    for k, v in replacements.items():
        readme_tpl = readme_tpl.replace(k, v)
    (song_dir / "README.md").write_text(readme_tpl, encoding="utf-8", newline="\n")

    ly_tpl_path = root / "_templates" / "主旋律加左手伴奏-v01.ly.tpl"
    ly_tpl = ly_tpl_path.read_text(encoding="utf-8")
    for k, v in replacements.items():
        ly_tpl = ly_tpl.replace(k, v)
    ly_name = f"主旋律加左手伴奏-{ver}.ly"
    (song_dir / ly_name).write_text(ly_tpl, encoding="utf-8", newline="\n")

    print(f"Created: {song_dir}")
    print(f"Next: put melody image in 來源/主旋律-{ver}.* then edit {ly_name}")
    compile_py = Path(__file__).resolve().parent / "compile_score.py"
    print(
        f'Compile: python "{compile_py}" '
        f'--song-dir "{song_dir}" --score "主旋律加左手伴奏-{ver}" --publish'
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
