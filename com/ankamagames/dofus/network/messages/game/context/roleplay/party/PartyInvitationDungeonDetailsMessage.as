package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyInvitationMemberInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.PartyGuestInformations;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class PartyInvitationDungeonDetailsMessage extends PartyInvitationDetailsMessage implements INetworkMessage
   {
      
      public function PartyInvitationDungeonDetailsMessage()
      {
         this.playersDungeonReady = new Vector.<Boolean>();
         super();
      }
      
      public static const protocolId:uint = 6262;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var dungeonId:uint = 0;
      
      public var playersDungeonReady:Vector.<Boolean>;
      
      override public function getMessageId() : uint
      {
         return 6262;
      }
      
      public function initPartyInvitationDungeonDetailsMessage(param1:uint = 0, param2:uint = 0, param3:String = "", param4:uint = 0, param5:String = "", param6:uint = 0, param7:Vector.<PartyInvitationMemberInformations> = null, param8:Vector.<PartyGuestInformations> = null, param9:uint = 0, param10:Vector.<Boolean> = null) : PartyInvitationDungeonDetailsMessage
      {
         super.initPartyInvitationDetailsMessage(param1,param2,param3,param4,param5,param6,param7,param8);
         this.dungeonId = param9;
         this.playersDungeonReady = param10;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.dungeonId = 0;
         this.playersDungeonReady = new Vector.<Boolean>();
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_PartyInvitationDungeonDetailsMessage(param1);
      }
      
      public function serializeAs_PartyInvitationDungeonDetailsMessage(param1:ICustomDataOutput) : void
      {
         super.serializeAs_PartyInvitationDetailsMessage(param1);
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            param1.writeVarShort(this.dungeonId);
            param1.writeShort(this.playersDungeonReady.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.playersDungeonReady.length)
            {
               param1.writeBoolean(this.playersDungeonReady[_loc2_]);
               _loc2_++;
            }
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_PartyInvitationDungeonDetailsMessage(param1);
      }
      
      public function deserializeAs_PartyInvitationDungeonDetailsMessage(param1:ICustomDataInput) : void
      {
         var _loc4_:* = false;
         super.deserialize(param1);
         this.dungeonId = param1.readVarUhShort();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonDetailsMessage.dungeonId.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
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
