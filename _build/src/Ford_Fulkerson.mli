open Graph
open Tools



val graphresiduel : int graph -> int graph


(*id1 = départ, id2=arrivée  *)
val parcours : int graph -> id -> id -> int list option

val printlist : int list option -> unit 

val maxflot : int graph -> id list -> int

val modifyflot : int graph -> int -> id list -> int graph

val resi_to_flot : int graph -> int graph -> string graph

val ford_fulkerson : int graph -> id -> id -> string graph 

(* a faire : fonction finale, penser à utiliser e_fold pour recréer le graph à partir du résiduel, peut etre faire une fonction annexe avant*)