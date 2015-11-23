type 'a list_mutable = LMnil | LMcons of 'a * 'a list_mutable ref;;

let rec concat_copy lm1 lm2 = match lm1 with
    LMnil -> lm2
  | LMcons (h, t) -> let tail = ref (concat_copy !t lm2)
                     in LMcons (h, tail);;

let concat_share lm1 lm2 =
  let rec aux lm1 lm2 = match lm1 with
      LMnil -> ()
    | LMcons (h, t) -> if !t = LMnil then t := lm2
                       else aux !t lm2
  in aux lm1 lm2;;

(* testy *)


let l1 = LMcons (1, ref (LMcons (2, ref (LMcons (3, ref (LMcons (4, ref LMnil)))))));;
let l2 = LMcons (5, ref (LMcons (6, ref (LMcons (6, ref (LMcons (7, ref LMnil)))))));;

let l3 = concat_copy l1 l2;;

concat_share l1 l2;;

l1 = l3;;
