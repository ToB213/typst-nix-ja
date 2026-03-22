# typst-nix-ja

[Nix](https://nixos.org/) を使って再現性のある日本語 [Typst](https://typst.app/) 執筆環境を構築するテンプレートです。

## 特徴

- **フォント自動取得**: Source Han Serif / Sans・JetBrains Mono を Nix が管理
- **再現性**: `flake.lock` により全員が同一のツールバージョンを使用
- **VS Code 連携**: [Tinymist](https://github.com/Myriad-Dreamin/tinymist) による保存時プレビュー・自動フォーマット

## 必要なもの

- [Nix](https://nixos.org/download/) （flakes 有効化済み）
- [direnv](https://direnv.net/)（オプション、自動 `nix develop` 用）

## クイックスタート

```sh
# リポジトリをクローン
git clone <this-repo>
cd typst-nix-ja

# Nix 開発環境に入る
nix develop

# テンプレートをコンパイル
typst compile template/report.typ reports/report.pdf
```

direnv を使う場合はクローン後に `direnv allow` するだけで自動的に環境が有効になります。

## VS Code での使い方

1. [Tinymist 拡張機能](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) をインストール
2. `.vscode/settings.json` が自動的に適用される
3. `report.typ` を開いて編集すると、保存時に自動コンパイル・プレビューが更新される

> **注意**: Tinymist は `nix develop` 環境内のバイナリを使うよう `.vscode/tinymist-wrapper.sh` 経由で起動します。ターミナルから VS Code を開くか（`code .`）、direnv を有効にしてください。

## ディレクトリ構成

```
.
├── flake.nix              # Nix 環境定義（typst・tinymist・フォント）
├── flake.lock             # バージョンロックファイル
├── template/
│   ├── report.typ         # レポートテンプレート本体
│   └── references.bib     # 参考文献（BibTeX 形式）
├── reports/               # コンパイル済み PDF の出力先（gitignore 済み）
└── .vscode/
    ├── settings.json      # Tinymist 設定
    └── tinymist-wrapper.sh # nix develop 経由で tinymist を起動するラッパー
```

## 使用フォント

| フォント | 用途 |
|---|---|
| [Source Han Serif](https://github.com/adobe-fonts/source-han-serif) | 本文（明朝体） |
| [Source Han Sans](https://github.com/adobe-fonts/source-han-sans) | 見出し・タイトル（ゴシック体） |
| [JetBrains Mono](https://www.jetbrains.com/lp/mono/) | コードブロック |

## ライセンス

MIT
