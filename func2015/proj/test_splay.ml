open Splay;;
open Comparable;;
open Bintree;;
open Helpers;;
  
module Int : COMPARABLE with type t = int =
struct
  type t = int

  let cmp = compare
  let str = string_of_int
end;;

module Bint = Bintree(Int);;
module S = Splay(Bint);;

let graphics () =
  let s = S.empty ()
  in Draw.draw (module S) s; let s = S.insert 6 s
  in Draw.draw (module S) s; let s = S.insert 7 s
  in Draw.draw (module S) s; let s = S.insert 5 s
  in Draw.draw (module S) s; let s = S.insert 8 s
  in Draw.draw (module S) s; let s = S.insert 4 s
  in Draw.draw (module S) s; let s = S.insert 3 s
  in Draw.draw (module S) s; let s = S.insert 2 s
  in Draw.draw (module S) s; let s = S.insert 1 s
  in Draw.draw (module S) s;
  let s = S.delete 7 s
  in Draw.draw (module S) s


let operations () =
  print_endline "testing splay operations ->";
  let s = S.empty () in
  test_assert "  is_empty on empty" (S.is_empty s) &&
  test_equals "  depth on empty" (S.depth s) 0 &&
  test_equals "  delete on empty" (S.delete 3 s) s &&
  test_assert_false "  search on empty" (S.search 5 s) &&
  test_failure "  min on empty" (fun () -> S.min !s) &&
  test_failure "  max on empty" (fun () -> S.max !s) &&
  let s1 = S.insert 4 s in
  test_assert_false "  is_empty on nonempty" (S.is_empty s1) &&
  test_equals "  depth on nonempty" (S.depth s1) 1 &&
  let s2 = S.insert 6 s1 in
  let s3 = S.insert 7 s2 in
  test_assert_false "  nonexistent search" (S.search 8 s3) &&
  test_assert "  existent search" (S.search 4 s3) &&
  test_equals "  depth" (S.depth s3) 3 &&
  let s4 = S.delete 6 s3 in
  test_assert_false "  delete" (S.search 6 s4) &&
  test_equals "  min" (S.min !s3) 4 &&
  test_equals "  max" (S.max !s3) 7
        
let main () =
  assert (operations ());
  print_endline "Done. Time for drawing tests (any key to progress)..";
  graphics ()
    
let _ = main ()
 
