open Ecs
open Component_defs
open System_defs

let create name x y width height =
  let e = Entity.create () in
  Position.set e { x = x; y = y};
  Velocity.set e Vector.zero;
  Mass.set e infinity;
  Box.set e { width = width; height = height };
  Name.set e name;
  Surface.set e Texture.black;


  (* systems *)
  Collision_S.register e;
  Draw_S.register e;
  e

let set_color e color =
  Surface.set e color;