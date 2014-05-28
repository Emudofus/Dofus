package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ObjectEffectDate extends ObjectEffect implements INetworkType
   {
      
      public function ObjectEffectDate() {
         super();
      }
      
      public static const protocolId:uint = 72;
      
      public var year:uint = 0;
      
      public var month:uint = 0;
      
      public var day:uint = 0;
      
      public var hour:uint = 0;
      
      public var minute:uint = 0;
      
      override public function getTypeId() : uint {
         return 72;
      }
      
      public function initObjectEffectDate(actionId:uint = 0, year:uint = 0, month:uint = 0, day:uint = 0, hour:uint = 0, minute:uint = 0) : ObjectEffectDate {
         super.initObjectEffect(actionId);
         this.year = year;
         this.month = month;
         this.day = day;
         this.hour = hour;
         this.minute = minute;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.year = 0;
         this.month = 0;
         this.day = 0;
         this.hour = 0;
         this.minute = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ObjectEffectDate(output);
      }
      
      public function serializeAs_ObjectEffectDate(output:IDataOutput) : void {
         super.serializeAs_ObjectEffect(output);
         if(this.year < 0)
         {
            throw new Error("Forbidden value (" + this.year + ") on element year.");
         }
         else
         {
            output.writeShort(this.year);
            if(this.month < 0)
            {
               throw new Error("Forbidden value (" + this.month + ") on element month.");
            }
            else
            {
               output.writeShort(this.month);
               if(this.day < 0)
               {
                  throw new Error("Forbidden value (" + this.day + ") on element day.");
               }
               else
               {
                  output.writeShort(this.day);
                  if(this.hour < 0)
                  {
                     throw new Error("Forbidden value (" + this.hour + ") on element hour.");
                  }
                  else
                  {
                     output.writeShort(this.hour);
                     if(this.minute < 0)
                     {
                        throw new Error("Forbidden value (" + this.minute + ") on element minute.");
                     }
                     else
                     {
                        output.writeShort(this.minute);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ObjectEffectDate(input);
      }
      
      public function deserializeAs_ObjectEffectDate(input:IDataInput) : void {
         super.deserialize(input);
         this.year = input.readShort();
         if(this.year < 0)
         {
            throw new Error("Forbidden value (" + this.year + ") on element of ObjectEffectDate.year.");
         }
         else
         {
            this.month = input.readShort();
            if(this.month < 0)
            {
               throw new Error("Forbidden value (" + this.month + ") on element of ObjectEffectDate.month.");
            }
            else
            {
               this.day = input.readShort();
               if(this.day < 0)
               {
                  throw new Error("Forbidden value (" + this.day + ") on element of ObjectEffectDate.day.");
               }
               else
               {
                  this.hour = input.readShort();
                  if(this.hour < 0)
                  {
                     throw new Error("Forbidden value (" + this.hour + ") on element of ObjectEffectDate.hour.");
                  }
                  else
                  {
                     this.minute = input.readShort();
                     if(this.minute < 0)
                     {
                        throw new Error("Forbidden value (" + this.minute + ") on element of ObjectEffectDate.minute.");
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
   }
}
