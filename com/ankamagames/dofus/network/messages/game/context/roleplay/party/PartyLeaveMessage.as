package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyLeaveMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyLeaveMessage() {
         super();
      }
      
      public static const protocolId:uint = 5594;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 5594;
      }
      
      public function initPartyLeaveMessage(partyId:uint = 0) : PartyLeaveMessage {
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
         this.serializeAs_PartyLeaveMessage(output);
      }
      
      public function serializeAs_PartyLeaveMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyLeaveMessage(input);
      }
      
      public function deserializeAs_PartyLeaveMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
