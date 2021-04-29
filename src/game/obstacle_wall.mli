open Ecs

val destroy : Entity.t -> unit
val create : int -> int -> float -> int -> float -> Entity.t
val x_case_to_x_pos : int -> float
val y_case_to_y_pos : int -> float