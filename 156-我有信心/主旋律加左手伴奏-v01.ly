\version "2.24.3"

%% 156 我有信心 — 主旋律 + 左手伴奏（大譜表）v01
%% 旋律依官方主旋律譜（C 大調寫法）；過門為降 E
%% 左手：4/4 分解／柱式（個人練習編配）

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
  left-margin = 12
  right-margin = 12
  system-system-spacing.basic-distance = 15
}

\header {
  title = "我有信心"
  subtitle = "主旋律 + 左手伴奏"
  subsubtitle = "詩歌 156 · 詩篇 27:13 · C 大調（過門降 E）· 4/4"
  composer = "旋律依官方主旋律譜；左手依和弦編配"
  tagline = ##f
}

globalC = {
  \key c \major
  \time 4/4
  \tempo \markup { "堅定地" } 4 = 76
  \set Score.barNumberVisibility = #all-bar-numbers-visible
  \override Score.BarNumber.break-visibility = ##(#f #t #t)
}

globalEb = {
  \key ees \major
  \time 4/4
}

%% ========== 主旋律 ==========
melody = {
  \globalC
  \clef treble

  \mark \markup \box "主歌"
  %% 縱使我陷入絕境，腳下的路很艱辛，
  c'4 c'8 g8 b4. d'8 |
  c'8 a8 g4 ~ g4 r4 |
  c'4 b8 c'8 g8 c'8 d'4 |
  c'8. b16 a4 ~ a4 r8 c'8 |
  \break

  %% 我不是孤身一人面對人生曲折，
  d'8 e'8 f'8 g'8 r8 d'8 e'4 |
  b8 a8 r8 d'8 e'8 c'8 b8 a8 |
  %% 上帝是我堅強後盾。
  r8 c'8 c'8 c'8 b8. a16 g4 ~ |
  g2 r8 g8 a8 g8 |
  \break

  \mark \markup \box "副歌"
  %% 我有信心衝破黑暗的困境，我能看見曙光照亮天際。
  a'4. e'8 f'4. c'8 |
  g'4. c'8 e'4 r8 g'8 |
  a'4. e'8 f'4. c'8 |
  g'2. r8 g'8 |
  \break

  %% 耶和華必賜力量，不用擔心害怕。
  a'4 a'4 g'4 e'4 |
  f'4 a'4 a'8 g'8 a'4 |
  %% 耶和華總在我的身旁。我有信心！
  g'2 r4 e'8 g'8 |
  a'4 a'4 g'4 e'4 |
  f'4. g'8 a'4 a'8 g'8 |
  a'4 g'2. |
  \break

  %% 第二結尾 → 過門
  r4 g'8 a'8 g'8 a'4. |
  c''1 |

  \mark \markup \box "過門"
  \key ees \major
  %% 我有信心跨越重重障礙，我能看見光明未來。
  bes'4 bes'8 g'8 ees''4. c''8 |
  bes'8 g'8 f'4 ~ f'4 r8 g'8 |
  aes'4 aes'8 f'8 d''4. bes'8 |
  aes'8 f'8 ees'4 ~ ees'4 r8 ees'8 |
  \break

  %% 堅強的信心幫助我堅持到底，捍衛真理、臨危不懼。
  g'8 aes'8 bes'8 c''8 r8 g'8 aes'4 |
  ees'8 d'8 r8 g'8 aes'8 f'8 ees'8 d'8 |
  r8 c'8 c'8 c'8 d'8. ees'16 f'4 ~ |
  f'4 g'2.\fermata |
  \break

  \mark \markup \box "主歌（第三段）"
  \key c \major
  %% 幸福生活已不遠，希望近在眼前。
  c'4 c'8 g8 b4. d'8 |
  c'8 a8 g4 ~ g4 r4 |
  c'4 b8 c'8 g8 c'8 d'4 |
  c'8. b16 a4 ~ a4 r8 c'8 |
  \break

  %% 我下定決心，一刻都不放棄，等待耶和華伸張正義。
  d'8 e'8 f'8 g'8 r8 d'8 e'4 |
  b8 a8 r8 d'8 e'8 c'8 b8 a8 |
  r8 c'8 c'8 c'8 b8. a16 g4 ~ |
  g2 r8 g8 a8 g8 |
  \break

  \mark \markup \box "副歌（結尾）"
  a'4. e'8 f'4. c'8 |
  g'4. c'8 e'4 r8 g'8 |
  a'4. e'8 f'4. c'8 |
  g'2. r8 g'8 |
  \break

  a'4 a'4 g'4 e'4 |
  f'4 a'4 a'8 g'8 a'4 |
  g'2 r4 e'8 g'8 |
  a'4 a'4 g'4 e'4 |
  f'4. g'8 a'4 a'8 g'8 |
  a'4 g'2. |
  \break

  %% 我有信心！我有信心！
  r4 g'8 a'8 g'8 a'4. |
  c''2. r4 |
  r4 g'8 a'8 g'8 a'4. |
  c''1\fermata |
  \bar "|."
}

%% ========== 左手（4/4：低音 + 和弦／分解）==========
leftHand = {
  \globalC
  \clef bass

  \mark \markup \box "主歌"
  %% C  G/C  | F/C  | C  G/C  | Am
  c4 <e g c'> g,4 <d g b> |
  f,4 <a c' f'> <a c' f'> <a c' f'> |
  c4 <e g c'> g,4 <d g b> |
  a,4 <c' e'> <c' e'> <c' e'> |
  \break

  %% F  C/G  | G  | Am  F  | C/G  G
  f,4 <a c'> c4 <e g c'> |
  g,4 <b d'> <b d'> <b d'> |
  a,4 <c' e'> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  \break

  \mark \markup \box "副歌"
  %% Am F | C/G G | Am F | C G
  a,4 <c' e'> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  a,4 <c' e'> f,4 <a c'> |
  c4 <e g c'> g,4 <b d'> |
  \break

  %% Am F | C G | Am F | C G | Am F | G
  a,4 <c' e'> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  a,4 <c' e'> e,4 <g c'> |
  a,4 <c' e'> e,4 <g c'> |
  f,4 <a c'> f,4 <a c'> |
  g,4 <b d'> <b d'> <b d'> |
  \break

  %% 第二結尾 Csus4 C
  c4 <f g c'> <e g c'> <e g c'> |
  c4 <e g c'> <e g c'> <e g c'> |

  \mark \markup \box "過門"
  \key ees \major
  %% Ab Bb | Gm Cm | Ab Bb | Eb
  aes,4 <c' ees'> bes,4 <d' f'> |
  g,4 <bes d'> c4 <ees' g'> |
  aes,4 <c' ees'> bes,4 <d' f'> |
  ees,4 <g bes ees'> <g bes ees'> <g bes ees'> |
  \break

  %% Ab Eb/G | Fm  | Gsus G | Gsus G
  aes,4 <c' ees'> ees,4 <g bes> |
  f,4 <aes c'> <aes c'> <aes c'> |
  g,4 <c' d' f'> g,4 <b d' f'> |
  g,4 <c' d' f'> g,4 <b d' f'>\fermata |
  \break

  \mark \markup \box "主歌（第三段）"
  \key c \major
  c4 <e g c'> g,4 <d g b> |
  f,4 <a c' f'> <a c' f'> <a c' f'> |
  c4 <e g c'> g,4 <d g b> |
  a,4 <c' e'> <c' e'> <c' e'> |
  \break

  f,4 <a c'> c4 <e g c'> |
  g,4 <b d'> <b d'> <b d'> |
  a,4 <c' e'> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  \break

  \mark \markup \box "副歌（結尾）"
  a,4 <c' e'> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  a,4 <c' e'> f,4 <a c'> |
  c4 <e g c'> g,4 <b d'> |
  \break

  a,4 <c' e'> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  a,4 <c' e'> e,4 <g c'> |
  a,4 <c' e'> e,4 <g c'> |
  f,4 <a c'> f,4 <a c'> |
  g,4 <b d'> <b d'> <b d'> |
  \break

  %% 我有信心！×2
  a,4 <c' e'> f,4 <a c' f'> |
  c4 <e g c'> <e g c'> <e g c'> |
  a,4 <c' e'> f,4 <a c' f'> |
  c2. <e g c'>4\fermata |
  \bar "|."
}

chordNames = \chordmode {
  \set chordChanges = ##t
  %% 主歌
  c2 g2/c |
  f1/c |
  c2 g2/c |
  a1:m |
  f2 c2/g |
  g1 |
  a2:m f2 |
  c2/g g2 |
  %% 副歌
  a2:m f2 |
  c2/g g2 |
  a2:m f2 |
  c2 g2 |
  a2:m f2 |
  c2 g2 |
  a2:m c2/e |
  a2:m c2/e |
  f1 |
  g1 |
  c2:sus4 c2 |
  c1 |
  %% 過門（降 E）
  aes2 bes2 |
  g2:m c2:m |
  aes2 bes2 |
  ees1 |
  aes2 ees2/g |
  f1:m |
  g2:sus4 g2 |
  g2:sus4 g2 |
  %% 主歌 3
  c2 g2/c |
  f1/c |
  c2 g2/c |
  a1:m |
  f2 c2/g |
  g1 |
  a2:m f2 |
  c2/g g2 |
  %% 副歌結尾
  a2:m f2 |
  c2/g g2 |
  a2:m f2 |
  c2 g2 |
  a2:m f2 |
  c2 g2 |
  a2:m c2/e |
  a2:m c2/e |
  f1 |
  g1 |
  a2:m f2 |
  c1 |
  a2:m f2 |
  c1 |
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

\markup \vspace #0.8
\markup \column {
  \line \bold { "彈奏說明" }
  \vspace #0.2
  \line { "• 右手：主旋律（依官方主旋律譜之 C 大調寫法）" }
  \line { "• 左手：4/4「低音＋和弦」；斜線和弦（G/C、F/C 等）第 1 拍用斜線後低音" }
  \line { "• 過門轉降 E 大調，再回 C 大調進第三段與結尾副歌" }
  \line { "• 吉他 Capo 3：上方 A 調和弦＝本譜 C 調（鋼琴直接彈本譜即可）" }
}
