\version "2.24.0"
%% 156「我有信心」melody + bottom-row concert chords
%% Official Chinese lead sheet sjjsm-CH pp.234–235
%% Pitch: Opus notehead centers (Finale glyph origin ≈ 2 steps flat vs visual pitch)
%% Capo 3 top guitar row IGNORED; bottom row = concert/piano
%% Absolute LilyPond pitches; middle C = c'

melody = {
  \key c \major
  \time 4/4

  %% ===== 主歌 Verse 1/2 =====
  %% M1 縱使我陷入 / 那些忠貞的
  g'4 g'8 e'8 f'4.. g'16 |
  %% M2 絕境， / 榜樣，
  f'8 e'8 e'4 r2 |
  %% M3 腳下的路很艱 / 一生都信心堅
  g'8. g'16 g'8 g'8 b'4 g'16 f'8. |
  %% M4 辛，我不 / 強。耶和
  e'2 r4 e'8 f'8 |
  %% M5 是孤身一人面 / 華不忘記，必
  g'8 g'8 g'8 e'8 f'4 r8 f'8 |
  %% M6 對人生曲折，上 / 賜他們生命，忠
  %% AMBIGUOUS V6: PDF b'4. + r8 + f'8 = 4.5; keep dot, drop r8
  g'8 b'4. g'8 f'8 e'8 f'8 |
  %% M7 帝是我堅強後 / 心事跡將會延
  g'8 g'8 g'8 e'8 f'4. e'8 |
  %% M8 盾。 + pickup 我有信
  e'2 r8 e''8 e''8 d''8 |

  %% ===== 副歌 Chorus =====
  %% M9 心衝破黑暗的
  %% AMBIGUOUS C1: PDF looks like three dotted quarters (6 beats in one bar);
  %%              fitted to 4/4 as 8. 16 8. 16 4. 8 (matches syllable count)
  e''8. d''16 e''8. d''16 c''4. a'8 |
  %% M10 困境，我能看
  g'4 b'4 r8 e''8 e''8 d''8 |
  %% M11 見曙光照亮天
  %% AMBIGUOUS C3: extra dots in PDF; undotted middle pair for 4/4
  e''4. d''8 e''8 d''8 c''8 b'8 |
  %% M12 際。耶和
  b'2 r4 g'8 b'8 |
  %% M13 華必賜力量，不
  c''8 c''8 c''8 b'8 c''4 r8 b'8 |
  %% M14 用擔心害怕。 + pickup
  b'8 g'8 g'8 e'8 f'4 r8 g'8 |
  %% M15 耶和華總在我的身
  b'8 b'8 g'8 c''8 b'8 c''8 c''8 e''8 |
  %% M16 旁。 + pickup 我有信
  f''2 r8 e''8 e''8 d''8 |

  %% ===== 1st ending =====
  e''2. r4 |
  R1 |
  R1 |
  R1 |

  %% ===== 2nd ending =====
  e''2. r8 e''8 |

  %% ===== 過門 Bridge (Eb) =====
  \key ees \major
  %% 有信心
  e''4.. b'16 d''4 r4 |
  %% 跨越重重障礙，我
  %% AMBIGUOUS Br2: PDF dotted d'' + r8 g'8 overrun; chosen d''8 g'8
  b'8 b'8 b'8 a'8 b'8 b'8 d''8 g'8 |
  %% 能看見光明未
  e''4. e''8 f''8 e''8 d''8 c''8 |
  %% 來。
  b'2. r4 |
  %% 堅強的信心幫助
  e''8 e''8 e''8 f''8 f''8 f''8 e''8 f''8 |
  %% 我堅持到底，捍
  g''8 g''8 f''8 f''8 e''4 r8 d''8 |
  %% 衛真理、臨危不懼。
  %% AMBIGUOUS Br7–8
  c''4. b'8 a'8 g'8 g'8 a'8 |
  b'2 r2 |

  %% ===== 主歌 Verse 3 =====
  \key c \major
  g'4 g'8 e'8 f'4.. g'16 |
  f'8 e'8 e'4 r2 |
  g'8. g'16 g'8 g'8 b'4 g'16 f'8. |
  e'2 r4 e'8 f'8 |
  g'8 g'8 g'8 e'8 f'4 r8 f'8 |
  g'8 b'4. g'8 f'8 e'8 f'8 |
  g'8 g'8 g'8 e'8 f'4. e'8 |
  e'2 r8 e''8 e''8 d''8 |

  %% ===== 副歌 final =====
  e''8. d''16 e''8. d''16 c''4. a'8 |
  g'4 b'4 r8 e''8 e''8 d''8 |
  e''4. d''8 e''8 d''8 c''8 b'8 |
  b'2 r4 g'8 b'8 |
  c''8 c''8 c''8 b'8 c''4 r8 b'8 |
  b'8 g'8 g'8 e'8 f'4 r8 g'8 |
  b'8 b'8 g'8 c''8 b'8 c''8 c''8 e''8 |
  f''2 r2 |

  %% ===== 我有信心！×2 =====
  %% AMBIGUOUS Fin: PDF shows r2 + r8 + three 8ths then whole; fitted to 4/4
  r2 e''8 e''8 d''8 r8 |
  e''1 |
  r2 e''8 e''8 d''8 r8 |
  e''1\fermata |
  \bar "|."
}

chordNames = \chordmode {
  \set chordChanges = ##t

  %% Verse 1/2
  c2 g2/c |
  f1/c |
  c2 g2/c |
  a2:m f2 |
  c2/g g2 |
  a2:m f2 |
  c2/g g2 |
  c2:sus4 c4 g4/b |

  %% Chorus
  a2:m f2 |
  c2/g g2 |
  a2:m f2 |
  c2 g2 |
  a2:m f2 |
  c2 g2 |
  a2:m f2 |
  g1 |

  %% 1st ending
  a1:m |
  f1 |
  c1 |
  g1 |

  %% 2nd ending
  c2:sus4 c2 |

  %% Bridge
  aes2 bes2 |
  g2:m c2:m |
  aes2 bes2 |
  ees1 |
  aes2 ees2/g |
  f1:m |
  g2:sus4 g2 |
  g2:sus4 g2 |

  %% Verse 3
  c2 g2/c |
  f1/c |
  c2 g2/c |
  a2:m f2 |
  c2/g g2 |
  a2:m f2 |
  c2/g g2 |
  c2:sus4 c4 g4/b |

  %% Final chorus
  a2:m f2 |
  c2/g g2 |
  a2:m f2 |
  c2 g2 |
  a2:m f2 |
  c2 g2 |
  a2:m f2 |
  g1 |

  %% 我有信心！×2
  a2:m f2 |
  c1 |
  a2:m f2 |
  c1 |
}

\score {
  <<
    \new ChordNames \chordNames
    \new Staff { \clef treble \melody }
  >>
}
