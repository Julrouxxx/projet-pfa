open Ecs
open Component_defs
open System_defs

let destroy e =
  Coeur_S.unregister e;
  Draw_S.unregister e;
  Position.delete e;
  Name.delete e;
  Box.delete e;
  Life.delete e;
  Image1.delete e;
  Image2.delete e;
  Surface.delete e

let set_image e img =
  Surface.set e (Texture.create_image img (Box.get e).width (Box.get e).width)

let create name img1 img2 x y size numLife =
  let e = Entity.create () in
  Position.set e { x = x; y = y};
  Name.set e name;
  Box.set e { width = size; height = size};
  Life.set e numLife;
  Image1.set e img1;
  Image2.set e img2;
  Surface.set e (Texture.create_image img1 size size);

  (* systems *)
  Draw_S.register e;
  Coeur_S.register e;
  e