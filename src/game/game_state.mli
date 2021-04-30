open Ecs
open Data

type scene = Menu | Play | Gameover

val get_levels : unit -> level list
val get_timeStartLevel : unit -> float
val get_timeEndLevel : unit -> float
val get_timer : unit -> Entity.t
val get_color : unit -> Gfx.color
val get_obstacles : unit -> Entity.t list
val get_obstacles_wall : unit -> Entity.t list
val get_obstacles_bomb : unit -> Entity.t list
val get_coeur1 : unit -> Entity.t
val get_coeur2 : unit -> Entity.t
val get_coeur3 : unit -> Entity.t
val get_player : unit -> Entity.t
val get_wall_up : unit -> Entity.t
val get_wall_down : unit -> Entity.t
val get_wall_right : unit -> Entity.t
val get_wall_left : unit -> Entity.t
val get_background : unit -> Entity.t
val get_numLevel : unit -> int
val get_score : unit -> int
val get_scene: unit -> scene
val get_isRepeat: unit -> bool
val get_isRandom: unit -> bool

val menu : unit -> unit
val play : unit -> unit
val gameover : unit -> unit

val isMenu : unit -> bool
val isPlay : unit -> bool
val isGameover : unit -> bool

val inc_score : unit -> unit
val reset_score : unit -> unit

val set_isRepeat : bool -> unit
val set_isRandom : bool -> unit
val set_numLevel : int -> unit
val set_levels : level list -> unit
val set_timeStartLevel : float -> unit
val set_timeEndLevel : float -> unit
val set_timer : Entity.t -> unit
val set_color : Gfx.color -> unit
val add_obstacles : Entity.t -> unit
val remove_obstacles : Entity.t -> unit
val add_obstacles_wall : Entity.t -> unit
val remove_obstacles_wall : Entity.t -> unit
val add_obstacles_bomb : Entity.t -> unit
val remove_obstacles_bomb : Entity.t -> unit
val set_coeur1 : Entity.t -> unit
val set_coeur2 : Entity.t -> unit
val set_coeur3 : Entity.t -> unit
val set_player : Entity.t -> unit
val set_wall_up : Entity.t -> unit
val set_wall_down : Entity.t -> unit
val set_wall_right : Entity.t -> unit
val set_wall_left : Entity.t -> unit
val set_background : Entity.t -> unit
val set_numLevel : int -> unit