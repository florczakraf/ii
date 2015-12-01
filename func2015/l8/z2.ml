module type VERTEX =
sig
  type t
  type label
         
  val equal : t -> t -> bool
  val create : label -> t
  val get_label : t -> label
end;;

module Vertex : VERTEX with type label = int =
struct
  type label = int
  type t = {l : label}

  let equal {l = l1} {l = l2} = l1 = l2
  let create l = {l = l}
  let get_label {l = l} = l
end;;

module type EDGE =
sig
  type t  
  type label
  type vertex

  val equal : t -> t -> bool
  val create : label -> vertex -> vertex -> t
  val get_label : t -> label
  val get_start : t -> vertex
  val get_end : t -> vertex
end;;

module Edge (V : VERTEX) : (EDGE with type vertex = V.t and type label = int) =
struct
  type vertex = V.t
  type label = int
  type t = {l : label; a : vertex; b : vertex}

  let equal {a = a1; b = b1} {a = a2; b = b2} = V.equal a1 a2 && V.equal b1 b2

  let get_label {l = l} = l

  let create l a b = {l = l; a = a; b = b}

  let get_start {a = a} = a

  let get_end {b = b} = b
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
  
module Graph (VER : VERTEX) (EDG : EDGE with type vertex = VER.t and type label = int) : (GRAPH with module V = VER and module E = EDG) =
struct
  module V = VER
  module E = EDG

  type edge = E.t
  type vertex = V.t

  type t = {edges : edge list; verts : vertex list}

  let mem_v g v = List.exists (V.equal v) g.verts;;
  let mem_e g e = List.exists (E.equal e) g.edges;;
  let mem_e_v g a b = List.exists (fun e -> E.get_start e = a && E.get_end e = b) g.edges
  let find_e g a b = List.hd (List.filter (fun e -> E.get_start e = a && E.get_end e = b) g.edges);;
  let succ g v = List.filter (mem_e_v g v) g.verts;;
  let pred g v = List.filter (fun v2 -> mem_e_v g v2 v) g.verts;;
  let succ_e g v = List.fold_left (fun acc x -> (find_e g v x)::acc) [] (succ g v);;
  let pred_e g v = List.fold_left (fun acc x -> (find_e g x v)::acc) [] (pred g v);;


  let empty = {edges = []; verts = []};;
  let add_v g v = {edges = g.edges; verts = v::g.verts};;
  let add_e g e = {edges = e::g.edges; verts = g.verts};;
  let rem_v g v = {edges = g.edges; verts = List.filter (fun v' -> not (V.equal v v')) g.verts};;
  let rem_e g e = {edges = List.filter (fun e' -> not (E.equal e e')) g.edges; verts = g.verts};;

  let fold_v f g v = List.fold_right f g.verts v;;         
  let fold_e f g e = List.fold_right f g.edges e;;
                                  
end;;


(* testy *)
(* TODO *)
  
module E = Edge(Vertex);;
module G = Graph(Vertex)(E);;
  
let v1 = Vertex.get_label (Vertex.create 1);;
