type 'a llist = LNil | LCons of 'a * (unit -> 'a llist);;

let lhd = function
  | LNil -> failwith "lhd"
  | LCons (x, _) -> x;;

let ltl = function
  | LNil -> failwith "ltl"
  | LCons (_, xs) -> xs ();;

let rec lfrom k = LCons (k, fun () -> lfrom (k + 1));;

let rec ltake i llst =
  match i, llst with
    0, _ -> []
  | _, LNil -> []
  | i, LCons(x, xs) -> x::ltake (i - 1) (xs ());;

let leibniz_pi =
  let rec aux acc = function
    | LNil -> failwith "?"
    | LCons (h, t) -> let sign = if h mod 2 = 0 then -1. else 1.
                      in let next = (acc +. sign *. 4. *. (1. /. (2. *. float_of_int h -. 1.)))
                         in LCons (next, fun () -> aux next (t ()))
  in LCons (4., fun () -> aux 4. (lfrom 2));;

let rec apply f = function
  | LNil -> LNil
  | LCons (x, xs) -> let xs = xs ()
                     in let LCons (y, ys) = xs
                        in let LCons (z, zs) = ys ()
                           in LCons(f x y z, fun () -> apply f xs);;



let euler_pi =
  let transform x y z =
    let yz = y -. z
    in z -. yz *. yz /. (x -. 2. *. y +. z)
  in apply transform leibniz_pi;;
  
ltake 5 leibniz_pi;;
ltake 5 euler_pi;;

(* lazy, force *)
type 'a llist = LNil | LCons of 'a * 'a llist Lazy.t;;

let rec lfrom k = LCons (k, lazy (lfrom (k + 1)));;

let rec ltake i llst =
  match i, llst with
    0, _ -> []
  | _, LNil -> []
  | i, LCons (x, lazy xs) -> x::ltake (i - 1) xs;;

let leibniz_pi =
  let rec aux acc = function
    | LNil -> failwith "?"
    | LCons (h, lazy t) -> let sign = if h mod 2 = 0 then -1. else 1.
                           in let next = (acc +. sign *. 4. *. (1. /. (2. *. float_of_int h -. 1.)))
                              in LCons (next, lazy (aux next t))
  in LCons (4., lazy (aux 4. (lfrom 2)));;

let rec apply f = function
  | LNil -> LNil
  | LCons (x, lazy xs) -> let LCons (y, lazy ys) = xs
                          in let LCons (z, lazy zs) = ys
                             in LCons (f x y z, lazy (apply f xs));;

let euler_pi =
  let transform x y z =
    let yz = y -. z
    in z -. yz *. yz /. (x -. 2. *. y +. z)
  in apply transform leibniz_pi;;
  
ltake 5 leibniz_pi;;
ltake 5 euler_pi;;
