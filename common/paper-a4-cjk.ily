%% Shared A4 paper + CJK fonts for JW-Work 音樂/ (LilyPond 2.26+)
%% Windows: Microsoft JhengHei. Optional: WenQuanYi Micro Hei.
%% Symptom if missing: title text may show as boxes.

\paper {
  #(set-paper-size "a4")
  fonts.sans = "Microsoft JhengHei"
  fonts.roman = "Microsoft JhengHei"
  indent = 14
  top-margin = 12
  bottom-margin = 12
  left-margin = 14
  right-margin = 14
  system-system-spacing.basic-distance = 16
}
