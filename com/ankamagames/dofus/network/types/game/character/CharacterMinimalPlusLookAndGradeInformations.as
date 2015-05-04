package com.ankamagames.dofus.network.types.game.character
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharacterMinimalPlusLookAndGradeInformations extends CharacterMinimalPlusLookInformations implements INetworkType
   {
      
      public function CharacterMinimalPlusLookAndGradeInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 193;
      
      public var grade:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 193;
      }
      
      public function initCharacterMinimalPlusLookAndGradeInformations(param1:uint = 0, param2:uint = 0, param3:String = "", param4:EntityLook = null, param5:uint = 0) : CharacterMinimalPlusLookAndGradeInformations
      {
         super.initCharacterMinimalPlusLookInformations(param1,param2,param3,param4);
         this.grade = param5;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.grade = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterMinimalPlusLookAndGradeInformations(param1);
      }
      
      public function serializeAs_CharacterMinimalPlusLookAndGradeInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_CharacterMinimalPlusLookInformations(param1);
         if(this.grade < 0)
         {
            throw new Error("Forbidden value (" + this.grade + ") on element grade.");
         }
         else
         {
            param1.writeVarInt(this.grade);
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterMinimalPlusLookAndGradeInformations(param1);
      }
      
      public function deserializeAs_CharacterMinimalPlusLookAndGradeInformations(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.grade = param1.readVarUhInt();
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
