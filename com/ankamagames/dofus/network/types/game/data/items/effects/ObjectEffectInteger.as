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
      
      public function initObjectEffectInteger(param1:uint=0, param2:uint=0) : ObjectEffectInteger {
         super.initObjectEffect(param1);
         this.value = param2;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.value = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ObjectEffectInteger(param1);
      }
      
      public function serializeAs_ObjectEffectInteger(param1:IDataOutput) : void {
         super.serializeAs_ObjectEffect(param1);
         if(this.value < 0)
         {
            throw new Error("Forbidden value (" + this.value + ") on element value.");
         }
         else
         {
            param1.writeShort(this.value);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ObjectEffectInteger(param1);
      }
      
      public function deserializeAs_ObjectEffectInteger(param1:IDataInput) : void {
         super.deserialize(param1);
         this.value = param1.readShort();
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
