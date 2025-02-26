#!/usr/bin/env bash
set -euo pipefail

pkgname="mpv-thumbfast"
srcdir="/pkgbuild/src"
pkgdir="/pkgbuild/build"

# Clone master branch
dnf -y install git
mkdir -p "$srcdir"
git clone "https://github.com/po5/thumbfast.git" "$srcdir"
cd "$srcdir"

# Install files to pkgdir
install -Dm 644 "thumbfast.conf" -t "${pkgdir}/etc/mpv/script-opts/"
install -Dm 644 "thumbfast.lua" -t "${pkgdir}/etc/mpv/scripts/"
install -Dm 644 "LICENSE"* -t "${pkgdir}/usr/share/licenses/${pkgname}/"
