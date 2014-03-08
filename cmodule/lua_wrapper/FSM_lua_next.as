package cmodule.lua_wrapper
{
   public final class FSM_lua_next extends Machine
   {
      
      public function FSM_lua_next() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_lua_next = null;
         _loc1_ = new FSM_lua_next();
         FSM_lua_next.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 11;
      
      public static const NumberRegCount:int = 2;
      
      public var i10:int;
      
      public var f0:Number;
      
      public var f1:Number;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i7:int;
      
      public var i8:int;
      
      public var i9:int;
   }
}
