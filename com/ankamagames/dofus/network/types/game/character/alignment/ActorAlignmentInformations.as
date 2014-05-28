package com.ankamagames.dofus.network.types.game.character.alignment
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class ActorAlignmentInformations extends Object implements INetworkType
   {
      
      public function ActorAlignmentInformations() {
         super();
      }
      
      public static const protocolId:uint = 201;
      
      public var alignmentSide:int = 0;
      
      public var alignmentValue:uint = 0;
      
      public var alignmentGrade:uint = 0;
      
      public var characterPower:uint = 0;
      
      public function getTypeId() : uint {
         return 201;
      }
      
      public function initActorAlignmentInformations(alignmentSide:int = 0, alignmentValue:uint = 0, alignmentGrade:uint = 0, characterPower:uint = 0) : ActorAlignmentInformations {
         this.alignmentSide = alignmentSide;
         this.alignmentValue = alignmentValue;
         this.alignmentGrade = alignmentGrade;
         this.characterPower = characterPower;
         return this;
      }
      
      public function reset() : void {
         this.alignmentSide = 0;
         this.alignmentValue = 0;
         this.alignmentGrade = 0;
         this.characterPower = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_ActorAlignmentInformations(output);
      }
      
      public function serializeAs_ActorAlignmentInformations(output:IDataOutput) : void {
         output.writeByte(this.alignmentSide);
         if(this.alignmentValue < 0)
         {
            throw new Error("Forbidden value (" + this.alignmentValue + ") on element alignmentValue.");
         }
         else
         {
            output.writeByte(this.alignmentValue);
            if(this.alignmentGrade < 0)
            {
               throw new Error("Forbidden value (" + this.alignmentGrade + ") on element alignmentGrade.");
            }
            else
            {
               output.writeByte(this.alignmentGrade);
               if(this.characterPower < 0)
               {
                  throw new Error("Forbidden value (" + this.characterPower + ") on element characterPower.");
               }
               else
               {
                  output.writeInt(this.characterPower);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ActorAlignmentInformations(input);
      }
      
      public function deserializeAs_ActorAlignmentInformations(input:IDataInput) : void {
         this.alignmentSide = input.readByte();
         this.alignmentValue = input.readByte();
         if(this.alignmentValue < 0)
         {
            throw new Error("Forbidden value (" + this.alignmentValue + ") on element of ActorAlignmentInformations.alignmentValue.");
         }
         else
         {
            this.alignmentGrade = input.readByte();
            if(this.alignmentGrade < 0)
            {
               throw new Error("Forbidden value (" + this.alignmentGrade + ") on element of ActorAlignmentInformations.alignmentGrade.");
            }
            else
            {
               this.characterPower = input.readInt();
               if(this.characterPower < 0)
               {
                  throw new Error("Forbidden value (" + this.characterPower + ") on element of ActorAlignmentInformations.characterPower.");
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
