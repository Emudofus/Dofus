package cmodule.lua_wrapper
{
   public final class FSM_os_getenv extends Machine
   {
      
      public function FSM_os_getenv() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_os_getenv = null;
         _loc1_ = new FSM_os_getenv();
         FSM_os_getenv.gworker = _loc1_;
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
