#import "Notebook-1/template.typ": *

#show: init

// 設定
#let config = (
  title: "Typstテンプレートについて", // レポート名
  author: (
    affiliation: "", // 所属
    name: "lookup" // (学籍番号) 名前
  ),
  make-date: "2025-06-21", // 作成日
  update-date: "2026-04-11", // 更新日
)

// meta data
#set document(
    title: config.title,
    author: config.author.name,
    date: auto,
)

#title-block(config.title, config.author.affiliation, config.author.name, config.make-date, config.update-date)

= 概要
Typstで作ったテンプレートをまとめてある.

= リスト
- 実験レポート
- 授業ノート
- 同人誌
- 工学研究部部報
