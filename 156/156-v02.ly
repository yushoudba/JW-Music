\version "2.24.3"

%% 156 我有信心 — 主旋律 + 左手伴奏（大譜表）v02
%% 旋律依 音樂/source/sjjsm_CH.pdf pp.234–235（來源/v02-pageN.png）
%% 左手：4/4 低音＋柱式（個人練習編配）

\include "../common/paper-a4-cjk.ily"

\paper {
  #(define fonts
    (set-global-fonts
     #:sans "WenQuanYi Micro Hei"
     #:roman "WenQuanYi Micro Hei"
     #:factor (/ staff-height pt 20)
   ))
}

\header {
  title = "我有信心"
  subtitle = "主旋律 + 左手伴奏"
  subsubtitle = "詩歌 156 · 詩篇 27:13 · C 大調（過門降 E）· 4/4 · v02"
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

%% ========== 主旋律 ==========
melody = {
  \globalC
  \clef treble

  \mark \markup \box "主歌"
  %% 縱使我陷入絕境，
  e'4 e'8 c'8 d'4.. e'16 |
  d'8 c'8 ~ c'4 r2 |
  %% 腳下的路很艱辛，
  e'8 e'8 e'8 e'8 g'4 e'16 d'8. |
  c'2 r4 c'8 d'8 |
  \break

  %% 我不是孤身一人面對人生曲折，
  e'8 e'8 e'8 c'8 d'4 r8 d'8 |
  e'8 g'4. e'8 d'8 c'8 d'8 |
  %% 上帝是我堅強後盾。
  e'8 e'8 e'8 c'8 d'4. c'8 |
  c'2 r8 g'8 a'8 g'8 |
  \break

  \mark \markup \box "副歌"
  %% 我有信心衝破黑暗的困境，我能看見曙光照亮天際。
  a'4. e'8 f'4. c'8 |
  g'4 e'4 r8 g'8 a'8 g'8 |
  a'4. e'8 f'4. c'8 |
  g'2 r4 e'8 g'8 |
  \break

  %% 耶和華必賜力量，不用擔心害怕。
  a'8 a'8 a'8 g'8 a'4 r8 g'8 |
  g'8 e'8 e'8 c'8 d'4 r4 |
  %% 耶和華總在我的身旁。我有信心！
  e'8 g'8 g'8 e'8 a'8 g'8 a'8 a'8 |
  c''4 d''2 r8 g'8 |
  \break

  %% 第1／第2結尾簡化為一次通過：心！→過門
  a'2. r4 |
  R1 |
  a'2. r8 g'8 |

  \mark \markup \box "過門"
  \key ees \major
  %% 我有信心跨越重重障礙，我能看見光明未來。
  aes'8. g'16 f'4 r2 |
  g'8 g'8 bes'8 bes'8 bes'8 c''8 c''8 g'8 |
  c''8. c''16 ees''8 ees''8 d''8 c''8 bes'8 aes'8 |
  g'2. r4 |
  \break

  %% 堅強的信心幫助我堅持到底，捍衛真理、臨危不懼。
  aes'8 aes'8 aes'8 bes'8 bes'8 bes'8 aes'8 bes'8 |
  c''8 c''8 bes'8 bes'8 aes'4 r8 g'8 |
  f'4. ees'8 d'8 c'8 c'8 d'8 |
  ees'2 r2 |
  \break

  \mark \markup \box "主歌（第三段）"
  \key c \major
  e'4 e'8 c'8 d'4.. e'16 |
  d'8 c'8 ~ c'4 r2 |
  e'8 e'8 e'8 e'8 g'4 e'16 d'8. |
  c'2 r4 c'8 d'8 |
  \break

  e'8 e'8 e'8 c'8 d'4 r8 d'8 |
  e'8 g'4. e'8 d'8 c'8 d'8 |
  e'8 e'8 e'8 c'8 d'4. c'8 |
  c'2 r8 g'8 a'8 g'8 |
  \break

  \mark \markup \box "副歌（結尾）"
  a'4. e'8 f'4. c'8 |
  g'4 e'4 r8 g'8 a'8 g'8 |
  a'4. e'8 f'4. c'8 |
  g'2 r4 e'8 g'8 |
  \break

  a'8 a'8 a'8 g'8 a'4 r8 g'8 |
  g'8 e'8 e'8 c'8 d'4 r4 |
  e'8 g'8 g'8 e'8 a'8 g'8 a'8 a'8 |
  c''4 d''2 r4 |
  \break

  %% 我有信心！我有信心！
  r4 g'8 a'8 g'8 a'4. |
  c''1 |
  r4 g'8 a'8 g'8 a'4. |
  c''1\fermata |
  \bar "|."
}

%% ========== 左手 ==========
leftHand = {
  \globalC
  \clef bass

  \mark \markup \box "主歌"
  %% C G/C | F/C | C G/C | Am
  c4 <e g c'> g,4 <d g b> |
  f,4 <a c' f'> <a c' f'> <a c' f'> |
  c4 <e g c'> g,4 <d g b> |
  a,4 <c e a> <c e a> <c e a> |
  \break

  %% F C/G | G | Am F | C/G G
  f,4 <a c'> c4 <e g c'> |
  g,4 <b d'> <b d'> <b d'> |
  a,4 <c e a> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  \break

  \mark \markup \box "副歌"
  %% Am F | C/G G | Am F | C G
  a,4 <c e a> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  a,4 <c e a> f,4 <a c'> |
  c4 <e g c'> g,4 <b d'> |
  \break

  a,4 <c e a> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  a,4 <c e a> f,4 <a c'> |
  g,4 <b d'> <b d'> <b d'> |
  \break

  %% endings
  a,4 <c e a> <c e a> <c e a> |
  f,4 <a c'> <a c'> <a c'> |
  c4 <f g c'> <e g c'> <e g c'> |

  \mark \markup \box "過門"
  \key ees \major
  aes,4 <c ees aes> bes,4 <d f bes> |
  g,4 <bes d'> c4 <ees g c'> |
  aes,4 <c ees aes> bes,4 <d f bes> |
  ees,4 <g bes ees'> <g bes ees'> <g bes ees'> |
  \break

  aes,4 <c ees aes> ees,4 <g bes> |
  f,4 <aes c'> <aes c'> <aes c'> |
  g,4 <c d f> g,4 <b d f> |
  g,4 <c d f> g,4 <b d f> |
  \break

  \mark \markup \box "主歌（第三段）"
  \key c \major
  c4 <e g c'> g,4 <d g b> |
  f,4 <a c' f'> <a c' f'> <a c' f'> |
  c4 <e g c'> g,4 <d g b> |
  a,4 <c e a> <c e a> <c e a> |
  \break

  f,4 <a c'> c4 <e g c'> |
  g,4 <b d'> <b d'> <b d'> |
  a,4 <c e a> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  \break

  \mark \markup \box "副歌（結尾）"
  a,4 <c e a> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  a,4 <c e a> f,4 <a c'> |
  c4 <e g c'> g,4 <b d'> |
  \break

  a,4 <c e a> f,4 <a c'> |
  c4 <e g> g,4 <b d'> |
  a,4 <c e a> f,4 <a c'> |
  g,4 <b d'> <b d'> <b d'> |
  \break

  a,4 <c e a> f,4 <a c' f'> |
  c4 <e g c'> <e g c'> <e g c'> |
  a,4 <c e a> f,4 <a c' f'> |
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
  a2:m f2 |
  g1 |
  %% endings
  a1:m |
  f1 |
  c2:sus4 c2 |
  %% 過門
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
  a2:m f2 |
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
  \line { "• 右手：主旋律（依 sjjsm_CH.pdf／來源 v02 頁）" }
  \line { "• 左手：4/4「低音＋柱式和弦」；斜線和弦第 1 拍用斜線後低音" }
  \line { "• 過門轉降 E，再回 C 進第三段與結尾副歌" }
  \line { "• v02：相對 v01 重對總譜旋律並重編左手" }
}
