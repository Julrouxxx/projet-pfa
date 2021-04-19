open Ecs

val destroy : Entity.t -> unit
val create : string -> Gfx.image -> Gfx.image -> float -> float -> int -> int -> Entity.t
val set_image : Entity.t -> Gfx.image -> unit