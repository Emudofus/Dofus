package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectEffectMount extends ObjectEffect implements INetworkType
   {
      
      public function ObjectEffectMount() {
         super();
      }
      
      public static const protocolId:uint = 179;
      
      public var mountId:uint = 0;
      
      public var date:Number = 0;
      
      public var modelId:uint = 0;
      
      override public function getTypeId() : uint {
         return 179;
      }
      
      public function initObjectEffectMount(actionId:uint = 0, mountId:uint = 0, date:Number = 0, modelId:uint = 0) : ObjectEffectMount {
         super.initObjectEffect(actionId);
         this.mountId = mountId;
         this.date = date;
         this.modelId = modelId;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.mountId = 0;
         this.date = 0;
         this.modelId = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectEffectMount(output);
      }
      
      public function serializeAs_ObjectEffectMount(output:IDataOutput) : void {
         super.serializeAs_ObjectEffect(output);
         if(this.mountId < 0)
         {
            throw new Error("Forbidden value (" + this.mountId + ") on element mountId.");
         }
         else
         {
            output.writeInt(this.mountId);
            output.writeDouble(this.date);
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
            }
            else
            {
               output.writeShort(this.modelId);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectEffectMount(input);
      }
      
      public function deserializeAs_ObjectEffectMount(input:IDataInput) : void {
         super.deserialize(input);
         this.mountId = input.readInt();
         if(this.mountId < 0)
         {
            throw new Error("Forbidden value (" + this.mountId + ") on element of ObjectEffectMount.mountId.");
         }
         else
         {
            this.date = input.readDouble();
            this.modelId = input.readShort();
            if(this.modelId < 0)
            {
               throw new Error("Forbidden value (" + this.modelId + ") on element of ObjectEffectMount.modelId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
