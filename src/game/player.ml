open Ecs
open Component_defs
open System_defs

let create name x y life =
  let e = Entity.create () in
  Position.set e { x = x; y = y};
  Velocity.set e Vector.zero;
  Mass.set e infinity;
  Box.set e {width = Globals.player_size; height=Globals.player_size };
  Name.set e name;
  Life.set e life;
  Invincibility.set e 0.;
  Surface.set e Texture.black;


  (* systems *)
  Collision_S.register e;
  Control_S.register e;
  Draw_S.register e;
  Move_S.register e;
  e

let invincibility e duration =
  if Game_state.get_status () == Playing then
    Invincibility.set e duration

let move_up e =
  if Game_state.get_status () == Playing then
    Velocity.set e { x = (Velocity.get e).x; y = -100.0 }
  
let move_down e =
  if Game_state.get_status () == Playing then
    Velocity.set e { x = (Velocity.get e).x; y = 100.0 }

let move_right e =
  if Game_state.get_status () == Playing then
    Velocity.set e { x = 100.0; y = (Velocity.get e).y }

let move_left e =
  if Game_state.get_status () == Playing then
    Velocity.set e { x = -100.0; y = (Velocity.get e).y }
  
let stop_horizontal e =
  if Game_state.get_status () == Playing then
    Velocity.set e { x = 0.0; y = (Velocity.get e).y }

let stop_vertical e =
  if Game_state.get_status () == Playing then
    Velocity.set e { x = (Velocity.get e).x; y = 0.0 }
  