package cmodule.lua_wrapper
{
   public final class FSM_math_tanh extends Machine
   {
      
      public function FSM_math_tanh() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_math_tanh = null;
         _loc1_ = new FSM_math_tanh();
         FSM_math_tanh.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 5;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var f2:Number;
      
      public var f3:Number;
      
      public var i3:int;
      
      public var f4:Number;
   }
}
