let horner2 x coeffs =
  let rec aux coeffs =
    match coeffs with
      []        -> 0.
    | c::[]     -> c
    | c::coeffs -> x *. (aux coeffs) +. c
  in
  aux coeffs;;

let horner2' x coeffs =
  List.fold_right (fun coef acc -> x *. acc +. coef) coeffs 0.;;

  
horner2 2. [1.;0.;-1.;2.];;
horner2' 2. [1.;0.;-1.;2.];;
