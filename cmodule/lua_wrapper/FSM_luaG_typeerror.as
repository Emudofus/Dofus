package cmodule.lua_wrapper
{
   public final class FSM_luaG_typeerror extends Machine
   {
      
      public function FSM_luaG_typeerror() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaG_typeerror = null;
         _loc1_ = new FSM_luaG_typeerror();
         FSM_luaG_typeerror.gworker = _loc1_;
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
