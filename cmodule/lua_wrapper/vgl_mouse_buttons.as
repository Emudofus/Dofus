package cmodule.lua_wrapper
{
   function vgl_mouse_buttons() : int {
      var stage:Stage = null;
      if(vglMouseFirst)
      {
         stage = gsprite.stage;
         stage.addEventListener(MouseEvent.MOUSE_DOWN,function(param1:MouseEvent):*
         {
            var vglMouseButtons:* = 1;
         });
         stage.addEventListener(MouseEvent.MOUSE_UP,function(param1:MouseEvent):*
         {
            var vglMouseButtons:* = 0;
         });
         vglMouseFirst = false;
      }
      return vglMouseButtons;
   }
}
