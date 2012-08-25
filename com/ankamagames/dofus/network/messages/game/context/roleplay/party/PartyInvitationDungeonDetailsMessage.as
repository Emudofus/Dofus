package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyInvitationDungeonDetailsMessage extends PartyInvitationDetailsMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var playersDungeonReady:Vector.<Boolean>;
        public static const protocolId:uint = 6262;

        public function PartyInvitationDungeonDetailsMessage()
        {
            this.playersDungeonReady = new Vector.<Boolean>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6262;
        }// end function

        public function initPartyInvitationDungeonDetailsMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:String = "", param5:uint = 0, param6:Vector.<PartyInvitationMemberInformations> = null, param7:uint = 0, param8:Vector.<Boolean> = null) : PartyInvitationDungeonDetailsMessage
        {
            super.initPartyInvitationDetailsMessage(param1, param2, param3, param4, param5, param6);
            this.dungeonId = param7;
            this.playersDungeonReady = param8;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.dungeonId = 0;
            this.playersDungeonReady = new Vector.<Boolean>;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PartyInvitationDungeonDetailsMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyInvitationDungeonDetailsMessage(param1:IDataOutput) : void
        {
            super.serializeAs_PartyInvitationDetailsMessage(param1);
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
            }
            param1.writeShort(this.dungeonId);
            param1.writeShort(this.playersDungeonReady.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.playersDungeonReady.length)
            {
                
                param1.writeBoolean(this.playersDungeonReady[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyInvitationDungeonDetailsMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyInvitationDungeonDetailsMessage(param1:IDataInput) : void
        {
            var _loc_4:Boolean = false;
            super.deserialize(param1);
            this.dungeonId = param1.readShort();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of PartyInvitationDungeonDetailsMessage.dungeonId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readBoolean();
                this.playersDungeonReady.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
