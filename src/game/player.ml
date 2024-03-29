open Ecs
open Component_defs
open System_defs

let destroy e =
  Collision_S.unregister e;
  Control_S.unregister e;
  Draw_S.unregister e;
  Move_S.unregister e;
  Direction_S.unregister e;
  Invincibility_S.unregister e;
  Position.delete e;
  Velocity.delete e;
  Mass.delete e;
  Box.delete e;
  Name.delete e;
  Life.delete e;
  Invincibility.delete e;
  Surface.delete e;
  Movement.delete e;
  Speed.delete e

let create name x y life speed =
  let e = Entity.create () in
  Position.set e { x = x; y = y};
  Velocity.set e Vector.zero;
  Mass.set e 10.0;
  Box.set e {width = Globals.player_size; height=Globals.player_size };
  Name.set e name;
  Life.set e life;
  Invincibility.set e 0.0;
  Surface.set e Texture.blue;
  Movement.set e Direction.zero;
  Speed.set e speed;


  (* systems *)
  Collision_S.register e;
  Control_S.register e;
  Draw_S.register e;
  Move_S.register e;
  Direction_S.register e;
  Invincibility_S.register e;
  e

let invincibility e duration =
  if Game_state.get_scene () == Play then
    Invincibility.set e duration

let move_up e b =
  if Game_state.get_scene () == Play then
    Movement.set e (Direction.set_up (Movement.get e) b)
  
let move_down e b =
  if Game_state.get_scene () == Play then
    Movement.set e (Direction.set_down (Movement.get e) b)

let move_right e b =
  if Game_state.get_scene () == Play then
    Movement.set e (Direction.set_right (Movement.get e) b)

let move_left e b =
  if Game_state.get_scene () == Play then
    Movement.set e (Direction.set_left (Movement.get e) b)

let lose_life e =
  if Game_state.get_scene () == Play then
    Life.set e ((Life.get e)-1);
    invincibility e Globals.invincibility_duration

let reset_life e =
  if Game_state.get_scene () == Play then
    Life.set e 3