package cmodule.lua_wrapper
{
   public final class FSM_os_exit extends Machine
   {
      
      public function FSM_os_exit() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_os_exit = null;
         _loc1_ = new FSM_os_exit();
         FSM_os_exit.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 3;
      
      public static const NumberRegCount:int = 0;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
   }
}
