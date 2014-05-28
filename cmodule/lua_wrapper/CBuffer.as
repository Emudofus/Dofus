package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   class CBuffer extends Object
   {
      
      function CBuffer(param1:int, param2:ICAllocator=null) {
         super();
         if(!param2)
         {
            param2 = new CHeapAllocator();
         }
         this.allocator = param2;
         this.sizeVal = param1;
         this.alloc();
      }
      
      public static function free(param1:int) : void {
         ptr2Buffer[param1].free();
      }
      
      private static var ptr2Buffer:Object = {};
      
      private var sizeVal:int;
      
      private var valCache;
      
      public function get size() : int {
         return this.sizeVal;
      }
      
      public function set value(param1:*) : void {
         if(this.ptrVal)
         {
            this.setValue(param1);
         }
         else
         {
            this.valCache = param1;
         }
      }
      
      private var allocator:ICAllocator;
      
      public function free() : void {
         if(this.ptrVal)
         {
            this.valCache = this.computeValue();
            this.allocator.free(this.ptrVal);
            delete ptr2Buffer[[this.ptrVal]];
            this.ptrVal = 0;
         }
      }
      
      public function get ptr() : int {
         return this.ptrVal;
      }
      
      protected function setValue(param1:*) : void {
      }
      
      public function get value() : * {
         return this.ptrVal?this.computeValue():this.valCache;
      }
      
      private var ptrVal:int;
      
      protected function computeValue() : * {
         return undefined;
      }
      
      private function alloc() : void {
         if(!this.ptrVal)
         {
            this.ptrVal = this.allocator.alloc(this.sizeVal);
            ptr2Buffer[this.ptrVal] = this;
         }
      }
      
      public function reset() : void {
         if(!this.ptrVal)
         {
            this.alloc();
            this.setValue(this.valCache);
         }
      }
   }
}
