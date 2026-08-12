\version "2.26.0"

%% 163 我的眼睛多麼有福！ — 左手伴奏（3/4 圓舞曲型）
%% 依樂譜和弦：低音（1）｜和弦（2）｜和弦（3）
%% 斜線和弦第 1 拍用指定低音

\header {
  title = "我的眼睛多麼有福！"
  subtitle = "左手伴奏（圓舞曲型）"
  subsubtitle = "詩歌 163 · 馬太福音 13:16 · C 大調 · 3/4"
  composer = "依原曲和弦編配左手"
  tagline = ##f
}

\paper {
  #(set-paper-size "a4")
  #(define fonts
    (set-global-fonts
     #:sans "WenQuanYi Micro Hei"
     #:roman "WenQuanYi Micro Hei"
     #:factor (/ staff-height pt 20)
   ))
  indent = 12
  top-margin = 12
  bottom-margin = 12
  left-margin = 14
  right-margin = 14
  system-system-spacing.basic-distance = 14
  markup-system-spacing.basic-distance = 10
}

\layout {
  \context {
    \Score
    \override MetronomeMark.padding = #3
  }
  \context {
    \Staff
    \override InstrumentName.self-alignment-X = #RIGHT
  }
}

global = {
  \key c \major
  \time 3/4
  \tempo \markup { "溫柔地" } 4 = 84
  \clef bass
  \set Score.barNumberVisibility = #all-bar-numbers-visible
  \override Score.BarNumber.break-visibility = ##(#f #t #t)
}

%% 圓舞曲型：低音 + 和弦 + 和弦（絕對音高，避免 relative 八度漂移）
leftHand = {
  \global

  %% ========== 主歌 A（1–16）==========
  \mark \markup \box "主歌"
  %% 1 F/A
  a,4 <c f> <c f> |
  %% 2 G/B
  b,4 <d g> <d g> |
  %% 3 C
  c4 <e g> <e g> |
  %% 4 Em
  e,4 <g b> <g b> |
  %% 5 F
  f,4 <a c'> <a c'> |
  %% 6 G
  g,4 <b d'> <b d'> |
  %% 7 C
  c4 <e g> <e g> |
  %% 8 Em
  e,4 <g b> <g b> |
  \break

  %% 9 F
  f,4 <a c'> <a c'> |
  %% 10 Fm
  f,4 <aes c'> <aes c'> |
  %% 11 Em7
  e,4 <g b d'> <g b> |
  %% 12 Am
  a,4 <c' e'> <c' e'> |
  %% 13 Dm7
  d4 <f a c'> <f a> |
  %% 14 Dm7/C
  c4 <f a> <f a> |
  %% 15 Bb
  bes,,4 <d f> <d f> |
  %% 16 G
  g,4 <b d'> <b d'> |
  \break

  %% ========== 主歌 B（17–32）==========
  \mark \markup \box "主歌（後段）"
  %% 17 F/A
  a,4 <c f> <c f> |
  %% 18 G/B
  b,4 <d g> <d g> |
  %% 19 C
  c4 <e g> <e g> |
  %% 20 Em
  e,4 <g b> <g b> |
  %% 21 F
  f,4 <a c'> <a c'> |
  %% 22 G
  g,4 <b d'> <b d'> |
  %% 23 C
  c4 <e g> <e g> |
  %% 24 Em
  e,4 <g b> <g b> |
  \break

  %% 25 F
  f,4 <a c'> <a c'> |
  %% 26 Fm
  f,4 <aes c'> <aes c'> |
  %% 27 Em7
  e,4 <g b d'> <g b> |
  %% 28 Am
  a,4 <c' e'> <c' e'> |
  %% 29 Dm7
  d4 <f a c'> <f a> |
  %% 30 Dm7/C（低音下行進副歌）
  c4 <f a> <f a> |
  %% 31 F/G
  g,4 <a c' f'> <a c'> |
  %% 32 C
  c4 <e g> <e g> |
  \break

  %% ========== 副歌（33–49）==========
  \mark \markup \box "副歌"
  %% 33 F
  f,4 <a c'> <a c'> |
  %% 34 G7
  g,4 <b d' f'> <b d'> |
  %% 35 C
  c4 <e g> <e g> |
  %% 36 F
  f,4 <a c'> <a c'> |
  %% 37 G7
  g,4 <b d' f'> <b d'> |
  %% 38 Am
  a,4 <c' e'> <c' e'> |
  %% 39 C/E
  e,4 <g c'> <g c'> |
  %% 40 F
  f,4 <a c'> <a c'> |
  \break

  %% 41 G
  g,4 <b d'> <b d'> |
  %% 42 Am
  a,4 <c' e'> <c' e'> |
  %% 43 G
  g,4 <b d'> <b d'> |
  %% 44 F
  f,4 <a c'> <a c'> |
  %% 45 C/E
  e,4 <g c'> <g c'> |
  %% 46 Dm7
  d4 <f a c'> <f a> |
  %% 47–48 G
  g,4 <b d'> <b d'> |
  g,4 <b d'> <b d'> |
  %% 49 C（收束）
  c2. \fermata |
  \bar "|."
}

%% 和弦記號（對照練習用）
chordNames = \chordmode {
  \set chordChanges = ##t
  f4/a s s |
  g/b s s |
  c s s |
  e:m s s |
  f s s |
  g s s |
  c s s |
  e:m s s |
  f s s |
  f:m s s |
  e:m7 s s |
  a:m s s |
  d:m7 s s |
  d:m7/c s s |
  bes s s |
  g s s |
  %% 主歌後段
  f/a s s |
  g/b s s |
  c s s |
  e:m s s |
  f s s |
  g s s |
  c s s |
  e:m s s |
  f s s |
  f:m s s |
  e:m7 s s |
  a:m s s |
  d:m7 s s |
  d:m7/c s s |
  f/g s s |
  c s s |
  %% 副歌
  f s s |
  g:7 s s |
  c s s |
  f s s |
  g:7 s s |
  a:m s s |
  c/e s s |
  f s s |
  g s s |
  a:m s s |
  g s s |
  f s s |
  c/e s s |
  d:m7 s s |
  g s s |
  g s s |
  c2. |
}

\score {
  <<
    \new ChordNames { \chordNames }
    \new Staff \with {
      instrumentName = "左手"
      shortInstrumentName = "L.H."
    } {
      \leftHand
    }
  >>
  \layout { }
}

\markup \vspace #1
\markup \column {
  \line \bold { "彈奏說明" }
  \vspace #0.3
  \line { "• 型態：每小節「低音（第 1 拍）— 和弦（第 2 拍）— 和弦（第 3 拍）」" }
  \line { "• 斜線和弦（F/A、G/B、Dm7/C、C/E、F/G）：第 1 拍務必彈斜線後的低音" }
  \line { "• 力度：第 1 拍稍強，第 2、3 拍較輕，避免蓋過右手旋律" }
  \line { "• Fm、B♭ 為色彩變化處，請聽清楚再接回 C 大調進行" }
  \line { "• 結尾低音線：A–G–F–E–D–G–C（副歌後半）" }
}
