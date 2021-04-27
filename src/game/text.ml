open Ecs
open Component_defs
open System_defs


let destroy e =
  Collision_S.unregister e;
  Draw_S.unregister e;
  Position.delete e;
  Velocity.delete e;
  Mass.delete e;
  Box.delete e;
  Name.delete e;
  Surface.delete e

let create text x y size =
  let e = Entity.create () in
  Position.set e { x = x; y = y};
  Box.set e { width = 0; height = 0 };
  Surface.set e (Texture.Text(text, (string_of_int size) ^ "px UpheavalPro", (Game_state.get_color ())));

  (* systems *)
  Draw_S.register e;
  e

let set_text e text size =
  Surface.set e (Texture.Text(text, (string_of_int size) ^ "px UpheavalPro", (Game_state.get_color ())))


let hide_text e =
  Draw_S.unregister e

let show_text e =
  Draw_S.register e;
  Bg.reset_background (Game_state.get_background ())