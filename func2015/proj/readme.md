Usage
---

* `./make.sh` - compile all modules
* `./make.sh clean` - delete compiled modules
* ~~`./make.sh install` - copy modules to ocaml directory~~ (TODO)


Notes
-----

In splay.ml all occurences of
```ocaml
let T.Node (l, v, r) = splay e !t in
```

are replaced with:

```ocaml
match splay e !t with
  T.Leaf -> assert false
| T.Node (l, v, r)
```


so there are no `pattern-matching is not exhaustive` warnings.
