type obstacle = {
  time : int;
  t : string;
  x : int;
  y : int;
  direction : int;
  speed : float;
}
type level = { effect : string list; obstacles : obstacle list; }
val list : level list ref
val load_effects : 'a list -> 'a list
val load_obstacles_aux : string list -> obstacle
val load_obstacles : string list -> obstacle list
val load_line : string -> level
val load_data : string -> level list
val size_level : unit -> int
val _get_effect : int -> int -> string
val _size_obstacle : int -> int
val _get_obstacle : int -> int -> obstacle
