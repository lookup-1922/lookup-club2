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

#let maketitle(
  title: "",
  authors: "",
  date: datetime.today().display("[year]年[month]月[day]日"),
  abstract: [],
  keywords: (),
) = {
  set document(title: title, author: authors, date: auto, keywords: keywords)

  place(top + center, scope: "parent", float: true)[
    #set text(font: font.sans, weight: font.sans-weight)
    #set align(center)
    
    // タイトルの表示
    #text(font: font.sans, size: 1.5em, weight: font.sans-weight, title)\
    // 名前の表示
    #if authors != "" [#text(authors)\ ] else []
    // 日付の表示
    #date
    #if abstract != [] {
      block(width: 90%)[
        #set text(0.9em, font: font.serif)
        概要
        #align(left)[#abstract]
      ]
    }
  ]
}

#let noindent(body) = {
  set par(first-line-indent: 0em)
  body
}

#let my-bibliography(file-name) = {
  set text(lang: "en")
  bibliography(
    file-name,
    title: "参考文献",
    full: true,
  )
  set text(lang: "ja")
}
