package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TeleportBuddiesRequestedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var inviterId:uint = 0;
        public var invalidBuddiesIds:Vector.<uint>;
        public static const protocolId:uint = 6302;

        public function TeleportBuddiesRequestedMessage()
        {
            this.invalidBuddiesIds = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6302;
        }// end function

        public function initTeleportBuddiesRequestedMessage(param1:uint = 0, param2:uint = 0, param3:Vector.<uint> = null) : TeleportBuddiesRequestedMessage
        {
            this.dungeonId = param1;
            this.inviterId = param2;
            this.invalidBuddiesIds = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.dungeonId = 0;
            this.inviterId = 0;
            this.invalidBuddiesIds = new Vector.<uint>;
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

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_TeleportBuddiesRequestedMessage(param1);
            return;
        }// end function

        public function serializeAs_TeleportBuddiesRequestedMessage(param1:IDataOutput) : void
        {
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
            }
            param1.writeShort(this.dungeonId);
            if (this.inviterId < 0)
            {
                throw new Error("Forbidden value (" + this.inviterId + ") on element inviterId.");
            }
            param1.writeInt(this.inviterId);
            param1.writeShort(this.invalidBuddiesIds.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.invalidBuddiesIds.length)
            {
                
                if (this.invalidBuddiesIds[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.invalidBuddiesIds[_loc_2] + ") on element 3 (starting at 1) of invalidBuddiesIds.");
                }
                param1.writeInt(this.invalidBuddiesIds[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TeleportBuddiesRequestedMessage(param1);
            return;
        }// end function

        public function deserializeAs_TeleportBuddiesRequestedMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            this.dungeonId = param1.readShort();
            if (this.dungeonId < 0)
            {
                throw new Error("Forbidden value (" + this.dungeonId + ") on element of TeleportBuddiesRequestedMessage.dungeonId.");
            }
            this.inviterId = param1.readInt();
            if (this.inviterId < 0)
            {
                throw new Error("Forbidden value (" + this.inviterId + ") on element of TeleportBuddiesRequestedMessage.inviterId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                if (_loc_4 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of invalidBuddiesIds.");
                }
                this.invalidBuddiesIds.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
