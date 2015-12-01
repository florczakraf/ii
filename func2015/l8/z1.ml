module type PQUEUE =
sig
  type priority
  type 'a t
          
  exception EmptyPQueue
              
  val empty : 'a t
  val insert : 'a t -> priority -> 'a -> 'a t
  val remove : 'a t -> priority * 'a * 'a t
end

module PQueue : PQUEUE with type priority = int =
  struct
    type priority = int;;
    type 'a t = ('a * priority) list;;
    exception EmptyPQueue;;

    let empty = [];;
    let insert q p x =
      let rec aux qs =
        match qs with
          [] -> [(x, p)]
        | (h, hp)::qs' -> if p >= hp then (x, p)::qs
                          else (h, hp)::(aux qs')
      in aux q;;


    let remove = function
      | [] -> raise EmptyPQueue
      | (x, p)::qs -> (p, x, qs);;    
  end;;


let list_of_pq qs =
  let rec aux acc qs = try let (p, x, qs') = PQueue.remove qs
                           in aux (x::acc) qs'
                       with
                         PQueue.EmptyPQueue -> acc
  in aux [] qs;;
  
let sort (xs:int list) =
  let insert p x q = PQueue.insert q p x
  in let xsp = List.map (fun x -> (x, x)) xs
     in let q = List.fold_left (fun acc (x, p) -> insert p x acc) PQueue.empty xsp
        in ((list_of_pq q):int list);;
  
module type ORDTYPE =
  sig
    type t
    val compare: t -> t -> int
  end;;

module OrdPQueue (OrdType: ORDTYPE) : PQUEUE
       with type priority = OrdType.t =
         struct
           type priority = OrdType.t;;
           type 'a t = ('a * priority) list;;
           exception EmptyPQueue;;
             
           let empty = [];;
             
           let insert q p x =
             let rec aux qs =
               match qs with
                 [] -> [(x, p)]
               | (h, hp)::qs' -> if p >= hp then (x, p)::qs
                                 else (h, hp)::(aux qs')
             in aux q;;
             
           let remove = function
             | [] -> raise EmptyPQueue
             | (x, p)::qs -> (p, x, qs);;

         end;;

let sort' xs =
  let module IntOrder: ORDTYPE with type t = int =
        struct
          type t = int
          let compare a b = b - a
        end
  in let module PQ = OrdPQueue(IntOrder)
     in let rec list_of_pq acc qs = try let (p, x, qs') = PQ.remove qs
                                        in list_of_pq (x::acc) qs'
                                    with
                                      PQ.EmptyPQueue -> acc
        in let insert p x q = PQ.insert q p x
           in let xsp = List.map (fun x -> (x, x)) xs
              in let q = List.fold_left (fun acc (x, p) -> insert p x acc) PQ.empty xsp
                 in list_of_pq [] q;;
                                                 

sort [1;6;23;-6;2;1;1;1] = [-6; 1; 1; 1; 1; 2; 6; 23];;
sort' [1;6;23;-6;2;1;1;1] = [-6; 1; 1; 1; 1; 2; 6; 23];;
  
