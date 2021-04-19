type animation = {
  frames : Gfx.render array;
  mutable current : int
}

type t = 
  Color of Gfx.color
| Image of Gfx.render
| Animation of animation
| Text of (string * string * Gfx.color) (* text * font * color *)

let black = Color (Gfx.color 0 0 0 255)
let red = Color (Gfx.color 255 0 0 255)
let blue = Color (Gfx.color 0 0 255 255)

let gray = Color (Gfx.color 128 128 128 255)
let white = Color (Gfx.color 255 255 255 255)
let alpha_zero = Color (Gfx.color 0 0 0 0)

let create_image img w h = 
  let os = Gfx.create_offscreen w h in
  Gfx.draw_image_scale os img 0 0 w h;
  Image os

let create_animation img num_w num_h sw sh dw dh =
  let frames = Array.init (num_w * num_h) (fun _ -> Gfx.create_offscreen dw dh) in
  let x = ref 0 in
  let y = ref 0 in
  for j = 0 to num_h - 1 do
    for i = 0 to num_w - 1 do
      Gfx.draw_image_full frames.(j * num_w + i) img !x !y sw sh 0 0 dw dh;
      x := !x + sw;
    done;
    x := 0;
    y := !y + sh;
  done;
  Animation { current = 0; frames = frames }

let get_frame anim dir =
  let f = anim.frames.(anim.current) in
  let d = 
    if dir > 0 then 1 else if dir < 0 then -1 else 0
  in
  let len = Array.length anim.frames in
  anim.current <- (anim.current + len + d) mod len;
  f