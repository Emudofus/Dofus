package cmodule.lua_wrapper
{
   public final class FSM_math_frexp extends Machine
   {
      
      public function FSM_math_frexp() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_math_frexp = null;
         _loc1_ = new FSM_math_frexp();
         FSM_math_frexp.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      override public final function work() : void {
      }
   }
}
