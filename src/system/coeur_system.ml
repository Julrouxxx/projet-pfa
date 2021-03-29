open Component_defs

let init () = ()

let update _dt el =
  List.iter (fun e ->
  	let numLife = Life.get e in
    if (Life.get (Game_state.get_player ())) >= numLife then
      Surface.set e (Texture.create_image (Image1.get e) (Box.get e).width (Box.get e).width)
    else
      Surface.set e (Texture.create_image (Image2.get e) (Box.get e).width (Box.get e).width)
    ) el
