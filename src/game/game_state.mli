open Ecs

type status = Menu | Playing | Pause | Gameover
type controlmode = Sidescroller | Topdown

val get_color : unit -> Gfx.color
val get_obstacles : unit -> Entity.t list
val get_coeur1 : unit -> Entity.t
val get_coeur2 : unit -> Entity.t
val get_coeur3 : unit -> Entity.t
val get_player : unit -> Entity.t
val get_wall_up : unit -> Entity.t
val get_wall_down : unit -> Entity.t
val get_wall_right : unit -> Entity.t
val get_wall_left : unit -> Entity.t
val get_level : unit -> int
val get_score : unit -> int
val get_status : unit -> status
val get_controlmode : unit -> controlmode

val play : unit -> unit
val pause : unit -> unit
val gameover : unit -> unit
val menu : unit -> unit

val sidescroller : unit -> unit
val topdown : unit -> unit


val set_color : Gfx.color -> unit
val add_obstacles : Entity.t -> unit
val set_coeur1 : Entity.t -> unit
val set_coeur2 : Entity.t -> unit
val set_coeur3 : Entity.t -> unit
val set_player : Entity.t -> unit
val set_wall_up : Entity.t -> unit
val set_wall_down : Entity.t -> unit
val set_wall_right : Entity.t -> unit
val set_wall_left : Entity.t -> unit