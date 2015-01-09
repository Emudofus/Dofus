package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class TeleportBuddiesRequestedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6302;

        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var inviterId:uint = 0;
        public var invalidBuddiesIds:Vector.<uint>;

        public function TeleportBuddiesRequestedMessage()
        {
            this.invalidBuddiesIds = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6302);
        }

        public function initTeleportBuddiesRequestedMessage(dungeonId:uint=0, inviterId:uint=0, invalidBuddiesIds:Vector.<uint>=null):TeleportBuddiesRequestedMessage
        {
            this.dungeonId = dungeonId;
            this.inviterId = inviterId;
            this.invalidBuddiesIds = invalidBuddiesIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dungeonId = 0;
            this.inviterId = 0;
            this.invalidBuddiesIds = new Vector.<uint>();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_TeleportBuddiesRequestedMessage(output);
        }

        public function serializeAs_TeleportBuddiesRequestedMessage(output:ICustomDataOutput):void
        {
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element dungeonId.")));
            };
            output.writeVarShort(this.dungeonId);
            if (this.inviterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.inviterId) + ") on element inviterId.")));
            };
            output.writeVarInt(this.inviterId);
            output.writeShort(this.invalidBuddiesIds.length);
            var _i3:uint;
            while (_i3 < this.invalidBuddiesIds.length)
            {
                if (this.invalidBuddiesIds[_i3] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.invalidBuddiesIds[_i3]) + ") on element 3 (starting at 1) of invalidBuddiesIds.")));
                };
                output.writeVarInt(this.invalidBuddiesIds[_i3]);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TeleportBuddiesRequestedMessage(input);
        }

        public function deserializeAs_TeleportBuddiesRequestedMessage(input:ICustomDataInput):void
        {
            var _val3:uint;
            this.dungeonId = input.readVarUhShort();
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element of TeleportBuddiesRequestedMessage.dungeonId.")));
            };
            this.inviterId = input.readVarUhInt();
            if (this.inviterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.inviterId) + ") on element of TeleportBuddiesRequestedMessage.inviterId.")));
            };
            var _invalidBuddiesIdsLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _invalidBuddiesIdsLen)
            {
                _val3 = input.readVarUhInt();
                if (_val3 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val3) + ") on elements of invalidBuddiesIds.")));
                };
                this.invalidBuddiesIds.push(_val3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.interactive.meeting

