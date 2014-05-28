package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_thunk_luaDoStringAsync extends Machine
   {
      
      public function FSM_thunk_luaDoStringAsync() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_thunk_luaDoStringAsync = null;
         _loc1_ = new FSM_thunk_luaDoStringAsync();
         FSM_thunk_luaDoStringAsync.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
   }
}
