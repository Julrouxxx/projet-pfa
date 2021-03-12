open Ecs

val create : string -> float -> float -> int -> float -> Entity.t

val invincibility : Entity.t -> float -> unit
val move_up : Entity.t -> bool -> unit
val move_down : Entity.t -> bool -> unit
val move_right : Entity.t -> bool -> unit
val move_left : Entity.t -> bool -> unit