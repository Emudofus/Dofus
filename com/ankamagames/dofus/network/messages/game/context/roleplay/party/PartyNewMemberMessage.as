package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyMemberInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyNewMemberMessage extends PartyUpdateMessage implements INetworkMessage
   {
      
      public function PartyNewMemberMessage() {
         super();
      }
      
      public static const protocolId:uint = 6306;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      override public function getMessageId() : uint {
         return 6306;
      }
      
      public function initPartyNewMemberMessage(partyId:uint = 0, memberInformations:PartyMemberInformations = null) : PartyNewMemberMessage {
         super.initPartyUpdateMessage(partyId,memberInformations);
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
         this.serializeAs_PartyNewMemberMessage(output);
      }
      
      public function serializeAs_PartyNewMemberMessage(output:IDataOutput) : void {
         super.serializeAs_PartyUpdateMessage(output);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyNewMemberMessage(input);
      }
      
      public function deserializeAs_PartyNewMemberMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }
}
