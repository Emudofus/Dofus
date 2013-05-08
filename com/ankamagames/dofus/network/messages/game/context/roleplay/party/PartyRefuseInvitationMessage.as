package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class PartyRefuseInvitationMessage extends AbstractPartyMessage implements INetworkMessage
   {
         

      public function PartyRefuseInvitationMessage() {
         super();
      }

      public static const protocolId:uint = 5582;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return (super.isInitialized)&&(this._isInitialized);
      }

      override public function getMessageId() : uint {
         return 5582;
      }

      public function initPartyRefuseInvitationMessage(partyId:uint=0) : PartyRefuseInvitationMessage {
         super.initAbstractPartyMessage(partyId);
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this._isInitialized=false;
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
         this.serializeAs_PartyRefuseInvitationMessage(output);
      }

      public function serializeAs_PartyRefuseInvitationMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyRefuseInvitationMessage(input);
      }

      public function deserializeAs_PartyRefuseInvitationMessage(input:IDataInput) : void {
         super.deserialize(input);
      }
   }

}