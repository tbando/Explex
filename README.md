# Explex

Explex は、[0xProto](https://github.com/0xType/0xProto) と [IBM Plex Sans JP](https://github.com/IBM/plex) を合成した、プログラミング向けフォントです。

日本語グリフが含まれていない 0xProto を日本語文書でも扱いやすくし、半角1:全角2 比率の等幅フォント化することを目指しました。

[👉 ダウンロード](https://github.com/yuru7/Explex/releases/latest)  
※「Assets」内の zip ファイルをダウンロードしてご利用ください。

> 💡 その他、公開中のプログラミングフォント
> - 日本語文字に源柔ゴシック、英数字部分に Hack を使った [**白源 (はくげん／HackGen)**](https://github.com/yuru7/HackGen)
> - 日本語文字に IBM Plex Sans JP、英数字部分に IBM Plex Mono を使った [**PlemolJP (プレモル ジェイピー)**](https://github.com/yuru7/PlemolJP)
> - 日本語文字にBIZ UDゴシック、英数字部分に JetBrains Mono を使った [**UDEV Gothic**](https://github.com/yuru7/udev-gothic)

## 特徴

以下の特徴を備えています。

- 文字形を崩さない控えめなリガチャやテクスチャーヒーリングに対応、コーディングシーンに最適化された 0xProto 由来のラテン文字
- IBM社が提供する IBM Plex Sans JP 由来の読み易い日本語文字
- 記号類グリフの豊富な [Hack](https://github.com/source-foundry/Hack) を追加合成することで記号の不足を補完
- 全角スペースの可視化
- 収録される文字の違い等によって分かれた複数のバリエーションを用意 (下記参照)

### バリエーション

| **フォント ファミリー** | **説明** |
| :------------:          | :---     |
| **Explex** | 文字幅比率「半角1:全角2」の通常版の Explex。主にASCIIコードの英数字記号に 0xProto の字体を使い、その他の日本語文字や記号類に IBM Plex Sans JP を使っている。 |
| **Explex Console** | 0xProto の字体を除外せずに全て適用したフォントファミリー。さらに追加合成した Hack に含まれる矢印記号など多くの記号が半角で表示されるため、コンソールでの利用や記号類は可能な限り半角で表示したい人にオススメ。 |

## 表示サンプル

![image](https://github.com/user-attachments/assets/54caeaf4-92ba-4a56-ada2-c2210db09b22)

## ビルド


環境:

- fontforge: `20230101` \[[Windows](https://fontforge.org/en-US/downloads/windows/)\] \[[Linux](https://fontforge.org/en-US/downloads/gnulinux/)\]
- Python: `>=3.12`

### Windows (PowerShell Core)

```sh
# 必要パッケージのインストール
pip install -r requirements.txt
# ビルド
& "C:\Program Files (x86)\FontForgeBuilds\bin\ffpython.exe" .\fontforge_script.py && python3 .\fonttools_script.py
```

### Linux / Docker

```sh
# フォントのビルド
make build
# フォントの Lint (チェック) を実行
make lint
# ビルド成果物の削除
make clean
```

### ビルドオプション

`fontforge_script.py` 実行時、以下のオプションを指定できます。

- `--console`: できるだけ East Asian Ambiguous Width 記号を半角で表示する
- `--hidden-zenkaku-space`: 全角スペース可視化を無効化

## ライセンス

SIL OPEN FONT LICENSE Version 1.1 が適用され、商用・非商用問わず利用可能です。

- 詳細は [LICENSE](https://raw.githubusercontent.com/yuru7/Explex/main/LICENSE) を参照
- 各種ソースフォントのライセンスは、ソースフォント毎のディレクトリに同梱
