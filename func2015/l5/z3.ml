type 'a llist = LNil | LCons of 'a * (unit -> 'a llist);;

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

let queen n =
  let rec aux qs =
    if is_solution n qs then [qs]
    else List.fold_left (fun acc x -> (aux x) @ acc) [] (next_queen n qs)
  in aux [];;

List.length (queen 5) = 10;;
List.length (queen 8) = 92;;
    
