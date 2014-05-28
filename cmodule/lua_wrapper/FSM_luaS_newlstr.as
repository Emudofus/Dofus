package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_luaS_newlstr extends Machine
   {
      
      public function FSM_luaS_newlstr() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaS_newlstr = null;
         _loc1_ = new FSM_luaS_newlstr();
         FSM_luaS_newlstr.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 14;
      
      public static const NumberRegCount:int = 0;
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var i13:int;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public var i9:int;
   }
}
