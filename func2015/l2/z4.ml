let rec merge cmp a b =
  match a, b with
    [], _            -> b
  | _, []            -> a
  | x :: xs, y :: ys -> if cmp x y then x :: (merge cmp xs (y :: ys))
                        else y :: (merge cmp (x :: xs) ys);;

let rec merge' ?(acc=[]) cmp a b =
  match a, b with
    [], _        -> acc @ b
  | _, []        -> acc @ a
  | x::xs, y::ys -> if cmp x y then merge' ~acc: (acc @ [x]) cmp xs (y :: ys)
                    else merge' ~acc: (acc @ [y]) cmp (x :: xs) ys;;

let rec take n xs =
  match n, xs with
    0, _       -> []
  | _, []      -> []
  | _, x :: xs -> x :: take (n - 1) xs;;

let rec drop n xs =
  match n, xs with
    0, _       -> xs
  | _, []      -> []
  | _, x :: xs -> drop (n - 1) xs;;

let div xs =
  let half = (List.length xs) / 2
  in (take half xs, drop half xs);;

let rec mergesort cmp xs =
  match xs with
    []  -> []
  | [x] -> [x]
  | _   -> let (l, r) = div xs
           in merge' cmp (mergesort cmp l) (mergesort cmp r);;

merge (<=) [3;4;5] [1;2;8];;
merge' (<=) [3;4;5] [1;2;8];;
mergesort (<=) [6;3;6;33;2;-4];;
