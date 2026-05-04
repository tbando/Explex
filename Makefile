IMAGE_NAME = explex-builder

.PHONY: build-image build clean fetch-fonts

# ソースフォントのダウンロード
fetch-fonts:
	./fetch_fonts.sh

# Dockerイメージの作成
build-image:
	docker build -t $(IMAGE_NAME) .

# フォントのビルドを実行
# ホストのカレントディレクトリを /work にマウントして成果物を取り出せるようにする
# fontforge -script の前に python-fontforge がインストールされている環境では、
# 標準の python3 から import fontforge して実行することも可能です。
build: build-image
	# 1:2 比率版のビルド
	docker run --rm -v $(PWD):/work $(IMAGE_NAME) \
		bash -c "python3 ./fontforge_script.py --nerd-font --console && python3 ./fonttools_script.py"

# フォントのLintを実行 (Google Fonts等の標準に準拠しているか確認)
lint: build-image
	docker run --rm -v $(PWD):/work $(IMAGE_NAME) \
		fontbakery check-universal build/*.ttf

# 名前を詳細に確認する
check-name: build-image
	docker run --rm -v $(PWD):/work $(IMAGE_NAME) \
		python3 -c 'from fontTools import ttLib; font = ttLib.TTFont("build/ExplexConsoleNF-Bold.ttf"); [print(f"Platform {r.platformID} ID {r.nameID}: {r.toUnicode()}") for r in font["name"].names]'

# ビルド成果物の削除
clean:
	rm -rf build/
