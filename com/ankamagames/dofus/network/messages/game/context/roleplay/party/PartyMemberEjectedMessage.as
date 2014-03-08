package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyMemberEjectedMessage extends PartyMemberRemoveMessage implements INetworkMessage
   {
      
      public function PartyMemberEjectedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6252;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var kickerId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6252;
      }
      
      public function initPartyMemberEjectedMessage(partyId:uint=0, leavingPlayerId:uint=0, kickerId:uint=0) : PartyMemberEjectedMessage {
         super.initPartyMemberRemoveMessage(partyId,leavingPlayerId);
         this.kickerId = kickerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.kickerId = 0;
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
         this.serializeAs_PartyMemberEjectedMessage(output);
      }
      
      public function serializeAs_PartyMemberEjectedMessage(output:IDataOutput) : void {
         super.serializeAs_PartyMemberRemoveMessage(output);
         if(this.kickerId < 0)
         {
            throw new Error("Forbidden value (" + this.kickerId + ") on element kickerId.");
         }
         else
         {
            output.writeInt(this.kickerId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyMemberEjectedMessage(input);
      }
      
      public function deserializeAs_PartyMemberEjectedMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.kickerId = input.readInt();
         if(this.kickerId < 0)
         {
            throw new Error("Forbidden value (" + this.kickerId + ") on element of PartyMemberEjectedMessage.kickerId.");
         }
         else
         {
            return;
         }
      }
   }
}
