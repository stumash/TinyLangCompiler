(* categories of values in golite *)
type vcat =
    | Type
    | Constant
    | Variable
    | Intd 

(* all valid types in golite *)
type gltype =
    | IntT
    | FloatT
    | BoolT
    | RuneT
    | StringT
    | NamedT of string * (int * int)
    | StructT of (string * gltype) list
    | ArrayT of int * gltype
    | SliceT of gltype
    | FunctionT of gltype list * gltype
    | Void

(* pretty print vcat and gltype *)

let string_of_vcat vc =
    match vc with
    | Type -> "Type"
    | Constant -> "Constant"
    | Variable -> "Variable"

let string_of_strs ?(sep=",") strs =
    let f (i, acc) str =
        let acc' =
            if i!=(List.length strs)-1 then acc ^ str ^ sep ^ " "
            else acc ^ str ^ " " in
        (i+1, acc') in
    snd @@ List.fold_left f (0,"") strs

let rec string_of_glt gt =
    match gt with
    | IntT -> "IntT"
    | FloatT -> "FloatT"
    | BoolT -> "BoolT"
    | RuneT -> "RuneT"
    | StringT -> "StringT"
    | NamedT (str, (lineno, colno)) ->
        let f (lineno, colno) = (string_of_int lineno)^":"^(string_of_int colno) in
        "NamedT( " ^ str ^ ", " ^ (f (lineno,colno)) ^ " )"
    | StructT stds ->
        "struct{ " ^ (string_of_strs (List.map string_of_std stds)) ^"}"
    | ArrayT (i, gt) ->
        "[" ^ (string_of_int i) ^ "]" ^ (string_of_glt gt)
    | SliceT gt ->
        "[ ]" ^ (string_of_glt gt)
    | FunctionT (gts, gt) ->
        let strs = List.map string_of_glt gts in
        "(" ^ (string_of_strs strs) ^ ") -> " ^ (string_of_glt gt)
    | Void -> "Void"

and string_of_std (str, gt) =
    str ^ " " ^ (string_of_glt gt) ^ "; "
