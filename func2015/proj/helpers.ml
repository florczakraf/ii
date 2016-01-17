let assert_failure stmnt =
  try stmnt ();false with
    Failure _ -> true;;

let test_failure desc stmnt =
  print_string desc;
  let res = assert_failure stmnt
  in match res with
       true -> print_endline (" -> OK"); res
     | _ -> print_endline (" -> FAIL"); res
  
let test_assert desc stmnt =
  print_string desc;
  match stmnt with
    true -> print_endline (" -> OK"); stmnt
  | _ -> print_endline (" -> FAIL"); stmnt

let test_assert_false desc stmnt =
  print_string desc;
  match stmnt with
    false -> print_endline (" -> OK"); not stmnt
  | _ -> print_endline (" -> FAIL"); not stmnt

                                       
let test_equals desc a b =
  print_string desc;
  match a = b with
    true -> print_endline (" -> OK"); true
  | _ -> print_endline (" -> FAIL"); false
