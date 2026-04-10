#import "template.typ": *
#import "@preview/unify:0.7.1": *
#import "@preview/physica:0.9.7": *

#show: init

// 設定
#let config = (
  title: "科目名　授業ノート", // レポート名
  author: (
    affiliation: "", // 所属
    name: "lookup" // 名前
  ),
  make-date: "2025-10-01", // 作成日
  update-date: "2026-04-11", // 更新日
)

// meta data
#set document(
    title: config.title,
    author: config.author.name,
    date: auto,
)

#title-block(config.title, config.author.affiliation, config.author.name, config.make-date, config.update-date)

#outline(depth: 2)

= Heading
