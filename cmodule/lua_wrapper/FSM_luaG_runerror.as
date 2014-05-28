package cmodule.lua_wrapper
{
   public final class FSM_luaG_runerror extends Machine
   {
      
      public function FSM_luaG_runerror() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaG_runerror = null;
         _loc1_ = new FSM_luaG_runerror();
         FSM_luaG_runerror.gworker = _loc1_;
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
