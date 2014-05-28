package com.ankamagames.dofus.network.messages.game.character.replay
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterReplayRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterReplayRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 167;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var characterId:uint = 0;
      
      override public function getMessageId() : uint {
         return 167;
      }
      
      public function initCharacterReplayRequestMessage(characterId:uint = 0) : CharacterReplayRequestMessage {
         this.characterId = characterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.characterId = 0;
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
         this.serializeAs_CharacterReplayRequestMessage(output);
      }
      
      public function serializeAs_CharacterReplayRequestMessage(output:IDataOutput) : void {
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         else
         {
            output.writeInt(this.characterId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterReplayRequestMessage(input);
      }
      
      public function deserializeAs_CharacterReplayRequestMessage(input:IDataInput) : void {
         this.characterId = input.readInt();
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of CharacterReplayRequestMessage.characterId.");
         }
         else
         {
            return;
         }
      }
   }
}
