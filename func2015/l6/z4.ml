let (++) arg1 arg2 = fun x -> arg1 (arg2 x);;

let lit l cont = fun s -> cont (s ^ l);;

let eol cont = fun s -> cont (s ^ "\n");;

let inr cont = fun s i -> cont (s ^ string_of_int i);;

let flt cont = fun s f -> cont (s ^ string_of_float f);;

let str cont = fun s s2 -> cont (s ^ s2);;

let sprintf dirs = dirs (fun x -> x) "";;

(* testy *)
  
let ala_ma n = sprintf (lit "Ala ma " ++ inr ++ lit " kot" ++ str ++ lit ".") n
                     (if n = 1 then "a" else if 1 < n && n < 5 then "y" else "ow");;

ala_ma 1;;
ala_ma 2;;
ala_ma 5;;
ala_ma 123;;

