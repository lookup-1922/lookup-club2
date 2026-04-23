#import "template.typ": *
#import "@preview/unify:0.7.1": *
#import "@preview/physica:0.9.7": *

#show: init

// 設定
#let config = (
  title: "本として印刷できる", // タイトル
  version: "1", //バージョン
  author: (
    affiliation: "", // 所属
    name: "lookup" // 名前
  ),
)

// meta data
#set document(
    title: config.title,
    author: config.author.name,
    date: auto,
)

#cover(
  config.title, 
  config.version, 
  config.author.affiliation, 
  config.author.name, 
)

#outline(depth: 2)

#pagebreak()

#show: preamble

= まえがき
文句を言ったら同人誌!

#show: content
= 本文

#show: afterword

= あとがき

#bibliography(
  "works.yaml",
  full: true,
)

#colophon(
  title: config.title,
  issue-date: "2025-09-23",
  author-name: config.author.name,
  contact: link("https://lookup-1922.hatenablog.com/"),
  printer: "未定"
)
