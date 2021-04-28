open Ecs

type t = {
  
  title : (Entity.t * string);
  endless : (Entity.t * string);
  niveaux : (Entity.t * string);
  niveau1 : Entity.t;
  niveau2 : Entity.t;
  niveau3 : Entity.t;
  listNiveaux : string list;
  keyPressedHaut : bool;
  keyPressedBas : bool;
  isNiveau : bool;
  currentMode : int;
  currentNiveau : int;
}

let state = ref {

  title = (Entity.dummy, "");
  endless = (Entity.dummy, "");
  niveaux = (Entity.dummy, "");
  niveau1 = Entity.dummy;
  niveau2 = Entity.dummy;
  niveau3 = Entity.dummy;
  listNiveaux = [];
  keyPressedHaut = false;
  keyPressedBas = false;
  isNiveau = false;
  currentMode = 1;
  currentNiveau = 1;
}

let clear () =
  state := {
    title = (Entity.dummy, "");
    endless = (Entity.dummy, "");
    niveaux = (Entity.dummy, "");
    niveau1 = Entity.dummy;
    niveau2 = Entity.dummy;
    niveau3 = Entity.dummy;
    listNiveaux = [];
    keyPressedHaut = false;
    keyPressedBas = false;
    isNiveau = false;
    currentMode = 1;
    currentNiveau = 1;
  }

let get_title () = !state.title
let get_endless () = !state.endless
let get_niveaux () = !state.niveaux
let get_niveau1 () = !state.niveau1
let get_niveau2 () = !state.niveau2
let get_niveau3 () = !state.niveau3
let get_listNiveaux () = !state.listNiveaux
let get_currentMode () = !state.currentMode

let set_title p =
  state := { !state with title = p }
let set_endless p =
  state := { !state with endless = p }
let set_niveaux p =
  state := { !state with niveaux = p }
let set_niveau1 p =
  state := { !state with niveau1 = p }
let set_niveau2 p =
  state := { !state with niveau2 = p }
let set_niveau3 p =
  state := { !state with niveau3 = p }

let add_listNiveaux p =
  state := { !state with listNiveaux = !state.listNiveaux@[p] }
let remove_listNiveaux p =
  state := { !state with listNiveaux = (List.filter (fun x -> x != p) !state.listNiveaux) }

let event () = 
  Gfx.debug (string_of_int (!state.currentMode));
  match !state.currentMode with
  | 1 -> 
    Text.set_text (fst !state.endless) ("> "^(snd !state.endless)) 25;
    Text.set_text (fst !state.niveaux) ("  "^(snd !state.niveaux)) 25;
    (Text.hide_text !state.niveau1);
    (Text.hide_text !state.niveau2);
    (Text.hide_text !state.niveau3)
  | 2 -> 
    Text.set_text (fst !state.endless) ("  "^(snd !state.endless)) 25;
    if (!state.isNiveau) then
      Text.set_text (fst !state.niveaux) ("  "^(snd !state.niveaux)) 25
    else
      Text.set_text (fst !state.niveaux) ("> "^(snd !state.niveaux)) 25;
    (Text.show_text !state.niveau1);
    (Text.show_text !state.niveau2);
    (Text.show_text !state.niveau3);

    if (!state.currentNiveau - 1) > 0 then
      Text.set_text !state.niveau1 ("  "^(List.nth !state.listNiveaux (!state.currentNiveau - 1 - 1))) 25
    else 
      Text.set_text !state.niveau1 "" 25;

    if (!state.currentNiveau) < List.length (!state.listNiveaux) then
      Text.set_text !state.niveau3 ("  "^(List.nth !state.listNiveaux (!state.currentNiveau - 1 + 1))) 25
    else 
      Text.set_text !state.niveau3 "" 25;

    if (!state.isNiveau) then
      Text.set_text !state.niveau2 ("> "^(List.nth !state.listNiveaux (!state.currentNiveau - 1))) 25
    else
      Text.set_text !state.niveau2 ("  "^(List.nth !state.listNiveaux (!state.currentNiveau - 1))) 25
  | _ -> 
    (Text.hide_text !state.niveau1);
    (Text.hide_text !state.niveau2);
    (Text.hide_text !state.niveau3)

let event_haut () = 
  if(not(!state.keyPressedHaut)) then begin
    state := { !state with keyPressedHaut = true };
    if !state.isNiveau then begin
      if 1 < !state.currentNiveau then
        state := { !state with currentNiveau = !state.currentNiveau - 1 };
    end
    else begin
      if 1 < !state.currentMode then
        state := { !state with currentMode = !state.currentMode - 1 };
    end;
    event ();
  end


let event_bas () = 
  if(not(!state.keyPressedBas)) then begin
    state := { !state with keyPressedBas = true };
    if !state.isNiveau then begin
      if !state.currentNiveau < (List.length (!state.listNiveaux)) then
        state := { !state with currentNiveau = !state.currentNiveau + 1 };
    end
    else begin
      if !state.currentMode < 2 then
        state := { !state with currentMode = !state.currentMode + 1 };
    end;
    event ();
  end

let release_haut () =
  state := { !state with keyPressedHaut = false }

let release_bas () =
  state := { !state with keyPressedBas = false }

let enter () =
  match !state.currentMode with
  | 1 -> 
      Game_state.set_numLevel 1;
      Game_state.set_isRepeat false;
      Game_state.play ()
  | 2 -> 
    if not(!state.isNiveau) then begin
      state := { !state with isNiveau = true };
      event ();
    end else begin
      Game_state.set_numLevel (int_of_string (List.nth !state.listNiveaux (!state.currentNiveau - 1)));
      Game_state.set_isRepeat true;
      Game_state.play ();
    end 
  | _ -> ()

let back () =
  match !state.currentMode with
  | 1 -> ()
  | 2 -> 
    if !state.isNiveau then
      state := { !state with isNiveau = false };
    event ()
  | _ -> ()