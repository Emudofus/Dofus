package cmodule.lua_wrapper
{
   public final class FSM_exit extends Machine
   {
      
      public function FSM_exit() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_exit = null;
         _loc1_ = new FSM_exit();
         FSM_exit.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 2;
      
      public static const NumberRegCount:int = 0;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
   }
}
