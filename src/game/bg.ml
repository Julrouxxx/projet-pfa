open Ecs
open Component_defs
open System_defs


let reset_background e =
  Draw_S.unregister e;
  Draw_S.register e

let destroy e =
  Draw_S.unregister e;
  Position.delete e;
  Box.delete e;
  Surface.delete e

let create color =
  let e = Entity.create () in
  Position.set e Vector.zero;
  Box.set e { width = Globals.canvas_width; height = Globals.canvas_height};
  Surface.set e color;
  
  Draw_S.register e;
  e
