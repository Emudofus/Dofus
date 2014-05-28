package cmodule.lua_wrapper
{
   public final class FSM_math_cos extends Machine
   {
      
      public function FSM_math_cos() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_math_cos = null;
         _loc1_ = new FSM_math_cos();
         FSM_math_cos.gworker = _loc1_;
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
