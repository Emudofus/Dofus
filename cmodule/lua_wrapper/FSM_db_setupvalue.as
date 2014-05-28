package cmodule.lua_wrapper
{
   public final class FSM_db_setupvalue extends Machine
   {
      
      public function FSM_db_setupvalue() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_db_setupvalue = null;
         _loc1_ = new FSM_db_setupvalue();
         FSM_db_setupvalue.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 3;
      
      public static const NumberRegCount:int = 0;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
   }
}
