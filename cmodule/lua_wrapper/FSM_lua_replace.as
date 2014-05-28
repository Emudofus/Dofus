package cmodule.lua_wrapper
{
   public final class FSM_lua_replace extends Machine
   {
      
      public function FSM_lua_replace() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_lua_replace = null;
         _loc1_ = new FSM_lua_replace();
         FSM_lua_replace.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 6;
      
      public static const NumberRegCount:int = 1;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var f0:Number;
   }
}
