package com.ankamagames.jerakine.types
{
   import flash.utils.IExternalizable;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class DefaultableColor extends Color implements IExternalizable
   {
      
      public function DefaultableColor(c:uint = 0) {
         super(c);
      }
      
      public var isDefault:Boolean = false;
      
      override public function writeExternal(output:IDataOutput) : void {
         super.writeExternal(output);
         output.writeBoolean(this.isDefault);
      }
      
      override public function readExternal(input:IDataInput) : void {
         super.readExternal(input);
         this.isDefault = input.readBoolean();
      }
   }
}
