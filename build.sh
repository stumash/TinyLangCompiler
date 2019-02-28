#!/usr/bin/env bash

THIS_DIR="$(dirname "$(readlink -f "$0")")"
cd "${THIS_DIR}/src"

ocamlbuild -use-menhir -menhir 'menhir --explain' main_scan.native
ocamlbuild -use-menhir -menhir 'menhir --explain' main_tokens.native
ocamlbuild -use-menhir -menhir 'menhir --explain' main_parse.native
