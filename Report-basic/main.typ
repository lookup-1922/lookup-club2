#import "template.typ": *
#import "@preview/unify:0.7.1": *
#import "@preview/physica:0.9.5": *
#import "@preview/whalogen:0.3.0": ce

#show: init

// 設定
#let config = (
  title: "タイトル", // レポート名
  author: (
    affiliation: "電気通信大学 III類", // 所属
    name: "2513000 lookup" // (学籍番号) 名前
  ),
  experiment-date: "2025-06-00", //実験日
  make-date: "2025-06-21", // 作成日
  update-date: "2026-04-11", // 更新日
)

// meta data
#set document(
    title: config.title,
    author: config.author.name,
    date: auto,
)

#title-block(config.title, config.author.affiliation, config.author.name, config.experiment-date, config.make-date, config.update-date)

= 目的

= 原理

= 方法

= 実験結果

= 考察

#bibliography(
  "works.yaml",
  full: true,
)

#show: appendix
= 付録
