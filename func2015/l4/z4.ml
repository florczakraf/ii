(* zadanie 4. *)
(* rozwiązałem tylko dwa pierwsze podpunkty *)

type formula =
  | Var of char
  | Not of formula
  | And of formula * formula
  | Or of formula * formula;;

type taut_result = True | False of (char * bool) list;;
  
let uniq lst = List.fold_left (fun acc e -> if List.mem e acc then acc else e::acc) [] lst;;
  
let extract_vars f =
  let rec aux acc = function
    | Var v -> v::acc
    | Not f -> aux acc f
    | And (f1, f2) -> aux (aux acc f2) f1
    | Or (f1, f2) -> aux (aux acc f2) f1
  in uniq (aux [] f);;

let eval f vals =
  let rec aux = function
    | Var v -> List.assoc v vals
    | Not f -> not (aux f)
    | And (f1, f2) -> aux f1 && aux f2
    | Or (f1, f2) -> aux f1 || aux f2
  in aux f;;

let is_tautology f =
  let vars = extract_vars f
  in let rec aux vals = function
         [] -> if (eval f vals) then True else False vals
       | v::vars -> let val1 = aux ((v, true)::vals) vars
                    and val2 = aux ((v, false)::vals) vars
                    in match val1, val2 with
                         False vals, _ -> False vals
                       | _, False vals -> False vals
                       | True, True -> True
     in aux [] vars;;
  
let rec nnf = function
  | Var v -> Var v
  | Not f -> (match f with
                Var v -> Not (Var v)
              | Not f -> nnf f
              | And (f1, f2) -> Or (nnf (Not f1), nnf (Not f2))
              | Or (f1, f2) -> And (nnf (Not f1), nnf (Not f2)))
  | And (f1, f2) -> And (nnf f1, nnf f2)
  | Or (f1, f2) -> Or (nnf f1, nnf f2);;
  
(* testy *)
  
let f1 = Or (Var 'a', Not (Var 'b'));;
let taut = Not (Not (Or (Var 'a', Not (Var 'a'))));;
let f2 = Or (And (Var 'a', Var 'b'), Not (And (Var 'c', And (Var 'd', Var 'e'))));;
extract_vars f1 = ['b';'a'];;
is_tautology f1;;
is_tautology taut = True;;
nnf taut = Or (Var 'a', Not (Var 'a'));;
nnf f2 = Or (And (Var 'a', Var 'b'), Or (Not (Var 'c'), Or (Not (Var 'd'), Not (Var 'e'))));;


