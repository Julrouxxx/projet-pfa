open Ecs

type status = Menu 
  | Playing 
  | Pause 
  | Gameover

type controlmode = Sidescroller 
  | Topdown

type t = {
  
  timer : Entity.t;
  mutable color : Gfx.color;
  obstacles : Entity.t list;
  coeur1 : Entity.t;
  coeur2 : Entity.t;
  coeur3 : Entity.t;
  player : Entity.t;
  wall_up : Entity.t;
  wall_down : Entity.t;
  wall_right : Entity.t;
  wall_left : Entity.t;
  mutable timeEndLevel : float;
  mutable level : int;
  mutable score : int;
  mutable status : status;
  mutable controlmode : controlmode;
}

let state = ref {

  timer = Entity.dummy;
  color = Gfx.color 255 255 255 255;
  obstacles = [];
  coeur1 = Entity.dummy;
  coeur2 = Entity.dummy;
  coeur3 = Entity.dummy;
  player = Entity.dummy;
  wall_up = Entity.dummy;
  wall_down = Entity.dummy;
  wall_right = Entity.dummy;
  wall_left = Entity.dummy;
  timeEndLevel = 0.0;
  level = 1;
  score = 0;
  status = Playing;
  controlmode = Topdown
}

let get_timeEndLevel () = !state.timeEndLevel
let get_timer () = !state.timer
let get_color () = !state.color
let get_obstacles () = !state.obstacles
let get_coeur1 () = !state.coeur1
let get_coeur2 () = !state.coeur2
let get_coeur3 () = !state.coeur3
let get_player () = !state.player
let get_wall_up () = !state.wall_up
let get_wall_down () = !state.wall_down
let get_wall_right () = !state.wall_right
let get_wall_left () = !state.wall_left
let get_level () = !state.level
let get_score () = !state.score
let get_status () = !state.status
let get_controlmode () = !state.controlmode

let menu () = !state.status <- Menu
let play () = !state.status <- Playing
let pause () = !state.status <- Pause
let gameover () = !state.status <- Gameover

let sidescroller () = !state.controlmode <- Sidescroller
let topdown () = !state.controlmode <- Topdown


let set_timeEndLevel p =
  state := { !state with timeEndLevel = p }

let set_timer p =
  state := { !state with timer = p }
let set_color p =
  state := { !state with color = p }

let add_obstacles p =
  state := { !state with obstacles = !state.obstacles@[p] }

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