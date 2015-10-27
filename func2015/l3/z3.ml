let derivative coeffs =
  let rec aux coeffs n =
    match coeffs with
      c::[]     -> [n *. c]
    | c::coeffs -> (n *. c)::(aux coeffs (n +. 1.))
  in
  match coeffs with
    [_]       -> [0.]
  | _::coeffs -> aux coeffs 1.;;

let derivative' = function
    [_] -> [0.]
  | coeffs -> tl (mapi (fun i c -> c *. float_of_int i) coeffs);;
  
derivative [1.;0.;-1.;2.];;
derivative' [1.;0.;-1.;2.];;
derivative' [12323.];;
