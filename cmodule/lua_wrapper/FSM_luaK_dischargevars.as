package cmodule.lua_wrapper
{
   public final class FSM_luaK_dischargevars extends Machine
   {
      
      public function FSM_luaK_dischargevars() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaK_dischargevars = null;
         _loc1_ = new FSM_luaK_dischargevars();
         FSM_luaK_dischargevars.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 0;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      override public final function work() : void {
      }
   }
}
