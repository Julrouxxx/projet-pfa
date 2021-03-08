open Ecs

val create : string -> float -> float -> int -> Entity.t

val invincibility : Entity.t -> float -> unit
val move_up : Entity.t -> unit
val move_down : Entity.t -> unit
val move_right : Entity.t -> unit
val move_left : Entity.t -> unit

val stop_horizontal : Entity.t -> unit
val stop_vertical : Entity.t -> unit