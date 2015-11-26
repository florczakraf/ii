type 'a list_mutable = LMnil | LMcons of 'a * 'a list_mutable ref;;

let rec concat_copy lm1 lm2 = match lm1 with
    LMnil -> lm2
  | LMcons (h, t) -> let tail = ref (concat_copy !t lm2)
                     in LMcons (h, tail);;

let concat_share lm1 lm2 =
  let rec aux l1 l2 = match l1 with
      LMnil -> l2
    | LMcons (h, t) -> if !t = LMnil then (t := l2;
					   lm1)
                       else aux !t l2
  in aux lm1 lm2;;

(* testy *)


let l1 = LMcons (1, ref (LMcons (2, ref (LMcons (3, ref (LMcons (4, ref LMnil)))))));;
let l2 = LMcons (5, ref (LMcons (6, ref (LMcons (6, ref (LMcons (7, ref LMnil)))))));;

let l3 = concat_copy l1 l2;;

concat_share l1 l2;;

l1 = l3;;

let l4 = LMnil;;
let l5 = LMcons (1, ref LMnil);;

concat_share l4 l5;;
