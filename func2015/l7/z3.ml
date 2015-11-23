type ('a, 'b) mem = MNil | MCons of 'a * 'b * ('a, 'b) mem;;

let m_empty = MNil;;

let rec m_find x = function
  | MNil -> None
  | MCons (x', y, t) -> if x = x' then Some y else m_find x t;;

let m_add mem x y = MCons (x, y, mem);;

let m_fun f =
  let mem = ref m_empty
  in let aux x = match m_find x !mem with
         None -> let y = f x
                 in (mem := m_add !mem x y;
                     y)
       | Some y -> y
     in aux;;

let rec fib n = match n with
  | 0 | 1 -> 1
  | _ -> fib (n - 1) + fib (n - 2);;

let fib_memo = m_fun fib;;

let m_fun' f =
  let mem = ref m_empty
  in let rec aux x = match (m_find x !mem) with
       | None -> let y = f x aux
                 in mem := m_add !mem x y;
                    y
       | Some y -> y
     in aux;;
  
let fib' n cont = match n with
  | 0 | 1 -> 1
  | _ -> cont (n - 1) + cont (n - 2);;

let fib_memo' = m_fun' fib';;

let benchmark f n =
  let start = Sys.time() and y = f n
  in (Sys.time() -. start, y);;

benchmark fib 38;;
    
benchmark fib_memo 38;;
  
benchmark fib_memo' 38;;
