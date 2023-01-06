open Graph
open Tools
open Gfile

let graphresiduel graph = 
  let gr2 = clone_nodes graph in 
  let f gr id1 id2 n = new_arc (new_arc gr id2 id1 0) id1 id2 n in
  e_fold graph f gr2 
;;


let parcours graph id1 id2 = 
  let rec pl graph id1 id2 li ls =
    if not((find_arc graph id1 id2 = None) ||  (find_arc graph id1 id2 = Some 0) ) then match ls with 
      |None -> Some [id2 ; id1]
      |Some l -> Some (id2::l)
    else
      let rec f = function
        |[] -> None
        |(x,0) :: r -> f r 
        |(y,_) :: r -> if (List.mem y li) then
                f r
            else match (pl graph y id2 (y::li) (match ls with |None -> Some (y::[id1]) |Some l -> Some (y::l))) with
                |None -> f r 
                |Some x -> Some x
    in
      f (out_arcs graph id1) 
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
  |[x] -> x
  |x::y::r ->  match (find_arc graph x y) with
    |None -> max_int
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
    |None -> resi_to_flot graph graphr 
    |Some [] ->resi_to_flot graph graphr
    |Some l ->  
      let flot = maxflot graphr l in
      let graphmod = modifyflot graphr flot l in
      if (flot=0) then
          resi_to_flot graph graphr
      else ford graphmod id1 id2 
  in
  ford graphres id1 id2 
;;