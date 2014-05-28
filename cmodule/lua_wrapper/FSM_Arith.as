package cmodule.lua_wrapper
{
   public final class FSM_Arith extends Machine
   {
      
      public function FSM_Arith() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_Arith = null;
         _loc1_ = new FSM_Arith();
         FSM_Arith.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 3;
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var f2:Number;
      
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
   }
}
