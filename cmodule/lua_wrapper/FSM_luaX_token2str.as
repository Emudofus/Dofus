package cmodule.lua_wrapper
{
   public final class FSM_luaX_token2str extends Machine
   {
      
      public function FSM_luaX_token2str() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaX_token2str = null;
         _loc1_ = new FSM_luaX_token2str();
         FSM_luaX_token2str.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 4;
      
      public static const NumberRegCount:int = 0;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
   }
}
