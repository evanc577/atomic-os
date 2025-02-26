#!/usr/bin/env bash
set -euo pipefail

srcdir="/pkgbuild/src"

if [[ $# -ne 2 ]]; then
    echo "Downloads latest release source to $srcdir"
    echo "Usage: $0 <USER> <REPO>"
    exit 1
fi

USER=$1
REPO=$2

mkdir -p "$srcdir"
TAG="$(curl "https://api.github.com/repos/$USER/$REPO/releases/latest" | jq --raw-output '.tag_name')"
curl -Lo "$REPO-$TAG.tar.gz" "https://github.com/$USER/$REPO/archive/refs/tags/$TAG.tar.gz"
tar xvf "${REPO}-${TAG}.tar.gz" --strip-components=1 -C "$srcdir"
