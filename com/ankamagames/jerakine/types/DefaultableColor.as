package com.ankamagames.jerakine.types
{
   import flash.utils.IExternalizable;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class DefaultableColor extends Color implements IExternalizable
   {
      
      public function DefaultableColor(param1:uint=0) {
         super(param1);
      }
      
      public var isDefault:Boolean = false;
      
      override public function writeExternal(param1:IDataOutput) : void {
         super.writeExternal(param1);
         param1.writeBoolean(this.isDefault);
      }
      
      override public function readExternal(param1:IDataInput) : void {
         super.readExternal(param1);
         this.isDefault = param1.readBoolean();
      }
   }
}
