#!/bin/bash

if [[ $1 = "clean" ]]; then
    rm *.cm*
    rm *.o
elif [[ $1 = "test" ]]; then
    for module in avl bst heap rb splay
    do
        if [ -f $module.cmo ]; then
            ./test_$module.o
        else
            echo "Please compile libraries first with: ./make.sh"
            exit
        fi
    done
else
    # base
    ocamlc -c comparable.mli; echo "Compiling comparable.mli"
    ocamlc -c bintree.ml; echo "Compiling bintree.ml"
    ocamlc -c draw.ml; echo "Compiling draw.ml"
    ocamlc -c helpers.ml; echo "Compiling helpers.ml"
    # modules
    for module in avl bst heap rb splay
    do
        ocamlc -c $module.ml
        ocamlc graphics.cma draw.cmo bintree.cmo $module.cmo helpers.cmo test_$module.ml -o test_$module.o
        echo "Compiling $module.ml and its test."
    done
fi
