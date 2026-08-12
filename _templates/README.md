# {{NUMBER}} {{TITLE}}

依主旋律譜與和弦編成的鋼琴譜（{{KEY}}、{{TIME}}）。

| 檔案 | 說明 |
|------|------|
| **`{{NUMBER}}-{{VERSION}}-pageN.png`** | **推薦**：右手主旋律 + 左手伴奏 |
| `{{NUMBER}}-{{VERSION}}.ly` | LilyPond 原始檔 |
| `來源/{{VERSION}}-pageN.png` | 自 `source/sjjsm_CH.pdf` 截出或覆寫圖 |

資料夾僅用編號：`音樂/{{FOLDER}}/`。

## 編譯（PNG，不要 PDF）

```bash
cd "音樂/{{FOLDER}}"
python ../scripts/compile_score.py --song-dir . --score "{{NUMBER}}-{{VERSION}}" --publish
```
