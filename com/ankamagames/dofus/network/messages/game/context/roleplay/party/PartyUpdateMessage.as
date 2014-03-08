package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class PartyUpdateMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public function PartyUpdateMessage() {
         this.memberInformations = new PartyMemberInformations();
         super();
      }
      
      public static const protocolId:uint = 5575;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var memberInformations:PartyMemberInformations;
      
      override public function getMessageId() : uint {
         return 5575;
      }
      
      public function initPartyUpdateMessage(partyId:uint=0, memberInformations:PartyMemberInformations=null) : PartyUpdateMessage {
         super.initAbstractPartyEventMessage(partyId);
         this.memberInformations = memberInformations;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.memberInformations = new PartyMemberInformations();
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
         this.serializeAs_PartyUpdateMessage(output);
      }
      
      public function serializeAs_PartyUpdateMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyEventMessage(output);
         output.writeShort(this.memberInformations.getTypeId());
         this.memberInformations.serialize(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyUpdateMessage(input);
      }
      
      public function deserializeAs_PartyUpdateMessage(input:IDataInput) : void {
         super.deserialize(input);
         var _id1:uint = input.readUnsignedShort();
         this.memberInformations = ProtocolTypeManager.getInstance(PartyMemberInformations,_id1);
         this.memberInformations.deserialize(input);
      }
   }
}
