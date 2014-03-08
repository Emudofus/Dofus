package cmodule.lua_wrapper
{
   public final class FSM___sread extends Machine
   {
      
      public function FSM___sread() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM___sread = null;
         _loc1_ = new FSM___sread();
         FSM___sread.gworker = _loc1_;
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
