package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   public final class FSM_as3_release extends Machine
   {
      
      public function FSM_as3_release() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_as3_release = null;
         _loc1_ = new FSM_as3_release();
         FSM_as3_release.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 2;
      
      override public final function work() : void {
      }
      
      public var f1:Number;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public var i7:int;
   }
}
