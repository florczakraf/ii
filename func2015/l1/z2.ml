if true then 4 else 5;;
  (* int *)
if false then 1 else 3.5;;
  (* err  *)
4.75 + 2.34;;
  (* err  *)
false || "ab" > "cd";;
(* bool *)
if true then ();;
(* ()  *)
if false then () else 4;;
(* err  *)
let x = 2 in x^"aa";;
(* err  *)
let y = "abc" in y^y;;
(* string  *)
(fun x -> x.[1]) "abcdef";;
(* char  *)
(fun x -> x) true;;
(* bool  *)
let x = [1; 2] in x@x;;
(* int list  *)
let rec f f = f + f in f 42;;
(* int  *)
