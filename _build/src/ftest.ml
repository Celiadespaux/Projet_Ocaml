open Gfile
open Tools
open Ford_Fulkerson
open Moneysharing

let () =

  (* Check the number of command-line arguments *)
  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf
        "\n ✻  Usage: %s infile source sink outfile\n\n%s%!" Sys.argv.(0)
        ("    🟄  infile  : input file containing a graph\n" ^
         "    🟄  source  : identifier of the source vertex (used by the ford-fulkerson algorithm)\n" ^
         "    🟄  sink    : identifier of the sink vertex (ditto)\n" ^
         "    🟄  outfile : output file in which the result should be written.\n\n") ;
      exit 0
    end ;


  (* Arguments are : infile(1) source-id(2) sink-id(3) outfile(4) *)

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

 
  and _source = int_of_string Sys.argv.(2)
  and _sink = int_of_string Sys.argv.(3)
  in

  (* Open file *)
  let graph = from_file infile in
  (*Les deux derniers arguments sont les points de départ et d'arrivée où nous souhaitons augmenter le flot *)
  let graphf = ford_fulkerson (gmap graph  (fun x -> int_of_string x)) 0 5 in


  let () =  write_file outfile graph ;
    export "outfilexport" graph ;
    export "outfilexport2" graphf ;
  in

  ()



