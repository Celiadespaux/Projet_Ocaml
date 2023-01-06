open Graph
open Tools
open Gfile


let rec total = function 
  |[] -> 0
  |x :: rest -> x + total rest
;;

let rembourse l = 
  let t = total l in
  let nbr = List.length l in
  let rec remb = function 
    |[] -> []
    |x :: rest -> ((t/nbr) - x) :: (remb rest)
    in
    remb l 
  ;;

  (* les utilisateurs commencent à 2*)
  (* let creategraph l = 
    let  li = rembourse l in 
    let empty = empty_graph in
    let rec node acu i = function
      |[] -> new_node (new_node acu 0) 1
      |x :: rest -> node (new_node acu (i)) (i+1) rest 
      in
    let rec arc acu i = function
      |[] -> acu
      |x :: rest -> if (x>0) then
        arc (new_arc acu i 0 x) (i+1) rest
        else 
        arc (new_arc acu 1 i (-x)) (i+1) rest
    in
    let arc2 acu list = 
      let taille = List.length list in
      let rec a acu node i = 
        if i>1 then 
        a (new_arc acu node (node+1) max_int) node (i-1) else
        acu 
        in
      let rec b acu i =
        if (i<(taille+2)) then b (a acu i taille) i+1 else
        acu
        in
        b acu 2 in
    arc2 (arc (node empty 2 li) 2 li) li 
    ;; *)