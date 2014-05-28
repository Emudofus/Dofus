package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyAcceptInvitationMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyAcceptInvitationMessage() {
         super();
      }
      
      public static const protocolId:uint = 5580;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 5580;
      }
      
      public function initPartyAcceptInvitationMessage(partyId:uint = 0) : PartyAcceptInvitationMessage {
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
         this.serializeAs_PartyAcceptInvitationMessage(output);
      }
      
      public function serializeAs_PartyAcceptInvitationMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyAcceptInvitationMessage(input);
      }
      
      public function deserializeAs_PartyAcceptInvitationMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
