type obstacle = {
  time : float;
  t : string;
  x : int;
  y : int;
  direction : int;
  speed : float;
}
type level = {red: int; green: int; blue: int ; obstacles: obstacle list }
val list : level list ref
val load_obstacles_aux : string list -> obstacle
val load_obstacles : string list -> obstacle list
val load_line : string -> level
val load_data : string -> level list
val size_level : unit -> int
val _get_color_red : int -> int
val _get_color_green : int -> int
val _get_color_blue : int -> int

val _size_obstacle : int -> int
val _get_obstacle : int -> int -> obstacle
val init_data : int -> int -> int -> unit
val create_level: int -> unit