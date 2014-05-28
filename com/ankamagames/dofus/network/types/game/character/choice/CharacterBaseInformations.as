package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class CharacterBaseInformations extends CharacterMinimalPlusLookInformations implements INetworkType
   {
      
      public function CharacterBaseInformations() {
         super();
      }
      
      public static const protocolId:uint = 45;
      
      public var breed:int = 0;
      
      public var sex:Boolean = false;
      
      override public function getTypeId() : uint {
         return 45;
      }
      
      public function initCharacterBaseInformations(id:uint = 0, level:uint = 0, name:String = "", entityLook:EntityLook = null, breed:int = 0, sex:Boolean = false) : CharacterBaseInformations {
         super.initCharacterMinimalPlusLookInformations(id,level,name,entityLook);
         this.breed = breed;
         this.sex = sex;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.breed = 0;
         this.sex = false;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterBaseInformations(output);
      }
      
      public function serializeAs_CharacterBaseInformations(output:IDataOutput) : void {
         super.serializeAs_CharacterMinimalPlusLookInformations(output);
         output.writeByte(this.breed);
         output.writeBoolean(this.sex);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterBaseInformations(input);
      }
      
      public function deserializeAs_CharacterBaseInformations(input:IDataInput) : void {
         super.deserialize(input);
         this.breed = input.readByte();
         this.sex = input.readBoolean();
      }
   }
}
