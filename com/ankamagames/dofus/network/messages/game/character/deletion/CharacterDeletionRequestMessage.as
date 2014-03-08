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
      
      public function initCharacterDeletionRequestMessage(param1:uint=0, param2:String="") : CharacterDeletionRequestMessage {
         this.characterId = param1;
         this.secretAnswerHash = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.characterId = 0;
         this.secretAnswerHash = "";
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_CharacterDeletionRequestMessage(param1);
      }
      
      public function serializeAs_CharacterDeletionRequestMessage(param1:IDataOutput) : void {
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         else
         {
            param1.writeInt(this.characterId);
            param1.writeUTF(this.secretAnswerHash);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterDeletionRequestMessage(param1);
      }
      
      public function deserializeAs_CharacterDeletionRequestMessage(param1:IDataInput) : void {
         this.characterId = param1.readInt();
         if(this.characterId < 0)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of CharacterDeletionRequestMessage.characterId.");
         }
         else
         {
            this.secretAnswerHash = param1.readUTF();
            return;
         }
      }
   }
}
