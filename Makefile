IMAGE_NAME = explex-builder

.PHONY: build-image build clean

# Dockerイメージの作成
build-image:
	docker build -t $(IMAGE_NAME) .

# フォントのビルドを実行
# ホストのカレントディレクトリを /work にマウントして成果物を取り出せるようにする
# fontforge -script の前に python-fontforge がインストールされている環境では、
# 標準の python3 から import fontforge して実行することも可能です。
build: build-image
	docker run --rm -v $(PWD):/work $(IMAGE_NAME) \
		bash -c "python3 ./fontforge_script.py --nerd-font && python3 ./fonttools_script.py"

# ビルド成果物の削除
clean:
	rm -rf build/
