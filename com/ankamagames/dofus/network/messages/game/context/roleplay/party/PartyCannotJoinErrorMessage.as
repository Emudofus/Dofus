package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyCannotJoinErrorMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public function PartyCannotJoinErrorMessage() {
         super();
      }
      
      public static const protocolId:uint = 5583;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var reason:uint = 0;
      
      override public function getMessageId() : uint {
         return 5583;
      }
      
      public function initPartyCannotJoinErrorMessage(partyId:uint=0, reason:uint=0) : PartyCannotJoinErrorMessage {
         super.initAbstractPartyMessage(partyId);
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.reason = 0;
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
         this.serializeAs_PartyCannotJoinErrorMessage(output);
      }
      
      public function serializeAs_PartyCannotJoinErrorMessage(output:IDataOutput) : void {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeByte(this.reason);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyCannotJoinErrorMessage(input);
      }
      
      public function deserializeAs_PartyCannotJoinErrorMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of PartyCannotJoinErrorMessage.reason.");
         }
         else
         {
            return;
         }
      }
   }
}
