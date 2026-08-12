#!/usr/bin/env python3
"""Compile a LilyPond score to PNG only; optionally publish to JW-Music."""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path


def find_lilypond() -> Path | None:
    which = shutil.which("lilypond")
    if which:
        return Path(which)

    candidates = [
        Path(r"C:\Tools\LilyPond\lilypond-2.26.0\bin\lilypond.exe"),
        Path(r"C:\Tools\LilyPond\lilypond-2.24.3\bin\lilypond.exe"),
    ]
    for c in candidates:
        if c.is_file():
            return c

    local = os.environ.get("LOCALAPPDATA")
    if local:
        base = Path(local) / "LilyPond"
        if base.is_dir():
            found = list(base.rglob("lilypond.exe"))
            if found:
                return found[0]

    pf = Path(r"C:\Program Files\LilyPond")
    if pf.is_dir():
        found = list(pf.rglob("lilypond.exe"))
        if found:
            return found[0]

    # Unix
    for name in ("lilypond",):
        w = shutil.which(name)
        if w:
            return Path(w)
    return None


def main() -> int:
    p = argparse.ArgumentParser(description="Compile LilyPond score to PNG (no PDF kept)")
    p.add_argument("--song-dir", required=True)
    p.add_argument("--score", required=True, help="Stem without .ly, e.g. 主旋律加左手伴奏-v01")
    p.add_argument("--resolution", type=int, default=140)
    p.add_argument("--publish", action="store_true", help="After PNG, run publish_music.py")
    args = p.parse_args()

    song_dir = Path(args.song_dir).resolve()
    ly_path = song_dir / f"{args.score}.ly"
    if not ly_path.is_file():
        print(f"Score not found: {ly_path}", file=sys.stderr)
        return 1

    lily = find_lilypond()
    if not lily:
        print(
            "lilypond not found.\n"
            "Install from https://lilypond.org/download.zh.html\n"
            r"Expected: C:\Tools\LilyPond\lilypond-2.26.0\bin\lilypond.exe",
            file=sys.stderr,
        )
        return 1

    print(f"Using: {lily}")
    print(f"Compiling: {ly_path}")

    log_path = song_dir / "compile-last.log"
    cmd = [str(lily), "--png", f"-dresolution={args.resolution}", str(ly_path)]
    proc = subprocess.run(
        cmd,
        cwd=str(song_dir),
        text=True,
        capture_output=True,
        encoding="utf-8",
        errors="replace",
    )
    log_text = (proc.stdout or "") + (proc.stderr or "")
    log_path.write_text(log_text, encoding="utf-8")
    if log_text.strip():
        print(log_text.rstrip())

    if proc.returncode != 0:
        print(f"lilypond failed (exit {proc.returncode}). See {log_path}", file=sys.stderr)
        return proc.returncode

    for pdf in song_dir.glob(f"{args.score}*.pdf"):
        pdf.unlink()
        print(f"Removed PDF (PNG-only): {pdf}")

    pngs = sorted(song_dir.glob(f"{args.score}*.png"))
    if not pngs:
        print(f"No PNG produced for {args.score}. See {log_path}", file=sys.stderr)
        return 1

    print("OK PNG:")
    for png in pngs:
        print(f"  {png.name}")

    if args.publish:
        publish = Path(__file__).resolve().parent / "publish_music.py"
        print("")
        print("Publishing to JW-Music main...")
        pub = subprocess.run(
            [sys.executable, str(publish), "--song", song_dir.name],
            check=False,
        )
        return pub.returncode

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
