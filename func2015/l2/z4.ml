(* zadanie 4. *)

let rec merge cmp xs ys =
  match xs, ys with
    [], _        -> ys
  | _, []        -> xs
  | x::xs, y::ys -> if cmp x y then x::(merge cmp xs (y::ys))
                    else y::(merge cmp (x::xs) ys);;
  
(* merge' jest ogonowa ale dziala nieefektywnie, bo doklada pojedyncze el. na koniec akumulatora, ponizej znajduje sie merge'', ktory dziala dobrze *)

let rec merge' ?(acc = []) cmp xs ys =
  match xs, ys with
    [], _        -> acc@ys
  | _, []        -> acc@xs
  | x::xs, y::ys -> if cmp x y then merge' ~acc:(acc@[x]) cmp xs (y::ys)
                    else merge' ~acc: (acc@[y]) cmp (x::xs) ys;;

let merge'' cmp xs ys =
  let rec aux acc xs ys =
    match xs, ys with
      [], []       -> acc
    | [], y::ys    -> aux (y::acc) [] ys
    | x::xs, []    -> aux (x::acc) xs []
    | x::xs, y::ys -> if cmp x y then aux (x::acc) xs (y::ys)
                      else aux (y::acc) (x::xs) ys
  in List.rev (aux [] xs ys);;

(* funkcje pomocnicze do mergesorta *)
let take n xs =
  let rec aux acc n xs =
    match n, xs with
      0, _     -> acc
    | _, []    -> acc
    | _, x::xs -> aux (x::acc) (n - 1) xs
  in List.rev (aux [] x xs);;

let rec drop n xs =
  match n, xs with
    0, _     -> xs
  | _, []    -> []
  | _, x::xs -> drop (n - 1) xs;;

let halve xs =
  let half = (List.length xs) / 2
  in (take half xs, drop half xs);;

let rec mergesort cmp xs =
  match xs with
    []  -> []
  | [x] -> [x]
  | _   -> let (l, r) = halve xs
           in merge'' cmp (mergesort cmp l) (mergesort cmp r);;

(* porownanie dzialania merge'ow *)

let rec tabulate ?(b = 0) ?(a = []) e s =
  if b = e then a
  else tabulate ~b:(b) ~a:(s (e - 1) :: a) (e - 1) s;;

let evens n = 2 * n;;
let odds n = 2 * n + 1;;

(* wersja nieogonowa nie radzi sobie z dlugimi listami (stack overflow) *)
merge (<=) (tabulate 100000 evens) (tabulate 100000 odds);;
(* w tej wersji nie doczekalem sie wyniku *)    
merge' (<=) (tabulate 100000 evens) (tabulate 100000 odds);;
(* a ta dziala szybko *)
merge'' (<=) (tabulate 100000 evens) (tabulate 100000 odds);;
