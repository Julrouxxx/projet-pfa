open Component_defs

let init () = ()

let update _dt el =
  List.iter (fun e ->

    if not (TimeSpawn.has_component e && TimeSpawn.get e >= _dt) then begin
	  	let vert = Vert.get e in
	  	if vert <= 0.0 then begin
	  		if Destroyer.has_component e then (Destroyer.get e) e;
	  	end else begin
	  		Vert.set e (vert -. 3.0);
  			Surface.set e (Color (Gfx.color 255 (int_of_float (Vert.get e)) 0 255));
	  	end;
  	end
    ) el
