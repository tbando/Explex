#!/bin/bash
set -e

# build.ini から特定のセクションの値を読み取る関数
get_version() {
    local section=$1
    local key=$2
    awk -F ' *= *' '/\['"$section"'\]/{a=1} a==1 && $1=='"\"$key\""'{print $2; exit}' build.ini | xargs
}

PROTO_VER=$(get_version "SOURCE_VERSIONS" "0XPROTO")
NERD_VER=$(get_version "SOURCE_VERSIONS" "NERDFONTS")
PLEX_VER=$(get_version "SOURCE_VERSIONS" "IBMPLEX")

echo "Fetching source fonts..."
echo "0xProto: $PROTO_VER"
echo "Nerd Fonts: $NERD_VER"
echo "IBM Plex Sans JP: $PLEX_VER"

# 0xProto のダウンロード
PROTO_VER_UNDERSCORE=$(echo $PROTO_VER | tr '.' '_')
echo "--- Downloading 0xProto $PROTO_VER ---"
curl -L -o 0xProto.zip "https://github.com/0xType/0xProto/releases/download/${PROTO_VER}/0xProto_${PROTO_VER_UNDERSCORE}.zip"
unzip -o 0xProto.zip -d 0xProto_temp
find 0xProto_temp -name "*.ttf" ! -name "*-NL.ttf" ! -name "ZxProto-*" -exec cp {} source_fonts/0xProto/ \;
rm -rf 0xProto_temp 0xProto.zip

# Nerd Fonts のダウンロード
echo "--- Downloading Nerd Fonts $NERD_VER ---"
curl -L -o NerdFontsSymbolsOnly.zip "https://github.com/ryanoasis/nerd-fonts/releases/download/v${NERD_VER}/NerdFontsSymbolsOnly.zip"
unzip -o NerdFontsSymbolsOnly.zip SymbolsNerdFont-Regular.ttf -d source_fonts/nerd-fonts/
rm NerdFontsSymbolsOnly.zip

# IBM Plex Sans JP のダウンロード
echo "--- Downloading IBM Plex Sans JP $PLEX_VER ---"
curl -L -o IBMPlexSansJP.zip "https://github.com/IBM/plex/releases/download/%40ibm%2Fplex-sans-jp%40${PLEX_VER}/ibm-plex-sans-jp.zip"
unzip -o IBMPlexSansJP.zip -d IBMPlexSansJP_temp
find IBMPlexSansJP_temp -name "*.ttf" -exec cp {} source_fonts/ibm-plex-sans-jp/ \;
rm -rf IBMPlexSansJP_temp IBMPlexSansJP.zip

echo "Successfully updated all source fonts."
