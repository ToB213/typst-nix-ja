//  設定

#let accent = rgb("#1a3a5c")   // メインカラー（紺）

// ページ
#set page(
  paper: "a4",
  margin: (top: 25mm, bottom: 25mm, left: 30mm, right: 25mm),
  header: context {
    set text(size: 9pt, fill: luma(120))
    grid(
      columns: (1fr, 1fr),
      align(left)[報告書], align(right)[#datetime.today().display("[year]年[month]月[day]日")],
    )
    line(length: 100%, stroke: 0.4pt + luma(180))
  },
  footer: context {
    line(length: 100%, stroke: 0.4pt + luma(180))
    set text(size: 9pt, fill: luma(120))
    align(center)[#counter(page).display("1")]
  },
)

// 本文フォント
#set text(
  font: ("Source Han Serif",),
  size: 11pt,
  lang: "ja",
  region: "JP",
  spacing: 100%,
)

// 段落
#set par(
  first-line-indent: (amount: 1em, all: true),
  justify: true,
  leading: 0.85em,
  spacing: 0.6em,
)

// ドキュメントメタ
#set document(title: [報告書タイトル], author: "著者名")

// 見出し
#set heading(numbering: "1.1.")


#show heading.where(level: 1): it => {
  v(2em)
  set text(size: 14pt, weight: "bold", fill: accent, font: ("Source Han Sans",))
  block(below: 0.4em, it)
  line(length: 100%, stroke: 1pt + accent)
  v(0.5em)
}

#show heading.where(level: 2): it => {
  v(1.4em)
  set text(size: 12pt, weight: "bold", fill: accent, font: ("Source Han Sans",))
  block(below: 0.8em, it)
}

#show heading.where(level: 3): it => {
  v(1.0em)
  set text(size: 11pt, weight: "bold", fill: accent, font: ("Source Han Sans",))
  block(below: 0.8em, it)
}

// 数式
#set math.equation(numbering: "(1)")

// コードブロック
#show raw.where(block: true): it => {
  set text(font: ("JetBrains Mono",), size: 9pt)
  block(
    width: 100%,
    inset: (x: 1em, y: 0.8em),
    stroke: (left: 3pt + accent),
    fill: luma(245),
    radius: (right: 4pt),
    it,
  )
}

// インラインコード
#show raw.where(block: false): it => {
  box(
    fill: luma(238),
    inset: (x: 0.3em, y: 0.15em),
    radius: 2pt,
  )[#set text(font: ("JetBrains Mono",), size: 0.9em)
    #it]
}

// リンク
#show link: it => {
  set text(fill: accent)
  underline(it)
}

// 引用
#show ref: it => {
  set text(fill: accent)
  it
}

// 図・表キャプション
#set figure(gap: 0.6em)
#show figure.caption: it => {
  set text(size: 9.5pt, fill: luma(60))
  set align(center)
  block(above: 0.4em)[
    *#it.supplement #it.counter.display(it.numbering)*　#it.body
  ]
}

//  タイトルブロック

#let title-block(
  title: [],
  subtitle: none,
  authors: (),
  affiliation: none,
  date: datetime.today(),
  abstract: none,
) = {
  // タイトル
  align(center)[
    #block(width: 90%)[
      #set text(size: 20pt, weight: "bold", fill: accent, font: ("Source Han Sans",))
      #set par(first-line-indent: 0pt, justify: false)
      #title
    ]
  ]

  // サブタイトル
  if subtitle != none {
    v(0.4em)
    align(center)[
      #set text(size: 13pt, fill: luma(60))
      #set par(first-line-indent: 0pt)
      #subtitle
    ]
  }

  v(0.5em)
  align(center)[
    #line(length: 50%, stroke: 1.2pt + accent)
  ]
  v(0.5em)

  align(center)[
    #set text(size: 10pt, font: ("Source Han Sans",))
    #set par(first-line-indent: 0pt, leading: 0.8em)
    #if type(authors) == array { authors.join("　・　") } else { authors }
    #if affiliation != none [ 　（#affiliation）]
    　#date.display("[year]年[month]月[day]日")
  ]

  // 概要
  if abstract != none {
    v(0.8em)
    block(
      width: 100%,
      inset: (x: 1.2em, y: 0.9em),
      stroke: (left: 3pt + accent),
      fill: luma(248),
      radius: (right: 4pt),
    )[
      #set text(size: 10pt)
      #set par(first-line-indent: 1em, leading: 0.8em)
      *概要*　#abstract
    ]
  }

  v(1.2em)
  line(length: 100%, stroke: 0.6pt + luma(180))
}

//  本文

#title-block(
  title: [報告書タイトル],
  subtitle: [サブタイトル（任意）],
  authors: ("著者 太郎", "著者 花子"),
  affiliation: "〇〇大学 〇〇研究室",
  abstract: [
    本報告書の概要をここに記述する。研究の目的・手法・結果・結論を簡潔にまとめる。概要は200〜400字程度が目安である。
  ],
)

= はじめに

ここに導入文を記述する。研究・調査の背景と意義を述べ、読者が本報告書を読む動機を与える。参考文献の引用例：#cite(<BN00987515>)。

== 背景

本研究の背景について述べる。関連研究との比較を行い、本研究の位置づけを明確にする。

=== 先行研究

先行研究の詳細はここに記述する。既存手法の問題点や未解決課題を整理する。

== 目的

本報告書の目的は以下の通りである。

- 目的1：〇〇を明らかにする
- 目的2：〇〇を実現する手法を提案する
- 目的3：提案手法の有効性を実験的に検証する

= 手法

提案手法について説明する。数式を用いる場合は以下のように記述する：

$ bold(y) = bold(W) bold(x) + bold(b) $ <eq:linear>

@eq:linear に示すように、線形変換を用いる。`inline code` のようにインラインコードも記述できる。

コードブロックの例：

```python
import numpy as np

def softmax(x):
    """ソフトマックス関数"""
    e_x = np.exp(x - np.max(x))
    return e_x / e_x.sum()
```

= 結果

実験結果を示す。#figure(
  rect(width: 8cm, height: 5cm, fill: luma(240), stroke: 0.5pt),
  caption: [実験結果の例（ここに図を挿入する）],
) <fig:result>

@fig:result に示すように、〇〇という結果が得られた。

= おわりに

本報告書では〜について述べた。提案手法により〇〇が達成された。今後の課題として〇〇が挙げられる。

#bibliography("references.bib", title: "参考文献", style: "ieee")
