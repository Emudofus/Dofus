package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   class CBufferTypemap extends CTypemap
   {
      
      function CBufferTypemap() {
         super();
      }
      
      override public function destroyC(param1:Array) : void {
         CBufferTypemap.free(param1[0]);
      }
      
      override public function createC(param1:*, param2:int=0) : Array {
         var _loc3_:CBuffer = null;
         _loc3_ = param1;
         _loc3_.reset();
         return [_loc3_.ptr];
      }
   }
}
