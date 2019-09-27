#!/usr/bin/env bash
set -ex
pandoc --to markdown_github-raw_html --wrap=none README.md > README.md.new
mv README.md.new README.md
