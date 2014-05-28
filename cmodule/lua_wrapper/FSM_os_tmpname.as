package cmodule.lua_wrapper
{
   public final class FSM_os_tmpname extends Machine
   {
      
      public function FSM_os_tmpname() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_os_tmpname = null;
         _loc1_ = new FSM_os_tmpname();
         FSM_os_tmpname.gworker = _loc1_;
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
