package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyInvitationDungeonMessage extends PartyInvitationMessage implements INetworkMessage
   {
      
      public function PartyInvitationDungeonMessage() {
         super();
      }
      
      public static const protocolId:uint = 6244;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var dungeonId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6244;
      }
      
      public function initPartyInvitationDungeonMessage(partyId:uint = 0, partyType:uint = 0, maxParticipants:uint = 0, fromId:uint = 0, fromName:String = "", toId:uint = 0, dungeonId:uint = 0) : PartyInvitationDungeonMessage {
         super.initPartyInvitationMessage(partyId,partyType,maxParticipants,fromId,fromName,toId);
         this.dungeonId = dungeonId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.dungeonId = 0;
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
         this.serializeAs_PartyInvitationDungeonMessage(output);
      }
      
      public function serializeAs_PartyInvitationDungeonMessage(output:IDataOutput) : void {
         super.serializeAs_PartyInvitationMessage(output);
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            output.writeShort(this.dungeonId);
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyInvitationDungeonMessage(input);
      }
      
      public function deserializeAs_PartyInvitationDungeonMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.dungeonId = input.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonMessage.dungeonId.");
         }
         else
         {
            return;
         }
      }
   }
}
