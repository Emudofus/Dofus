package cmodule.lua_wrapper
{
   public final class FSM_codearith extends Machine
   {
      
      public function FSM_codearith() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_codearith = null;
         _loc1_ = new FSM_codearith();
         FSM_codearith.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 9;
      
      public static const NumberRegCount:int = 4;
      
      public var f0:Number;
      
      public var f1:Number;
      
      public var f2:Number;
      
      public var f3:Number;
      
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
