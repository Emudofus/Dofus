package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyNewGuestMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public function PartyNewGuestMessage() {
         this.guest = new PartyGuestInformations();
         super();
      }
      
      public static const protocolId:uint = 6260;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var guest:PartyGuestInformations;
      
      override public function getMessageId() : uint {
         return 6260;
      }
      
      public function initPartyNewGuestMessage(partyId:uint = 0, guest:PartyGuestInformations = null) : PartyNewGuestMessage {
         super.initAbstractPartyEventMessage(partyId);
         this.guest = guest;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.guest = new PartyGuestInformations();
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
         this.serializeAs_PartyNewGuestMessage(output);
      }
      
      public function serializeAs_PartyNewGuestMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyEventMessage(output);
         this.guest.serializeAs_PartyGuestInformations(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyNewGuestMessage(input);
      }
      
      public function deserializeAs_PartyNewGuestMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.guest = new PartyGuestInformations();
         this.guest.deserialize(input);
      }
   }
}
