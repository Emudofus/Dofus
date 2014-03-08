package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_push_as3_to_lua_stack_if_convertible extends Machine
   {
      
      public function FSM_push_as3_to_lua_stack_if_convertible() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_push_as3_to_lua_stack_if_convertible = null;
         _loc1_ = new FSM_push_as3_to_lua_stack_if_convertible();
         FSM_push_as3_to_lua_stack_if_convertible.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 2;
      
      public var i10:int;
      
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
