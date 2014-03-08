package cmodule.lua_wrapper
{
   public final class FSM_getF extends Machine
   {
      
      public function FSM_getF() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_getF = null;
         _loc1_ = new FSM_getF();
         FSM_getF.gworker = _loc1_;
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
