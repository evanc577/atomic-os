#!/usr/bin/env bash
set -exuo pipefail

# Parse options
gpgkey=$(echo "$1" | jq -r 'try .["gpgkey"]' | envsubst)
reponame=$(echo "$1" | jq -re 'try .["reponame"]' | envsubst)
repobaseurl=$(echo "$1" | jq -re 'try .["repobaseurl"]' | envsubst)
get_json_array packages 'try .["packages"][]' "$1"

if [[ -z ${packages[@]} ]]; then
    exit 1
fi

# Load GPG key
if [[ "$gpgkey" != "null" ]]; then
    gpgarg="--setopt=${reponame}.gpgkey=${gpgkey}"
else
    gpgarg="--nogpgcheck"
fi

# Install packages
dnf5 -y install --repofrompath "$reponame,$repobaseurl" --repo "$reponame" "${gpgarg}" "${packages[@]}"
