open Ecs
open Component_defs

let img_table = Hashtbl.create 16

let load_image f = Hashtbl.add img_table f (Gfx.load_image f)

let get_image f = Hashtbl.find img_table f
let () = load_image "images/coeur_plein.png"
let () = load_image "images/coeur_vide.png"

let wait_img _dt =
  not (Hashtbl.fold (fun _ img acc -> acc && Gfx.image_ready img) img_table true)

let chain_functions f_list =
  let funs = ref f_list in
  fun dt -> match !funs with
               [] -> false
              | f :: ll ->
                 if f dt then true
                 else begin
                  funs := ll;
                  true
                 end

let init_game _dt =
  Random.self_init ();
  System.init_all ();
  let player =
    Player.create "player" Globals.player_init_x Globals.player_init_y 3 100.0
  in
  let _coeur1 =
    Coeur.create "Coeur1" (get_image "images/coeur_plein.png") (get_image "images/coeur_vide.png") 0.0 0.0 55 1
  in
  let _coeur2 =
    Coeur.create "Coeur2" (get_image "images/coeur_plein.png") (get_image "images/coeur_vide.png") 55.0 0.0 55 2
  in
  let _coeur3 =
    Coeur.create "Coeur3" (get_image "images/coeur_plein.png") (get_image "images/coeur_vide.png") 110.0 0.0 55 3
  in
  let wall_up =
    Wall.create "wall_up" (float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0) 
    						(float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0) 
    						(Globals.player_size*32) 
    						(Globals.player_size)
  in
  let wall_down =
    Wall.create "wall_down" (float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0) 
    						(float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0+.float_of_int (Globals.player_size)*.17.0) 
    						(Globals.player_size*32) 
    						(Globals.player_size)
  in
  let wall_left =
    Wall.create "wall_left" (float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0) 
    						(float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0) 
    						(Globals.player_size) 
    						(Globals.player_size*18)
  in
  let wall_right =
    Wall.create "wall_right" (float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0+.float_of_int (Globals.player_size)*.31.0) 
    						(float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0) 
    						(Globals.player_size) 
    						(Globals.player_size*18)
  in

  ignore (Data.load_data "data");
  for i = 0 to (Data._size_obstacle 0 - 1) do
    if (Data._get_obstacle 0 i).t = "BOMB" then
      let _obstacle =
        Obstacle.create (Data._get_obstacle 0 i).x (Data._get_obstacle 0 i).y (Data._get_obstacle 0 i).speed (Data._get_obstacle 0 i).direction
      in
    ()
  done;
  (*let _obstacle2 =
    Obstacle.create "obstacle2" 2 0 100.0 Globals.direction_down
  in
  let _obstacle3 =
    Obstacle.create "obstacle3" 3 0 100.0 Globals.direction_down
  in
  let _obstacle4 =
    Obstacle.create "obstacle4" 30 0 100.0 Globals.direction_down
  in*)
  let _background =
  	Bg.create Texture.black
  in
  Input_handler.register_command (KeyDown "z") (fun () -> Player.move_up player true);
  Input_handler.register_command (KeyDown "s") (fun () -> Player.move_down player true);
  Input_handler.register_command (KeyDown "q") (fun () -> Player.move_left player true);
  Input_handler.register_command (KeyDown "d") (fun () -> Player.move_right player true);

  Input_handler.register_command (KeyUp "z") (fun () -> Player.move_up player false);
  Input_handler.register_command (KeyUp "s") (fun () -> Player.move_down player false);
  Input_handler.register_command (KeyUp "q") (fun () -> Player.move_left player false);
  Input_handler.register_command (KeyUp "d") (fun () -> Player.move_right player false);

  Game_state.set_player player;
  Game_state.set_wall_up wall_up;
  Game_state.set_wall_down wall_down;
  Game_state.set_wall_left wall_left;
  Game_state.set_wall_right wall_right;

  false

let cpt = ref 0.0

let play_game dt =

	if (dt >= !cpt) then begin
		System.update_all dt;
		cpt := !cpt +. 1000.0/.60.0;
  end;
  (Life.get (Game_state.get_player ())) > 0

let game_over _dt = 
	false

(* Question 2.3 *)
let run () = Gfx.main_loop (
        chain_functions [
            wait_img;
            init_game;
            play_game;
            game_over 
        ])