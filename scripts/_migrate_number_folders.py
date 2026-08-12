from pathlib import Path
import re
import shutil

root = Path(r"c:\Git\JW-Work\音樂")


def migrate(number: str) -> None:
    legacy = [p for p in root.iterdir() if p.is_dir() and p.name.startswith(number + "-")]
    dest = root / number
    if not legacy:
        print(f"{number}: no legacy folder")
        return
    src = legacy[0]
    print(f"Migrating {src.name} -> {number}/")
    if dest.exists():
        for item in src.iterdir():
            target = dest / item.name
            if item.is_dir():
                shutil.copytree(item, target, dirs_exist_ok=True)
            else:
                shutil.copy2(item, target)
        shutil.rmtree(src)
    else:
        src.rename(dest)

    src_dir = dest / "來源"
    src_dir.mkdir(exist_ok=True)
    for p in list(dest.glob("主旋律-v*-p*.png")) + list(dest.glob("主旋律-v*-page*.png")):
        m = re.match(r"主旋律-(v\d+)-p(\d+)\.png$", p.name) or re.match(
            r"主旋律-(v\d+)-page(\d+)\.png$", p.name
        )
        if m:
            new = src_dir / f"{m.group(1)}-page{m.group(2)}.png"
            shutil.move(str(p), str(new))
            print(f"  source -> 來源/{new.name}")

    for ly in list(dest.glob("主旋律加左手伴奏-v*.ly")):
        m = re.match(r"主旋律加左手伴奏-(v\d+)\.ly$", ly.name)
        if m:
            new = dest / f"{number}-{m.group(1)}.ly"
            if new.exists():
                ly.unlink()
            else:
                ly.rename(new)
            print(f"  ly -> {new.name}")

    for png in list(dest.glob("主旋律加左手伴奏-v*-page*.png")):
        m = re.match(r"主旋律加左手伴奏-(v\d+)-(page\d+)\.png$", png.name)
        if m:
            new = dest / f"{number}-{m.group(1)}-{m.group(2)}.png"
            if new.exists():
                png.unlink()
            else:
                png.rename(new)
            print(f"  png -> {new.name}")

    # drop unversioned legacy score files if numbered v01 exists
    for pat in (
        "主旋律加左手伴奏.ly",
        "主旋律加左手伴奏-page*.png",
        "左手伴奏-*.ly",
        "左手伴奏-*.png",
        "左手伴奏-*-v01.ly",
    ):
        for p in dest.glob(pat):
            # keep LH optional files? User asked output images numbered; LH extras can stay or go.
            # Remove only clearly obsolete unnumbered grand-staff duplicates.
            if p.name.startswith("主旋律加左手伴奏.") or re.match(
                r"主旋律加左手伴奏-page\d+\.png$", p.name
            ):
                p.unlink(missing_ok=True)
                print(f"  removed legacy {p.name}")

    readme = dest / "README.md"
    title = ""
    meta = dest / "song-meta.yaml"
    if meta.is_file():
        for line in meta.read_text(encoding="utf-8").splitlines():
            if line.strip().startswith("title:"):
                title = line.split(":", 1)[1].strip().strip('"').strip("'")
    body = f"""# {number} {title}

依主旋律譜與和弦編成的鋼琴譜。資料夾僅用編號。

| 檔案 | 說明 |
|------|------|
| **`{number}-v01-pageN.png`** | **推薦**：主旋律 + 左手伴奏 |
| `{number}-v01.ly` | LilyPond 原始檔 |
| `來源/v01-pageN.png` | 主旋律來源圖 |

## 編譯／公開

```bash
cd "音樂/{number}"
python ../scripts/compile_score.py --song-dir . --score "{number}-v01" --publish
```

目前推薦：`v01`
"""
    readme.write_text(body, encoding="utf-8", newline="\n")
    print(f"Done {number}: {[p.name for p in sorted(dest.iterdir(), key=lambda x: x.name)]}")


migrate("156")
migrate("163")
