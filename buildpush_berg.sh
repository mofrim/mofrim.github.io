#!/usr/bin/env bash

rm -rf public
zola build
cd public
git init && git add . && git commit -m "update page"
git remote add berg berg:mofrim/pages.git
git push -u berg main --force
