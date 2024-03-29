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

let create name x y width height =
  let e = Entity.create () in
  Position.set e { x = x; y = y};
  Velocity.set e Vector.zero;
  Mass.set e infinity;
  Box.set e { width = width; height = height };
  Name.set e name;
  Surface.set e Texture.white;


  (* systems *)
  Collision_S.register e;
  Draw_S.register e;
  e

let set_color e color =
  Surface.set e color;