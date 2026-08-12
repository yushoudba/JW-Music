# 主旋律＋左手伴奏五線譜（Music-Sheet-Flow）

權威入口。Brain plugin `music` 指向本檔；執行細節與腳本都在 `音樂/`。

**本領域腳本一律 Python**（`音樂/scripts/*.py`）；**不再新增或使用 `.ps1`**。

## 目標

你提供主旋律圖 → 編碼 LilyPond（右手主旋律＋左手伴奏）→ 編譯 **PNG**（暫不要 PDF）→ 推公開庫並回傳鏈結。

## 命名（硬性）

| 項目 | 格式 | 例 |
|------|------|-----|
| 曲目資料夾 | **僅詩歌編號** | `音樂/156/` |
| 歌名 | 只寫在 `song-meta.yaml`／README／譜頭，**不進夾名、不進圖檔名** | `title: "我有信心"` |
| 譜原始檔 | `{編號}-vNN.ly` | `156-v01.ly` |
| 產出 PNG | `{編號}-vNN-pageN.png` | `156-v01-page1.png` |
| 來源圖 | `來源/vNN-pageN.png`（或多頁 `vNN-p1.png`） | `來源/v01-page1.png` |

禁止再使用 `156-我有信心/`、`主旋律加左手伴奏-v01.png` 等長檔名作為**新產出**。

## 目錄

```
音樂/
├── Music-Sheet-Flow.md
├── README.md
├── common/
├── _templates/
├── scripts/
│   ├── new_song.py
│   ├── compile_score.py
│   └── publish_music.py
└── {編號}/
    ├── song-meta.yaml
    ├── README.md
    ├── 來源/vNN-pageN.png
    ├── {編號}-vNN.ly
    └── {編號}-vNN-pageN.png
```

## 流程

1. `python 音樂/scripts/new_song.py --number N --title "歌名" …` 建夾 `音樂/{N}/`
2. **放入／確認來源圖**（見「來源圖」）；使用者本則附圖視同來源，須先存成 `來源/vNN-…` 再編碼
3. **依來源圖**寫入 `{N}-vNN.ly` 的 `melody`／`chordNames`／`leftHand`（**絕對音高**，勿 `\relative`）
4. `python 音樂/scripts/compile_score.py --song-dir 音樂/{N} --score "{N}-vNN" --publish`
5. **回覆 raw PNG 鏈結**（腳本會印出；代理須轉貼）
6. 對譜；重大改動則升版，再 compile `--publish`

電腦預設產出後必公開。手機／雲端：有 LilyPond 則同流程；僅有 PNG 時用 `publish_music.py`；都不能時只改 `.ly` 並註明回電腦編譯。

### 來源圖（硬性）

| 規則 | 說明 |
|------|------|
| 唯一旋律真相 | **僅**使用者上傳／指定的主旋律圖 |
| 存放路徑 | `音樂/{編號}/來源/vNN-pageN.png`（或 `vNN-p1.png`）；對話附圖須先寫入再編碼 |
| 讀圖後編碼 | 寫 `melody` 前必須能指出所用檔名；**禁止**憑記憶、歌詞或印象另寫旋律 |
| 找不到圖 | **停止編碼**，索取圖或路徑；不得臆造旋律 |

### 主旋律禁令（硬性）

- **禁止**改寫、簡化、美化、移調順便改掉、或重作右手主旋律。
- 「編伴奏／重編伴奏」＝**只動** `leftHand`、伴奏型態、必要時 `chordNames` 與排版；**`melody` 須與來源圖逐音、逐節奏、逐小節一致**。
- 升版若來源圖未改：`melody` 應與上一版相同（除非使用者要求修正對譜錯誤）。
- RH 與來源圖不符：**先修正 melody**，再談伴奏。

### 左手型態

| 拍號 | 預設 | 參考 |
|------|------|------|
| 3/4 | 圓舞曲：低音｜和弦｜和弦 | `common/lh-waltz-34.ily`、163 |
| 4/4 | 柱式或分解 | `common/lh-broken-44.ily` |

弱起、銜接小節需手工微調，不要假設可全自動產生左手。

### 校對清單

- **RH 與來源圖一致**（音高、時值、小節數、弱起）——不通過則不得宣稱完成
- RH／LH 小節數一致（含 `\partial`）
- 和弦與低音大致對得上
- 段標（主歌／副歌）位置合理
- 結尾 `\fermata`／`\bar "|."`
- 產出檔名符合 `{編號}-vNN-pageN.png`

## 版次

- 檔名：`-v01`、`-v02`…（兩位數），接在編號後：`156-v02.ly`
- 改旋律（僅對譜修正）／和弦／伴奏型／大排版 → 升版
- README 標「目前推薦」版；舊版可留

## 產出

- **交付**：`{編號}-vNN-pageN.png`＋ [JW-Music](https://github.com/yushoudba/JW-Music) raw 鏈結
- **不交付**：PDF
- **可編輯來源**：`{編號}-vNN.ly`

代理完成後標準回覆：先 raw PNG 網址，再附 `tree/main/{編號}`。

## 手機 Cursor vs 電腦 Cursor

同一協定、同一 Python 腳本。

### 電腦版

```
依 音樂/Music-Sheet-Flow.md
新歌｜編號 {N} 歌名 {名} …
來源圖已放 來源/v01-page1.png
請依圖編碼主旋律+左手 → 編譯 → 公開庫
```

### 手機版

```
編伴奏 {編號} v01
來源：{本則附圖}
只要 PNG
公開庫
```

```bash
python 音樂/scripts/compile_score.py --song-dir "音樂/156" --score "156-v01" --publish
python 音樂/scripts/publish_music.py --song 156
```

## 二腦

- corpus `jw:music`（僅 `音樂/**/*.md`）
- 明確編某編號時直接讀本協定

## 腳本

```bash
python 音樂/scripts/new_song.py --number 200 --title "歌名" --key C --time "3/4"
python 音樂/scripts/compile_score.py --song-dir "音樂/200" --score "200-v01" --publish
python 音樂/scripts/publish_music.py --song 200
```

## 對外公開

- 公開鏡像：[yushoudba/JW-Music](https://github.com/yushoudba/JW-Music)
- 曲目路徑：`https://github.com/yushoudba/JW-Music/tree/main/{編號}`
- 真相來源：私有庫 `音樂/`；單向同步

## 用途聲明

旋律依**使用者提供的官方主旋律譜圖**逐字編碼；左手為個人練習編配。代理不得以自創旋律取代上傳圖。
