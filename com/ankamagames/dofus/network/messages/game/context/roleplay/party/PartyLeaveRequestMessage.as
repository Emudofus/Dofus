package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyLeaveRequestMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyLeaveRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5593;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 5593;
      }
      
      public function initPartyLeaveRequestMessage(partyId:uint = 0) : PartyLeaveRequestMessage {
         super.initAbstractPartyMessage(partyId);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
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
         this.serializeAs_PartyLeaveRequestMessage(output);
      }
      
      public function serializeAs_PartyLeaveRequestMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyLeaveRequestMessage(input);
      }
      
      public function deserializeAs_PartyLeaveRequestMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
