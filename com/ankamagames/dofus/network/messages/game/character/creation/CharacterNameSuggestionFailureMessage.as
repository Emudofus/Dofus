package com.ankamagames.dofus.network.messages.game.character.creation
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterNameSuggestionFailureMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterNameSuggestionFailureMessage() {
         super();
      }
      
      public static const protocolId:uint = 164;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var reason:uint = 1;
      
      override public function getMessageId() : uint {
         return 164;
      }
      
      public function initCharacterNameSuggestionFailureMessage(param1:uint=1) : CharacterNameSuggestionFailureMessage {
         this.reason = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.reason = 1;
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
         this.serializeAs_CharacterNameSuggestionFailureMessage(param1);
      }
      
      public function serializeAs_CharacterNameSuggestionFailureMessage(param1:IDataOutput) : void {
         param1.writeByte(this.reason);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterNameSuggestionFailureMessage(param1);
      }
      
      public function deserializeAs_CharacterNameSuggestionFailureMessage(param1:IDataInput) : void {
         this.reason = param1.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of CharacterNameSuggestionFailureMessage.reason.");
         }
         else
         {
            return;
         }
      }
   }
}
