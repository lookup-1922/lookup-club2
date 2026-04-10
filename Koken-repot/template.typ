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
  // ページの設定
  set page(
    paper: "a4",
    margin: (top: 1.3in, x: 0.787in, bottom: 1.18in),
    
  )

  set page(
    columns: 2,
  )
  
  // テキストの設定
  set text(
    lang: "ja",
    font: font.serif,
    size: font.size
  )
  show math.equation: set text(font: font.math)
  show raw: set text(font: font.raw)

  // heading numbering の設定
  set heading(numbering: "1.")

  // heading font の設定
  show heading: set text(
    font: font.sans, 
    size: font.size, 
    weight: font.sans-weight
  )
  
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

// フッターの設定
#let footer(body) = {
  set page(
    header-ascent: 1em,
    footer-descent: 1em,
    footer: [
      #grid(
        columns: (auto,1fr,auto),
        stroke: (top: 0.5pt), inset: (top: 10pt),
        "電気通信大学 工学研究部",
        "",
        align(right)[
          #link("https://www.koken.club.uec.ac.jp")\
          #link("ueckoken@gmail.com")
        ],
      )
    ],
  )
  body
}

#let title-block(title, author) = {
  place(
    top + center,
    scope: "parent",
    float: true,
    {
      v(1em)
      text(font: font.sans, size: 1.5em, weight: font.sans-weight, title)
      linebreak()
      text(font: font.sans, size: 1.2em, weight: font.sans-weight, author)
      v(1em)
    }
  )
}
