package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_luaF_newproto extends Machine
   {
      
      public function FSM_luaF_newproto() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaF_newproto = null;
         _loc1_ = new FSM_luaF_newproto();
         FSM_luaF_newproto.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      override public final function work() : void {
      }
   }
}
