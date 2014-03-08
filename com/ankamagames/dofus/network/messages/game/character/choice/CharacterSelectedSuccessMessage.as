package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.character.choice.CharacterBaseInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterSelectedSuccessMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterSelectedSuccessMessage() {
         this.infos = new CharacterBaseInformations();
         super();
      }
      
      public static const protocolId:uint = 153;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var infos:CharacterBaseInformations;
      
      override public function getMessageId() : uint {
         return 153;
      }
      
      public function initCharacterSelectedSuccessMessage(param1:CharacterBaseInformations=null) : CharacterSelectedSuccessMessage {
         this.infos = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.infos = new CharacterBaseInformations();
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
         this.serializeAs_CharacterSelectedSuccessMessage(param1);
      }
      
      public function serializeAs_CharacterSelectedSuccessMessage(param1:IDataOutput) : void {
         this.infos.serializeAs_CharacterBaseInformations(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_CharacterSelectedSuccessMessage(param1);
      }
      
      public function deserializeAs_CharacterSelectedSuccessMessage(param1:IDataInput) : void {
         this.infos = new CharacterBaseInformations();
         this.infos.deserialize(param1);
      }
   }
}
