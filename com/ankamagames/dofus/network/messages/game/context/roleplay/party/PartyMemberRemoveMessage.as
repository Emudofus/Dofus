package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyMemberRemoveMessage extends AbstractPartyEventMessage implements INetworkMessage
   {
      
      public function PartyMemberRemoveMessage() {
         super();
      }
      
      public static const protocolId:uint = 5579;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var leavingPlayerId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5579;
      }
      
      public function initPartyMemberRemoveMessage(partyId:uint = 0, leavingPlayerId:uint = 0) : PartyMemberRemoveMessage {
         super.initAbstractPartyEventMessage(partyId);
         this.leavingPlayerId = leavingPlayerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.leavingPlayerId = 0;
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
         this.serializeAs_PartyMemberRemoveMessage(output);
      }
      
      public function serializeAs_PartyMemberRemoveMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyEventMessage(output);
         if(this.leavingPlayerId < 0)
         {
            throw new Error("Forbidden value (" + this.leavingPlayerId + ") on element leavingPlayerId.");
         }
         else
         {
            output.writeInt(this.leavingPlayerId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyMemberRemoveMessage(input);
      }
      
      public function deserializeAs_PartyMemberRemoveMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.leavingPlayerId = input.readInt();
         if(this.leavingPlayerId < 0)
         {
            throw new Error("Forbidden value (" + this.leavingPlayerId + ") on element of PartyMemberRemoveMessage.leavingPlayerId.");
         }
         else
         {
            return;
         }
      }
   }
}
