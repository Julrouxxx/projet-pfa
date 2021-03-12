type t = { right : bool ; left : bool ; up : bool ; down : bool }

let zero = { right = false ; left = false ; up = false ; down = false }
let is_zero d = d.right = false && d.left = false && d.up = false && d.down = false

let is_zero_horizontal d = d.right = true && d.left = true || d.right = false && d.left = false
let is_zero_vertical d = d.up = true && d.down = true || d.up = false && d.down = false

let set_right d b = { right = b ; left = d.left ; up = d.up ; down = d.down }
let set_left d b = { right = d.right ; left = b ; up = d.up ; down = d.down }
let set_up d b = { right = d.right ; left = d.left ; up = b ; down = d.down }
let set_down d b = { right = d.right ; left = d.left ; up = d.up ; down = b }