# 主旋律＋左手伴奏五線譜（Music-Sheet-Flow）

權威入口。Brain plugin `music` 指向本檔；執行細節與腳本都在 `音樂/`。

**本領域腳本一律 Python**（`音樂/scripts/*.py`）；**不再新增或使用 `.ps1`**。

## 目標

依**官方主旋律總譜**編碼 LilyPond（右手主旋律＋左手伴奏）→ 編譯 **PNG**（暫不要 PDF 產出）→ 推公開庫並回傳鏈結。

## 觸發（使用者怎麼說）

使用者**只需給詩歌編號**即可開工（歌名可省略，由總譜讀出）：

| 說法 | 動作 |
|------|------|
| `156`／`編伴奏 156`／`156 編伴奏` | 從總譜找 156 → 建夾／編碼 → 編譯 → 公開 |
| `重編伴奏 156` | 只改左手；RH 維持與總譜一致 |
| `公開庫 156` | 僅推送／印 raw 鏈結 |
| 本則另附圖／另指定路徑 | **該圖優先於總譜**（覆寫本次旋律真相） |

## 旋律來源（硬性）

| 優先 | 來源 | 路徑 |
|------|------|------|
| **預設** | 官方主旋律**總譜**（全書） | **`音樂/source/sjjsm_CH.pdf`**（已入 Git） |
| 覆寫 | 使用者本則附圖或指定檔 | 存入 `音樂/{編號}/來源/vNN-pageN.png` 後編碼 |
| 禁止 | 憑記憶、歌詞印象、他站 rank 譜 | — |

### 總譜作業步驟

1. 確認 `音樂/source/sjjsm_CH.pdf` 存在（git 內）。
2. 依**編號**在 PDF 內定位該曲（目錄／書籤／頁面標號／曲首編號）。
3. 讀該曲主旋律、調號、拍號、弱起、段標、和弦（若譜上有）。
4. **建議**：將相關頁匯出／截圖存成 `音樂/{編號}/來源/vNN-pageN.png`，方便對譜與升版稽核；寫 `melody` 前須能指出總譜檔名＋頁，或曲目夾內來源圖檔名。
5. 找不到該編號：**停止**，說明總譜中未定位到，索取頁碼或附圖；**不得臆造旋律**。

## 命名（硬性）

| 項目 | 格式 | 例 |
|------|------|-----|
| 曲目資料夾 | **僅詩歌編號** | `音樂/156/` |
| 歌名 | 只寫在 `song-meta.yaml`／README／譜頭，**不進夾名、不進圖檔名** | `title: "我有信心"` |
| 譜原始檔 | `{編號}-vNN.ly` | `156-v01.ly` |
| 產出 PNG | `{編號}-vNN-pageN.png` | `156-v01-page1.png` |
| 曲目來源圖 | `來源/vNN-pageN.png`（自總譜截出或使用者覆寫） | `來源/v01-page1.png` |
| 總譜 | 固定 | `source/sjjsm_CH.pdf` |

禁止再使用 `156-我有信心/`、`主旋律加左手伴奏-v01.png` 等長檔名作為**新產出**。

## 目錄

```
音樂/
├── Music-Sheet-Flow.md
├── README.md
├── source/
│   ├── README.md
│   └── sjjsm_CH.pdf          ← 全書主旋律（預設真相）
├── common/
├── _templates/
├── scripts/
│   ├── new_song.py
│   ├── compile_score.py
│   └── publish_music.py
└── {編號}/
    ├── song-meta.yaml
    ├── README.md
    ├── 來源/vNN-pageN.png    ← 建議：自總譜截出之對譜頁
    ├── {編號}-vNN.ly
    └── {編號}-vNN-pageN.png
```

## 流程

1. 使用者給編號 N（可無歌名）。
2. 自 `source/sjjsm_CH.pdf` 定位 N，讀歌名／調／拍／旋律（或使用本則覆寫圖）。
3. 若尚無夾：`python 音樂/scripts/new_song.py --number N --title "（總譜歌名）" …` → `音樂/{N}/`
4. 將對譜頁放入 `來源/`（建議）；**依總譜／來源圖**寫入 `{N}-vNN.ly` 的 `melody`／`chordNames`／`leftHand`（**絕對音高**，勿 `\relative`）
5. `python 音樂/scripts/compile_score.py --song-dir 音樂/{N} --score "{N}-vNN" --publish`
6. **回覆 raw PNG 鏈結**（腳本會印出；代理須轉貼）
7. 對譜；重大改動則升版，再 compile `--publish`

電腦預設產出後必公開。手機／雲端：有 LilyPond 則同流程；僅有 PNG 時用 `publish_music.py`；都不能時只改 `.ly` 並註明回電腦編譯。

### 主旋律禁令（硬性）

- **禁止**改寫、簡化、美化、移調順便改掉、或重作右手主旋律。
- 「編伴奏／重編伴奏」＝**只動** `leftHand`、伴奏型態、必要時 `chordNames` 與排版；**`melody` 須與總譜（或覆寫來源圖）逐音、逐節奏、逐小節一致**。
- 升版若來源未改：`melody` 應與上一版相同（除非使用者要求修正對譜錯誤）。
- RH 與來源不符：**先修正 melody**，再談伴奏。

### 左手型態

| 拍號 | 預設 | 參考 |
|------|------|------|
| 3/4 | 圓舞曲：低音｜和弦｜和弦 | `common/lh-waltz-34.ily`、163 |
| 4/4 | 柱式或分解 | `common/lh-broken-44.ily` |

弱起、銜接小節需手工微調，不要假設可全自動產生左手。

### 校對清單

- **RH 與總譜／來源圖一致**（音高、時值、小節數、弱起）——不通過則不得宣稱完成
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
- **不交付**：伴奏成品 PDF（總譜 `sjjsm_CH.pdf` 是**輸入**，不是交付物）
- **可編輯來源**：`{編號}-vNN.ly`

代理完成後標準回覆：先 raw PNG 網址，再附 `tree/main/{編號}`。

## 手機 Cursor vs 電腦 Cursor

同一協定、同一 Python 腳本。

### 電腦／手機（預設：只給編號）

```
編伴奏 156
```

或僅：

```
156
```

（工作區在音樂／JW-Work、或語境已是編伴奏時，代理依本協定從 `source/sjjsm_CH.pdf` 開工。）

### 覆寫來源時

```
編伴奏 156
來源：{本則附圖}
```

### 僅公開

```
公開庫 156
```

```bash
python 音樂/scripts/compile_score.py --song-dir "音樂/156" --score "156-v01" --publish
python 音樂/scripts/publish_music.py --song 156
```

## 二腦

- corpus `jw:music`（僅 `音樂/**/*.md`；不索引 PDF／.ly）
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
- **總譜 PDF 不推公開庫**（僅私有庫 `音樂/source/`；公開庫只放各曲 PNG／.ly 等產出）
- **手機推公開庫**：設 Cursor Secret `JW_MUSIC_TOKEN`（步驟見 [手機推公開庫-GH_TOKEN.md](手機推公開庫-GH_TOKEN.md)），再說「公開庫 {編號}」

## 用途聲明

旋律依 **`音樂/source/sjjsm_CH.pdf`**（或使用者明示覆寫的主旋律圖）逐字編碼；左手為個人練習編配。代理不得以自創旋律取代總譜／上傳圖。
