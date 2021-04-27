open Ecs

val destroy : Entity.t -> unit
val create : string -> float -> float -> int -> Entity.t

val set_text : Entity.t -> string -> int -> unit
val show_text : Entity.t -> unit
val hide_text : Entity.t -> unit
