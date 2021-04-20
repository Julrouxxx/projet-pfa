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
  let timer =
	  Text.create "01:54" (float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0+.float_of_int (Globals.player_size)*.32.0-.156.0) 
                        (float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0-.5.0) 
                        0 
                        0;
  in 
  let player =
    Player.create "player" Globals.player_init_x Globals.player_init_y 1000 100.0
  in
  let coeur_size = 33 in
  let coeur_XoffSet = (float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0) in
  let coeur_YoffSet = (float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0)-.float_of_int (coeur_size) in
  let coeur1 =
    Coeur.create "Coeur1" (get_image "images/coeur_plein.png") (get_image "images/coeur_vide.png") coeur_XoffSet coeur_YoffSet coeur_size 1
  in
  let coeur2 =
    Coeur.create "Coeur2" (get_image "images/coeur_plein.png") (get_image "images/coeur_vide.png") (coeur_XoffSet+.float_of_int (coeur_size)) coeur_YoffSet coeur_size 2
  in
  let coeur3 =
    Coeur.create "Coeur3" (get_image "images/coeur_plein.png") (get_image "images/coeur_vide.png") (coeur_XoffSet+.float_of_int (coeur_size*2)) coeur_YoffSet coeur_size 3
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
  Data.create_level 1;
  ignore (Data.load_data "data");
  for i = 0 to (Data._size_obstacle 0 - 1) do
    if (Data._get_obstacle 0 i).t = "OBS" then
      let _obstacle =
        Obstacle.create (Data._get_obstacle 0 i).x (Data._get_obstacle 0 i).y (Data._get_obstacle 0 i).speed (Data._get_obstacle 0 i).direction (Data._get_obstacle 0 i).time
      in
      Game_state.set_timeEndLevel (max (Game_state.get_timeEndLevel ()) (Data._get_obstacle 0 i).time);
  	  Game_state.add_obstacles _obstacle;
      ()
  done;
  (*for i = 0 to 15 do 
    Obstacle.random_param (Obstacle.create 0 0 100.0 Globals.direction_down 0.0)
  done;*)
  (*let _obstacle2 =
    Obstacle.create 2 0 100.0 Globals.direction_down
  in
  let _obstacle3 =
    Obstacle.create 3 0 100.0 Globals.direction_down
  in
  let _obstacle4 =
    Obstacle.create 30 0 100.0 Globals.direction_down
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

  Game_state.set_timer timer;
  Game_state.set_coeur1 coeur1;
  Game_state.set_coeur2 coeur2;
  Game_state.set_coeur3 coeur3;
  Game_state.set_player player;
  Game_state.set_wall_up wall_up;
  Game_state.set_wall_down wall_down;
  Game_state.set_wall_left wall_left;
  Game_state.set_wall_right wall_right;

  false

let cpt = ref 0.0

let float_to_time v =
  string_of_int (((int_of_float (v/.100000.0)) mod 10) / 3)^
  string_of_int (((int_of_float (v/.10000.0)) mod 10) / 6)^
  ":"^
  string_of_int ((int_of_float (v/.10000.0)) mod 6)^
  string_of_int ((int_of_float (v/.1000.0)) mod 10)

let play_game dt =
	if (dt >= !cpt) then begin
    Text.set_text (Game_state.get_timer ()) (float_to_time (((Game_state.get_timeEndLevel ()) +. 15000.0) -. !cpt));
		System.update_all dt;
		cpt := !cpt +. 1000.0/.60.0;
    (*Gfx.debug (string_of_float (((Game_state.get_timeEndLevel ()) +. 15000.0) -. !cpt));*)
	end;
	(Life.get (Game_state.get_player ())) > 0

let init_game_over _dt = 
  Text.destroy (Game_state.get_timer ());
	Wall.destroy (Game_state.get_wall_up ());
	Wall.destroy (Game_state.get_wall_right ());
	Wall.destroy (Game_state.get_wall_down ());
	Wall.destroy (Game_state.get_wall_left ());
	Coeur.destroy (Game_state.get_coeur1 ());
	Coeur.destroy (Game_state.get_coeur2 ());
	Coeur.destroy (Game_state.get_coeur3 ());
	Player.destroy (Game_state.get_player ());
	List.iter (fun e -> Obstacle.destroy e) (Game_state.get_obstacles ());
	Input_handler.clear_commands ();
	false

let game_over dt = 
	if (dt >= !cpt) then begin
		System.update_all dt;
		cpt := !cpt +. 1000.0/.60.0;
	end;
	true

(* Question 2.3 *)
let run () = Gfx.main_loop (
    chain_functions [
        wait_img;
        init_game;
        play_game;
        init_game_over;
        game_over
    ])