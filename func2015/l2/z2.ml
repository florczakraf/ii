(* zadanie 2. *)

let rec a n =
  match n with
    0 -> 1
  | 1 -> 2
  | _ -> 2 * a (n - 2) - a (n - 1) + 1;;

let rec a' ?(acc1 = 1) ?(acc2 = 2) ?(i = 0) n =
  let acc = 2 * acc1 - acc2 + 1
  in
  if i = n then acc1
  else a' ~acc1:acc2 ~acc2:acc ~i:(i + 1) n;; 

(* wersja nieogonowa wyrzuca stack overflow *)
a 500000;;
a' 500000;;
      
