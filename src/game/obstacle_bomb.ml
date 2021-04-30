open Ecs
open Component_defs
open System_defs

let x_case_to_x_pos x = 
  float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0+.float_of_int (x)*.float_of_int (Globals.player_size)

let y_case_to_y_pos y = 
  float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0+.float_of_int (y)*.float_of_int (Globals.player_size)

let destroy e =
  Game_state.remove_obstacles_bomb e;
  Draw_S.unregister e;
  Obstacle_bomb_destroyer_S.unregister e;
  Position.delete e;
  Box.delete e;
  Surface.delete e;
  Speed.delete e;
  Destroyer.delete e;
  Vert.delete e;
  TimeSpawn.delete e

let destroyer self =
  (*random_param self*)
  (*crée un obstacle dans chaque direction*)
  let _obstacle1 =
    Obstacle.create (X_case.get self) (Y_case.get self) (Speed.get self) 1 0.0
  in
  let _obstacle2 =
    Obstacle.create (X_case.get self) (Y_case.get self) (Speed.get self) 2 0.0
  in
  let _obstacle3 =
    Obstacle.create (X_case.get self) (Y_case.get self) (Speed.get self) 3 0.0
  in
  let _obstacle4 =
    Obstacle.create (X_case.get self) (Y_case.get self) (Speed.get self) 4 0.0
  in
  Game_state.add_obstacles _obstacle1;
  Game_state.add_obstacles _obstacle2;
  Game_state.add_obstacles _obstacle3;
  Game_state.add_obstacles _obstacle4;
  Bg.reset_background (Game_state.get_background ());
  destroy self

let create x y speed timespawn =
  let e = Entity.create () in
  Position.set e { x = x_case_to_x_pos x; y = y_case_to_y_pos y};
  Box.set e { width = Globals.player_size; height=Globals.player_size };
  Surface.set e (Color (Gfx.color 255 255 0 255));
  Speed.set e speed;
  Destroyer.set e destroyer;
  Vert.set e 255.0;
  TimeSpawn.set e timespawn;
  X_case.set e x;
  Y_case.set e y;

  (* systems *)
  Draw_S.register e;
  Obstacle_bomb_destroyer_S.register e;
  e