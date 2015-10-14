fun x y -> x + y;;
let plus x y = x + y;;
let plus x = fun y -> x + y;;
let plus = fun x -> fun y -> x + y;;
let plus3 = plus 3;;
plus3 5;;
