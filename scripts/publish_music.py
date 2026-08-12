#!/usr/bin/env python3
"""Mirror JW-Work/音樂 to public yushoudba/JW-Music (one-way). Cross-platform for desktop + mobile/cloud Cursor."""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
from datetime import datetime
from pathlib import Path
from urllib.parse import quote

PUBLIC_REPO = "yushoudba/JW-Music"
SKIP_DIRS = {"_templates", "common", "scripts", ".cursor"}
PAGE_PNG_RE = re.compile(r"-v\d+-page\d+\.png$", re.I)


def run(cmd: list[str], cwd: Path | None = None, check: bool = True) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        cmd,
        cwd=str(cwd) if cwd else None,
        check=check,
        text=True,
        capture_output=True,
        encoding="utf-8",
        errors="replace",
    )


def default_mirror_dir() -> Path:
    if os.name == "nt":
        return Path(r"C:\Git\JW-Music")
    return Path.home() / ".cache" / "JW-Music"


def music_root() -> Path:
    return Path(__file__).resolve().parents[1]


def jw_root() -> Path:
    return music_root().parent


def source_stamp() -> str:
    try:
        cp = run(["git", "rev-parse", "--short", "HEAD"], cwd=jw_root(), check=False)
        if cp.returncode == 0 and cp.stdout.strip():
            return cp.stdout.strip()
    except OSError:
        pass
    return "unknown"


def song_dirs(root: Path) -> list[Path]:
    out: list[Path] = []
    for p in sorted(root.iterdir(), key=lambda x: (0, int(x.name)) if x.name.isdigit() else (1, x.name)):
        if not p.is_dir() or p.name in SKIP_DIRS:
            continue
        # Prefer number-only folders; keep legacy "156-歌名" during transition.
        if re.match(r"^\d+$", p.name) or re.match(r"^\d+-", p.name) or (p / "song-meta.yaml").is_file():
            out.append(p)
    return out


def song_title(song: Path) -> str:
    meta = song / "song-meta.yaml"
    if meta.is_file():
        for line in meta.read_text(encoding="utf-8").splitlines():
            if line.strip().startswith("title:"):
                return line.split(":", 1)[1].strip().strip('"').strip("'")
    return song.name


def build_gallery(root: Path) -> str:
    lines: list[str] = []
    for song in song_dirs(root):
        name = song.name
        title = song_title(song)
        label = f"{name} {title}" if title and title != name else name
        lines.append(f"### [{label}]({name}/)")
        lines.append("")
        pngs = sorted(song.glob("*-v*-page*.png"))
        pngs = [p for p in pngs if PAGE_PNG_RE.search(p.name)]
        if not pngs:
            pngs = sorted(song.glob("*-page*.png"))
        if not pngs:
            lines.append("_No recommended PNG yet._")
            lines.append("")
        else:
            for p in pngs:
                lines.append(f"![{p.stem}]({name}/{p.name})")
                lines.append("")
    return "\n".join(lines) if lines else "_No songs yet._\n"


def ensure_mirror(mirror: Path, repo: str) -> None:
    git_dir = mirror / ".git"
    if not git_dir.is_dir():
        if mirror.exists():
            shutil.rmtree(mirror)
        mirror.parent.mkdir(parents=True, exist_ok=True)
        print(f"Cloning {repo} -> {mirror}")
        cp = run(["gh", "repo", "clone", repo, str(mirror)], check=False)
        if cp.returncode != 0:
            # fallback: git clone
            run(["git", "clone", f"https://github.com/{repo}.git", str(mirror)])
        cp = run(["git", "rev-parse", "--verify", "HEAD"], cwd=mirror, check=False)
        if cp.returncode != 0:
            run(["git", "checkout", "-b", "main"], cwd=mirror, check=False)
    else:
        run(["git", "fetch", "origin"], cwd=mirror, check=False)
        run(["git", "checkout", "main"], cwd=mirror, check=False)
        run(["git", "pull", "--ff-only", "origin", "main"], cwd=mirror, check=False)


def sync_content(src: Path, mirror: Path) -> None:
    for child in mirror.iterdir():
        if child.name == ".git":
            continue
        if child.is_dir():
            shutil.rmtree(child)
        else:
            child.unlink()

    for name in ("common", "_templates", "scripts"):
        s = src / name
        if s.is_dir():
            shutil.copytree(s, mirror / name)

    for song in song_dirs(src):
        shutil.copytree(song, mirror / song.name)

    shutil.copy2(src / "Music-Sheet-Flow.md", mirror / "Music-Sheet-Flow.md")
    gi = src / ".gitignore"
    if gi.is_file():
        shutil.copy2(gi, mirror / ".gitignore")

    cursor = mirror / ".cursor"
    if cursor.exists():
        shutil.rmtree(cursor)

    for p in mirror.rglob("compile-last.log"):
        p.unlink(missing_ok=True)
    for p in mirror.rglob("*.pdf"):
        p.unlink(missing_ok=True)

    tpl = (src / "_templates" / "PUBLIC-README.md").read_text(encoding="utf-8")
    readme = tpl.replace("{{GALLERY}}", build_gallery(src))
    (mirror / "README.md").write_text(readme, encoding="utf-8", newline="\n")


def ensure_git_identity(mirror: Path) -> None:
    email = run(["git", "config", "user.email"], cwd=mirror, check=False)
    if email.returncode != 0 or not email.stdout.strip():
        run(["git", "config", "user.email", "yushoudba@users.noreply.github.com"], cwd=mirror)
        run(["git", "config", "user.name", "yushoudba"], cwd=mirror)


def write_public_links(mirror: Path, repo: str, song_filter: str) -> None:
    base = f"https://raw.githubusercontent.com/{repo}/main"
    print("")
    print("=== Public PNG links ===")
    dirs = [
        p
        for p in sorted(
            mirror.iterdir(),
            key=lambda x: (0, int(x.name)) if x.name.isdigit() else (1, x.name),
        )
        if p.is_dir() and (re.match(r"^\d+$", p.name) or re.match(r"^\d+-", p.name))
    ]
    if song_filter:
        dirs = [p for p in dirs if p.name == song_filter or song_filter in p.name]
    for d in dirs:
        pngs = sorted(p for p in d.glob("*.png") if PAGE_PNG_RE.search(p.name))
        for p in pngs:
            url = f"{base}/{quote(d.name)}/{quote(p.name)}"
            print(url)
    print(f"Repo: https://github.com/{repo}")
    if song_filter and dirs:
        print(f"Tree: https://github.com/{repo}/tree/main/{quote(dirs[0].name)}")


def github_token() -> str | None:
    """Prefer JW_MUSIC_TOKEN (Cursor secret); also accept GH_TOKEN / GITHUB_TOKEN."""
    for key in ("JW_MUSIC_TOKEN", "GH_TOKEN", "GITHUB_TOKEN"):
        val = os.environ.get(key, "").strip()
        if not val:
            continue
        # Cursor may inject App token as GH_TOKEN (ghs_...); skip when possible.
        if key == "GH_TOKEN" and val.startswith("ghs_"):
            continue
        return val
    ghs = os.environ.get("GH_TOKEN", "").strip()
    return ghs or None


def push_main(mirror: Path, repo: str) -> int:
    """Push HEAD to main. Prefer env token (mobile/cloud); else default git creds."""
    token = github_token()
    if token:
        src = "JW_MUSIC_TOKEN" if os.environ.get("JW_MUSIC_TOKEN") else "GH_TOKEN/GITHUB_TOKEN"
        print(f"Auth: {src} (one-shot URL push; token not saved in .git/config)")
        push_url = f"https://x-access-token:{token}@github.com/{repo}.git"
        cp = run(["git", "push", "-u", push_url, "HEAD:main"], cwd=mirror, check=False)
    else:
        print("Auth: default git credentials (no JW_MUSIC_TOKEN / GH_TOKEN in env)")
        cp = run(["git", "push", "-u", "origin", "HEAD:main"], cwd=mirror, check=False)
    if cp.returncode != 0:
        err = (cp.stderr or cp.stdout or "").strip()
        if err:
            tok = github_token()
            if tok and tok in err:
                err = err.replace(tok, "***")
            print(err, file=sys.stderr)
        print(
            "Push failed. Desktop: gh auth login. "
            "Mobile/cloud: set Cursor secret JW_MUSIC_TOKEN "
            "(PAT with write access to yushoudba/JW-Music). "
            "See 音樂/手機推公開庫-GH_TOKEN.md",
            file=sys.stderr,
        )
    return cp.returncode


def main() -> int:
    parser = argparse.ArgumentParser(description="Publish 音樂/ mirror to JW-Music")
    parser.add_argument("--mirror-dir", type=Path, default=default_mirror_dir())
    parser.add_argument("--repo", default=PUBLIC_REPO)
    parser.add_argument("--skip-push", action="store_true")
    parser.add_argument("--message", default="")
    parser.add_argument("--song", default="", help="Filter link output (e.g. 163)")
    args = parser.parse_args()

    src = music_root()
    mirror = args.mirror_dir
    print(f"Source: {src}")
    print(f"Mirror: {mirror}")

    ensure_mirror(mirror, args.repo)
    sync_content(src, mirror)

    stamp = source_stamp()
    date = datetime.now().strftime("%Y-%m-%d %H:%M")
    message = args.message or f"sync from JW-Work/music ({stamp}) at {date}"

    ensure_git_identity(mirror)
    run(["git", "add", "-A"], cwd=mirror)
    status = run(["git", "status", "--porcelain"], cwd=mirror)
    if not status.stdout.strip():
        print("No changes to publish.")
    else:
        run(["git", "commit", "-m", message], cwd=mirror)
        if args.skip_push:
            print("SkipPush: commit created locally only.")
        else:
            code = push_main(mirror, args.repo)
            if code != 0:
                return code
            print(f"Pushed to https://github.com/{args.repo}")

    write_public_links(mirror, args.repo, args.song)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
