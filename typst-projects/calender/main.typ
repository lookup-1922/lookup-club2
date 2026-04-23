#import "./template.typ": *

#show: init

#let date = datetime(
  year: 2026,
  month: 04,
  day: 01,
)

#let events = (
  "1": [予定],
  "2": [18:00–22:00 時間付きの予定],
  "29": [#akazi("昭和の日")],
)

#month-calendar(
  date: date,
  events: events,
)
