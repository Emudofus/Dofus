package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   class CRefTypemap extends CTypemap
   {
      
      function CRefTypemap(param1:CTypemap) {
         super();
         this.subtype = param1;
      }
      
      override public function fromC(param1:Array) : * {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = param1[0];
         _loc3_ = 0;
         while(_loc3_ < this.subtype.ptrLevel)
         {
            CRefTypemap.ds.position = _loc2_;
            _loc2_ = CRefTypemap.ds.readInt();
            _loc3_++;
         }
         return this.subtype.readValue(_loc2_);
      }
      
      private var subtype:CTypemap;
      
      override public function createC(param1:*, param2:int=0) : Array {
         return null;
      }
   }
}
