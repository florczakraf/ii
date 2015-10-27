let horner x coeffs =
  let rec aux acc = function
      []        -> acc
    | c::coeffs -> aux (x *. acc +. c) coeffs
  in
  aux 0. coeffs;;

let horner' x coeffs =
  List.fold_left (fun acc coef -> x *. acc +. coef) 0. coeffs;;

  
horner 2. [1.;0.;-1.;2.];;
horner' 2. [1.;0.;-1.;2.];;
