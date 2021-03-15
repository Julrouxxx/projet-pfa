open Ecs

type status = Menu 
  | Playing 
  | Pause 
  | Gameover

type controlmode = Sidescroller 
  | Topdown

type t = {

  player : Entity.t;
  wall_up : Entity.t;
  wall_down : Entity.t;
  wall_right : Entity.t;
  wall_left : Entity.t;
  mutable level : int;
  mutable score : int;
  mutable status : status;
  mutable controlmode : controlmode;
}

let state = ref {

  player = Entity.dummy;
  wall_up = Entity.dummy;
  wall_down = Entity.dummy;
  wall_right = Entity.dummy;
  wall_left = Entity.dummy;
  level = 1;
  score = 0;
  status = Playing;
  controlmode = Topdown
}

let get_player () = !state.player
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