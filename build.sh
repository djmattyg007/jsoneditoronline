#!/bin/bash

set -e

cd "$(dirname -- "$(readlink -f "$0")")"

JE_VERSION="$(yarn -s info jsoneditor version)"

checksum() {
    sha256sum "$1" | cut -f1 -d ' '
}

yarn install --frozen-lockfile

rm -rf dist
mkdir dist

jecss_filename="jsoneditor-v${JE_VERSION}.min.css"
cp node_modules/jsoneditor/dist/jsoneditor.min.css "dist/${jecss_filename}"
jejs_filename="jsoneditor-v${JE_VERSION}.min.js"
cp node_modules/jsoneditor/dist/jsoneditor.min.js "dist/${jejs_filename}"
cp -r node_modules/jsoneditor/dist/img dist/img

yarn run sass --no-source-map sass/app.scss dist/app.css
appcss_checksum="$(checksum dist/app.css)"
mv dist/app.css "dist/app.${appcss_checksum}.css"

cat js/init.js js/split.js > dist/app.js
appjs_checksum="$(checksum dist/app.js)"
mv dist/app.js "dist/app.${appjs_checksum}.js"

cat html/index.html | yarn run -s handlebarsjs-cli --jeCss="${jecss_filename}" --jeJs="${jejs_filename}" --appCssChecksum="${appcss_checksum}" --appJsChecksum="${appjs_checksum}" > dist/index.html
