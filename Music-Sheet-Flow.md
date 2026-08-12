# 主旋律＋左手伴奏五線譜（Music-Sheet-Flow）

權威入口。Brain plugin `music` 指向本檔；執行細節與腳本都在 `音樂/`。

## 目標

你提供主旋律圖 → 編碼 LilyPond（右手主旋律＋左手伴奏）→ 編譯 **PNG**（暫不要 PDF）。

## 目錄

```
音樂/
├── Music-Sheet-Flow.md     ← 本協定
├── README.md
├── common/                 ← paper、左手慣例註解
├── _templates/
├── scripts/new-song.ps1, compile.ps1
└── {編號}-{歌名}/
    ├── song-meta.yaml
    ├── README.md
    ├── 來源/主旋律-vNN.*
    ├── 主旋律加左手伴奏-vNN.ly
    └── 主旋律加左手伴奏-vNN-page*.png
```

## 流程

1. `new-song.ps1` 建夾（或沿用既有夾）
2. 放入 `來源/主旋律-vNN` 圖檔
3. 依圖寫入 `.ly`：`melody`／`chordNames`／`leftHand`（**絕對音高**，勿 `\relative`）
4. `compile.ps1 -Publish` 出 PNG，並推送到公開庫 `JW-Music` 的 **main**
5. **回覆使用者公開 PNG raw 鏈結**（腳本會印出；代理須轉貼）
6. 對譜；重大改動則升版 `v01` → `v02`，再 compile -Publish

電腦預設產出後必公開；手機／雲端若有 `git`＋推送權限，用 Python 腳本公開（見下）。若不能 push，只改 `.ly`，並請回電腦執行 compile -Publish。

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

- **交付**：PNG（多頁 `-page1.png`…）＋推上 [JW-Music](https://github.com/yushoudba/JW-Music) `main` 後的 **raw 圖片鏈結**
- **不交付**：PDF（第一階段；`compile.ps1` 刪旁生 PDF）
- **可編輯來源**：僅 `.ly`

代理完成一首／一版後的標準回覆：先給 raw PNG 網址列表，再附 tree 連結。

## 手機 Cursor vs 電腦 Cursor

同一協定、同一資料夾。差別只在指令長度與能否本機編譯。

### 電腦版（完整）

```
依 音樂/Music-Sheet-Flow.md
新歌｜編號 {N} 歌名 {名} 調 {C} 拍 {3/4}
來源圖已放 來源/主旋律-v01
請編碼主旋律+左手 → 編譯 PNG（不要 PDF）
```

```
編譯 音樂/{編號}-{歌名}/ 主旋律加左手伴奏-v01
```

```
升版到 v02：{改動摘要}
```

### 手機版（短）

```
編伴奏 {編號或歌名} v01
來源：{本則附圖｜路徑}
只要 PNG
公開庫
```

```
對譜檢查 {編號} v01
```

```
下一版：{一句改什麼}
```

| 能力 | 手機／雲端 Agent | 說明 |
|------|------------------|------|
| 改 `.ly`、寫檔 | 通常可以 | 與電腦相同 |
| `compile.ps1`（LilyPond） | 多半不行 | Windows 本機工具；雲端通常無 lilypond |
| 上傳公開庫 | **可以（建議用 Python）** | `python 音樂/scripts/publish_music.py --song {編號}` |
| `.ps1` | 多半不行 | 需 PowerShell；改用 `.py` |

公開條件：環境能跑 `git`／`gh`，且已登入可 push `yushoudba/JW-Music`（例如本機已 `gh auth`，或雲端設好 `GH_TOKEN`）。

若不能編譯也不能 push：只改 `.ly`，回覆電腦執行：

```powershell
音樂\scripts\compile.ps1 -SongDir "音樂\{編號}-{歌名}" -Score "主旋律加左手伴奏-v0N" -Publish
```

若 PNG 已在工作區、只需公開：

```bash
python 音樂/scripts/publish_music.py --song 163
```

## 二腦

- 路由／搜尋：corpus `jw:music`（僅 `音樂/**/*.md`）
- 不索引 `.ly`／PNG／來源圖
- 明確已在編某歌時，直接讀本協定，不必先跑完整 Brain

## 腳本

```powershell
# 電腦（Windows）：編譯 + 公開
音樂\scripts\compile.ps1 -SongDir "音樂\200-歌名" -Score "主旋律加左手伴奏-v01" -Publish
音樂\scripts\publish-music.ps1 -Song "200-歌名"
```

```bash
# 手機／雲端／跨平台：只同步公開庫並印鏈結（Python）
python 音樂/scripts/publish_music.py --song 200
```

LilyPond 搜尋順序：PATH → `C:\Tools\LilyPond\lilypond-2.26.0\bin` → `%LOCALAPPDATA%\LilyPond\*\bin`。

## 對外公開

- 公開鏡像庫：[yushoudba/JW-Music](https://github.com/yushoudba/JW-Music)（Public，`main`）
- 真相來源仍是本私有庫 `音樂/`；單向同步：`publish-music.ps1`／`publish_music.py`／`compile -Publish`
- **產出後預設立刻 push main，並提供 raw PNG 鏈結**；勿在公開庫當工作區改譜
- 手機優先：`python 音樂/scripts/publish_music.py --song …`（不依賴 ps1）

## 用途聲明

旋律依官方主旋律譜；左手為個人練習編配。
