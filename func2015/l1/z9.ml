let hd s =
  s 0;;

let tl s =
  fun (i: int) -> s (i + 1);;

let map f s =
  fun (i: int) -> f (s i);;

let add c =
  map ((+) c);;

let map2 f s1 s2 =
  fun (i: int) -> (f (s1 i)) (s2 i);;

let replace n a s =
  fun (i: int) -> if i mod n = 0 then a else s i;;

let take n s =
  fun (i: int) -> s (n * i);;

let fold a f s =
  fun (n: int) ->
    let acc = ref a
    in
      for i = 0 to n do
        acc := f !acc (s i)
      done;
      !acc;;

let rec tabulate ?(b = 0) e s =
  if b = e then []
  else (s b) :: tabulate ~b:(b + 1) e s;;

let rec tabulate' ?(b = 0) ?(a = []) e s =
  if b = e then a
  else tabulate' ~b:(b) ~a:(s (e - 1) :: a) (e - 1) s;;
  
let tab = tabulate';;

(* streams *)
let nats n = n;;
let evens n = 2 * n;;
let odds n = 2 * n + 1;;
let rec fibs n =
  match n with
    0 -> 1
  | 1 -> 1
  | _ -> fibs (n - 2) + fibs (n - 1);;

(* tests *)

1 = hd odds;;
[1;2;3;4;5] = tab 5 (tl nats);;
[0;3;6;9;12] = tab 5 (map ( ( * ) 3) nats);;
[2;4;6;8;10] = tab 5 (add 1 odds);;
[1;5;9;13;17] = tab 5 (map2 (+) evens odds);;
[17;1;2;17;4] = tab 5 (replace 3 17 nats);;
[1;2;5;13;34] = tab 5 (take 2 fibs);;
[0;1;3;6;10] = tab 5 (fold 0 (+) nats);;
[0;1;2;3;4] = tab 5 nats;;
[2;4;6;8;10] = tab ~b:1 6 evens;;

tabulate 10 fibs = tabulate' 10 fibs;;
