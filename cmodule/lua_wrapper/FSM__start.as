package cmodule.lua_wrapper
{
   public final class FSM__start extends Machine
   {
      
      public function FSM__start() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM__start = null;
         _loc1_ = new FSM__start();
         FSM__start.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
   }
}
