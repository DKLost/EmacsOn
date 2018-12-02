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

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)

is_target(){
  ifWinActive,ahk_class ConsoleWindowClass ; Cygwin
    return 1
  ifWinActive,ahk_class MEADOW ; Meadow
    return 1 
  ifWinActive,ahk_class cygwin/x X rl-xterm-XTerm-0
    return 1
  ifWinActive,ahk_class MozillaUIWindowClass ; keysnail on Firefox
    return 1
  ifWinActive,ahk_class VMwareUnityHostWndClass
    return 1
  ifWinActive,ahk_class Vim ; GVIM
    return 1
; ifWinActive,ahk_class SWT_Window0 ; Eclipse
;   return 1
  ifWinActive,ahk_class Xming X
    return 1
; ifWinActive,ahk_class SunAwtFrame
;   return 1
  ifWinActive,ahk_class Emacs
    return 1
  ifWinActive,ahk_exe VirtualBox.exe
    return 1
; ifWinActive,ahk_class XEmacs ; XEmacs on Cygwin
;   return 1
  return 0
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

^x::
  if is_target()
    Send %A_ThisHotkey%
  else
    is_pre_x = 1
  return 
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
!f::
  if is_target()
    Send %A_ThisHotKey%
  else
    forward_word()
  return 
^c::
  if is_target()
    Send %A_ThisHotkey%
  else
  {
    if is_pre_x
      kill_emacs()
  }
  return  
^d::
  if is_target()
    Send %A_ThisHotkey%
  else
    delete_char()
  return
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
^o::
   if is_target()
     Send %A_ThisHotkey%
   else
     open_line()
   return
^g::
  if is_target()
    Send %A_ThisHotkey%
  else
    quit()
  return
^j::
   if is_target()
     Send %A_ThisHotkey%
   else
     newline_and_indent()
   return
^m::
  if is_target()
    Send %A_ThisHotkey%
  else
    newline()
  return
^i::
  if is_target()
    Send %A_ThisHotkey%
  else
    indent_for_tab_command()
  return
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
^r::
  if is_target()
    Send %A_ThisHotkey%
  else
    isearch_backward()
  return
^w::
  if is_target()
    Send %A_ThisHotkey%
  else
    kill_region()
  return
!w::
  if is_target()
    Send %A_ThisHotkey%
  else
    kill_ring_save()
  return
^y::
  if is_target()
    Send %A_ThisHotkey%
  else
    yank()
  return
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
^a::
  if is_target()
    Send %A_ThisHotkey%
  else
    move_beginning_of_line()
  return
^e::
  if is_target()
    Send %A_ThisHotkey%
  else
    move_end_of_line()
  return
^p::
  if is_target()
    Send %A_ThisHotkey%
  else
    previous_line()
  return
^n::
  if is_target()
    Send %A_ThisHotkey%
  else
    next_line()
  return
^b::
  if is_target()
    Send %A_ThisHotkey%
  else
    backward_char()
  return
!b::
  if is_target()
    Send %A_ThisHotKey%
  else
    backward_word()
  return 
^v::
  if is_target()
    Send %A_ThisHotkey%
  else
    scroll_down()
  return
!v::
  if is_target()
    Send %A_ThisHotkey%
  else
    scroll_up()
  return
!<::
  if is_target()
    Send %A_ThisHotKey%
  else
    move_to_top()
  return
!>::
  if is_target()
    Send %A_ThisHotKey%
  else
    move_to_end()
  return
#CapsLock::Suspend

#if !is_target()
  CapsLock::Ctrl
  +CapsLock::CapsLock