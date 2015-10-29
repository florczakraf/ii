let possible_pairs =
  let rec aux acc x y =
    if x = 50 then acc
    else if x + y < 100 && x + y + 1 <> 100 then aux ((x,y)::acc) x (y + 1)
    else aux ((x,y)::acc) (x + 1) (x + 2)
  in aux [] 2 3;;

let p n =
  List.filter (fun (x,y) -> x * y = n) possible_pairs;;

let s n =
  List.filter (fun (x,y) -> x + y = n) possible_pairs;;
  
let s1 n =
  match List.length (p n) with
    1 -> true
  | _ -> false;;

let s2 n =
  List.for_all (fun (x,y) -> not (s1 (x * y))) (s n);;
  
let s3 n =
  let rec aux flag = function
      [] -> flag
    | (x,y)::lst -> if flag && s2 (x + y) then false
                    else if s2 (x + y) then aux true lst
                    else aux flag lst
  in aux false (p n);;

let s4 n =
  let rec aux flag = function
      [] -> flag
    | (x,y)::lst -> if flag && s3 (x * y) then false
                    else if s3 (x * y) then aux true lst
                    else aux flag lst
  in aux false (s n);;

let solve =
  let rec aux = function
      [] -> (-1,-1)
    | (x,y)::lst -> if not (s1 (x * y)) && s2 (x + y) && s3 (x * y) && s4 (x + y) then (x, y)
                    else aux lst
  in aux possible_pairs;;

