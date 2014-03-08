package cmodule.lua_wrapper
{
   public final class FSM_tinsert extends Machine
   {
      
      public function FSM_tinsert() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_tinsert = null;
         _loc1_ = new FSM_tinsert();
         FSM_tinsert.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 7;
      
      public static const NumberRegCount:int = 1;
      
      override public final function work() : void {
      }
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var f0:Number;
   }
}
