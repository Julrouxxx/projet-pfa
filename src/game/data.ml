open Ecs

type obstacle = {time: float; t: string; x: int; y: int; direction: int; speed: float}
type level = {red: int; green: int; blue: int ; obstacles: obstacle list }
let list = ref []


let load_obstacles_aux acc =
    match acc with
    [time; t; x; y; direction; speed] -> {time=(float_of_string time); t=t; x=(int_of_string x); y=(int_of_string y); direction=(int_of_string direction); speed=(float_of_string speed)}
    | _ -> failwith "Error" 

let rec load_obstacles acc =
    match acc with
     obstacle::obstacles -> (load_obstacles_aux (String.split_on_char '|' obstacle))::(load_obstacles obstacles)
    | []  -> []

let load_line line =
   match String.split_on_char ',' line with
       [colors; obstacles] -> {red=  int_of_string (List.nth (String.split_on_char ';' colors) 0); green=  int_of_string (List.nth (String.split_on_char ';' colors) 1); blue= int_of_string (List.nth (String.split_on_char ';' colors) 2); obstacles=(load_obstacles (String.split_on_char '@' obstacles))}
       | _ -> failwith "Error 1"


let load_string line =
    list := [(load_line line)];
    List.hd !list

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
         !list

let size_level () =
    let s = List.length !list in
    s

let _get_color_red level =
     let l  = List.nth !list level in
     let o = l.red in
     o

let _get_color_green level =
    let l  = List.nth !list level in
    let o = l.green in
    o

let _get_color_blue level =
    let l  = List.nth !list level in
    let o = l.blue in
    o

let _size_obstacle level =
    let l = List.nth !list level in
    List.length l.obstacles

let _get_obstacle level o =
    let l  = List.nth !list level in
    let o = List.nth (l.obstacles) o in
    o

let str = ref ""

let create_obstacle time obsType x y direction speed =
  let t = string_of_float (time) ^ "|" ^ 
          obsType ^ "|" ^ 
          string_of_int (x) ^ "|" ^ 
          string_of_int (y) ^ "|" ^ 
          string_of_int (direction) ^ "|" ^ 
          string_of_float (speed) ^ "@" in
  t


let init_data r g b =
    str := "//" ^ string_of_int r ^ ";" ^ string_of_int g ^ ";" ^ string_of_int b ^ ",";
    ()

let create_level l =
  str := "";
  match l with
    1 ->  init_data 255 255 0;
          for i = 0 to (*96*)3 do
            let random_direction = 1+(Random.int 4) in
            let random_int_X = ref 0 in
            let random_int_Y = ref 0 in
            if random_direction == Globals.direction_down || random_direction == Globals.direction_up then begin
              random_int_X := 1+(Random.int 30);
              if random_direction == Globals.direction_up then
                random_int_Y := 17;
            end
             else if random_direction == Globals.direction_right || random_direction == Globals.direction_left then begin
              random_int_Y := 1+(Random.int 16);
              if random_direction == Globals.direction_left then
                random_int_X := 31;
            end;
            str := !str ^ (create_obstacle (500.0 *. (float_of_int i)) "OBS" !random_int_X !random_int_Y random_direction 50.0);
          done;
          str := String.sub  !str 0 (String.length !str - 1);
          !str
  | 2 -> init_data 255 0 255;
          for i = 0 to 16 do
            let random_direction = 1+(Random.int 4) in
            let random_int_X = ref 0 in
            let random_int_Y = ref 0 in
            if random_direction == Globals.direction_down || random_direction == Globals.direction_up then begin
              if random_direction == Globals.direction_up then
                random_int_Y := 17;
              random_int_X := 2+(Random.int 28);
              for j = 1 to 30 do
                if(not(!random_int_X - 1 <= j && j <= !random_int_X + 1)) then
                  str := !str ^ (create_obstacle (3000.0 *. (float_of_int i)) "OBS" j !random_int_Y random_direction 50.0);
              done;
            end
             else if random_direction == Globals.direction_right || random_direction == Globals.direction_left then begin
              if random_direction == Globals.direction_left then
                random_int_X := 31;
              random_int_Y := 2+(Random.int 14);
              for j = 1 to 16 do
                if(not(!random_int_Y - 1 <= j && j <= !random_int_Y + 1)) then
                  str := !str ^ (create_obstacle (3000.0 *. (float_of_int i)) "OBS" !random_int_X j random_direction 50.0);
              done;
            end;
          done;
          str := String.sub  !str 0 (String.length !str - 1);
          !str
  | 3 -> !str (* do level 3 *)
  | _ -> !str (* unknown *) 