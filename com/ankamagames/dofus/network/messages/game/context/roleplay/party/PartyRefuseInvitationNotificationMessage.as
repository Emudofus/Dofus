package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyRefuseInvitationNotificationMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public function PartyRefuseInvitationNotificationMessage() {
         super();
      }
      
      public static const protocolId:uint = 5596;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var guestId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5596;
      }
      
      public function initPartyRefuseInvitationNotificationMessage(partyId:uint=0, guestId:uint=0) : PartyRefuseInvitationNotificationMessage {
         super.initAbstractPartyEventMessage(partyId);
         this.guestId = guestId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.guestId = 0;
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
         this.serializeAs_PartyRefuseInvitationNotificationMessage(output);
      }
      
      public function serializeAs_PartyRefuseInvitationNotificationMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyEventMessage(output);
         if(this.guestId < 0)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element guestId.");
         }
         else
         {
            output.writeInt(this.guestId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyRefuseInvitationNotificationMessage(input);
      }
      
      public function deserializeAs_PartyRefuseInvitationNotificationMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.guestId = input.readInt();
         if(this.guestId < 0)
         {
            throw new Error("Forbidden value (" + this.guestId + ") on element of PartyRefuseInvitationNotificationMessage.guestId.");
         }
         else
         {
            return;
         }
      }
   }
}
