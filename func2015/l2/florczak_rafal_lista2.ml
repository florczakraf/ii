(* zadanie 1. *)

(* Nie potrafie napisac wersji bez generowania nieuzytkow *)

let rec sublists xs =
  match xs with
    []    -> [[]]
  | x::xs -> (List.map (fun xs -> x::xs) (sublists xs)) @ (sublists xs);;

sublists [1;2;3];;

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
      
(* zadanie 3. *)

let rec replace_nth (xs, i, r) =
  match xs with
    []      -> []
  | x::xs -> match i with
               0 -> r::xs
             | _ -> x::replace_nth (xs, i - 1, r);;

replace_nth ([1;2;3], 1, 5);;

(* zadanie 4. *)

let rec merge cmp xs ys =
  match xs, ys with
    [], _        -> ys
  | _, []        -> xs
  | x::xs, y::ys -> if cmp x y then x::(merge cmp xs (y::ys))
                    else y::(merge cmp (x::xs) ys);;
  
(* merge' jest ogonowa ale dziala nieefektywnie, bo doklada pojedyncze el. na koniec akumulatora przy uzyciu @; nizej znajduje sie merge'', ktory dziala dobrze *)

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

(* zadanie 5. *)

(* permutacje uzyskuje przez doczepienie do elementu wszystkich permutacji listy o 1 krotszej (tj. bez tego elementu) *)
let rec permutations xs =
  match xs with
    []    -> []
  | x::[] -> [[x]]
  | xs    -> List.fold_left (fun acc x -> acc @ List.map (fun perm -> x::perm) (permutations (List.filter ((<>) x) xs))) [] xs;;
  
permutations [1;2;3];;

(* zadanie 6. *)

let suffixes xs =
  let rec aux acc xs =
    match xs with
      []    -> acc
    | x::xs -> aux ((x::xs)::acc) xs
  in
  List.rev (aux [] xs);;

let prefixes xs =
  let rec aux acc xs =
    match xs with
      []    -> acc
    | x::xs -> aux (((List.hd acc)@[x])::acc) xs
  in
  match xs with
    []    -> []
  | x::xs ->  List.rev (aux [[x]] xs);;
  
suffixes [1;2;3];;
prefixes [1;2;3];;

