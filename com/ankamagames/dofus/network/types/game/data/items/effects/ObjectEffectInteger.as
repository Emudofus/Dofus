package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectEffectInteger extends ObjectEffect implements INetworkType
   {
      
      public function ObjectEffectInteger() {
         super();
      }
      
      public static const protocolId:uint = 70;
      
      public var value:uint = 0;
      
      override public function getTypeId() : uint {
         return 70;
      }
      
      public function initObjectEffectInteger(actionId:uint=0, value:uint=0) : ObjectEffectInteger {
         super.initObjectEffect(actionId);
         this.value = value;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectEffectInteger(output);
      }
      
      public function serializeAs_ObjectEffectInteger(output:IDataOutput) : void {
         super.serializeAs_ObjectEffect(output);
         if(this.value < 0)
         {
            throw new Error("Forbidden value (" + this.value + ") on element value.");
         }
         else
         {
            output.writeShort(this.value);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectEffectInteger(input);
      }
      
      public function deserializeAs_ObjectEffectInteger(input:IDataInput) : void {
         super.deserialize(input);
         this.value = input.readShort();
         if(this.value < 0)
         {
            throw new Error("Forbidden value (" + this.value + ") on element of ObjectEffectInteger.value.");
         }
         else
         {
            return;
         }
      }
   }
}
