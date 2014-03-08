package cmodule.lua_wrapper
{
   public final class FSM_str_sub extends Machine
   {
      
      public function FSM_str_sub() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_str_sub = null;
         _loc1_ = new FSM_str_sub();
         FSM_str_sub.gworker = _loc1_;
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
