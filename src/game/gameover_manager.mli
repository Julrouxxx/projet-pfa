open Ecs

val get_title : unit -> Entity.t
val get_message : unit -> Entity.t
val get_score1 : unit -> Entity.t
val get_score2 : unit -> Entity.t

val set_title : Entity.t -> unit
val set_message : Entity.t -> unit
val set_score1 : Entity.t -> unit
val set_score2 : Entity.t -> unit

val clear : unit -> unit