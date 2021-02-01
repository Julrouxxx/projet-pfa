(* All our objects *)

let player1 =
  Player.create "player1" Globals.player1_init_x Globals.player_init_y
let player2 =
  Player.create "player2" Globals.player2_init_x Globals.player_init_y
let wall_top = Wall.create "wall_top" 0.0 0.0
let wall_bottom = Wall.create "wall_bottom" 0.0 580.0
let iwall_left = Score_zone.create "wall_left" player2 0.0 20.0
let iwall_rght = Score_zone.create "wall_right" player1 760.0 20.0

let ball = Ball.create "ball" Globals.ball_player1_init_x Globals.ball_init_y

let () =
  Input_handler.register_command (KeyDown "w") (fun () -> Player.move_up player1);
  Input_handler.register_command (KeyDown "s") (fun () -> Player.move_down player1);
  Input_handler.register_command (KeyUp "w") (fun () -> Player.stop player1);
  Input_handler.register_command (KeyUp "s") (fun () -> Player.stop player1);

  Input_handler.register_command (KeyDown "i") (fun () -> Player.move_up player2);
  Input_handler.register_command (KeyDown "k") (fun () -> Player.move_down player2);
  Input_handler.register_command (KeyUp "i") (fun () -> Player.stop player2);
  Input_handler.register_command (KeyUp "k") (fun () -> Player.stop player2);

  Input_handler.register_command (KeyDown "n") (fun () -> Ball.launch ball);

  Game_state.init ball player1 player2

(* *)
let init () = System.init_all ()

let frames = ref 0
let time = ref 0.0
let update dt =
  if !frames mod 600 == 0 then begin
    let t = dt -. !time in
    Gfx.debug (Format.asprintf "%f fps" (1000. *. float !frames /. t));
    time := dt;
    frames := 0
  end;
  incr frames;
  (* Update all systems *)
  System.update_all dt;
  (* Repeat indefinitely *)
  true

let update_loop () = Gfx.main_loop update

let () =
  init ();
  update_loop ()
