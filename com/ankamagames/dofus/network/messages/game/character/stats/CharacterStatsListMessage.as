package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharacterStatsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterStatsListMessage()
      {
         this.stats = new CharacterCharacteristicsInformations();
         super();
      }
      
      public static const protocolId:uint = 500;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var stats:CharacterCharacteristicsInformations;
      
      override public function getMessageId() : uint
      {
         return 500;
      }
      
      public function initCharacterStatsListMessage(param1:CharacterCharacteristicsInformations = null) : CharacterStatsListMessage
      {
         this.stats = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.stats = new CharacterCharacteristicsInformations();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterStatsListMessage(param1);
      }
      
      public function serializeAs_CharacterStatsListMessage(param1:ICustomDataOutput) : void
      {
         this.stats.serializeAs_CharacterCharacteristicsInformations(param1);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterStatsListMessage(param1);
      }
      
      public function deserializeAs_CharacterStatsListMessage(param1:ICustomDataInput) : void
      {
         this.stats = new CharacterCharacteristicsInformations();
         this.stats.deserialize(param1);
      }
   }
}
