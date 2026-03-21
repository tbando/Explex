FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# FontForge, Python, fonttools などの依存関係をインストール
RUN apt-get update && apt-get install -y \
  fontforge \
  python3-fontforge \
  python3-pip \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY requirements.txt .
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt 

# デフォルトの実行コマンド
CMD ["bash"]
