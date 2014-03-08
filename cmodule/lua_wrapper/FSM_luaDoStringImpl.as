package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_luaDoStringImpl extends Machine
   {
      
      public function FSM_luaDoStringImpl() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaDoStringImpl = null;
         _loc1_ = new FSM_luaDoStringImpl();
         FSM_luaDoStringImpl.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 13;
      
      public static const NumberRegCount:int = 1;
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
      public var f0:Number;
      
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
      
      override public final function work() : void {
      }
   }
}
