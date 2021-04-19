open Ecs

val destroy : Entity.t -> unit
val create : string -> float -> float -> int -> int -> Entity.t

val set_color : Entity.t -> Texture.t -> unit
val set_text : Entity.t -> string -> unit
