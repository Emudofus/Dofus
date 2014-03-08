package com.ankamagames.dofus.network.messages.game.character.choice
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class CharacterSelectedErrorMissingMapPackMessage extends CharacterSelectedErrorMessage implements INetworkMessage
   {
      
      public function CharacterSelectedErrorMissingMapPackMessage() {
         super();
      }
      
      public static const protocolId:uint = 6300;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var subAreaId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6300;
      }
      
      public function initCharacterSelectedErrorMissingMapPackMessage(subAreaId:uint=0) : CharacterSelectedErrorMissingMapPackMessage {
         this.subAreaId = subAreaId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.subAreaId = 0;
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_CharacterSelectedErrorMissingMapPackMessage(output);
      }
      
      public function serializeAs_CharacterSelectedErrorMissingMapPackMessage(output:IDataOutput) : void {
         super.serializeAs_CharacterSelectedErrorMessage(output);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         else
         {
            output.writeInt(this.subAreaId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CharacterSelectedErrorMissingMapPackMessage(input);
      }
      
      public function deserializeAs_CharacterSelectedErrorMissingMapPackMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.subAreaId = input.readInt();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of CharacterSelectedErrorMissingMapPackMessage.subAreaId.");
         }
         else
         {
            return;
         }
      }
   }
}
