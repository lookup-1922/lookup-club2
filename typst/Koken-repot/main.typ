#import "template.typ": *
#import "@preview/unify:0.7.1": *
#import "@preview/physica:0.9.7": *

#show: init
#show: footer

// 設定
#let config = (
  title: "工学研究部 部報", // タイトル
  issue: "n", // 号数
  author: "25 lookup", // 名前
)

// meta data
#set document(title: config.title, author: config.author, date: auto,)

// ヘッダーの設定
#set page(header: {box(stroke: (bottom: 0.5pt), inset: (bottom: 5pt), {h(1fr);"工学研究部 部報" + config.issue + "号"})})

#title-block(config.title, config.author)

= 本文
#lorem(30)

#bibliography(
  "works.yaml",
  full: true,
)
