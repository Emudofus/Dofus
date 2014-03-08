package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import __AS3__.vec.Vector;
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
      
      public function initPartyInvitationDungeonDetailsMessage(param1:uint=0, param2:uint=0, param3:uint=0, param4:String="", param5:uint=0, param6:Vector.<PartyInvitationMemberInformations>=null, param7:Vector.<PartyGuestInformations>=null, param8:uint=0, param9:Vector.<Boolean>=null) : PartyInvitationDungeonDetailsMessage {
         super.initPartyInvitationDetailsMessage(param1,param2,param3,param4,param5,param6,param7);
         this.dungeonId = param8;
         this.playersDungeonReady = param9;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.dungeonId = 0;
         this.playersDungeonReady = new Vector.<Boolean>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PartyInvitationDungeonDetailsMessage(param1);
      }
      
      public function serializeAs_PartyInvitationDungeonDetailsMessage(param1:IDataOutput) : void {
         super.serializeAs_PartyInvitationDetailsMessage(param1);
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            param1.writeShort(this.dungeonId);
            param1.writeShort(this.playersDungeonReady.length);
            _loc2_ = 0;
            while(_loc2_ < this.playersDungeonReady.length)
            {
               param1.writeBoolean(this.playersDungeonReady[_loc2_]);
               _loc2_++;
            }
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PartyInvitationDungeonDetailsMessage(param1);
      }
      
      public function deserializeAs_PartyInvitationDungeonDetailsMessage(param1:IDataInput) : void {
         var _loc4_:* = false;
         super.deserialize(param1);
         this.dungeonId = param1.readShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonDetailsMessage.dungeonId.");
         }
         else
         {
            _loc2_ = param1.readUnsignedShort();
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readBoolean();
               this.playersDungeonReady.push(_loc4_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
