open Ecs

type status = Menu | Playing | Pause | Gameover
type controlmode = Sidescroller | Topdown
val init : Entity.t -> unit
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

val get_player : unit -> Entity.t