open Ecs

type status = Menu 
  | Playing 
  | Pause 
  | Gameover

type controlmode = Sidescroller 
  | Topdown

type t = {

  player : Entity.t;
  mutable level : int;
  mutable score : int;
  mutable status : status;
  mutable controlmode : controlmode;
}

let state = ref {

  player = Entity.dummy;
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

let init p =
  state := { !state with player = p }
