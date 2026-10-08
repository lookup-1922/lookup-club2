// フォント設定
#let font = (
  size: 11pt,
  serif: ("New Computer Modern", "Noto Serif CJK JP"),
  sans: ("Noto Sans CJK JP"),
  sans-weight: "medium",
  math: ("New Computer Modern Math", "Noto Serif CJK JP"),
  raw:("DejaVu Sans Mono", "Noto Sans CJK JP"),
)

// 共通初期設定
#let init(body) = {
  // ページの設定
  set page(paper: "a4", numbering: "1", columns: 1)

  // テキストの設定
  set text(lang: "ja", font: font.serif, size: font.size)
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
  set math.equation(numbering: "(1)")

  // 図表の設定
  set figure(numbering: "1")
  let frame(stroke) = (x, y) => (
    left: none,
    right: none,
    top: if y < 2 { stroke } else { 0pt },
    bottom: stroke,
  )
  set table(stroke: frame(rgb("21222C")))
  show figure.where(kind: table): set figure.caption(position: top)
  
  body
}

// ノート用設定
#let notebook(body) = {
  set page(paper: "a5", columns: 1)

  // 数式の設定
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
  
  // 見出し(章)が変わるたびにカウンターをリセット
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  
  body
}

// レポート用設定
#let my-reports(body) = {
  set page(paper: "a4", columns: 2)
  body
}

// 同人誌用設定
#let doujinshi(body) = {
  let color = (
    main: rgb(60,87,200),
    accent-1: luma(200),
    accent-2: luma(160),
  )

  // heading font の設定
  show heading: set text(
    font: font.sans,
    size: font.size,
    weight: font.sans-weight
  )

  // heading level 1 の設定
  show heading.where(level: 1): block.with(
    fill: color.accent-1,
    width: 100%,
    inset: 8pt,
    radius: 4pt,
  )

  // heading level 2 の設定
  show heading.where(level: 2): block.with(
    stroke: (
      bottom: 2pt + color.accent-2, 
      rest: none,
    ),
    inset: (bottom: 4pt), // 下線との間隔
    width: 100%, // 横幅
  )
  body
}

// 工研部報用設定
#let koken-buho(body) = {
  /* 使い方要注意。部報の号数を書き込んで貼り付けること。フォントサイズを12ptにすること */
  // #set page(header: context {box(stroke: (bottom: 0.5pt), inset: (bottom: 5pt), {"タイトル "; counter(page).display("1/1", both: true,); h(1fr); "工学研究部 部報XX号"})})

  set page(margin: (top: 1.3in, x: 0.787in, bottom: 1.18in), columns: 2)
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

// 印刷用設定
#let for-print(body) = {
  set page(paper: "a4", columns: 2)
}

// 関数
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

#let my-bibliography(file-name) = {
  set text(lang: "en")
  bibliography(
    file-name,
    title: "参考文献",
    full: true,
  )
  set text(lang: "ja")
}
