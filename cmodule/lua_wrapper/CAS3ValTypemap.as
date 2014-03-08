package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   class CAS3ValTypemap extends CTypemap
   {
      
      function CAS3ValTypemap() {
         this.values = new ValueTracker();
         super();
      }
      
      override public function fromC(param1:Array) : * {
         return this.values.get(param1[0]);
      }
      
      private var values:ValueTracker;
      
      override public function createC(param1:*, param2:int=0) : Array {
         return [this.values.acquire(param1)];
      }
      
      override public function destroyC(param1:Array) : void {
         this.values.release(param1[0]);
      }
      
      public function get valueTracker() : ValueTracker {
         return this.values;
      }
   }
}
