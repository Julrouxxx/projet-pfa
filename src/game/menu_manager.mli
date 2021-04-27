open Ecs
open Data

val get_title : unit -> (Entity.t * string)
val get_endless : unit -> (Entity.t * string)
val get_niveaux : unit -> (Entity.t * string)
val get_niveau1 : unit -> Entity.t
val get_niveau2 : unit -> Entity.t
val get_niveau3 : unit -> Entity.t
val get_listNiveaux : unit -> string list
val get_currentMode : unit -> int

val set_title : (Entity.t * string) -> unit
val set_endless : (Entity.t * string) -> unit
val set_niveaux : (Entity.t * string) -> unit
val set_niveau1 : Entity.t -> unit
val set_niveau2 : Entity.t -> unit
val set_niveau3 : Entity.t -> unit

val add_listNiveaux : string -> unit
val remove_listNiveaux : string -> unit

val event_haut : unit -> unit
val event_bas : unit -> unit
val release_haut : unit -> unit
val release_bas : unit -> unit
val event : unit -> unit
val enter : unit -> unit
val back : unit -> unit