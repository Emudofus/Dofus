package cmodule.lua_wrapper
{
   public final class FSM_lua_gc extends Machine
   {
      
      public function FSM_lua_gc() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_lua_gc = null;
         _loc1_ = new FSM_lua_gc();
         FSM_lua_gc.gworker = _loc1_;
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
