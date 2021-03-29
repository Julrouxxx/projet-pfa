open Component_defs

let init () = ()

let time = ref 0.0
let update dt el =
  List.iter (fun e ->
  	let invinc = Invincibility.get e in
    let delta_t = min (1. /. 60.) (1000. *.(dt -. !time)) in
    time := dt;
    if invinc > 0.0 then begin
      Invincibility.set e ((Invincibility.get e)-.delta_t);
      if (int_of_float (invinc/.0.08) mod 2) = 0 then
        Surface.set e Texture.blue
      else
        Surface.set e Texture.alpha_zero

    end
    else begin
      Invincibility.set e 0.0;
      Surface.set e Texture.blue
    end
    ) el
