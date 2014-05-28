package cmodule.lua_wrapper
{
   import flash.events.*;
   import flash.display.*;
   import flash.utils.*;
   import flash.text.*;
   import flash.net.*;
   import flash.system.*;
   
   class CDoubleTypemap extends CTypemap
   {
      
      function CDoubleTypemap() {
         super();
         this.scratch = new ByteArray();
         this.scratch.length = 8;
         this.scratch.endian = "littleEndian";
      }
      
      override public function fromReturnRegs(param1:Object) : * {
         return param1.st0;
      }
      
      override public function toReturnRegs(param1:Object, param2:*, param3:int=0) : void {
         param1.st0 = param2;
      }
      
      override public function createC(param1:*, param2:int=0) : Array {
         this.scratch.position = 0;
         this.scratch.writeDouble(param1);
         this.scratch.position = 0;
         return [this.scratch.readInt(),this.scratch.readInt()];
      }
      
      override public function fromC(param1:Array) : * {
         this.scratch.position = 0;
         this.scratch.writeInt(param1[0]);
         this.scratch.writeInt(param1[1]);
         this.scratch.position = 0;
         return this.scratch.readDouble();
      }
      
      private var scratch:ByteArray;
      
      override public function get typeSize() : int {
         return 8;
      }
   }
}
