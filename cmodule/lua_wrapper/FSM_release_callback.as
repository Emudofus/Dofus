package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_release_callback extends Machine
   {
      
      public function FSM_release_callback() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_release_callback = null;
         _loc1_ = new FSM_release_callback();
         FSM_release_callback.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      override public final function work() : void {
      }
   }
}
