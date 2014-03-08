package cmodule.lua_wrapper
{
   public final class FSM_ll_loadfunc extends Machine
   {
      
      public function FSM_ll_loadfunc() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_ll_loadfunc = null;
         _loc1_ = new FSM_ll_loadfunc();
         FSM_ll_loadfunc.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 8;
      
      public static const NumberRegCount:int = 1;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
      
      public var i7:int;
   }
}
