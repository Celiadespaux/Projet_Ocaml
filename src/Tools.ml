open Graph

(* assert false is of type ∀α.α, so the type-checker is happy. *)
let clone_nodes gr = n_fold gr new_node empty_graph ;;





let gmap gr f= 
  let gr2 = clone_nodes gr in
  let trans gr src dst lbl = new_arc gr src dst (f lbl) in
  e_fold gr trans gr2
;;




let add_arc grp src dest n = match find_arc grp src dest with
    |None -> new_arc grp src dest n 
    |Some x -> new_arc grp src dest (n+x)
  ;;