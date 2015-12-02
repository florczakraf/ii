module type VERTEX =
sig
  type t
  type label
         
  val equal : t -> t -> bool
  val create : label -> t
  val label : t -> label
end;;

module Vertex : VERTEX with type label = int =
struct
  type label = int
  type t = {l : label}

  let equal v1 v2 = v1 = v2
  let create l = {l = l}
  let label v = v.l
end;;

module type EDGE =
sig
  type t  
  type label
  type vertex

  val equal : t -> t -> bool
  val create : label -> vertex -> vertex -> t
  val label : t -> label
  val get_start : t -> vertex
  val get_end : t -> vertex
end;;

module Edge (V : VERTEX) : (EDGE with type vertex = V.t and type label = int) =
struct
  type vertex = V.t
  type label = int
  type t = {l : label; a : vertex; b : vertex}

  let equal e1 e2 = e1 = e2
  let label e = e.l
  let create l a b = {l = l; a = a; b = b}
  let get_start e = e.a
  let get_end e = e.b
end;;
  
module type GRAPH =
sig
  (* typ reprezentacji grafu *)
  type t

  module V : VERTEX
  type vertex = V.t

  module E : EDGE with type vertex = vertex

  type edge = E.t

  (* funkcje wyszukiwania *)
  val mem_v : t -> vertex -> bool
  val mem_e : t -> edge -> bool
  val mem_e_v : t -> vertex -> vertex -> bool
  val find_e : t -> vertex -> vertex -> edge
  val succ : t -> vertex -> vertex list
  val pred : t -> vertex -> vertex list
  val succ_e : t -> vertex -> edge list
  val pred_e : t -> vertex -> edge list

  (* funkcje modyfikacji *) 
  val empty : t
  val add_e : t -> edge -> t
  val add_v : t -> vertex -> t
  val rem_e : t -> edge -> t
  val rem_v : t -> vertex -> t

  (* iteratory *)
  val fold_v : (vertex -> 'a -> 'a) -> t -> 'a -> 'a
  val fold_e : (edge -> 'a -> 'a) -> t -> 'a -> 'a
end;;
  
module Graph (V : VERTEX) (E : EDGE with type vertex = V.t and type label = int) : (GRAPH with module V = V and module E = E) =
struct
  module V = V
  module E = E

  type edge = E.t
  type vertex = V.t

  type t = {edges : edge list; verts : vertex list}

  let mem_v g v = List.exists (V.equal v) g.verts
  let mem_e g e = List.exists (E.equal e) g.edges
  let mem_e_v g a b = List.exists (fun e -> E.get_start e = a && E.get_end e = b) g.edges
  let find_e g a b = List.find (fun e -> E.get_start e = a && E.get_end e = b) g.edges
  let succ g v = List.filter (mem_e_v g v) g.verts
  let pred g v = List.filter (fun v2 -> mem_e_v g v2 v) g.verts
  let succ_e g v = List.fold_left (fun acc x -> (find_e g v x)::acc) [] (succ g v)
  let pred_e g v = List.fold_left (fun acc x -> (find_e g x v)::acc) [] (pred g v)

  let empty = {edges = []; verts = []}
  let add_v g v = {edges = g.edges; verts = v::g.verts}
  let add_e g e = {edges = e::g.edges; verts = g.verts}
  let rem_v g v = {edges = g.edges; verts = List.filter (fun v' -> not (V.equal v v')) g.verts}
  let rem_e g e = {edges = List.filter (fun e' -> not (E.equal e e')) g.edges; verts = g.verts}

  let fold_v f g v = List.fold_right f g.verts v
  let fold_e f g e = List.fold_right f g.edges e
end;;

module V = Vertex;;
module E = Edge(Vertex);;
module G = Graph(Vertex)(E);;
  
let bfs (type t) (type v) (type l) (module G : GRAPH with type t = t and type V.t = v and type V.label = l) g s =
  let rec aux acc q =
    match q with
      [] -> List.rev_map (G.V.label) acc
    | h::t -> let succs = G.succ g h
              in let not_visited = List.filter (fun v -> not (List.mem v acc)) succs
                 in let acc' = if List.mem h acc then acc else h::acc
                    in aux acc' (t@not_visited)
  in aux [] [s];;

let dfs (type t) (type v) (type l) (module G : GRAPH with type t = t and type V.t = v and type V.label = l) g s =
  let rec aux acc stack =
    match stack with
      [] -> List.rev_map (G.V.label) acc
    | h::t -> let succs = G.succ g h
              in let not_visited = List.filter (fun v -> not (List.mem v acc)) succs
                 in let acc' = if List.mem h acc then acc else h::acc
                    in aux acc' (not_visited@t)
  in aux [] [s];;

(* testy *)
  
let v1 = G.V.create 1;;
let v2 = G.V.create 2;;
let v3 = G.V.create 3;;
let v4 = G.V.create 4;;
let v5 = G.V.create 5;;
let v6 = G.V.create 6;;

let e1 = G.E.create 1 v1 v2;;
let e2 = G.E.create 2 v2 v3;;
let e3 = G.E.create 3 v3 v1;;
let e4 = G.E.create 4 v3 v4;;
let e5 = G.E.create 5 v4 v5;;
let e6 = G.E.create 6 v2 v6;;

let g = G.empty;;
let g = G.add_v g v1;;
let g = G.add_v g v2;;
let g = G.add_v g v3;;
let g = G.add_v g v4;;
let g = G.add_v g v5;;
let g = G.add_v g v6;;
let g = G.add_e g e1;;
let g = G.add_e g e2;;
let g = G.add_e g e3;;
let g = G.add_e g e4;;
let g = G.add_e g e5;;
let g = G.add_e g e6;;

bfs (module G) g v2;;
dfs (module G) g v2;;
  
let v7 = G.V.create 7;;
let e7 = G.E.create 7 v1 v5;;
  
G.mem_v g v1 = true;;
G.mem_v g v7 = false;;
G.mem_e g e1 = true;;    
G.mem_e g e7 = false;;
G.mem_e_v g v1 v2 = true;;
G.mem_e_v g v1 v3 = false;;
G.find_e g v1 v2 = e1;;
G.find_e g v1 v5;; (* Not_found *)
List.map (G.V.label) (G.succ g v2);; (* [3;6] *)
List.map (G.V.label) (G.pred g v3);; (* [2] *)
G.mem_v (G.rem_v g v1) v1 = false;;
G.mem_e (G.rem_e g e1) e1 = false;;
G.fold_v (fun v acc -> (G.V.label v)::acc) g [];;
G.fold_e (fun e acc -> (G.E.label e)::acc) g [];;


  
