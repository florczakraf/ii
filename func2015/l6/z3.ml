type 'a btree = Leaf | Node of 'a btree * 'a * 'a btree;;
type 'a array = Array of int * 'a btree;;

let aempty = Array (0, Leaf);;

let asub (Array (m, t)) i =
  if i < 1 || i > m then failwith "index out of range"
  else let rec aux i (Node (l, n, r)) =
         if i = 1 then n
         else let half = i / 2
              in if i mod 2 = 0 then aux half l
                 else aux half r
       in aux i t;;

let aupdate (Array (m, t)) i v =
  if i < 1 || i > m then failwith "index out of range"
  else let rec aux (Node (l, n, r)) i =
         if i = 1 then Node (l, v, r)
         else let half = i / 2 in
              if i mod 2 = 0 then Node (aux l half, n, r)
              else Node (l, n, aux r half)
       in Array (m, aux t i);;

let ahiext (Array (m, t)) v =
  if m = 0 then Array (1, Node (Leaf, v, Leaf))
  else let rec aux t i =
         if i = 1 then Node (Leaf, v, Leaf)
         else let half = i / 2 and Node (l, n, r) = t
              in if i mod 2 = 0 then Node (aux l half, n, r)
                 else Node (l, n, aux r half)
       in Array ((m + 1), aux t (m + 1));;

let ahirem (Array (m, t)) =
  let rec aux (Node (l, n, r)) i =
    if i = 1 then Leaf
    else let half = i/2
         in if i mod 2 = 0 then Node (aux l half, n, r)
            else Node (l, n, aux r half)
  in Array ((m - 1), aux t m);;

  
(* testy *)

let a0 = aempty;;
let a1 = ahiext a0 1;;
let a2 = ahiext a1 6;;
let a3 = ahiext a2 2;;
let a4 = ahiext a3 42;;
let a5 = ahiext a4 13;;
let a6 = ahiext a5 5;;

let elem3 = asub a6 3;;

let upd3 = aupdate a6 3 0;;

ahirem a6 = a5;;
ahirem a1 = aempty;;

  
