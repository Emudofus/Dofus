package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightResultPvpData extends FightResultAdditionalData implements INetworkType
   {
      
      public function FightResultPvpData() {
         super();
      }
      
      public static const protocolId:uint = 190;
      
      public var grade:uint = 0;
      
      public var minHonorForGrade:uint = 0;
      
      public var maxHonorForGrade:uint = 0;
      
      public var honor:uint = 0;
      
      public var honorDelta:int = 0;
      
      override public function getTypeId() : uint {
         return 190;
      }
      
      public function initFightResultPvpData(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0, param5:int=0) : FightResultPvpData {
         this.grade = param1;
         this.minHonorForGrade = param2;
         this.maxHonorForGrade = param3;
         this.honor = param4;
         this.honorDelta = param5;
         return this;
      }
      
      override public function reset() : void {
         this.grade = 0;
         this.minHonorForGrade = 0;
         this.maxHonorForGrade = 0;
         this.honor = 0;
         this.honorDelta = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightResultPvpData(param1);
      }
      
      public function serializeAs_FightResultPvpData(param1:IDataOutput) : void {
         super.serializeAs_FightResultAdditionalData(param1);
         if(this.grade < 0 || this.grade > 255)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         else
         {
            param1.writeByte(this.grade);
            if(this.minHonorForGrade < 0 || this.minHonorForGrade > 20000)
            {
               throw new Error("Forbidden value (" + this.minHonorForGrade + ") on element minHonorForGrade.");
            }
            else
            {
               param1.writeShort(this.minHonorForGrade);
               if(this.maxHonorForGrade < 0 || this.maxHonorForGrade > 20000)
               {
                  throw new Error("Forbidden value (" + this.maxHonorForGrade + ") on element maxHonorForGrade.");
               }
               else
               {
                  param1.writeShort(this.maxHonorForGrade);
                  if(this.honor < 0 || this.honor > 20000)
                  {
                     throw new Error("Forbidden value (" + this.honor + ") on element honor.");
                  }
                  else
                  {
                     param1.writeShort(this.honor);
                     param1.writeShort(this.honorDelta);
                     return;
                  }
               }
            }
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightResultPvpData(param1);
      }
      
      public function deserializeAs_FightResultPvpData(param1:IDataInput) : void {
         super.deserialize(param1);
         this.grade = param1.readUnsignedByte();
         if(this.grade < 0 || this.grade > 255)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element of FightResultPvpData.grade.");
         }
         else
         {
            this.minHonorForGrade = param1.readUnsignedShort();
            if(this.minHonorForGrade < 0 || this.minHonorForGrade > 20000)
            {
               throw new Error("Forbidden value (" + this.minHonorForGrade + ") on element of FightResultPvpData.minHonorForGrade.");
            }
            else
            {
               this.maxHonorForGrade = param1.readUnsignedShort();
               if(this.maxHonorForGrade < 0 || this.maxHonorForGrade > 20000)
               {
                  throw new Error("Forbidden value (" + this.maxHonorForGrade + ") on element of FightResultPvpData.maxHonorForGrade.");
               }
               else
               {
                  this.honor = param1.readUnsignedShort();
                  if(this.honor < 0 || this.honor > 20000)
                  {
                     throw new Error("Forbidden value (" + this.honor + ") on element of FightResultPvpData.honor.");
                  }
                  else
                  {
                     this.honorDelta = param1.readShort();
                     return;
                  }
               }
            }
         }
      }
   }
}
