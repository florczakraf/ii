type 'a llist = LNil | LCons of 'a * (unit -> 'a llist);;

let rec ltake i llst =
  match i, llst with
    0, _ -> []
  | _, LNil -> []
  | i, LCons(x, xs) -> x::ltake (i - 1) (xs ());;
  
let rec lfilter f = function
  | LNil -> LNil
  | LCons (x, xs) when f x -> LCons (x, fun () -> lfilter f (xs ()))
  | LCons (_, xs) -> lfilter f (xs ());;

let breadth_first next x =
  let rec aux = function
    | [] -> LNil
    | h::t -> LCons (h, fun () -> aux (t @ next h))
  in aux [x];;

let is_queen_safe oldqs newq =
  let rec nodiag = function
    | (i, []) -> true
    | (i, q::qs) -> abs(newq - q) <> i && nodiag (i + 1, qs)
  in not (List.mem newq oldqs) && nodiag (1, oldqs);;

let rec range a b =
  if a > b then []
  else a::(range (a + 1) b);;

let next_queen n qs =
  List.map (fun h -> h::qs) (List.filter (is_queen_safe qs) (range 1 n));;

let is_solution n qs = List.length qs = n;;

let breadth_queen n = lfilter (is_solution n) (breadth_first (next_queen n) []);;

List.length (ltake 100 (breadth_queen 8)) = 92;;
