#!/usr/bin/env bash
set -euo pipefail

pkgname="mpv-uosc"
srcdir="/pkgbuild/src"
pkgdir="/pkgbuild/build"

# Get latest release
USER="tomasklaen"
REPO="uosc"
../scripts/github-latest-release.sh "$USER" "$REPO"
cd "$srcdir"

# Build ziggy
dnf -y install golang git
tools/build ziggy

# Install files to pkgdir
install -Dm 644 "src/fonts/"* -t "${pkgdir}/etc/mpv/fonts/"
install -Dm 644 "src/uosc.conf" -t "${pkgdir}/etc/mpv/script-opts/"
install -Dm 755 "src/uosc/bin/ziggy-linux" -t "${pkgdir}/etc/mpv/scripts/uosc/bin/"
for dir in {char-conv,elements,intl,lib}; do
    install -Dm 644 "src/uosc/${dir}/"* -t "${pkgdir}/etc/mpv/scripts/uosc/${dir}/"
done
install -Dm 644 "src/uosc/main.lua" -t "${pkgdir}/etc/mpv/scripts/uosc/"
install -Dm 644 "LICENSE"* -t "${pkgdir}/usr/share/licenses/${pkgname}/"
