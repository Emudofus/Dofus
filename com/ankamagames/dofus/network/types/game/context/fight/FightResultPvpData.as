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
      
      public function initFightResultPvpData(grade:uint=0, minHonorForGrade:uint=0, maxHonorForGrade:uint=0, honor:uint=0, honorDelta:int=0) : FightResultPvpData {
         this.grade = grade;
         this.minHonorForGrade = minHonorForGrade;
         this.maxHonorForGrade = maxHonorForGrade;
         this.honor = honor;
         this.honorDelta = honorDelta;
         return this;
      }
      
      override public function reset() : void {
         this.grade = 0;
         this.minHonorForGrade = 0;
         this.maxHonorForGrade = 0;
         this.honor = 0;
         this.honorDelta = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightResultPvpData(output);
      }
      
      public function serializeAs_FightResultPvpData(output:IDataOutput) : void {
         super.serializeAs_FightResultAdditionalData(output);
         if((this.grade < 0) || (this.grade > 255))
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         else
         {
            output.writeByte(this.grade);
            if((this.minHonorForGrade < 0) || (this.minHonorForGrade > 20000))
            {
               throw new Error("Forbidden value (" + this.minHonorForGrade + ") on element minHonorForGrade.");
            }
            else
            {
               output.writeShort(this.minHonorForGrade);
               if((this.maxHonorForGrade < 0) || (this.maxHonorForGrade > 20000))
               {
                  throw new Error("Forbidden value (" + this.maxHonorForGrade + ") on element maxHonorForGrade.");
               }
               else
               {
                  output.writeShort(this.maxHonorForGrade);
                  if((this.honor < 0) || (this.honor > 20000))
                  {
                     throw new Error("Forbidden value (" + this.honor + ") on element honor.");
                  }
                  else
                  {
                     output.writeShort(this.honor);
                     output.writeShort(this.honorDelta);
                     return;
                  }
               }
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightResultPvpData(input);
      }
      
      public function deserializeAs_FightResultPvpData(input:IDataInput) : void {
         super.deserialize(input);
         this.grade = input.readUnsignedByte();
         if((this.grade < 0) || (this.grade > 255))
         {
            throw new Error("Forbidden value (" + this.grade + ") on element of FightResultPvpData.grade.");
         }
         else
         {
            this.minHonorForGrade = input.readUnsignedShort();
            if((this.minHonorForGrade < 0) || (this.minHonorForGrade > 20000))
            {
               throw new Error("Forbidden value (" + this.minHonorForGrade + ") on element of FightResultPvpData.minHonorForGrade.");
            }
            else
            {
               this.maxHonorForGrade = input.readUnsignedShort();
               if((this.maxHonorForGrade < 0) || (this.maxHonorForGrade > 20000))
               {
                  throw new Error("Forbidden value (" + this.maxHonorForGrade + ") on element of FightResultPvpData.maxHonorForGrade.");
               }
               else
               {
                  this.honor = input.readUnsignedShort();
                  if((this.honor < 0) || (this.honor > 20000))
                  {
                     throw new Error("Forbidden value (" + this.honor + ") on element of FightResultPvpData.honor.");
                  }
                  else
                  {
                     this.honorDelta = input.readShort();
                     return;
                  }
               }
            }
         }
      }
   }
}
