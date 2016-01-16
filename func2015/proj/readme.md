All `let T.Node (l, v, r) = splay e !t in` are replaced with:

`
match splay e !t with
  T.Leaf -> assert false
| T.Node (l, v, r)

`

so there are no `pattern-matching is not exhaustive` warnings.
