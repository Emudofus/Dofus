package com.ankamagames.dofus.network.messages.game.character.stats
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristicsInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterStatsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterStatsListMessage() {
         this.stats = new CharacterCharacteristicsInformations();
         super();
      }
      
      public static const protocolId:uint = 500;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var stats:CharacterCharacteristicsInformations;
      
      override public function getMessageId() : uint {
         return 500;
      }
      
      public function initCharacterStatsListMessage(stats:CharacterCharacteristicsInformations=null) : CharacterStatsListMessage {
         this.stats = stats;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.stats = new CharacterCharacteristicsInformations();
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterStatsListMessage(output);
      }
      
      public function serializeAs_CharacterStatsListMessage(output:IDataOutput) : void {
         this.stats.serializeAs_CharacterCharacteristicsInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterStatsListMessage(input);
      }
      
      public function deserializeAs_CharacterStatsListMessage(input:IDataInput) : void {
         this.stats = new CharacterCharacteristicsInformations();
         this.stats.deserialize(input);
      }
   }
}
