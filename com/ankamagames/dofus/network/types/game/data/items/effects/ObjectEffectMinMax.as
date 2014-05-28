package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectEffectMinMax extends ObjectEffect implements INetworkType
   {
      
      public function ObjectEffectMinMax() {
         super();
      }
      
      public static const protocolId:uint = 82;
      
      public var min:uint = 0;
      
      public var max:uint = 0;
      
      override public function getTypeId() : uint {
         return 82;
      }
      
      public function initObjectEffectMinMax(actionId:uint = 0, min:uint = 0, max:uint = 0) : ObjectEffectMinMax {
         super.initObjectEffect(actionId);
         this.min = min;
         this.max = max;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.min = 0;
         this.max = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectEffectMinMax(output);
      }
      
      public function serializeAs_ObjectEffectMinMax(output:IDataOutput) : void {
         super.serializeAs_ObjectEffect(output);
         if(this.min < 0)
         {
            throw new Error("Forbidden value (" + this.min + ") on element min.");
         }
         else
         {
            output.writeShort(this.min);
            if(this.max < 0)
            {
               throw new Error("Forbidden value (" + this.max + ") on element max.");
            }
            else
            {
               output.writeShort(this.max);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectEffectMinMax(input);
      }
      
      public function deserializeAs_ObjectEffectMinMax(input:IDataInput) : void {
         super.deserialize(input);
         this.min = input.readShort();
         if(this.min < 0)
         {
            throw new Error("Forbidden value (" + this.min + ") on element of ObjectEffectMinMax.min.");
         }
         else
         {
            this.max = input.readShort();
            if(this.max < 0)
            {
               throw new Error("Forbidden value (" + this.max + ") on element of ObjectEffectMinMax.max.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
