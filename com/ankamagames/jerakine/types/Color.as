package com.ankamagames.jerakine.types
{
   import flash.utils.IExternalizable;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;


   public class Color extends Object implements IExternalizable
   {
         

      public function Color(color:uint=0) {
         super();
         this.parseColor(color);
      }



      public var red:uint;

      public var green:uint;

      public var blue:uint;

      public function get color() : uint {
         return (this.red&255)<<16|(this.green&255)<<8|this.blue&255;
      }

      public function set color(value:uint) : void {
         this.parseColor(value);
      }

      public function readExternal(input:IDataInput) : void {
         this.red=input.readUnsignedByte();
         this.green=input.readUnsignedByte();
         this.blue=input.readUnsignedByte();
      }

      public function writeExternal(output:IDataOutput) : void {
         output.writeByte(this.red);
         output.writeByte(this.green);
         output.writeByte(this.blue);
      }

      public function toString() : String {
         return "[AdvancedColor(R=\""+this.red+"\",G=\""+this.green+"\",B=\""+this.blue+"\")]";
      }

      public function release() : void {
         this.red=this.green=this.blue=0;
      }

      public function adjustDarkness(nValue:Number) : void {
         this.red=(1-nValue)*this.red;
         this.green=(1-nValue)*this.green;
         this.blue=(1-nValue)*this.blue;
      }

      public function adjustLight(nValue:Number) : void {
         this.red=this.red+nValue*(255-this.red);
         this.green=this.green+nValue*(255-this.green);
         this.blue=this.blue+nValue*(255-this.blue);
      }

      private function parseColor(color:uint) : void {
         this.red=(color&16711680)>>16;
         this.green=(color&65280)>>8;
         this.blue=color&255;
      }
   }

}