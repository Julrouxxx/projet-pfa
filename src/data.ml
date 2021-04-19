type obstacle = {time: float; t: string; x: int; y: int; direction: int; speed: float};;
type level = {effect: string list ; obstacles: obstacle list };;
let list = ref [];;

let rec load_effects acc =
    match acc with
    effect :: effects -> effect::(load_effects effects)
    | [] -> acc ;;
let load_obstacles_aux acc =
    match acc with
    [time; t; x; y; direction; speed] -> {time=(float_of_string time); t=t; x=(int_of_string x); y=(int_of_string y); direction=(int_of_string direction); speed=(float_of_string speed)}
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
    let ic = open_in file in
    let () =
      try
        while true do
           let lineRaw = input_line ic in
           let line = String.sub lineRaw 2 (String.length lineRaw - 2) in
           list := !list@[(load_line line)];
            done
        with End_of_file -> ()
        in
         !list;;
let size_level () =
    let s = List.length !list in
    s;;
let _size_obstacle level =
    let l = List.nth !list level in
    List.length l.effect;;
let _get_effect level e =
     let l  = List.nth !list level in
     let o = List.nth (l.effect) e in
     o;;
let _size_obstacle level =
    let l = List.nth !list level in
    List.length l.obstacles;;
let _get_obstacle level o =
    let l  = List.nth !list level in
    let o = List.nth (l.obstacles) o in
    o;;

let write_data file =
    let oc = open_out file in
    begin
    (*Level 1*)
    Printf.fprintf oc "//,";
    for i = 1 to 100  do
    if i != 1 then begin
    Printf.fprintf oc "@";
    end;
        let random_direction = 1+(Random.int 4) in
        let random_int_X = ref 0 in
        let random_int_Y = ref 0 in
        if random_direction == Globals.direction_down || random_direction == Globals.direction_up then begin
          random_int_X := 1+(Random.int 30);
          if random_direction == Globals.direction_up then
            random_int_Y := 17;
        end
         else if random_direction == Globals.direction_right || random_direction == Globals.direction_left then begin
          random_int_Y := 1+(Random.int 15);
          if random_direction == Globals.direction_left then
            random_int_X := 31;
        end;
             Printf.fprintf oc "%f|OBS|%d|%d|%d|%f"  (500.0 *. (float_of_int i)) !random_int_X !random_int_Y random_direction 50.0;
             (*if i == 100 then begin Printf.fprintf oc "\n"; end;*)
      done;

    close_out oc;
    end;
