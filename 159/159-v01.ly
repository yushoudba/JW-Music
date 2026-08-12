\version "2.24.3"

%% 159 榮耀歸給耶和華 — 主旋律 + 左手伴奏（大譜表）v01
%% 旋律依 音樂/source/sjjsm_CH.pdf pp.240–241（來源/v01-pageN.png）
%% 音高：OpusStd 符頭中心對五線（concert F；Capo 5 上排忽略）
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
  title = "榮耀歸給耶和華"
  subtitle = "主旋律 + 左手伴奏"
  subsubtitle = "詩歌 159 · 詩篇 96:8 · F 大調 · 4/4 · v01"
  composer = "旋律依官方主旋律譜；左手依和弦編配"
  tagline = ##f
}

global = {
  \key f \major
  \time 4/4
  \tempo \markup { "讚美地" } 4 = 80
  \set Score.barNumberVisibility = #all-bar-numbers-visible
  \override Score.BarNumber.break-visibility = ##(#f #t #t)
}

%% ========== 主旋律 ==========
melody = {
  \global
  \clef treble

  \mark \markup \box "主歌"
  %% 至高的上帝耶 | 和華，
  a'4 g'8 e'8 a'4 g'8 e'8 |
  e'4 f'8 f'8 r2 |
  \break

  %% 你多麼尊貴、偉 | 大。
  bes'4 a'8 f'8 bes'4 a'8 f'8 |
  g'2 r2 |
  \break

  %% 抬頭望天我能 | 看見，你
  c''4 bes'8 g'8 c''4 bes'8 g'8 |
  g'4 a'8 a'8 r4 r8 g'8 |
  \break

  %% 充滿力量和榮 | 美。
  f'4 e'8 d'8 f'4 e'8 d'8 |
  e'2 r2 |
  \break

  %% 你坐在聖潔的 | 寶座，
  a'4 g'8 e'8 a'4 g'8 e'8 |
  e'4 f'8 f'8 r2 |
  \break

  %% 卻顧念地上的 | 我。
  bes'4 a'8 f'8 bes'4 a'8 f'8 |
  g'2 r2 |
  \break

  %% 時刻受到天父 | 恩待，該
  c''4 bes'8 g'8 c''4 bes'8 g'8 |
  g'4 a'8 a'8 r4 r8 bes'8 |
  \break

  %% 怎樣報答你的愛？ | （副歌弱起）我要歌
  c''4 c''8 d''8 bes'4 a'8 g'8 |
  r2 r8 a'8 a'8 c''8 |
  \break

  \mark \markup \box "副歌"
  %% 頌偉大的耶和 | 華，將你
  a'4 a'8 e''8 e''4 d''8 c''8 |
  bes'4 c''4 r2 |
  \break

  %% 名向人宣 | 揚。一生讚
  d''4 c''4 bes'4 a'4 |
  r2 r8 a'8 a'8 c''8 |
  \break

  %% 美永恆至 | 尊君王，
  a'4 a'8 e''8 e''4 d''8 c''8 |
  e''4 d''4 c''2 |
  \break

  %% 只有你配受顯 | 揚。
  r8 bes'8 c''8 d''8 c''8 bes'8 a'4 |
  a'2 r2 |
  \break

  %% 榮耀歸給耶和 | 華！
  bes'4 c''4 d''4 c''4 |
  bes'4 g'4 f'2\fermata |
  \bar "|."
}

%% ========== 左手（低音＋柱式）==========
leftHand = {
  \global
  \clef bass

  \mark \markup \box "主歌"
  %% F | F/A  Bb  Dm/A
  f,4 <a c' f'> c4 <a c' f'> |
  bes,4 <d' f' bes'> d4 <f a d'> |
  \break

  %% Gm | C  C/Bb
  g,4 <bes d' g'> g,4 <bes d' g'> |
  c4 <e g c'> bes,4 <e g c'> |
  \break

  %% A | Dm  Dm/C
  a,4 <e a c'> a,4 <e a c'> |
  d4 <f a d'> c4 <f a d'> |
  \break

  %% Bb  Gm7 | Csus4  C
  bes,4 <d' f' bes'> g,4 <bes d' f'> |
  c4 <f g c'> c4 <e g c'> |
  \break

  %% F | F/A  Bb  Dm/A
  f,4 <a c' f'> c4 <a c' f'> |
  bes,4 <d' f' bes'> d4 <f a d'> |
  \break

  %% Gm | C  C/Bb
  g,4 <bes d' g'> g,4 <bes d' g'> |
  c4 <e g c'> bes,4 <e g c'> |
  \break

  %% A | Dm  Bdim
  a,4 <e a c'> a,4 <e a c'> |
  d4 <f a d'> b,4 <d f b> |
  \break

  %% F/C  Fsus4/C  Bb/C | Bb  Csus4
  c4 <f a c'> c4 <f bes c'> |
  bes,4 <d' f' bes'> c4 <f g c'> |
  \break

  \mark \markup \box "副歌"
  %% F  F/A | Bb  F
  f,4 <a c' f'> c4 <a c' f'> |
  bes,4 <d' f' bes'> f,4 <a c' f'> |
  \break

  %% Gm  Dm/F  C/E  Csus4 | F/C  Csus4
  g,4 <bes d'> d4 <f a> |
  c4 <e g c'> c4 <f g c'> |
  \break

  %% F  F/A | Bb  F
  f,4 <a c' f'> c4 <a c' f'> |
  bes,4 <d' f' bes'> f,4 <a c' f'> |
  \break

  %% Gm  Dm/F  C/E  Csus4 | Dm7  C
  g,4 <bes d'> d4 <f a> |
  d4 <f a c'> c4 <e g c'> |
  \break

  %% Bb  Csus4  C | F  Eb/F  F
  bes,4 <d' f' bes'> c4 <f g c'> |
  f,4 <a c' f'> <g bes ees'> <a c' f'>\fermata |
  \bar "|."
}

chordNames = \chordmode {
  \set chordChanges = ##t
  %% 主歌
  f2 f2/a |
  bes2 d2:m/a |
  g1:m |
  c2 c2/bes |
  a1 |
  d2:m d2:m/c |
  bes2 g2:m7 |
  c2:sus4 c2 |
  f2 f2/a |
  bes2 d2:m/a |
  g1:m |
  c2 c2/bes |
  a1 |
  d2:m b2:dim |
  f2/c f2:sus4/c |
  bes2 c2:sus4 |
  %% 副歌
  f2 f2/a |
  bes2 f2 |
  g4:m d4:m/f c4/e c4:sus4 |
  f2/c c2:sus4 |
  f2 f2/a |
  bes2 f2 |
  g4:m d4:m/f c4/e c4:sus4 |
  d2:m7 c2 |
  bes2 c4:sus4 c4 |
  f2 ees4/f f4 |
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
  \line { "• 右手：主旋律（依 sjjsm_CH.pdf pp.240–241／來源 v01）" }
  \line { "• 左手：4/4「低音＋柱式和弦」；斜線和弦低音用斜線後音" }
  \line { "• Capo 5 上排和弦忽略；譜面與和弦為 concert F" }
  \line { "• v01：首版雙手譜；副歌節奏若與總譜有出入以來源 PNG 為準再升版" }
}
