package cmodule.lua_wrapper
{
   public final class FSM_str_match extends Machine
   {
      
      public function FSM_str_match() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_str_match = null;
         _loc1_ = new FSM_str_match();
         FSM_str_match.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 2;
      
      public static const NumberRegCount:int = 0;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
   }
}
