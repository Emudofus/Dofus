package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_create_as3_value_from_lua_stack extends Machine
   {
      
      public function FSM_create_as3_value_from_lua_stack() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_create_as3_value_from_lua_stack = null;
         _loc1_ = new FSM_create_as3_value_from_lua_stack();
         FSM_create_as3_value_from_lua_stack.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 10;
      
      public static const NumberRegCount:int = 2;
      
      public var f0:Number;
      
      public var f1:Number;
      
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
