package cmodule.lua_wrapper
{
   public final class FSM_str_byte extends Machine
   {
      
      public function FSM_str_byte() {
         super();
      }
      
      public static function start() : void {
         var _loc1_:FSM_str_byte = null;
         _loc1_ = new FSM_str_byte();
         FSM_str_byte.gworker = _loc1_;
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
