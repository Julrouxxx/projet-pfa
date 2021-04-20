open Ecs
open Component_defs
open System_defs

let set_direction e d =
  if d == Globals.direction_right then
    Movement.set e (Direction.set_right (Movement.get e) true)
  else if d == Globals.direction_left then
    Movement.set e (Direction.set_left (Movement.get e) true)
  else if d == Globals.direction_up then
    Movement.set e (Direction.set_up (Movement.get e) true)
  else if d == Globals.direction_down then
    Movement.set e (Direction.set_down (Movement.get e) true)

let x_case_to_x_pos x = 
  float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0+.float_of_int (x)*.float_of_int (Globals.player_size)

let y_case_to_y_pos y = 
  float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0+.float_of_int (y)*.float_of_int (Globals.player_size)

let random_param e =
  let random_direction = 1+(Random.int 4) in
  Movement.set e Direction.zero;
  set_direction e random_direction;
  if random_direction == Globals.direction_down || random_direction == Globals.direction_up then
    let random_int_X = 1+(Random.int 30) in
    if random_direction == Globals.direction_down then
      Position.set e { x = x_case_to_x_pos random_int_X; y = y_case_to_y_pos 0 }
    else Position.set e { x = x_case_to_x_pos random_int_X; y = y_case_to_y_pos 17 };
  else if random_direction == Globals.direction_right || random_direction == Globals.direction_left then
    let random_int_Y = 1+(Random.int 15) in
    if random_direction == Globals.direction_right then
      Position.set e { x = x_case_to_x_pos 0; y = y_case_to_y_pos random_int_Y }
    else Position.set e { x = x_case_to_x_pos 31; y = y_case_to_y_pos random_int_Y }

let destroy e =
  Collision_S.unregister e;
  Draw_S.unregister e;
  Move_S.unregister e;
  Direction_S.unregister e;
  Obstacle_destroyer_S.unregister e;
  Position.delete e;
  Velocity.delete e;
  Mass.delete e;
  Box.delete e;
  Surface.delete e;
  Movement.delete e;
  Speed.delete e;
  CollisionResolver.delete e;
  Destroyer.delete e;
  TimeSpawn.delete e

let resolve_collision self other =
  if other == Game_state.get_player () then begin
    let p = Game_state.get_player () in
    if Invincibility.get p <= 0.0 then begin
      Player.lose_life p;
      destroy self
    end
  end


let destroyer self =
  (*random_param self*)
  destroy self

let create x y speed direction timespawn =
  let e = Entity.create () in
  Position.set e { x = x_case_to_x_pos x; y = y_case_to_y_pos y};
  Velocity.set e Vector.zero;
  Mass.set e 10.0;
  Box.set e { width = Globals.player_size; height=Globals.player_size };
  Surface.set e Texture.red;
  Movement.set e Direction.zero;
  Speed.set e speed;
  CollisionResolver.set e resolve_collision;
  Destroyer.set e destroyer;
  set_direction e direction;
  TimeSpawn.set e timespawn;

  (* systems *)
  Collision_S.register e;
  Draw_S.register e;
  Move_S.register e;
  Direction_S.register e;
  Obstacle_destroyer_S.register e;
  e