#!/bin/sh

exec \
    emacs \
    -Q \
    --batch \
    --load "readme.el" \
    --eval "(render-then-write-markdown \"${1}\" \"${2}\")"
