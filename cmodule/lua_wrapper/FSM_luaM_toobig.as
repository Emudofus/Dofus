package cmodule.lua_wrapper
{
   public final class FSM_luaM_toobig extends Machine
   {
      
      public function FSM_luaM_toobig() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaM_toobig = null;
         _loc1_ = new FSM_luaM_toobig();
         FSM_luaM_toobig.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 2;
      
      public static const NumberRegCount:int = 0;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
   }
}
