open Ecs
open Component_defs
open System_defs

let create color =
  let e = Entity.create () in
  Position.set e Vector.zero;
  Box.set e { width = Globals.canvas_width; height = Globals.canvas_height};
  Surface.set e color;
  
  Draw_S.register e;
  e
