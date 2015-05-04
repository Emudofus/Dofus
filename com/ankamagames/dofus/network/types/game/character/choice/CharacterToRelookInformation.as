package com.ankamagames.dofus.network.types.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharacterToRelookInformation extends AbstractCharacterToRefurbishInformation implements INetworkType
   {
      
      public function CharacterToRelookInformation()
      {
         super();
      }
      
      public static const protocolId:uint = 399;
      
      override public function getTypeId() : uint
      {
         return 399;
      }
      
      public function initCharacterToRelookInformation(param1:uint = 0, param2:Vector.<int> = null, param3:uint = 0) : CharacterToRelookInformation
      {
         super.initAbstractCharacterToRefurbishInformation(param1,param2,param3);
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterToRelookInformation(param1);
      }
      
      public function serializeAs_CharacterToRelookInformation(param1:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractCharacterToRefurbishInformation(param1);
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterToRelookInformation(param1);
      }
      
      public function deserializeAs_CharacterToRelookInformation(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
      }
   }
}
