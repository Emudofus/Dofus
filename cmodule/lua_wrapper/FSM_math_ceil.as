package cmodule.lua_wrapper
{
   public final class FSM_math_ceil extends Machine
   {
      
      public function FSM_math_ceil() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_math_ceil = null;
         _loc1_ = new FSM_math_ceil();
         FSM_math_ceil.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 1;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      override public final function work() : void {
      }
      
      public var i3:int;
   }
}
