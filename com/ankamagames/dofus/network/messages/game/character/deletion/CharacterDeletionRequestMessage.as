package com.ankamagames.dofus.network.messages.game.character.deletion
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterDeletionRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterDeletionRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 165;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var characterId:uint = 0;
      
      public var secretAnswerHash:String = "";
      
      override public function getMessageId() : uint {
         return 165;
      }
      
      public function initCharacterDeletionRequestMessage(characterId:uint=0, secretAnswerHash:String="") : CharacterDeletionRequestMessage {
         this.characterId = characterId;
         this.secretAnswerHash = secretAnswerHash;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.characterId = 0;
         this.secretAnswerHash = "";
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
         this.serializeAs_CharacterDeletionRequestMessage(output);
      }
      
      public function serializeAs_CharacterDeletionRequestMessage(output:IDataOutput) : void {
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         else
         {
            output.writeInt(this.characterId);
            output.writeUTF(this.secretAnswerHash);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterDeletionRequestMessage(input);
      }
      
      public function deserializeAs_CharacterDeletionRequestMessage(input:IDataInput) : void {
         this.characterId = input.readInt();
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of CharacterDeletionRequestMessage.characterId.");
         }
         else
         {
            this.secretAnswerHash = input.readUTF();
            return;
         }
      }
   }
}
