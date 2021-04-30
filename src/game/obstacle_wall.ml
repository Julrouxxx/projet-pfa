open Ecs
open Component_defs
open System_defs

let x_case_to_x_pos x = 
  float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0+.float_of_int (x)*.float_of_int (Globals.player_size)

let y_case_to_y_pos y = 
  float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0+.float_of_int (y)*.float_of_int (Globals.player_size)

let destroy e =
  Game_state.remove_obstacles_wall e;
  Collision_S.unregister e;
  Draw_S.unregister e;
  Position.delete e;
  Velocity.delete e;
  Mass.delete e;
  Box.delete e;
  Surface.delete e

let create x y poids timespawn =
  let e = Entity.create () in
  Position.set e { x = x_case_to_x_pos x -. (float_of_int (Globals.player_size)*.0.3); y = y_case_to_y_pos y -. (float_of_int (Globals.player_size)*.0.3) };
  Velocity.set e Vector.zero;
  Mass.set e poids;
  Box.set e { width = int_of_float (float_of_int (Globals.player_size)*.1.5); height = int_of_float (float_of_int (Globals.player_size)*.1.5) };
  Surface.set e Texture.white;
  if poids >= 10000.0 then
    Mass.set e infinity;

  (* systems *)
  Collision_S.register e;
  Draw_S.register e;
  e