package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyInvitationMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class PartyInvitationDungeonDetailsMessage extends PartyInvitationDetailsMessage implements INetworkMessage
   {
      
      public function PartyInvitationDungeonDetailsMessage() {
         this.playersDungeonReady = new Vector.<Boolean>();
         super();
      }
      
      public static const protocolId:uint = 6262;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var dungeonId:uint = 0;
      
      public var playersDungeonReady:Vector.<Boolean>;
      
      override public function getMessageId() : uint {
         return 6262;
      }
      
      public function initPartyInvitationDungeonDetailsMessage(partyId:uint = 0, partyType:uint = 0, fromId:uint = 0, fromName:String = "", leaderId:uint = 0, members:Vector.<PartyInvitationMemberInformations> = null, guests:Vector.<PartyGuestInformations> = null, dungeonId:uint = 0, playersDungeonReady:Vector.<Boolean> = null) : PartyInvitationDungeonDetailsMessage {
         super.initPartyInvitationDetailsMessage(partyId,partyType,fromId,fromName,leaderId,members,guests);
         this.dungeonId = dungeonId;
         this.playersDungeonReady = playersDungeonReady;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.dungeonId = 0;
         this.playersDungeonReady = new Vector.<Boolean>();
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
         this.serializeAs_PartyInvitationDungeonDetailsMessage(output);
      }
      
      public function serializeAs_PartyInvitationDungeonDetailsMessage(output:IDataOutput) : void {
         super.serializeAs_PartyInvitationDetailsMessage(output);
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            output.writeShort(this.dungeonId);
            output.writeShort(this.playersDungeonReady.length);
            _i2 = 0;
            while(_i2 < this.playersDungeonReady.length)
            {
               output.writeBoolean(this.playersDungeonReady[_i2]);
               _i2++;
            }
            return;
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PartyInvitationDungeonDetailsMessage(input);
      }
      
      public function deserializeAs_PartyInvitationDungeonDetailsMessage(input:IDataInput) : void {
         var _val2:* = false;
         super.deserialize(input);
         this.dungeonId = input.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonDetailsMessage.dungeonId.");
         }
         else
         {
            _playersDungeonReadyLen = input.readUnsignedShort();
            _i2 = 0;
            while(_i2 < _playersDungeonReadyLen)
            {
               _val2 = input.readBoolean();
               this.playersDungeonReady.push(_val2);
               _i2++;
            }
            return;
         }
      }
   }
}
