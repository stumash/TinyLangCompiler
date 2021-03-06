(* Abstract Syntax Tree definition *)

type prog =
  | Program of package * (declaration list)
  | EmptyProgram

and package =
  | Package of string * (int * int)

and declaration =
  | FunctionDeclaration of identifier * parameters * (type_spec option) * (statement list) * (int * int)
  | VariableDeclaration of ((identifier list) * (type_spec option) * (expression list option)) list * (int * int)
  | TypeDeclaration of (identifier * type_spec) list * (int * int)

and identifier =
  | Identifier of string * (int * int)

and type_spec =
  | IdentifierType of identifier
  | ArrayTypeLiteral of expression * type_spec * (int * int)
  | StructTypeLiteral of (identifier * type_spec) list * (int * int)
  | SliceTypeLiteral of type_spec * (int * int)

and parameters =
  | Parameters of ((identifier list) * type_spec) list

and statement =
  | ExpressionStatement of expression * (int * int)
  | AssignmentStatement of (expression list) * assignment_operator * (expression list)
  | DeclarationStatement of declaration
  | ShortValDeclaration of (identifier list) * (expression list)
  | Inc of expression
  | Dec of expression
  | PrintStatement of (expression list option) * (int * int)
  | PrintlnStatement of (expression list option) * (int * int)
  | ReturnStatement of expression option * (int * int)
  | IfStatement of if_statement
  | SwitchStatement of statement * (expression option) * (switch_clause list) * (int * int)
  | ForStatement of statement * (expression option) * statement * (statement list) * (int * int) * (int * int)
  | BlockStatements of (statement list) * (int * int)
  | Break of (int * int)
  | Continue of (int * int)
  | EmptyStatement

and if_statement =
  | If of statement * expression * (statement list) * (else_statement option)  * (int * int)

and else_statement =
  | Elseif of if_statement * (int * int)
  | Else of statement list * (int * int)

and switch_clause =
  | Default of statement list * (int * int)
  | Case of (expression list) * (statement list) * (int * int)

and assignment_operator =
  | ASG
  | PLUSEQ
  | MINUSEQ
  | MULTEQ
  | DIVEQ
  | MODEQ
  | BANDEQ
  | BOREQ
  | XOREQ
  | LSHFTEQ
  | RSHFTEQ
  | NANDEQ

and expression =
(* binary expression *)
  | Or of expression * expression * (int * int)
  | And of expression * expression * (int * int)
  | Eq of expression * expression * (int * int)
  | Neq of expression * expression * (int * int)
  | Gt of expression * expression * (int * int)
  | Gteq of expression * expression * (int * int)
  | Lt of expression * expression * (int * int)
  | Lteq of expression * expression * (int * int)
  | Plus of expression * expression * (int * int)
  | Minus of expression * expression * (int * int)
  | Bor of expression * expression * (int * int)
  | Xor of expression * expression * (int * int)
  | Mult of expression * expression * (int * int)
  | Div of expression * expression * (int * int)
  | Mod of expression * expression * (int * int)
  | Lshft of expression * expression * (int * int)
  | Rshft of expression * expression * (int * int)
  | Band of expression * expression * (int * int)
  | Nand of expression * expression * (int * int)
(* unary expression *)
  | Uplus of expression * (int * int)
  | Uminus of expression * (int * int)
  | Not of expression * (int * int)
  | Uxor of expression * (int * int)
(* function calls *)
  | FunctionCall of identifier  * (expression list) * (int * int)
  | Append of expression * expression * (int * int)
  | Len of expression * (int * int)
  | Cap of expression * (int * int)
(* misc *)
  | ParenExpression of expression * (int * int)
  | LitInt of int * (int * int)
  | LitBool of bool * (int * int)
  | LitFloat of float * (int * int)
  | LitRune of string * (int * int)
  | LitString of string * (int * int)
  | LitRawString of string * (int * int)
  | IdentifierExpression of identifier_expression

and identifier_expression =
  | Ident of string * (int * int)
  | Indexed of expression * expression * (int * int)
  | StructAccess of expression * string * (int * int)

let rec get_pos_e = function
(* binary expression *)
  | Or ( _ , _ , pos) -> pos
  | And ( _ , _ , pos) -> pos
  | Eq ( _ , _ , pos) -> pos
  | Neq ( _ , _ , pos) -> pos
  | Gt ( _ , _ , pos) -> pos
  | Gteq ( _ , _ , pos) -> pos
  | Lt ( _ , _ , pos) -> pos
  | Lteq ( _ , _ , pos) -> pos
  | Plus ( _ , _ , pos) -> pos
  | Minus ( _ , _ , pos) -> pos
  | Bor ( _ , _ , pos) -> pos
  | Xor ( _ , _ , pos) -> pos
  | Mult ( _ , _ , pos) -> pos
  | Div ( _ , _ , pos) -> pos
  | Mod ( _ , _ , pos) -> pos
  | Lshft ( _ , _ , pos) -> pos
  | Rshft ( _ , _ , pos) -> pos
  | Band ( _ , _ , pos) -> pos
  | Nand ( _ , _ , pos) -> pos
(* unary expression *)
  | Uplus ( _ , pos) -> pos
  | Uminus ( _ , pos) -> pos
  | Not ( _ , pos) -> pos
  | Uxor ( _ , pos) -> pos
(* function calls *)
  | FunctionCall ( _  , _ , pos) -> pos
  | Append ( _ , _ , pos) -> pos
  | Len ( _ , pos) -> pos
  | Cap ( _ , pos) -> pos
(* misc *)
  | ParenExpression ( _ , pos) -> pos
  | LitInt ( _ , pos) -> pos
  | LitBool ( _ , pos) -> pos
  | LitFloat ( _ , pos) -> pos
  | LitRune ( _ , pos) -> pos
  | LitInt ( _ , pos) -> pos
  | LitString ( _, pos) -> pos
  | LitRawString ( _ , pos) -> pos
  | IdentifierExpression idexp -> get_pos_idexp idexp

and get_pos_idexp = function
  | Ident ( _ , pos) -> pos
  | Indexed ( _ , _ , pos) -> pos
  | StructAccess ( _ , _ , pos) -> pos
