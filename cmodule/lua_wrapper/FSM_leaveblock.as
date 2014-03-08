package cmodule.lua_wrapper
{
   public final class FSM_leaveblock extends Machine
   {
      
      public function FSM_leaveblock() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_leaveblock = null;
         _loc1_ = new FSM_leaveblock();
         FSM_leaveblock.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 12;
      
      public static const NumberRegCount:int = 0;
      
      public var i10:int;
      
      public var i11:int;
      
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
