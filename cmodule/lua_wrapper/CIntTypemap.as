package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   class CIntTypemap extends CTypemap
   {
      
      function CIntTypemap() {
         super();
      }
      
      override public function fromC(param1:Array) : * {
         return int(param1[0]);
      }
      
      override public function createC(param1:*, param2:int=0) : Array {
         return [int(param1)];
      }
   }
}
