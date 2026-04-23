// フォント設定
#let font = (
  size: 11pt,
  serif: ("Noto Serif CJK JP"),
  sans: ("Noto Sans CJK JP"),
  sans-weight: "medium",
  math: ("New Computer Modern Math", "Noto Serif CJK JP"),
  raw:("DejaVu Sans Mono", "Noto Sans CJK JP"),
)

// 初期設定
#let init(body) = {
  // 共通の設定
  // ページの設定
  set page(
    paper: "a5",
    numbering: "1"
  )

  // テキストの設定
  set text(
    lang: "ja",
    font: font.serif,
    size: font.size
  )
  show math.equation: set text(font: font.math)
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
  
  // 数式の設定
  set math.mat(delim: "[")
  set math.vec(delim: "[")
  set math.equation(
    numbering: num => 
      numbering("(1.1)", counter(heading).get().first(), num),
      number-align: bottom
  )

  // 図表の設定
  set figure(
    numbering: num =>
      numbering("1.1", counter(heading).get().first(), num)
  )
  
  // 表の設定
  let frame(stroke) = (x, y) => (
    left: none,
    right: none,
    top: if y < 2 { stroke } else { 0pt },
    bottom: stroke,
  )
  set table(stroke: frame(rgb("21222C")))

  // 表のキャプリョンを上部に
  show figure.where(kind: table): set figure.caption(position: top)

  // 見出し（章）が変わるたびにカウンターをリセット
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  
  body
}

// タイトルブロックの設定
#let title-block(title, author-affiliation, author-name, make-date, update-date) = {
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
  let make-date = parse-ymd(make-date)
  let update-date = parse-ymd(update-date)
  
  align(center)[
    #text(font: font.sans, size: 1.5em, weight: font.sans-weight, title)\
    // 所属組織の表示
    #print-if-not-empty(author-affiliation)
    // 名前の表示
    #print-if-not-empty(author-name)
    // 作成日の設定
    #print-date(make-date, "作成")
    // 更新日の設定
    #print-date(update-date, "更新")
  ]
}
