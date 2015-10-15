fun x y -> x + y;;
let plus x y = x + y;;
let plus x = fun y -> x + y;;
let plus = fun x -> fun y -> x + y;;
let plus_3 = plus 3;;
plus_3 5;;
