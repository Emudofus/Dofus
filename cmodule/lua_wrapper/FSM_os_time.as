package cmodule.lua_wrapper
{
   public final class FSM_os_time extends Machine
   {
      
      public function FSM_os_time() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_os_time = null;
         _loc1_ = new FSM_os_time();
         FSM_os_time.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 1;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
   }
}
