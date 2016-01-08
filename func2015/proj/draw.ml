(*#load "graphics.cma";;*)
open Graphics;;
open Bintree;;

module type BINSTRUCT =
sig
  module T : BINTREE
  type t

  val to_bintree: t -> T.tree
end
                 
let draw (type e) (type tree) (type t) (module S : BINSTRUCT with type t = t and type T.E.t = e and type T.tree = tree) s =
  let rec power x n =
    if n = 0 then 1
    else let a = power x (n / 2)
         in if (n mod 2) = 0 then a * a
            else x * a * a
  in let rec draw_tree d tree =
       let (x, y) = (current_x (), current_y ())
       in let a = d - 2
          in let b = (power 2 a) * 10
             in let draw_node v =
                  draw_circle x y 5;
                  set_color blue;
                  moveto (x + 10) (y - 5);
                  draw_string (S.T.E.str v);
                  set_color black;
                  moveto x y;
                in match tree with
                     S.T.Leaf -> ()
                   | S.T.Node (S.T.Leaf, v, S.T.Leaf) -> draw_node v
                   | S.T.Node (l, v, S.T.Leaf) ->
                      begin
                        draw_node v;
                        lineto (x - 10) (y - 20);
                        draw_tree (d - 1) l;
                      end
                   | S.T.Node (S.T.Leaf, v, r) ->
                      begin
                        draw_node v;
                        lineto (x + 10) (y - 20);
                        draw_tree (d - 1) r;
                      end
                   | S.T.Node (l, v, r) ->
                      begin
                        draw_node v;
                        lineto (x - b) (y - 20);
                        draw_tree (d - 1) l;
                        moveto x y;
                        lineto(x + b) (y - 20);
                        draw_tree (d - 1) r;
                      end
     in let bin_tree = S.to_bintree s
        in
        begin
          open_graph " 640x480";
          clear_graph ();
          moveto 320 400;
          draw_tree (S.T.depth bin_tree) bin_tree;
          ignore (read_key ());
        end
