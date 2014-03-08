package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectEffectDuration extends ObjectEffect implements INetworkType
   {
      
      public function ObjectEffectDuration() {
         super();
      }
      
      public static const protocolId:uint = 75;
      
      public var days:uint = 0;
      
      public var hours:uint = 0;
      
      public var minutes:uint = 0;
      
      override public function getTypeId() : uint {
         return 75;
      }
      
      public function initObjectEffectDuration(actionId:uint=0, days:uint=0, hours:uint=0, minutes:uint=0) : ObjectEffectDuration {
         super.initObjectEffect(actionId);
         this.days = days;
         this.hours = hours;
         this.minutes = minutes;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.days = 0;
         this.hours = 0;
         this.minutes = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectEffectDuration(output);
      }
      
      public function serializeAs_ObjectEffectDuration(output:IDataOutput) : void {
         super.serializeAs_ObjectEffect(output);
         if(this.days < 0)
         {
            throw new Error("Forbidden value (" + this.days + ") on element days.");
         }
         else
         {
            output.writeShort(this.days);
            if(this.hours < 0)
            {
               throw new Error("Forbidden value (" + this.hours + ") on element hours.");
            }
            else
            {
               output.writeShort(this.hours);
               if(this.minutes < 0)
               {
                  throw new Error("Forbidden value (" + this.minutes + ") on element minutes.");
               }
               else
               {
                  output.writeShort(this.minutes);
                  return;
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectEffectDuration(input);
      }
      
      public function deserializeAs_ObjectEffectDuration(input:IDataInput) : void {
         super.deserialize(input);
         this.days = input.readShort();
         if(this.days < 0)
         {
            throw new Error("Forbidden value (" + this.days + ") on element of ObjectEffectDuration.days.");
         }
         else
         {
            this.hours = input.readShort();
            if(this.hours < 0)
            {
               throw new Error("Forbidden value (" + this.hours + ") on element of ObjectEffectDuration.hours.");
            }
            else
            {
               this.minutes = input.readShort();
               if(this.minutes < 0)
               {
                  throw new Error("Forbidden value (" + this.minutes + ") on element of ObjectEffectDuration.minutes.");
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
