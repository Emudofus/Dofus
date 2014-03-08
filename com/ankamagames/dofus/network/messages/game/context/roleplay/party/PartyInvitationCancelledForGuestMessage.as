package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyInvitationCancelledForGuestMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyInvitationCancelledForGuestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6256;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var cancelerId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6256;
      }
      
      public function initPartyInvitationCancelledForGuestMessage(partyId:uint=0, cancelerId:uint=0) : PartyInvitationCancelledForGuestMessage {
         super.initAbstractPartyMessage(partyId);
         this.cancelerId = cancelerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.cancelerId = 0;
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
         this.serializeAs_PartyInvitationCancelledForGuestMessage(output);
      }
      
      public function serializeAs_PartyInvitationCancelledForGuestMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
         if(this.cancelerId < 0)
         {
            throw new Error("Forbidden value (" + this.cancelerId + ") on element cancelerId.");
         }
         else
         {
            output.writeInt(this.cancelerId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyInvitationCancelledForGuestMessage(input);
      }
      
      public function deserializeAs_PartyInvitationCancelledForGuestMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.cancelerId = input.readInt();
         if(this.cancelerId < 0)
         {
            throw new Error("Forbidden value (" + this.cancelerId + ") on element of PartyInvitationCancelledForGuestMessage.cancelerId.");
         }
         else
         {
            return;
         }
      }
   }
}
