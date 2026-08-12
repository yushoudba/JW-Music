# {{NUMBER}} {{TITLE}}

依主旋律譜與和弦編成的鋼琴譜（{{KEY}}、{{TIME}}）。

| 檔案 | 說明 |
|------|------|
| **`主旋律加左手伴奏-{{VERSION}}.png`（或 `-pageN.png`）** | **推薦**：右手主旋律 + 左手伴奏 |
| `主旋律加左手伴奏-{{VERSION}}.ly` | LilyPond 原始檔 |
| `來源/主旋律-{{VERSION}}.*` | 你提供的主旋律圖 |

## 編譯（PNG，不要 PDF）

```powershell
cd "音樂/{{FOLDER}}"
..\scripts\compile.ps1 -Score "主旋律加左手伴奏-{{VERSION}}"
```
