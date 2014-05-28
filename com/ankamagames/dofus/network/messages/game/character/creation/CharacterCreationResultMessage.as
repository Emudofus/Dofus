package com.ankamagames.dofus.network.messages.game.character.creation
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterCreationResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function CharacterCreationResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 161;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var result:uint = 1;
      
      override public function getMessageId() : uint {
         return 161;
      }
      
      public function initCharacterCreationResultMessage(result:uint = 1) : CharacterCreationResultMessage {
         this.result = result;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.result = 1;
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
         this.serializeAs_CharacterCreationResultMessage(output);
      }
      
      public function serializeAs_CharacterCreationResultMessage(output:IDataOutput) : void {
         output.writeByte(this.result);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterCreationResultMessage(input);
      }
      
      public function deserializeAs_CharacterCreationResultMessage(input:IDataInput) : void {
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of CharacterCreationResultMessage.result.");
         }
         else
         {
            return;
         }
      }
   }
}
