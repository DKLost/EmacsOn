;;
;; An autohotkey script that provides emacs-like keybinding on Windows
;;
#InstallKeybdHook
#UseHook

SetKeyDelay 0

; turns to be 1 when ctrl-x is pressed
is_pre_x = 0
; turns to be 1 when ctrl-space is pressed
is_pre_spc = 0

is_target(){
  return 0
}

select_all(){
  global
  if is_pre_x
    Send ^a 
  else
    Send h
  return
}

delete_char(){
  Send {Del}
  global is_pre_spc = 0
  return
}
kill_forward(){
  Send {ShiftDown}{END}{SHifTUP}
  Sleep 50 ;[ms] this value depends on your environment
  Send ^x
  global is_pre_spc = 0
  return
}
kill_backward(){
  Send {ShiftDown}{HOME}{SHifTUP}
  Sleep 50 ;[ms] this value depends on your environment
  Send ^x
  global is_pre_spc = 0
  global is_pre_x = 0
  return
}
open_line(){
  Send {Enter}{Up}{END}
  global is_pre_spc = 0
  return
}
quit(){
  global
  if is_pre_spc || is_pre_x{
    is_pre_spc = 0
    is_pre_x = 0
  }
  else 
    Send {ESC}
  return
}
newline(){
  Send {Enter}
  global is_pre_spc = 0
  return
}
indent_for_tab_command(){
  Send {Tab}
  global is_pre_spc = 0
  return
}
newline_and_indent(){
  Send {Enter}{Tab}
  global is_pre_spc = 0
  return
}
isearch_forward(){
  Send ^f
  global is_pre_spc = 0
  return
}
isearch_backward(){
  Send ^f
  global is_pre_spc = 0
  return
}
kill_region(){
  Send ^x
  global is_pre_spc = 0
  return
}
kill_ring_save(){
  Send ^c
  global is_pre_spc = 0
  return
}
yank(){
  Send ^v
  global is_pre_spc = 0
  return
}
undo(){
  Send ^z
  global is_pre_spc = 0
  return
}
redo(){
  Send ^y
  global is_pre_spc = 0
  return
}
find_file(){
  Send ^o
  global is_pre_x = 0
  return
}
save_buffer(){
  Send, ^s
  global is_pre_x = 0
  return
}
kill_emacs(){
  Send !{F4}
  global is_pre_x = 0
  return
}

move_beginning_of_line(){
  global
  if is_pre_spc
    Send +{HOME}
  else
    Send {HOME}
  return
}
move_end_of_line(){
  global
  if is_pre_spc
    Send +{END}
  else
    Send {END}
  return
}
previous_line(){
  global
  if is_pre_spc
    Send +{Up}
  else
    Send {Up}
  return
}
next_line(){
  global
  if is_pre_spc
    Send +{Down}
  else
    Send {Down}
  return
}
forward_char(){
  global
  if is_pre_spc
    Send +{Right}
  else
    Send {Right}
  return
}
forward_word(){
  global
  if is_pre_spc
    Send +{Left} 
  else
    Send ^{Right}
  return
}
backward_char(){
  global
  if is_pre_spc
    Send +{Left} 
  else
    Send {Left}
  return
}
backward_word(){
  global
  if is_pre_spc
    Send +{Left} 
  else
    Send ^{Left}
  return
}
scroll_up(){
  global
  if is_pre_spc
    Send +{PgUp}
  else
    Send {PgUp}
  return
}
scroll_down(){
  global
  if is_pre_spc
    Send +{PgDn}
  else
    Send {PgDn}
  return
}
move_to_top(){
  global
  if is_pre_spc
    Send +^{Home} 
  else
    Send ^{Home}
  return
}
move_to_end(){
  global
  if is_pre_spc
    Send +^{End} 
  else
    Send ^{End}
  return
}

h:: select_all()
^x:: is_pre_x = 1
^f::
  if is_target()
    Send %A_ThisHotkey%
  else{
    if is_pre_x
      find_file()
    else
      forward_char()
  }
  return  
!f::forward_word()
^c::
  if is_target()
    Send %A_ThisHotkey%
  else
  {
    if is_pre_x
      kill_emacs()
  }
  return  
^d::delete_char()
^k::
  if is_target()
    Send %A_ThisHotkey%
  else{
    if is_pre_x 
      kill_backward()
    else 
      kill_forward()
  }
  return
^o::open_line()
^g::quit()
^j::newline_and_indent()
^m::newline()
^i::indent_for_tab_command()
^s::
  if is_target()
    Send %A_ThisHotkey%
  else{
    if is_pre_x
      save_buffer()
    else
      isearch_forward()
  }
  return
^r::isearch_backward()
^w::kill_region()
!w::kill_ring_save()
^y::yank()
^/::
  if is_target()
    Send %A_ThisHotkey%
  else{
    if is_pre_x
      redo()
    else 
      undo()
  }
  return  
 
^Space::
  if is_target()
    Send {CtrlDown}{Space}{CtrlUp}
  else
  {
    if is_pre_spc
      is_pre_spc = 0
    else
      is_pre_spc = 1
  }
  return
^@::
  if is_target()
    Send %A_ThisHotkey%
  else
  {
    if is_pre_spc
      is_pre_spc = 0
    else
      is_pre_spc = 1
  }
  return
^a::move_beginning_of_line()
^e::move_end_of_line()
^p::previous_line()
^n::next_line()
^b::backward_char()
!b::backward_word()
^v::scroll_down()
!v::scroll_up()
!<::move_to_top()
!>::move_to_end()

#CapsLock::Suspend

#if !is_target()
  CapsLock::Ctrl
  +CapsLock::CapsLock