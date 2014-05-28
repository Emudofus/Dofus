package com.ankamagames.dofus.network.messages.game.character.creation
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterNameSuggestionSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterNameSuggestionSuccessMessage() {
         super();
      }
      
      public static const protocolId:uint = 5544;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var suggestion:String = "";
      
      override public function getMessageId() : uint {
         return 5544;
      }
      
      public function initCharacterNameSuggestionSuccessMessage(suggestion:String = "") : CharacterNameSuggestionSuccessMessage {
         this.suggestion = suggestion;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.suggestion = "";
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
         this.serializeAs_CharacterNameSuggestionSuccessMessage(output);
      }
      
      public function serializeAs_CharacterNameSuggestionSuccessMessage(output:IDataOutput) : void {
         output.writeUTF(this.suggestion);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterNameSuggestionSuccessMessage(input);
      }
      
      public function deserializeAs_CharacterNameSuggestionSuccessMessage(input:IDataInput) : void {
         this.suggestion = input.readUTF();
      }
   }
}
