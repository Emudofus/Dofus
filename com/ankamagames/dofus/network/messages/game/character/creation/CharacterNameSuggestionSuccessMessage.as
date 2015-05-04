package com.ankamagames.dofus.network.messages.game.character.creation
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class CharacterNameSuggestionSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterNameSuggestionSuccessMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5544;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var suggestion:String = "";
      
      override public function getMessageId() : uint
      {
         return 5544;
      }
      
      public function initCharacterNameSuggestionSuccessMessage(param1:String = "") : CharacterNameSuggestionSuccessMessage
      {
         this.suggestion = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.suggestion = "";
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
         this.serializeAs_CharacterNameSuggestionSuccessMessage(param1);
      }
      
      public function serializeAs_CharacterNameSuggestionSuccessMessage(param1:ICustomDataOutput) : void
      {
         param1.writeUTF(this.suggestion);
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterNameSuggestionSuccessMessage(param1);
      }
      
      public function deserializeAs_CharacterNameSuggestionSuccessMessage(param1:ICustomDataInput) : void
      {
         this.suggestion = param1.readUTF();
      }
   }
}
