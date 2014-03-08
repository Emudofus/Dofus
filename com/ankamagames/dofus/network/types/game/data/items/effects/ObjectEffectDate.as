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
      
      public function initObjectEffectDate(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0, param5:uint=0, param6:uint=0) : ObjectEffectDate {
         super.initObjectEffect(param1);
         this.year = param2;
         this.month = param3;
         this.day = param4;
         this.hour = param5;
         this.minute = param6;
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ObjectEffectDate(param1);
      }
      
      public function serializeAs_ObjectEffectDate(param1:IDataOutput) : void {
         super.serializeAs_ObjectEffect(param1);
         if(this.year < 0)
         {
            throw new Error("Forbidden value (" + this.year + ") on element year.");
         }
         else
         {
            param1.writeShort(this.year);
            if(this.month < 0)
            {
               throw new Error("Forbidden value (" + this.month + ") on element month.");
            }
            else
            {
               param1.writeShort(this.month);
               if(this.day < 0)
               {
                  throw new Error("Forbidden value (" + this.day + ") on element day.");
               }
               else
               {
                  param1.writeShort(this.day);
                  if(this.hour < 0)
                  {
                     throw new Error("Forbidden value (" + this.hour + ") on element hour.");
                  }
                  else
                  {
                     param1.writeShort(this.hour);
                     if(this.minute < 0)
                     {
                        throw new Error("Forbidden value (" + this.minute + ") on element minute.");
                     }
                     else
                     {
                        param1.writeShort(this.minute);
                        return;
                     }
                  }
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ObjectEffectDate(param1);
      }
      
      public function deserializeAs_ObjectEffectDate(param1:IDataInput) : void {
         super.deserialize(param1);
         this.year = param1.readShort();
         if(this.year < 0)
         {
            throw new Error("Forbidden value (" + this.year + ") on element of ObjectEffectDate.year.");
         }
         else
         {
            this.month = param1.readShort();
            if(this.month < 0)
            {
               throw new Error("Forbidden value (" + this.month + ") on element of ObjectEffectDate.month.");
            }
            else
            {
               this.day = param1.readShort();
               if(this.day < 0)
               {
                  throw new Error("Forbidden value (" + this.day + ") on element of ObjectEffectDate.day.");
               }
               else
               {
                  this.hour = param1.readShort();
                  if(this.hour < 0)
                  {
                     throw new Error("Forbidden value (" + this.hour + ") on element of ObjectEffectDate.hour.");
                  }
                  else
                  {
                     this.minute = param1.readShort();
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
