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
      
      public function initCharacterSelectedSuccessMessage(infos:CharacterBaseInformations=null) : CharacterSelectedSuccessMessage {
         this.infos = infos;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.infos = new CharacterBaseInformations();
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
         this.serializeAs_CharacterSelectedSuccessMessage(output);
      }
      
      public function serializeAs_CharacterSelectedSuccessMessage(output:IDataOutput) : void {
         this.infos.serializeAs_CharacterBaseInformations(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterSelectedSuccessMessage(input);
      }
      
      public function deserializeAs_CharacterSelectedSuccessMessage(input:IDataInput) : void {
         this.infos = new CharacterBaseInformations();
         this.infos.deserialize(input);
      }
   }
}
