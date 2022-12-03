open Graph
open Tools
open Gfile

let graphresiduel graph = 
  let gr2 = clone_nodes graph in 
  let f gr id1 id2 n = new_arc (new_arc gr id2 id1 0) id1 id2 n in
  e_fold graph f gr2 
;;


(*
arc(x,y).   
chemin(X,Y) :- arc(X,Y) 
chemin(A,B) :- arc(A,Z), chemin(Z,B)
*)

let parcours graph id1 id2 = 

  let rec pl graph id1 id2 li ls =
    if (find_arc graph id1 id2 != None && find_arc graph id1 id2 != Some 0 ) then match ls with 
      |None -> Some [id2 ; id1]
      |Some l -> Some (id2::l)
    else
      let rec f acu = function
        |[] -> acu 
        |(x,0)::rest -> f acu rest
        |(x,_)::rest -> if (List.mem x li) then f acu rest else f (x::acu) rest
      in
      let rec fa = function 
        | [] -> None 
        | y::r -> match pl graph y id2 (y::li) (Some(y:: (match ls with |None -> [] |Some l -> l))) with 
            |None -> fa r 
            |Some x-> Some x
    in
      fa (f [] (out_arcs graph id1) )
  in
  match (pl graph id1 id2 [] (None)) with
  |None -> None 
  |Some l -> Some (List.rev l)
;;



let rec printlist = function
  |None -> Printf.printf "error"
  |Some []-> ()
  |Some [x] -> Printf.printf " %d" x
  |Some (x :: rest) -> Printf.printf " %d ;" x ; printlist (Some rest)
;; 

let rec maxflot graph = function
  |[] -> max_int
  |[x] -> max_int
  |x::y::r ->  match (find_arc graph x y) with
    |None -> 0
    |Some x -> min x (maxflot graph (y::r))
;;


let rec modifyflot graph flot = function
  |[] -> graph
  |[x] -> graph
  |x::y::rest -> modifyflot (add_arc (add_arc graph x y (-flot)) y x (flot)) flot (y::rest)
;;


let resi_to_flot graphorigin graphresiduel = 
  let graphn = clone_nodes graphorigin in
  let f graphvide id1 id2 id = 
    let v = match find_arc graphresiduel id2 id1 with
      |None -> raise (Failure "Error" )
      |Some z -> z
    in
    new_arc graphvide id1 id2 (string_of_int v ^ "/" ^string_of_int id) in
  e_fold graphorigin f graphn 
;;


let ford_fulkerson graph id1 id2 = 
  let graphres = graphresiduel graph in

  let rec ford graphr id1 id2 =
    let rec parcourslist = parcours graphr id1 id2 in
    match parcourslist with 
    |None -> export "outfilexport3" (gmap graphr (fun x -> string_of_int x)) ;
            resi_to_flot graph graphr 
    |Some l ->
      let flot = maxflot graphr l in
      Printf.printf ("%i\n") flot ;
      let graphmod = modifyflot graphr flot l in
      ford graphmod id1 id2 
  in
  ford graphres id1 id2 
;;