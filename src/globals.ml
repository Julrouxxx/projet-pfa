(* Définitions globales, qu'on suppose constantes *)
let canvas_width = 800
let canvas_height = 600
let player_size = 20
let wall_thickness = 20

let player_init_x = float (canvas_width / 2 - player_size / 2)
let player_init_y = float (canvas_height / 2 - player_size / 2)

let direction_right = 1
let direction_left = 2
let direction_up = 3
let direction_down = 4

let invincibility_duration = 2.0;