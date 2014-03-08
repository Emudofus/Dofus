package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_luaB_loadstring extends Machine
   {
      
      public function FSM_luaB_loadstring() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaB_loadstring = null;
         _loc1_ = new FSM_luaB_loadstring();
         FSM_luaB_loadstring.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 0;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      override public final function work() : void {
      }
      
      public var i7:int;
   }
}
