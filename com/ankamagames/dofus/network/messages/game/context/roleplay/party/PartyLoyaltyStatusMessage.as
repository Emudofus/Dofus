package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyLoyaltyStatusMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyLoyaltyStatusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6270;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var loyal:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6270;
      }
      
      public function initPartyLoyaltyStatusMessage(partyId:uint = 0, loyal:Boolean = false) : PartyLoyaltyStatusMessage {
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
         this.serializeAs_PartyLoyaltyStatusMessage(output);
      }
      
      public function serializeAs_PartyLoyaltyStatusMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeBoolean(this.loyal);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyLoyaltyStatusMessage(input);
      }
      
      public function deserializeAs_PartyLoyaltyStatusMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.loyal = input.readBoolean();
      }
   }
}
