#!/usr/bin/env bash

set -euo pipefail

emacs \
    -Q \
    --batch \
    --load "readme.el" \
    --eval "(render-then-write-markdown \"${1}\" \"${2}\")"
