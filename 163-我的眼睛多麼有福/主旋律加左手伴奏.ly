\version "2.24.3"

%% 163 我的眼睛多麼有福！— 主旋律 + 左手伴奏（大譜表）
%% 旋律依主旋律譜；左手為 3/4 圓舞曲型（低音｜和弦｜和弦）

\header {
  title = "我的眼睛多麼有福！"
  subtitle = "主旋律 + 左手伴奏"
  subsubtitle = "詩歌 163 · 馬太福音 13:16 · C 大調 · 3/4"
  composer = "旋律依官方主旋律譜；左手依和弦編配"
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
  indent = 14
  top-margin = 12
  bottom-margin = 12
  left-margin = 14
  right-margin = 14
  system-system-spacing.basic-distance = 16
}

global = {
  \key c \major
  \time 3/4
  \tempo \markup { "溫柔地" } 4 = 84
  \set Score.barNumberVisibility = #all-bar-numbers-visible
  \override Score.BarNumber.break-visibility = ##(#f #t #t)
}

%% ========== 主旋律（高音譜表）==========
melody = {
  \global
  \clef treble
  \partial 2
  %% 弱起：F/A — G/B
  c'4 d'4 |

  \mark \markup \box "主歌"
  %% C Em F G C Em
  e'2 g'4 |
  g'2. |
  r4 f'4 e'4 |
  d'4 r8 c'8 d'4 |
  e'2 g'4 |
  g'2. |
  \break

  %% F Fm Em7 Am Dm7 Dm7/C
  r4 f'4 e'4 |
  d'4 r8 c'8 d'4 |
  e'2 d'4 |
  c'2 c'4 |
  f'2 e'4 |
  d'2 c'4 |
  %% Bb G
  d'2. |
  r2. |
  \break

  \mark \markup \box "主歌（後段）"
  %% 弱起式銜接：r c d → C Em F G C Em
  r4 c'4 d'4 |
  e'2 g'4 |
  g'2. |
  r4 f'4 e'4 |
  d'4 r8 c'8 d'4 |
  e'2 g'4 |
  g'2. |
  \break

  r4 f'4 e'4 |
  d'4 r8 c'8 d'4 |
  e'2 d'4 |
  c'2 c'4 |
  %% F Fm Em7 Am Dm7 Dm7/C F/G C
  f'2 e'4 |
  d'2 c'4 |
  c'2. |
  r4 e'4 g'4 |
  \break

  g'2. |
  r4 f'4 e'4 |
  e'2. |

  \mark \markup \box "副歌"
  %% F G7 C F G7 Am C/E F
  r4 e'4 g'4 |
  g'2. |
  r4 f'4 e'4 |
  e'2. |
  r4 e'4 g'4 |
  a'2. |
  \break

  r4 a'4 b'4 |
  %% G Am G F C/E Dm7 G G C
  c''2 b'4 |
  a'2 r4 |
  f'2 f'4 |
  a'2 g'4 |
  g'2. |
  r4 g'8 a'8 c''4 |
  c''2. |
  c''2.\fermata |
  \bar "|."
}

%% ========== 左手（低音譜表，圓舞曲型）==========
leftHand = {
  \global
  \clef bass
  \partial 2
  %% 弱起兩拍
  a,4 b,4 |

  \mark \markup \box "主歌"
  c4 <e g> <e g> |
  e,4 <g b> <g b> |
  f,4 <a c'> <a c'> |
  g,4 <b d'> <b d'> |
  c4 <e g> <e g> |
  e,4 <g b> <g b> |
  \break

  f,4 <a c'> <a c'> |
  f,4 <aes c'> <aes c'> |
  e,4 <g b d'> <g b> |
  a,4 <c' e'> <c' e'> |
  d4 <f a c'> <f a> |
  c4 <f a> <f a> |
  bes,,4 <d f> <d f> |
  g,4 <b d'> <b d'> |
  \break

  \mark \markup \box "主歌（後段）"
  %% 銜接小節（對旋律 r c d）
  a,4 <c f> <d g> |
  c4 <e g> <e g> |
  e,4 <g b> <g b> |
  f,4 <a c'> <a c'> |
  g,4 <b d'> <b d'> |
  c4 <e g> <e g> |
  e,4 <g b> <g b> |
  \break

  f,4 <a c'> <a c'> |
  f,4 <aes c'> <aes c'> |
  e,4 <g b d'> <g b> |
  a,4 <c' e'> <c' e'> |
  \break

  %% Dm7 F/G C → 進副歌
  d4 <f a c'> <f a> |
  g,4 <a c' f'> <a c'> |
  c4 <e g> <e g> |

  \mark \markup \box "副歌"
  f,4 <a c'> <a c'> |
  g,4 <b d' f'> <b d'> |
  c4 <e g> <e g> |
  f,4 <a c'> <a c'> |
  g,4 <b d' f'> <b d'> |
  a,4 <c' e'> <c' e'> |
  \break

  e,4 <g c'> <g c'> |
  f,4 <a c'> <a c'> |
  g,4 <b d'> <b d'> |
  a,4 <c' e'> <c' e'> |
  g,4 <b d'> <b d'> |
  f,4 <a c'> <a c'> |
  e,4 <g c'> <g c'> |
  d4 <f a c'> <f a> |
  g,4 <b d'> <b d'> |
  c2. \fermata |
  \bar "|."
}

chordNames = \chordmode {
  \set chordChanges = ##t
  \partial 2
  f4/a g/b |
  c2. |
  e2.:m |
  f2. |
  g2. |
  c2. |
  e2.:m |
  f2. |
  f2.:m |
  e2.:m7 |
  a2.:m |
  d2.:m7 |
  d2.:m7/c |
  bes2. |
  g2. |
  f4/a g/b s |
  c2. |
  e2.:m |
  f2. |
  g2. |
  c2. |
  e2.:m |
  f2. |
  f2.:m |
  e2.:m7 |
  a2.:m |
  d2.:m7 |
  f2./g |
  c2. |
  f2. |
  g2.:7 |
  c2. |
  f2. |
  g2.:7 |
  a2.:m |
  c2./e |
  f2. |
  g2. |
  a2.:m |
  g2. |
  f2. |
  c2./e |
  d2.:m7 |
  g2. |
  c2. |
}

\score {
  <<
    \new ChordNames { \chordNames }
    \new PianoStaff \with {
      instrumentName = \markup \center-column { "鋼琴" }
    } <<
      \new Staff = "right" \with {
        instrumentName = "主旋律"
        shortInstrumentName = "R.H."
      } { \melody }
      \new Staff = "left" \with {
        instrumentName = "伴奏"
        shortInstrumentName = "L.H."
      } { \leftHand }
    >>
  >>
  \layout {
    \context {
      \Score
      \override MetronomeMark.padding = #3
    }
  }
}

\markup \vspace #1
\markup \column {
  \line \bold { "彈奏說明" }
  \vspace #0.3
  \line { "• 右手：主旋律（可加八度或輕聲唱詞）" }
  \line { "• 左手：圓舞曲型「低音（1）— 和弦（2）— 和弦（3）」；弱起兩拍只彈低音 A、B" }
  \line { "• 力度：左手第 1 拍稍強，第 2、3 拍輕，勿蓋過旋律" }
  \line { "• 若只要左手，見同資料夾「左手伴奏-圓舞曲型」" }
}
