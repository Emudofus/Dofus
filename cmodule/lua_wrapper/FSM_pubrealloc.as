package cmodule.lua_wrapper
{
   public final class FSM_pubrealloc extends Machine
   {
      
      public function FSM_pubrealloc() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_pubrealloc = null;
         _loc1_ = new FSM_pubrealloc();
         FSM_pubrealloc.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 13;
      
      public static const NumberRegCount:int = 0;
      
      public var i10:int;
      
      public var i11:int;
      
      public var i12:int;
      
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
