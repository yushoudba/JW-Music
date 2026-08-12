\version "2.26.0"

%% {{NUMBER}} {{TITLE}} — 主旋律 + 左手伴奏（大譜表）v01
%% 旋律依主旋律譜；左手型態見 song-meta.yaml

\include "../common/paper-a4-cjk.ily"

\header {
  title = "{{TITLE}}"
  subtitle = "主旋律 + 左手伴奏"
  subsubtitle = "詩歌 {{NUMBER}} · {{SCRIPTURE}} · {{KEY}} · {{TIME}}"
  composer = "旋律依官方主旋律譜；左手依和弦編配"
  tagline = ##f
}

global = {
  \key c \major
  \time 4/4
  \tempo \markup { "{{TEMPO_MARK}}" } 4 = {{TEMPO_BPM}}
  \set Score.barNumberVisibility = #all-bar-numbers-visible
  \override Score.BarNumber.break-visibility = ##(#f #t #t)
}

%% ========== 主旋律（高音譜表）==========
melody = {
  \global
  \clef treble
  %% TODO: 依 來源/主旋律-v01 編碼
  c'1 |
  \bar "|."
}

%% ========== 左手 ==========
leftHand = {
  \global
  \clef bass
  %% TODO: 依和弦套模板（見 common/lh-*.ily）
  c1 |
  \bar "|."
}

chordNames = \chordmode {
  \set chordChanges = ##t
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

\markup \vspace #1
\markup \column {
  \line \bold { "彈奏說明" }
  \vspace #0.3
  \line { "• 右手：主旋律" }
  \line { "• 左手：依 song-meta 伴奏型態" }
}
