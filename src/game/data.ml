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

let random_position direction timeSpawn speed =
  let random_int_X = ref 0 in
  let random_int_Y = ref 0 in
  if direction == Globals.direction_down || direction == Globals.direction_up then begin
    random_int_X := 1+(Random.int 30);
    if direction == Globals.direction_up then
      random_int_Y := 17;
  end
   else if direction == Globals.direction_right || direction == Globals.direction_left then begin
    random_int_Y := 1+(Random.int 16);
    if direction == Globals.direction_left then
      random_int_X := 31;
  end;
  str := !str ^ (create_obstacle timeSpawn "OBS" !random_int_X !random_int_Y direction speed);
  ()

let line direction timeSpawn speed =
  let random_int_X = ref 0 in
  let random_int_Y = ref 0 in
  if direction == Globals.direction_down || direction == Globals.direction_up then begin
    if direction == Globals.direction_up then
      random_int_Y := 17;
    random_int_X := 2+(Random.int 28);
    for j = 1 to 30 do
      if(not(!random_int_X - 1 <= j && j <= !random_int_X + 1)) then
        str := !str ^ (create_obstacle timeSpawn "OBS" j !random_int_Y direction speed);
    done;
  end
   else if direction == Globals.direction_right || direction == Globals.direction_left then begin
    if direction == Globals.direction_left then
      random_int_X := 31;
    random_int_Y := 2+(Random.int 14);
    for j = 1 to 16 do
      if(not(!random_int_Y - 1 <= j && j <= !random_int_Y + 1)) then
        str := !str ^ (create_obstacle timeSpawn "OBS" !random_int_X j direction speed);
    done;
  end;
  ()

let diagonal direction timeSpawn speed =
  let random_int_X = ref 0 in
  let random_int_Y = ref 0 in
  if direction == Globals.direction_down || direction == Globals.direction_up then begin
    if direction == Globals.direction_up then
      random_int_Y := 17;
    random_int_X := 2+(Random.int 28);
    for j = 1 to 30 do
      if(not(!random_int_X - 1 <= j && j <= !random_int_X + 1)) then
        str := !str ^ (create_obstacle (timeSpawn+.20000.0/.speed*.(float_of_int (j)-.1.0)) "OBS" j !random_int_Y direction speed);
    done;
  end
   else if direction == Globals.direction_right || direction == Globals.direction_left then begin
    if direction == Globals.direction_left then
      random_int_X := 31;
    random_int_Y := 2+(Random.int 14);
    for j = 1 to 16 do
      if(not(!random_int_Y - 1 <= j && j <= !random_int_Y + 1)) then
        str := !str ^ (create_obstacle (timeSpawn+.20000.0/.speed*.(float_of_int (j)-.1.0)) "OBS" !random_int_X j direction speed);
    done;
  end;
  ()

let reverse_diagonal direction timeSpawn speed =
  let random_int_X = ref 0 in
  let random_int_Y = ref 0 in
  if direction == Globals.direction_down || direction == Globals.direction_up then begin
    if direction == Globals.direction_up then
      random_int_Y := 17;
    random_int_X := 2+(Random.int 28);
    for j = 1 to 30 do
      if(not(!random_int_X - 1 <= j && j <= !random_int_X + 1)) then
        str := !str ^ (create_obstacle (timeSpawn+.20000.0/.speed*.(float_of_int (31-j)-.1.0)) "OBS" j !random_int_Y direction speed);
    done;
  end
   else if direction == Globals.direction_right || direction == Globals.direction_left then begin
    if direction == Globals.direction_left then
      random_int_X := 31;
    random_int_Y := 2+(Random.int 14);
    for j = 1 to 16 do
      if(not(!random_int_Y - 1 <= j && j <= !random_int_Y + 1)) then
        str := !str ^ (create_obstacle (timeSpawn+.20000.0/.speed*.(float_of_int (17-j)-.1.0)) "OBS" !random_int_X j direction speed);
    done;
  end;
  ()

let create_level l =
  str := "";
  match l with
    1 ->  init_data 255 255 0;
          for i = 0 to 96 do
            let random_direction = 1+(Random.int 4) in
            random_position random_direction (500.0 *. (float_of_int i)) 50.0;
          done;
          str := String.sub  !str 0 (String.length !str - 1);
          !str
  | 2 -> init_data 255 0 255;
          for i = 0 to 16 do
            let random_direction = 1+(Random.int 4) in
            line random_direction (3000.0 *. (float_of_int i)) 50.0;
          done;
          str := String.sub  !str 0 (String.length !str - 1);
          !str
  | 3 -> init_data 255 0 0;
          for i = 0 to 26 do
            line 1 (2000.0 *. (float_of_int i)) 75.0;
          done;
          for i = 0 to 103 do
            random_position 4 (500.0 *. (float_of_int i)) 70.0;
          done;
          str := String.sub  !str 0 (String.length !str - 1);
          !str
  | 4 -> init_data 0 255 255;
          str := !str ^ (create_obstacle 0.0 "WALL" 5 5 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 26 5 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 26 12 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 5 12 0 100.0);

          str := !str ^ (create_obstacle 0.0 "WALL" 8 7 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 23 7 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 23 10 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 8 10 0 100.0);

          str := !str ^ (create_obstacle 0.0 "WALL" 11 5 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 20 5 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 20 12 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 11 12 0 100.0);

          str := !str ^ (create_obstacle 0.0 "WALL" 14 7 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 17 7 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 17 10 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 14 10 0 100.0);
          for i = 0 to 9 do
            diagonal 1 (5000.0 *. (float_of_int i)) 60.0;
          done;
          for i = 0 to 9 do
            reverse_diagonal 2 (5000.0 *. (float_of_int i)) 60.0;
          done;
          str := String.sub  !str 0 (String.length !str - 1);
          !str
  | 5 -> init_data 0 255 255;
          str := !str ^ (create_obstacle 0.0 "WALL" 5 5 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 26 5 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 26 12 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 5 12 0 100.0);

          str := !str ^ (create_obstacle 0.0 "WALL" 8 7 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 23 7 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 23 10 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 8 10 0 100.0);

          str := !str ^ (create_obstacle 0.0 "WALL" 11 5 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 20 5 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 20 12 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 11 12 0 100.0);

          str := !str ^ (create_obstacle 0.0 "WALL" 14 7 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 17 7 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 17 10 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 14 10 0 100.0);
          for i = 0 to 9 do
            diagonal 1 (5000.0 *. (float_of_int i)) 60.0;
          done;
          for i = 0 to 9 do
            reverse_diagonal 2 (5000.0 *. (float_of_int i)) 60.0;
          done;
          str := String.sub  !str 0 (String.length !str - 1);
          !str
  | 6 -> init_data 0 255 255;
          str := !str ^ (create_obstacle 0.0 "WALL" 5 5 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 26 5 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 26 12 0 100.0);
          str := !str ^ (create_obstacle 0.0 "WALL" 5 12 0 100.0);
          for i = 0 to 9 do
            diagonal 1 (5000.0 *. (float_of_int i)) 60.0;
          done;
          for i = 0 to 9 do
            reverse_diagonal 2 (5000.0 *. (float_of_int i)) 60.0;
          done;
          str := String.sub  !str 0 (String.length !str - 1);
          !str
  | _ -> !str (* unknown *) 