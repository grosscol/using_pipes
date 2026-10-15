#!/usr/bin/env sh

# Run from project root directory to create index.html
pandoc -t revealjs --template=pandoc-templates/default.revealjs \
  -o index.html  --slide-level=2 \
  -V revealjs-url=reveal.js  -V theme=dracula slides/*.md \
  -V date=$(date '+%Y-%m-%d')

echo "index.html built $(date)"
