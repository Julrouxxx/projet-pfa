open Component_defs

let init () = ()

let update _dt el =
  List.iter (fun e ->

    if not (TimeSpawn.has_component e && TimeSpawn.get e >= _dt) then begin
    	let move = Movement.get e in
    	let speed = Speed.get e in

    	if Direction.is_zero move then
    		Velocity.set e { x = 0.0; y = 0.0 }
    	else begin

    		if Direction.is_zero_horizontal move then
    			Velocity.set e { x = 0.0; y = (Velocity.get e).y }
    		else begin

  	  		if move.right == true then
  	  			Velocity.set e { x = speed; y = (Velocity.get e).y };

  	  		if move.left == true then
  	  			Velocity.set e { x = -.speed; y = (Velocity.get e).y }
    		end;

    		if Direction.is_zero_vertical move then
    			Velocity.set e { x = (Velocity.get e).x; y = 0.0 }
    		else begin

  	  		if move.up == true then
  	  			Velocity.set e { x = (Velocity.get e).x; y = -.speed };

  	  		if move.down == true then
  	  			Velocity.set e { x = (Velocity.get e).x; y = speed }
    		end;
    	end
    end
    ) el
