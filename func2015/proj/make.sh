#!/bin/bash

if [[ $1 = "clean" ]]; then
  rm *.cm*
else
  # base
  ocamlc -c comparable.mli
  ocamlc -c bintree.ml
  ocamlc -c draw.ml
  # modules
  for module in avl bst heap rb splay
  do
    ocamlc -c $module.ml
    ocamlc graphics.cma draw.cmo bintree.cmo $module.cmo test_$module.ml -o test_$module.o
  done

#  ocamlc graphics.cma draw.cmo bintree.cmo avl.cmo test_avl.ml -o test_avl.o
fi
