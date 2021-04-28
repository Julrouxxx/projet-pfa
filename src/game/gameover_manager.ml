open Ecs

type t = {
  
  title : Entity.t;
  message : Entity.t;
  score1 : Entity.t;
  score2 : Entity.t;
}

let state = ref {

  title = Entity.dummy;
  message = Entity.dummy;
  score1 = Entity.dummy;
  score2 = Entity.dummy;
}

let clear () =
  state := {
    title = Entity.dummy;
    message = Entity.dummy;
    score1 = Entity.dummy;
    score2 = Entity.dummy;
  }

let get_title () = !state.title
let get_message () = !state.message
let get_score1 () = !state.score1
let get_score2 () = !state.score2

let set_title p =
  state := { !state with title = p }
let set_message p =
  state := { !state with message = p }
let set_score1 p =
  state := { !state with score1 = p }
let set_score2 p =
  state := { !state with score2 = p }