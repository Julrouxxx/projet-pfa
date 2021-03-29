open Ecs

module Control_S = System.Make (Control_system)
module Draw_S = System.Make(Draw_system)
module Move_S = System.Make(Move_system)
module Collision_S = System.Make(Collision_system)
module Direction_S = System.Make(Direction_system)
module Obstacle_destroyer_S = System.Make(Obstacle_destroyer_system)
module Invincibility_S = System.Make(Invincibility_system)
module Coeur_S = System.Make(Coeur_system)

let () =
  System.register (module Draw_S);
  System.register (module Move_S);
  System.register (module Control_S);
  System.register (module Collision_S);
  System.register (module Direction_S);
  System.register (module Obstacle_destroyer_S);
  System.register (module Invincibility_S);
  System.register (module Coeur_S)
