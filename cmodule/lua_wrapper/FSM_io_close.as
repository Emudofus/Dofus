package cmodule.lua_wrapper
{
   public final class FSM_io_close extends Machine
   {
      
      public function FSM_io_close() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_io_close = null;
         _loc1_ = new FSM_io_close();
         FSM_io_close.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 3;
      
      public static const NumberRegCount:int = 1;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
   }
}
