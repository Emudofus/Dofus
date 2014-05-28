package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterMinimalPlusLookAndGradeInformations extends CharacterMinimalPlusLookInformations implements INetworkType
   {
      
      public function CharacterMinimalPlusLookAndGradeInformations() {
         super();
      }
      
      public static const protocolId:uint = 193;
      
      public var grade:uint = 0;
      
      override public function getTypeId() : uint {
         return 193;
      }
      
      public function initCharacterMinimalPlusLookAndGradeInformations(id:uint = 0, level:uint = 0, name:String = "", entityLook:EntityLook = null, grade:uint = 0) : CharacterMinimalPlusLookAndGradeInformations {
         super.initCharacterMinimalPlusLookInformations(id,level,name,entityLook);
         this.grade = grade;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.grade = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterMinimalPlusLookAndGradeInformations(output);
      }
      
      public function serializeAs_CharacterMinimalPlusLookAndGradeInformations(output:IDataOutput) : void {
         super.serializeAs_CharacterMinimalPlusLookInformations(output);
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         else
         {
            output.writeInt(this.grade);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterMinimalPlusLookAndGradeInformations(input);
      }
      
      public function deserializeAs_CharacterMinimalPlusLookAndGradeInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.grade = input.readInt();
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element of CharacterMinimalPlusLookAndGradeInformations.grade.");
         }
         else
         {
            return;
         }
      }
   }
}
