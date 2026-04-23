// フォント設定
#let font = (
  size: 11pt,
  serif: ("New Computer Modern","Noto Serif CJK JP"),
  sans: ("New Computer Modern","Noto Sans CJK JP"),
  sans-weight: "medium",
  math: ("New Computer Modern Math", "Noto Serif CJK JP"),
  raw:("DejaVu Sans Mono", "Noto Sans CJK JP"),
)

// 初期設定
#let init(body) = {
  // 共通の設定
  // ページの設定
  set page(
    paper: "a4",
    numbering: "1"
  )

  // テキストの設定
  set text(
    lang: "ja",
    font: font.serif,
    size: font.size
  )
  show math.equation: set text(font: font.math, size: font.size)
  show raw: set text(font: font.raw)

  // セクション番号の設定
  set heading(numbering: "1.")
  show heading: set text(font: font.sans, size: font.size, weight: font.sans-weight)

  // 段落の設定
  set par(
    first-line-indent: (
      all: true,
      amount: 1em,
    )
  )
  
  // 数式番号の設定
  set math.equation(
    numbering: "(1)",
    number-align: bottom
  )

  // 表の設定
  // 最終行にはtable.hline()が必要
  let frame(stroke) = (x, y) => (
    left: none,
    right: none,
    top: if y < 2 { stroke } else { none },
    bottom: if y == auto { stroke } else { none },
  )
  set table(stroke: frame(rgb("21222C")))

  // 表のキャプリョンを上部に
  show figure.where(kind: table): set figure.caption(position: top)
  
  body
}

// タイトルブロックの設定
#let title-block(title, author-affiliation, author-name, experiment-date, make-date, update-date) = {
  // 関数を定義
  // 日付をパースする関数
  let parse-ymd(date) = (
    if date != "" {
      date.split("-")
    } else  {""}
  )
  // データが空でなければ表示する関数
  let print-if-not-empty(data) = (
    if data != "" [
      #text(font: font.sans, weight: font.sans-weight, data)\
    ] else []
  )
  // 日付を表示する関数
  let print-date(date, caption) = (
    if date != "" and date.at(2) != "00" [
      #text(font: font.sans, weight: font.sans-weight, date.at(0) + "年" + date.at(1) + "月" + date.at(2) + "日" + caption)\
    ]
  )
  
  // データの前処理
  let experiment-date = parse-ymd(experiment-date)
  let make-date = parse-ymd(make-date)
  let update-date = parse-ymd(update-date)
  
  align(center)[
    #text(font: font.sans, size: 1.5em, weight: font.sans-weight, title)\
    // 所属組織の表示
    #print-if-not-empty(author-affiliation)
    // 名前の表示
    #print-if-not-empty(author-name)
    // 実験日の設定
    #print-date(experiment-date, "実験")
    // 作成日の設定
    #print-date(make-date, "作成")
    // 更新日の設定
    #print-date(update-date, "更新")
  ]
}

// 共同実験者の設定
#let co-experimenter(coex-name) = {
  align(center)[
    #text(font: font.sans, weight: font.sans-weight, "共同実験者 " + coex-name)\
  ]
}

// 付録の設定
#let appendix(body) = {
  set heading(
    numbering: "A.",
    supplement: [付録]
  )
  set math.equation(
    numbering: num => numbering("(A.1)", counter(heading).get().first(), num),
    number-align: bottom
  )
  set figure(
    numbering: num => numbering("A.1", counter(heading).get().first(), num),
  )
  
  counter(heading).update(0)
  counter(math.equation).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: raw)).update(0)
  
  body
}
