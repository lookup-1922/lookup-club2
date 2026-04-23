// フォント設定
#let font = (
  size: 11pt,
  serif: ("Noto Serif CJK JP"),
  sans: ("Noto Sans CJK JP"),
  sans-weight: "medium",
  math: ("New Computer Modern Math", "Noto Serif CJK JP"),
  raw:("DejaVu Sans Mono", "Noto Sans CJK JP"),
)

// カラー設定
#let color = (
  main: rgb(60,87,200),
  accent-1: luma(200),
  accent-2: luma(160),
)

// 初期設定
#let init(body) = {
  // ページの設定
  set page(
    paper: "a5",
    numbering: "1",
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
  
  // 段落の設定
  set par(
    first-line-indent: (
      all: true,
      amount: 1em,
    )
  )
  
  // 数式の設定
  set math.mat(delim: "[")
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
    top: if y < 2 { stroke } else { none },
    //bottom: stroke,
    bottom: if y == auto { stroke } else { none },
  )
  set table(stroke: frame(rgb("21222C")))

  // 表のキャプリョンを上部に
  show figure.where(kind: table): set figure.caption(position: top)

  // 見出し（章）が変わるたびにカウンターをリセット
  /*show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }*/
  
  body
}

#let preamble(body) = {
  // heading numbering の設定
  set heading(numbering: none)
  
  body
}

#let content(body) = {
  // heading numbering の設定
  set heading(numbering: "1.")
  
  body
}

#let afterword(body) = {
  // heading numbering の設定
  set heading(numbering: none)
  
  body
}

// 表紙の設定
#let cover(title, version, author-affiliation, author-name,) = {
  align(center + horizon)[
    #underline(
      text(font: font.sans, size: 2.1em, weight: font.sans-weight, title),
      stroke: 2pt + color.main,
      extent: 10pt,
      offset: 5pt
    )\
    \
    #text(font: font.sans, size: font.size, weight: font.sans-weight, "第" + version + "版")\
  ]
  
  align(left + bottom)[
    // 所属組織の存在の有無の確認
    #if author-affiliation != "" [
      #text(font: font.sans, weight: font.sans-weight, author-affiliation)\
    ]
  ]
  
  align(right + bottom)[
    #text(font: font.sans, weight: font.sans-weight, author-name)\
  ]
  pagebreak()
}

// 奥付の設定
#let colophon(title: "", issue-date: "", author-name: "", contact: "", printer: "") = {
  pagebreak()

  set par(
    first-line-indent: (
      all: false,
      amount: 1em,
    )
  )
  
  align(bottom)[
    #text(font: font.serif, size: 1.2em, weight: font.sans-weight, title)
    #line(length: 100%)
    #text([
      #if issue-date != "" [
        #let issue-date = (issue-date.split("-")        )
        #text(issue-date.at(0) + "年" + issue-date.at(1) + "月" + issue-date.at(2) + "日 初版発行")\
      ]
      #if author-name != "" [
        #text("発行者：" + author-name)\
      ]
      #if contact != "" [
        #text("連絡先：" + contact)\
      ]
      #if printer != "" [
        #text("印刷所：" + printer)\
      ]
      \
      #text("内容の正確性・完全性については十分配慮しておりますが、万一誤りがあった場合も、筆者および発行者は一切の責任を負いかねます。")
    ])
  ]
}
