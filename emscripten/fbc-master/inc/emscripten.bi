' Header for the FreeBASIC(fbjs) -> emscripten target
' Version: 2026/01/26

#define emscripten

#define CRLF !"\r\n"
#define LF !"\n"
#define _n !"\n" __FB_UNQUOTE__("_")

#define EMSCRIPTEN_KEEPALIVE(_Name) _Name cdecl alias __FB_EVAL__("__attribute__((used)) "+#_Name)
#macro DeclareFix(_Type,_Name)
  #undef _Name
  declare _Type _Name cdecl alias #_Name
#endmacro

'================================================================================
'#macro __EMSCRIPTEN_KEEPALIVE(_Name)
  '#define _Name _##_Name cdecl alias __FB_EVAL__("__attribute__((used)) "+#_Name)
  '#macro _DeclareFix
  '  #undef _Name
  '  declare     
'#endmacro
'================================================================================

type em_callback_func as sub ()
type em_arg_callback_func as sub(as any ptr)

extern "C"
  declare sub      emscripten_set_main_loop     (func as any ptr,fps as integer,simulate_infinite_loop as integer)
  declare sub      emscripten_cancel_main_loop  (func as any ptr,fps as integer,simulate_infinite_loop as integer)
  declare sub      emscripten_async_call        (as any ptr, arg as any ptr, millis as integer)
  declare sub      emscripten_async_wget        (url as zstring ptr,file as zstring ptr,onload as sub (as zstring ptr),onerror as sub (as zstring ptr))
  declare function emscripten_get_now           () as single
  declare sub      emscripten_run_script        (script as const zstring ptr)  
  declare function emscripten_run_script_int    (script as const zstring ptr) as long
  declare function emscripten_run_script_string (script as const zstring ptr) as zstring ptr
  declare sub      emscripten_async_run_script  (script as const zstring ptr , millis as long)
  'declare sub      emscripten_async_load_script (url as zstring ptr, onload as sub (),onerror as sub ())
  declare sub      emscripten_async_load_script (url as zstring ptr, onload as em_callback_func ,onerror as em_callback_func)
end extern

'=========================================================================
'================================ HELPERS ================================
'=========================================================================
static shared as byte g__Loaded , g__Failed
sub __OnLoad() : g__Loaded = 1 : end sub
sub __OnError() : g__Failed = 1 : end sub
sub LoadAsyncJS( sFileJS as string )
  g__Loaded = 0 : g__Failed = 0 : emscripten_async_load_script( sFileJS , @__OnLoad , @__OnError )
end sub
function WaitLoadJS() as long
  do
    if g__Loaded then return 1
    if g__Failed then return 0
    sleep 1,1
  loop
end function  

