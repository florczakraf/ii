let fix f =
  let rec fixf x = f fixf x
  in fixf;;

let fact = fix (fun f n -> if n = 0 then 1 else n * f (n - 1));;

fact 1 = 1;;
fact 2 = 2;;
fact 4 = 24;;

(* wersja bez jawnej rekurencji *)
      

let fact' n =
  let f = ref (fun n -> n)
  in f := (fun n -> if n = 0 then 1 else n * (!f (n - 1)));
     !f n;;

fact' 1 = 1;;
fact' 2 = 2;;
fact' 4 = 24;;


let fix' f =
  let fixf = ref (fun x -> x)
  in fixf := (fun x -> f !fixf x);
     !fixf;;


let fact'' = fix' (fun f n -> if n = 0 then 1 else n * f (n - 1));;

fact'' 1 = 1;;
fact'' 2 = 2;;
fact'' 4 = 24;;
