open Ecs
open Data

type scene = Menu 
  | Play
  | Gameover

type t = {
  
  levels : level list;
  timer : Entity.t;
  mutable color : Gfx.color;
  obstacles : Entity.t list;
  obstacles_wall : Entity.t list;
  obstacles_bomb : Entity.t list;
  coeur1 : Entity.t;
  coeur2 : Entity.t;
  coeur3 : Entity.t;
  player : Entity.t;
  wall_up : Entity.t;
  wall_down : Entity.t;
  wall_right : Entity.t;
  wall_left : Entity.t;
  background : Entity.t;
  mutable timeEndLevel : float;
  mutable timeStartLevel : float;
  mutable numLevel : int;
  mutable score : int;
  mutable isRepeat : bool;
  mutable isRandom : bool;
  mutable scene : scene;
}

let state = ref {

  levels = [];
  timer = Entity.dummy;
  color = Gfx.color 255 255 255 255;
  obstacles = [];
  obstacles_wall = [];
  obstacles_bomb = [];
  coeur1 = Entity.dummy;
  coeur2 = Entity.dummy;
  coeur3 = Entity.dummy;
  player = Entity.dummy;
  wall_up = Entity.dummy;
  wall_down = Entity.dummy;
  wall_right = Entity.dummy;
  wall_left = Entity.dummy;
  background = Entity.dummy;
  timeEndLevel = 0.0;
  timeStartLevel = 0.0;
  numLevel = 1;
  score = 0;
  isRepeat = false;
  isRandom = false;
  scene = Menu
}

let get_levels () = !state.levels
let get_timeEndLevel () = !state.timeEndLevel
let get_timeStartLevel () = !state.timeStartLevel
let get_timer () = !state.timer
let get_color () = !state.color
let get_obstacles () = !state.obstacles
let get_obstacles_wall () = !state.obstacles_wall
let get_obstacles_bomb () = !state.obstacles_bomb
let get_coeur1 () = !state.coeur1
let get_coeur2 () = !state.coeur2
let get_coeur3 () = !state.coeur3
let get_player () = !state.player
let get_wall_up () = !state.wall_up
let get_wall_down () = !state.wall_down
let get_wall_right () = !state.wall_right
let get_wall_left () = !state.wall_left
let get_background () = !state.background
let get_numLevel () = !state.numLevel
let get_score () = !state.score
let get_scene () = !state.scene
let get_isRepeat () = !state.isRepeat
let get_isRandom () = !state.isRandom

let menu () = !state.scene <- Menu
let play () = !state.scene <- Play
let gameover () = !state.scene <- Gameover

let isMenu () = !state.scene == Menu
let isPlay () = !state.scene == Play
let isGameover () = !state.scene == Gameover

let inc_score () =
  state := { !state with score = !state.score + 1 }
let reset_score () =
  state := { !state with score = 0 }

let set_isRepeat p =
  state := { !state with isRepeat = p }
let set_isRandom p =
  state := { !state with isRandom = p }

let set_numLevel p =
  state := { !state with numLevel = p }

let set_levels p =
  state := { !state with levels = p }
let set_timeEndLevel p =
  state := { !state with timeEndLevel = p }
let set_timeStartLevel p =
  state := { !state with timeStartLevel = p }

let set_timer p =
  state := { !state with timer = p }
let set_color p =
  state := { !state with color = p }
let set_numLevel p =
  state := { !state with numLevel = p }

let add_obstacles p =
  state := { !state with obstacles = !state.obstacles@[p] }
let remove_obstacles p =
  state := { !state with obstacles = (List.filter (fun x -> x != p) !state.obstacles) }

let add_obstacles_wall p =
  state := { !state with obstacles_wall = !state.obstacles_wall@[p] }
let remove_obstacles_wall p =
  state := { !state with obstacles_wall = (List.filter (fun x -> x != p) !state.obstacles_wall) }

let add_obstacles_bomb p =
  state := { !state with obstacles_bomb = !state.obstacles_bomb@[p] }
let remove_obstacles_bomb p =
  state := { !state with obstacles_bomb = (List.filter (fun x -> x != p) !state.obstacles_bomb) }

let set_coeur1 p =
  state := { !state with coeur1 = p }
let set_coeur2 p =
  state := { !state with coeur2 = p }
let set_coeur3 p =
  state := { !state with coeur3 = p }

let set_player p =
  state := { !state with player = p }

let set_wall_up e =
  state := { !state with wall_up = e }
let set_wall_down e =
  state := { !state with wall_down = e }
let set_wall_right e =
  state := { !state with wall_right = e }
let set_wall_left e =
  state := { !state with wall_left = e }
let set_background e =
  state := { !state with background = e }