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

let create text x y width height =
  let e = Entity.create () in
  Position.set e { x = x; y = y};
  Box.set e { width = width; height = height };
  Surface.set e (Texture.Text(text, "60px UpheavalPro", (Game_state.get_color ())));

  (* systems *)
  Draw_S.register e;
  e

let set_color e color =
  Surface.set e color

let set_text e text =
  Surface.set e (Texture.Text(text, "60px UpheavalPro", (Game_state.get_color ())))