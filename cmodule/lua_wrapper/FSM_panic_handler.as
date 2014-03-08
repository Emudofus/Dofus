package cmodule.lua_wrapper
{
   public final class FSM_panic_handler extends Machine
   {
      
      public function FSM_panic_handler() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_panic_handler = null;
         _loc1_ = new FSM_panic_handler();
         FSM_panic_handler.gworker = _loc1_;
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
