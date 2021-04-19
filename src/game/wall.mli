open Ecs

val destroy : Entity.t -> unit
val create : string -> float -> float -> int -> int -> Entity.t

val set_color : Entity.t -> Texture.t -> unit
