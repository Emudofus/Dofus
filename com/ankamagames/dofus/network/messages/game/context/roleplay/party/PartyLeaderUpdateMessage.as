package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyLeaderUpdateMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public function PartyLeaderUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 5578;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var partyLeaderId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5578;
      }
      
      public function initPartyLeaderUpdateMessage(partyId:uint=0, partyLeaderId:uint=0) : PartyLeaderUpdateMessage {
         super.initAbstractPartyEventMessage(partyId);
         this.partyLeaderId = partyLeaderId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.partyLeaderId = 0;
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
         this.serializeAs_PartyLeaderUpdateMessage(output);
      }
      
      public function serializeAs_PartyLeaderUpdateMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyEventMessage(output);
         if(this.partyLeaderId < 0)
         {
            throw new Error("Forbidden value (" + this.partyLeaderId + ") on element partyLeaderId.");
         }
         else
         {
            output.writeInt(this.partyLeaderId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyLeaderUpdateMessage(input);
      }
      
      public function deserializeAs_PartyLeaderUpdateMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.partyLeaderId = input.readInt();
         if(this.partyLeaderId < 0)
         {
            throw new Error("Forbidden value (" + this.partyLeaderId + ") on element of PartyLeaderUpdateMessage.partyLeaderId.");
         }
         else
         {
            return;
         }
      }
   }
}
