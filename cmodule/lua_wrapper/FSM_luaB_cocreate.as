package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_luaB_cocreate extends Machine
   {
      
      public function FSM_luaB_cocreate() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaB_cocreate = null;
         _loc1_ = new FSM_luaB_cocreate();
         FSM_luaB_cocreate.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 1;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
   }
}
