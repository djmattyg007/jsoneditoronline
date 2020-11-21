#!/bin/bash

JE_VERSION="9.1.3"

checksum() {
    cat "$1" | openssl dgst -sha256 -binary | openssl base64 -A
}

yarn install --frozen-lockfile

rm -rf dist
mkdir dist

jecss_filename="jsoneditor-v${JE_VERSION}.min.css"
cp node_modules/jsoneditor/dist/jsoneditor.min.css "dist/${jecss_filename}"
jecss_checksum="$(checksum "dist/${jecss_filename}")"

jejs_filename="jsoneditor-v${JE_VERSION}.min.js"
cp node_modules/jsoneditor/dist/jsoneditor.min.js "dist/${jejs_filename}"
jejs_checksum="$(checksum "dist/${jejs_filename}")"

yarn run sass sass/app.scss dist/app.css
appcss_checksum="$(checksum dist/app.css)"
mv dist/app.css "dist/app.${appcss_checksum}.css"

cat js/init.js > dist/app.js
appjs_checksum="$(checksum dist/app.js)"
mv dist/app.js "dist/app.${appjs_checksum}.js"

cat html/index.html | yarn run -s handlebarsjs-cli --jeCss="${jecss_filename}" --jeCssChecksum="${jecss_checksum}" --jeJs="${jejs_filename}" --jeJsChecksum="${jejs_checksum}" --appCssChecksum="${appcss_checksum}" --appJsChecksum="${appjs_checksum}" --appHtml='roflcopter' > dist/index.html
