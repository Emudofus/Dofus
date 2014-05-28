package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_restore_stack_limit extends Machine
   {
      
      public function FSM_restore_stack_limit() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_restore_stack_limit = null;
         _loc1_ = new FSM_restore_stack_limit();
         FSM_restore_stack_limit.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 0;
      
      public var i10:int;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      override public final function work() : void {
      }
      
      public var i7:int;
      
      public var i9:int;
   }
}
