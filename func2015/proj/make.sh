#!/bin/bash

if [[ $1 = "clean" ]]; then
  rm *.cm*
elif [[ $1 = "test" ]]; then
  for module in avl bst heap rb splay
  do
    ./test_$module.o
  done
else
  # base
  ocamlc -c comparable.mli
  ocamlc -c bintree.ml
  ocamlc -c draw.ml
  ocamlc -c helpers.ml
  # modules
  for module in avl bst heap rb splay
  do
    ocamlc -c $module.ml
    ocamlc graphics.cma draw.cmo bintree.cmo $module.cmo helpers.cmo test_$module.ml -o test_$module.o
  done

#  ocamlc graphics.cma draw.cmo bintree.cmo avl.cmo test_avl.ml -o test_avl.o
fi
