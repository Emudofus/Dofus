package cmodule.lua_wrapper
{
   public final class FSM_classend extends Machine
   {
      
      public function FSM_classend() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_classend = null;
         _loc1_ = new FSM_classend();
         FSM_classend.gworker = _loc1_;
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
