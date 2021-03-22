type obstacle = {time: int; t: string; x: int; y: int; direction: int; speed: float};;
type level = {effect: string list ; obstacles: obstacle list };;
let rec load_effects acc =
    match acc with
    effect :: effects -> effect::(load_effects effects)
    | [] -> acc ;;
let load_obstacles_aux acc =
    match acc with
    [time; t; x; y; direction; speed] -> {time=(int_of_string time); t=t; x=(int_of_string x); y=(int_of_string y); direction=(int_of_string direction); speed=(float_of_string speed)}
    | _ -> failwith "Error" ;;
let rec load_obstacles acc =
    match acc with
     obstacle::obstacles -> (load_obstacles_aux (String.split_on_char '|' obstacle))::(load_obstacles obstacles)
    | []  -> []
;;
let load_line line =
   match String.split_on_char ',' line with
       [effects; obstacles] -> {effect=(load_effects (String.split_on_char ';' effects)); obstacles=(load_obstacles (String.split_on_char '@' obstacles))}
       | _ -> failwith "Error 1";;
let load_data file =
    let list = ref [] in
    let ic = open_in file in
    let () =
      try
        while true do
           let line = input_line ic in
           list := !list@[(load_line line)];
            done
        with End_of_file -> ()
        in
         !list;;
load_data "../resources/static/data";;

