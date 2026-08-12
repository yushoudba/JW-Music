\version "2.24.3"

%% 163 我的眼睛多麼有福！ — 左手伴奏（3/4 分解和弦型）

\header {
  title = "我的眼睛多麼有福！"
  subtitle = "左手伴奏（分解和弦型）"
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
}

global = {
  \key c \major
  \time 3/4
  \tempo \markup { "溫柔地" } 4 = 84
  \clef bass
  \set Score.barNumberVisibility = #all-bar-numbers-visible
  \override Score.BarNumber.break-visibility = ##(#f #t #t)
}

%% 分解：低音 — 五度／和弦音 — 三度／高音（絕對音高）
leftHand = {
  \global

  \mark \markup \box "主歌"
  %% 1–8
  a,4 c f |
  b,4 d g |
  c4 e g |
  e,4 g b |
  f,4 a c' |
  g,4 b d' |
  c4 e g |
  e,4 g b |
  \break

  %% 9–16
  f,4 a c' |
  f,4 aes c' |
  e,4 g b |
  a,4 c' e' |
  d4 f a |
  c4 f a |
  bes,,4 d f |
  g,4 b d' |
  \break

  \mark \markup \box "主歌（後段）"
  %% 17–24
  a,4 c f |
  b,4 d g |
  c4 e g |
  e,4 g b |
  f,4 a c' |
  g,4 b d' |
  c4 e g |
  e,4 g b |
  \break

  %% 25–32
  f,4 a c' |
  f,4 aes c' |
  e,4 g b |
  a,4 c' e' |
  d4 f a |
  c4 f a |
  g,4 a c' |
  c4 e g |
  \break

  \mark \markup \box "副歌"
  %% 33–40
  f,4 a c' |
  g,4 b d' |
  c4 e g |
  f,4 a c' |
  g,4 b d' |
  a,4 c' e' |
  e,4 g c' |
  f,4 a c' |
  \break

  %% 41–49
  g,4 b d' |
  a,4 c' e' |
  g,4 b d' |
  f,4 a c' |
  e,4 g c' |
  d4 f a |
  g,4 b d' |
  g,4 b d' |
  c2. \fermata |
  \bar "|."
}

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
  \line { "• 型態：每小節三個四分音符分解（低音 → 中音 → 高音），較圓舞曲型和弦版更流動" }
  \line { "• 可與圓舞曲型交替：主歌用分解，副歌改回「低音＋和弦」" }
  \line { "• 連奏（legato）為主；結尾 C 可稍放慢並延長" }
}
