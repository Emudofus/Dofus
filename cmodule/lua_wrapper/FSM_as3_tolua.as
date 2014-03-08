package cmodule.lua_wrapper
{
   public final class FSM_as3_tolua extends Machine
   {
      
      public function FSM_as3_tolua() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_as3_tolua = null;
         _loc1_ = new FSM_as3_tolua();
         FSM_as3_tolua.gworker = _loc1_;
      }
      
      public static const intRegCount:int = 10;
      
      public static const NumberRegCount:int = 1;
      
      public var i0:int;
      
      public var i1:int;
      
      public var i2:int;
      
      public var i3:int;
      
      public var i4:int;
      
      public var i5:int;
      
      public var i6:int;
      
      public var i8:int;
      
      public var f0:Number;
      
      override public final function work() : void {
      }
      
      public var i7:int;
      
      public var i9:int;
   }
}
