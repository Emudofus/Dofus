package cmodule.lua_wrapper
{
   public final class FSM_luaD_call extends Machine
   {
      
      public function FSM_luaD_call() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_luaD_call = null;
         _loc1_ = new FSM_luaD_call();
         FSM_luaD_call.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 0;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      override public final function work() : void {
      }
   }
}
