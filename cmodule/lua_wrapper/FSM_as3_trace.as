package cmodule.lua_wrapper
{
   public final class FSM_as3_trace extends Machine
   {
      
      public function FSM_as3_trace() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_as3_trace = null;
         _loc1_ = new FSM_as3_trace();
         FSM_as3_trace.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 12;
      
      public static const NumberRegCount:int = 2;
      
      public var i10:int;
      
      public var i11:int;
      
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
