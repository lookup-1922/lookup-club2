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

  // セクション番号の設定
  set heading(numbering: "1.")
  show heading: set text(font: font.sans, size: font.size, weight: font.sans-weight)

  // 段落の設定
  set par(
    first-line-indent: (
      all: false,
      amount: 1em,
    )
  )
  
  // 数式の設定
  set math.equation(number-align: bottom)
  
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
  
  body
}

/* calenderの作成に使う変数 */
#let weekday_name = (
  "月",
  "火",
  "水",
  "木",
  "金",
  "土",
  "日",
)

/* calenderの作成に使う関数 */
// ISO8601 week number
#let iso-week(date) = {
  let w = date.weekday() // weekday: Mon=1 ... Sun=7
  let thursday = date + duration(days: 4 - w) // その週の木曜日
  let y = thursday.year() // その木曜日の年
  let jan4 = datetime(year: y, month: 1, day: 4) // その年の 1/4 (必ず week1)
  let jan4_monday = jan4 - duration(days: jan4.weekday() - 1) // jan4 の週の月曜
  let diff = thursday - jan4_monday // 週番号
  calc.floor(diff.days() / 7) + 1
}

/* calenderの作成 */
#let week-page(date, month, events) = {
  let week = iso-week(date)
  let weekday = date.weekday()
  let monday = date - duration(days: weekday - 1)

  let days = range(0,7)
    .map(i => monday + duration(days: i))

  text[
    #date.year()年 #month 月 #h(1fr) 第 #week 週
  ]

  table(
    columns: (1fr,),
    rows: 7,
    stroke: 0.7pt,

    ..range(0,7).map(i => {
      let d = days.at(i)

      let event ={
        if d.month() == month {
          events.at(str(d.day()), default: none)
        } else {
          none
        }
      }

      [
        #box(height: 20mm, width: 100%)[
          #d.display("[day]") [#weekday_name.at(i)]\
          #if event != none [#event]
          #v(1fr)
        ]
      ]
    })
  )
}

#let month-calendar(
  date: datetime.today(),
  events: (:),
) = {
  set document(title: date.display(), date: auto)

  let year = date.year()
  let month = date.month()

  let first = datetime(year: year, month: month, day: 1)

  let first-weekday = first.weekday()
  let first-monday = first - duration(days: first-weekday - 1)

  let next-month = datetime(year: year, month: month + 1, day: 1)

  let weeks = range(0,6)
    .map(i => first-monday + duration(days: i*7))
    .filter(d => d < next-month)

  for (i, w) in weeks.enumerate() {
    week-page(w, month, events)

    if i < weeks.len() - 1 {
      pagebreak()
    }
  }
}

#let akazi(bunsho) = {
  text(fill: red, bunsho)
}
