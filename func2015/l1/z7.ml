fun (x:int) -> x;;

let f f1 f2 x = f1 (f2 x);;
let rec f x = f x;;
