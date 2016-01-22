## Modules

##### AVL (avl.ml)
Implements: `empty`, `depth`, `is_empty`, `insert`, `delete`, `search`, `min`, `max`, `to_bintree` 

##### BST (bst.ml)
Implements: `empty`, `depth`, `is_empty`, `insert`, `delete`, `search`, `min`, `max`, `to_bintree`

##### Heap (heap.ml)
Implements: `empty`, `is_empty`, `insert`, `delete_min`, `min`, `to_bintree`

##### Red-black (rb.ml)
Implements: `empty`, `depth`, `is_empty`, `insert`, `delete`, `search`, `min`, `max`, `to_bintree`

##### Splay (splay.ml)
Implements: `empty`, `is_empty`, `insert`, `delete`, `search`, `min`, `max`, `to_bintree`


## Usage

* `./make.sh` -- compile all modules
* `./make.sh clean` -- delete compiled files
* `./make.sh test` -- compile and run all test files (some tests are interactive -- so you can see how tree changes after each operation)

To use any of these modules you have to include
```ocaml
open MODULE_NAME;;
open Comparable;;
open Bintree;;
```
in your code. Then create instance of `COMPARABLE` module. For example:
```ocaml
module Int : COMPARABLE with type t = int =
struct
  type t = int

  let cmp = compare
  let str = string_of_int
end;;
```
After that create `Bintree` module with `COMPARABLE`:
```ocaml
module Bint = Bintree(Int);;
```
And finally create desired module. For example:
```ocaml
module A = Avl(Bint);;
```

## Notes

In `splay.ml` all occurences of
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
