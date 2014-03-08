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
      
      public function initCharacterBaseInformations(param1:uint=0, param2:uint=0, param3:String="", param4:EntityLook=null, param5:int=0, param6:Boolean=false) : CharacterBaseInformations {
         super.initCharacterMinimalPlusLookInformations(param1,param2,param3,param4);
         this.breed = param5;
         this.sex = param6;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.breed = 0;
         this.sex = false;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterBaseInformations(param1);
      }
      
      public function serializeAs_CharacterBaseInformations(param1:IDataOutput) : void {
         super.serializeAs_CharacterMinimalPlusLookInformations(param1);
         param1.writeByte(this.breed);
         param1.writeBoolean(this.sex);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterBaseInformations(param1);
      }
      
      public function deserializeAs_CharacterBaseInformations(param1:IDataInput) : void {
         super.deserialize(param1);
         this.breed = param1.readByte();
         this.sex = param1.readBoolean();
      }
   }
}
