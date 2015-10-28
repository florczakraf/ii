let swap_rev (k, kth) (l, lth) lst =
  let rec aux acc i lst =
    match i = k, i = l with
      _, true -> aux (kth::acc) (i + 1) (List.tl lst)
    | true, _ -> acc @ (lth::(List.tl lst))
    | _, _ -> aux ((List.hd lst)::acc) (i + 1) (List.tl lst)
  in aux [] 0 lst;;

let next_permutation ?(cmp = (<)) lst =
  let k =
    let rec aux i lst =
      match lst with
        [] | [_] -> -1
      | h::h2::lst -> if cmp h2 h then (i + 1)
                      else aux (i + 1) (h2::lst)
    in aux 0 lst
  in if k = -1 then List.rev lst
     else let kth = List.nth lst k
          in let l =
               let rec aux i lst =
                 if cmp kth (List.hd lst) then i
                 else aux (i + 1) (List.tl lst)
               in aux 0 lst
             in swap_rev (k, kth) (l, List.nth lst l) lst;;

let perms ?(cmp = (<)) lst =
  let rec aux acc perm =
    if perm = lst then acc
    else aux (perm::acc) (next_permutation ~cmp: cmp  perm)
  in aux [lst] (next_permutation ~cmp: cmp lst);;

let nxt = next_permutation;;
  
nxt [3;4;2;1];;
nxt ['b';'c';'a'];;
permutations [1;2;3];;

    
