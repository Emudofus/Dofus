package cmodule.lua_wrapper
{
   public final class FSM_luaB_tonumber extends Machine
   {
      
      public function FSM_luaB_tonumber() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaB_tonumber = null;
         _loc1_ = new FSM_luaB_tonumber();
         FSM_luaB_tonumber.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 1;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      override public final function work() : void {
      }
   }
}
