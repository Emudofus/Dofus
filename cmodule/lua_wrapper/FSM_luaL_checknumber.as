package cmodule.lua_wrapper
{
   public final class FSM_luaL_checknumber extends Machine
   {
      
      public function FSM_luaL_checknumber() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaL_checknumber = null;
         _loc1_ = new FSM_luaL_checknumber();
         FSM_luaL_checknumber.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 5;
      
      public static const NumberRegCount:int = 2;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var f0:Number;
      
      public var i4:int;
      
      public var i3:int;
      
      override public final function work() : void {
      }
      
      public var f1:Number;
   }
}
