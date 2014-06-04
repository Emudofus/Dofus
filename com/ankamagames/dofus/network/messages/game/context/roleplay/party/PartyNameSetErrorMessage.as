package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyNameSetErrorMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyNameSetErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6501;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var result:uint = 0;
      
      override public function getMessageId() : uint {
         return 6501;
      }
      
      public function initPartyNameSetErrorMessage(partyId:uint = 0, result:uint = 0) : PartyNameSetErrorMessage {
         super.initAbstractPartyMessage(partyId);
         this.result = result;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.result = 0;
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
         this.serializeAs_PartyNameSetErrorMessage(output);
      }
      
      public function serializeAs_PartyNameSetErrorMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeByte(this.result);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyNameSetErrorMessage(input);
      }
      
      public function deserializeAs_PartyNameSetErrorMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.result = input.readByte();
         if(this.result < 0)
         {
            throw new Error("Forbidden value (" + this.result + ") on element of PartyNameSetErrorMessage.result.");
         }
         else
         {
            return;
         }
      }
   }
}
