module T = Golitetypes

(* Cactus-Stack Node*)
type cs_node =
    | CsRoot
    | CsNode of {
        parent           : cs_node;
        mutable children : cs_node list;
        context          : (string, (T.vcat, T.gltype)) Hashtbl.t
      }