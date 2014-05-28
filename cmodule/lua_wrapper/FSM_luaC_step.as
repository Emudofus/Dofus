package cmodule.lua_wrapper
{
   public final class FSM_luaC_step extends Machine
   {
      
      public function FSM_luaC_step() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaC_step = null;
         _loc1_ = new FSM_luaC_step();
         FSM_luaC_step.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 0;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      override public final function work() : void {
      }
      
      public var i7:int;
   }
}
