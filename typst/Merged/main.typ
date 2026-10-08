#import "./template.typ": *
#import "@preview/unify:0.7.1": *
#import "@preview/physica:0.9.8": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

#show: init
#show: doujinshi

#maketitle(
  title: "タイトル",
  authors: "名前",
)
