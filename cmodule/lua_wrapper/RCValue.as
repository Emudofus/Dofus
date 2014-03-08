package cmodule.lua_wrapper
{
   class RCValue extends Object
   {
      
      function RCValue(param1:*, param2:int) {
         super();
         this.value = param1;
         this.id = param2;
      }
      
      public var rc:int = 1;
      
      public var value;
      
      public var id:int;
   }
}
