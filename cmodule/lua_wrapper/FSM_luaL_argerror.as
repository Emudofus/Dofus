package cmodule.lua_wrapper
{
   public final class FSM_luaL_argerror extends Machine
   {
      
      public function FSM_luaL_argerror() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaL_argerror = null;
         _loc1_ = new FSM_luaL_argerror();
         FSM_luaL_argerror.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 8;
      
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
      
      public var i7:int;
   }
}
