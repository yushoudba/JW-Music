# 主旋律＋左手伴奏五線譜（Music-Sheet-Flow）

權威入口。Brain plugin `music` 指向本檔；執行細節與腳本都在 `音樂/`。

**本領域腳本一律 Python**（`音樂/scripts/*.py`）；**不再新增或使用 `.ps1`**。

## 目標

你提供主旋律圖 → 編碼 LilyPond（右手主旋律＋左手伴奏）→ 編譯 **PNG**（暫不要 PDF）→ 推公開庫並回傳鏈結。

## 目錄

```
音樂/
├── Music-Sheet-Flow.md     ← 本協定
├── README.md
├── common/
├── _templates/
├── scripts/
│   ├── new_song.py
│   ├── compile_score.py
│   └── publish_music.py
└── {編號}-{歌名}/
    ├── song-meta.yaml
    ├── README.md
    ├── 來源/主旋律-vNN.*
    ├── 主旋律加左手伴奏-vNN.ly
    └── 主旋律加左手伴奏-vNN-page*.png
```

## 流程

1. `python 音樂/scripts/new_song.py …` 建夾（或沿用既有夾）
2. 放入 `來源/主旋律-vNN` 圖檔
3. 依圖寫入 `.ly`：`melody`／`chordNames`／`leftHand`（**絕對音高**，勿 `\relative`）
4. `python 音樂/scripts/compile_score.py … --publish` 出 PNG，並推送到 `JW-Music` **main**
5. **回覆使用者公開 PNG raw 鏈結**（腳本會印出；代理須轉貼）
6. 對譜；重大改動則升版，再 `compile_score.py --publish`

電腦預設產出後必公開。手機／雲端：有 LilyPond 則同流程；僅有 PNG 時用 `publish_music.py`；都不能時只改 `.ly` 並註明回電腦編譯。

### 左手型態

| 拍號 | 預設 | 參考 |
|------|------|------|
| 3/4 | 圓舞曲：低音｜和弦｜和弦 | `common/lh-waltz-34.ily`、163 |
| 4/4 | 柱式或分解 | `common/lh-broken-44.ily` |

弱起、銜接小節需手工微調，不要假設可全自動產生左手。

### 校對清單

- RH／LH 小節數一致（含 `\partial`）
- 和弦與低音大致對得上
- 段標（主歌／副歌）位置合理
- 結尾 `\fermata`／`\bar "|."`

## 版次

- 檔名：`-v01`、`-v02`…（兩位數）
- 改旋律／和弦／伴奏型／大排版 → 升版
- README 標「目前推薦」版；舊版可留

## 產出

- **交付**：PNG＋推上 [JW-Music](https://github.com/yushoudba/JW-Music) `main` 後的 **raw 圖片鏈結**
- **不交付**：PDF（`compile_score.py` 刪旁生 PDF）
- **可編輯來源**：僅 `.ly`

代理完成一首／一版後的標準回覆：先給 raw PNG 網址列表，再附 tree 連結。

## 手機 Cursor vs 電腦 Cursor

同一協定、同一 Python 腳本。差別在環境有沒有 LilyPond／推送權限。

### 電腦版（完整）

```
依 音樂/Music-Sheet-Flow.md
新歌｜編號 {N} 歌名 {名} 調 {C} 拍 {3/4}
來源圖已放 來源/主旋律-v01
請編碼主旋律+左手 → 編譯 PNG → 公開庫（不要 PDF）
```

### 手機版（短）

```
編伴奏 {編號或歌名} v01
來源：{本則附圖｜路徑}
只要 PNG
公開庫
```

| 能力 | 手機／雲端 | 說明 |
|------|------------|------|
| 改 `.ly` | 通常可以 | 與電腦相同 |
| `compile_score.py` | 需本機有 lilypond | 雲端常缺 |
| `publish_music.py` | 可以 | 需 `git`／`gh` 或 `GH_TOKEN` |

```bash
python 音樂/scripts/compile_score.py --song-dir "音樂/{編號}-{歌名}" --score "主旋律加左手伴奏-v0N" --publish
python 音樂/scripts/publish_music.py --song 163
```

## 二腦

- 路由／搜尋：corpus `jw:music`（僅 `音樂/**/*.md`）
- 不索引 `.ly`／PNG／來源圖
- 明確已在編某歌時，直接讀本協定，不必先跑完整 Brain

## 腳本

```bash
python 音樂/scripts/new_song.py --number 200 --title "歌名" --key C --time "3/4"
python 音樂/scripts/compile_score.py --song-dir "音樂/200-歌名" --score "主旋律加左手伴奏-v01" --publish
python 音樂/scripts/publish_music.py --song 200
```

LilyPond 搜尋：PATH → `C:\Tools\LilyPond\lilypond-2.26.0\bin` → `%LOCALAPPDATA%\LilyPond\*\bin`。

## 對外公開

- 公開鏡像：[yushoudba/JW-Music](https://github.com/yushoudba/JW-Music)（Public，`main`）
- 真相來源：私有庫 `音樂/`；單向同步 `publish_music.py`／`compile_score.py --publish`
- 產出後預設 push main 並提供 raw PNG 鏈結

## 用途聲明

旋律依官方主旋律譜；左手為個人練習編配。
