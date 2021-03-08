open Ecs

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
  System.init_all ();
  let player =
    Player.create "player" Globals.player_init_x Globals.player_init_y 3
  in
  Input_handler.register_command (KeyDown "z") (fun () -> Player.move_up player);
  Input_handler.register_command (KeyDown "s") (fun () -> Player.move_down player);
  Input_handler.register_command (KeyDown "q") (fun () -> Player.move_left player);
  Input_handler.register_command (KeyDown "d") (fun () -> Player.move_right player);

  Input_handler.register_command (KeyUp "z") (fun () -> Player.stop_vertical player);
  Input_handler.register_command (KeyUp "s") (fun () -> Player.stop_vertical player);
  Input_handler.register_command (KeyUp "q") (fun () -> Player.stop_horizontal player);
  Input_handler.register_command (KeyUp "d") (fun () -> Player.stop_horizontal player);

  Game_state.init player;
  false


let play_game dt =
  System.update_all dt;
  true

let game_over _dt = 
	false

(* Question 2.3 *)
let run () = Gfx.main_loop (
        chain_functions [
            init_game;
            play_game;
            game_over 
        ])