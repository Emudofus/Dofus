package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyPledgeLoyaltyRequestMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyPledgeLoyaltyRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 6269;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var loyal:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6269;
      }
      
      public function initPartyPledgeLoyaltyRequestMessage(partyId:uint=0, loyal:Boolean=false) : PartyPledgeLoyaltyRequestMessage {
         super.initAbstractPartyMessage(partyId);
         this.loyal = loyal;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.loyal = false;
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
         this.serializeAs_PartyPledgeLoyaltyRequestMessage(output);
      }
      
      public function serializeAs_PartyPledgeLoyaltyRequestMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeBoolean(this.loyal);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyPledgeLoyaltyRequestMessage(input);
      }
      
      public function deserializeAs_PartyPledgeLoyaltyRequestMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.loyal = input.readBoolean();
      }
   }
}
