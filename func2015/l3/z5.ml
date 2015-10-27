let take n xs =
  let rec aux acc n xs =
    match n, xs with
      0, _     -> acc
    | _, []    -> acc
    | _, x::xs -> aux (x::acc) (n - 1) xs
  in List.rev (aux [] n xs);;

let rec drop n xs =
  match n, xs with
    0, _     -> xs
  | _, []    -> []
  | _, x::xs -> drop (n - 1) xs;;

let next_permutation ?(cmp = (<)) lst =
  let lst = List.rev lst
  in let k =
       let rec aux best i lst =
         match lst with
           h::h2::lst -> if cmp h h2 then aux i (i + 1) (h2::lst) else aux best (i + 1) (h2::lst)
         | _ -> best
       in aux (-1) 0 lst
     in if k = -1 then lst
        else let l =
               let lst = drop k lst
               in let kth = List.hd lst
                  in let rec aux best i lst =
                       match lst with
                         [] -> best
                       | h::lst -> if cmp kth h then aux i (i + 1) lst else aux best (i + 1) lst
                     in aux (k) (k) lst
             in let swap =
                  let kth = List.nth lst k
                  in let lth = List.nth lst l
                     in let rec aux acc i lst =
                          match lst with
                            [] -> List.rev acc
                          | h::lst -> if i = k then aux (lth::acc)  (i + 1) lst
                                      else if i = l then aux (kth::acc) (i + 1) lst
                                      else aux (h::acc) (i + 1) lst
                        in aux [] 0 lst
                in List.rev((take (k + 1) swap)@(List.rev(drop (k + 1) swap)));;

let fact n =
  let rec aux acc n =
    if n = 1 then acc
    else aux (acc * n) (n - 1)
  in aux 1 n;;

let perms ?(cmp = (<)) lst =
  let n = fact (List.length lst)
  in let rec aux acc i =
       if i = 0 then acc
       else aux ((next_permutation ~cmp:cmp (List.hd acc))::acc) (i - 1)
     in aux [lst] (n - 1);;

next_permutation [3;4;2;1];;
next_permutation [1;2;3;4];;
next_permutation ['b';'c';'a'];;
perms [3;2;1];;
