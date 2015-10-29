let m_valid = [[2.;4.];
               [5.;8.]];;

let m_invalid = [[2.;4.;5.];
                 [5.;1.]];;

let m_valid2 = [[5.;9.];
                [7.;3.]];;
  
let validate m =
  let len = List.length m
  in List.for_all (fun row -> List.length row = len) m;;

let nth_column m n =
  List.map (fun row -> List.nth row n) m;;

let transpose m =
  List.mapi (fun i _ -> nth_column m i) m;;
  
let zip = List.combine;;
(* map2 (fun x y -> (x,y)) *)

let rec zipf f xs ys =
  List.map (fun (x, y) -> f x y) (zip xs ys);;

let mult_vec v m =
  List.map (fun row -> List.fold_left (+.) 0. (zipf ( *. ) v row)) (transpose m);;

let mult m1 m2 =
  List.map (fun vec -> mult_vec vec m2) m1;;


validate m_valid = true;;
validate m_invalid = false;;
nth_column m_valid 1 = [4.;8.];;
transpose m_valid = [[2.;5.];[4.;8.]];;
zip [1.;2.;3.] ["a";"b";"c"] = [(1.,"a");(2.,"b");(3.,"c")];;
zipf ( +. ) [1.;2.;3.] [4.;5.;6.] = [5.;7.;9.];;
mult_vec [1.;2.] [[2.;0.];[4.;5.]] = [10.;10.];;                           
mult m_valid m_valid2 = [[38.;30.];[81.;69.]];;
