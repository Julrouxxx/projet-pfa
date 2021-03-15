open Ecs

val create : string -> float -> float -> int -> int -> Entity.t

val set_color : Entity.t -> Gfx.color -> unit
