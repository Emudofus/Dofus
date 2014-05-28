package cmodule.lua_wrapper
{
   public function vgl_keyinit(param1:int) : int {
      trace("vgl_keymode: " + param1);
      var vglKeyMode:* = param1;
      return 0;
   }
}
