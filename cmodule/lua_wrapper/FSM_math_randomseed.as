package cmodule.lua_wrapper
{
   public final class FSM_math_randomseed extends Machine
   {
      
      public function FSM_math_randomseed() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_math_randomseed = null;
         _loc1_ = new FSM_math_randomseed();
         FSM_math_randomseed.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 2;
      
      public static const NumberRegCount:int = 0;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
   }
}
