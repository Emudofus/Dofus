package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ObjectEffectMount extends ObjectEffect implements INetworkType
   {
      
      public function ObjectEffectMount()
      {
         super();
      }
      
      public static const protocolId:uint = 179;
      
      public var mountId:uint = 0;
      
      public var date:Number = 0;
      
      public var modelId:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 179;
      }
      
      public function initObjectEffectMount(param1:uint = 0, param2:uint = 0, param3:Number = 0, param4:uint = 0) : ObjectEffectMount
      {
         super.initObjectEffect(param1);
         this.mountId = param2;
         this.date = param3;
         this.modelId = param4;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.mountId = 0;
         this.date = 0;
         this.modelId = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffectMount(param1);
      }
      
      public function serializeAs_ObjectEffectMount(param1:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffect(param1);
         if(this.mountId < 0)
         {
            throw new Error("Forbidden value (" + this.mountId + ") on element mountId.");
         }
         else
         {
            param1.writeInt(this.mountId);
            if(this.date < -9.007199254740992E15 || this.date > 9.007199254740992E15)
            {
               throw new Error("Forbidden value (" + this.date + ") on element date.");
            }
            else
            {
               param1.writeDouble(this.date);
               if(this.modelId < 0)
               {
                  throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
               }
               else
               {
                  param1.writeVarShort(this.modelId);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectMount(param1);
      }
      
      public function deserializeAs_ObjectEffectMount(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.mountId = param1.readInt();
         if(this.mountId < 0)
         {
            throw new Error("Forbidden value (" + this.mountId + ") on element of ObjectEffectMount.mountId.");
         }
         else
         {
            this.date = param1.readDouble();
            if(this.date < -9.007199254740992E15 || this.date > 9.007199254740992E15)
            {
               throw new Error("Forbidden value (" + this.date + ") on element of ObjectEffectMount.date.");
            }
            else
            {
               this.modelId = param1.readVarUhShort();
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
}
