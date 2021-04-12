open Component_defs

let init () = ()

let update _dt el =
  List.iter (fun e ->

    if not (TimeSpawn.has_component e && TimeSpawn.get e >= _dt) then begin
	  	let pos = Position.get e in
	  	if not ((float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0) <= pos.x && 
	  		pos.x <= (float_of_int (Globals.canvas_width)/.2.0-.float_of_int (Globals.player_size)*.32.0/.2.0+.float_of_int (Globals.player_size)*.31.0) &&
	  		(float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0) <= pos.y &&
	  		pos.y <= (float_of_int (Globals.canvas_height)/.2.0-.float_of_int (Globals.player_size)*.18.0/.2.0+.float_of_int (Globals.player_size)*.17.0)) then
	  		if Destroyer.has_component e then (Destroyer.get e) e;
  	end
    ) el
