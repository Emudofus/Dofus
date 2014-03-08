package cmodule.lua_wrapper
{
   public final class FSM_atexit extends Machine
   {
      
      public function FSM_atexit() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_atexit = null;
         _loc1_ = new FSM_atexit();
         FSM_atexit.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 0;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      override public final function work() : void {
      }
   }
}
