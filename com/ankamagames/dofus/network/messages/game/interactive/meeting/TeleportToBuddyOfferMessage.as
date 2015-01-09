package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class TeleportToBuddyOfferMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6287;

        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var buddyId:uint = 0;
        public var timeLeft:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6287);
        }

        public function initTeleportToBuddyOfferMessage(dungeonId:uint=0, buddyId:uint=0, timeLeft:uint=0):TeleportToBuddyOfferMessage
        {
            this.dungeonId = dungeonId;
            this.buddyId = buddyId;
            this.timeLeft = timeLeft;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dungeonId = 0;
            this.buddyId = 0;
            this.timeLeft = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_TeleportToBuddyOfferMessage(output);
        }

        public function serializeAs_TeleportToBuddyOfferMessage(output:IDataOutput):void
        {
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element dungeonId.")));
            };
            output.writeShort(this.dungeonId);
            if (this.buddyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.buddyId) + ") on element buddyId.")));
            };
            output.writeInt(this.buddyId);
            if (this.timeLeft < 0)
            {
                throw (new Error((("Forbidden value (" + this.timeLeft) + ") on element timeLeft.")));
            };
            output.writeInt(this.timeLeft);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_TeleportToBuddyOfferMessage(input);
        }

        public function deserializeAs_TeleportToBuddyOfferMessage(input:IDataInput):void
        {
            this.dungeonId = input.readShort();
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element of TeleportToBuddyOfferMessage.dungeonId.")));
            };
            this.buddyId = input.readInt();
            if (this.buddyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.buddyId) + ") on element of TeleportToBuddyOfferMessage.buddyId.")));
            };
            this.timeLeft = input.readInt();
            if (this.timeLeft < 0)
            {
                throw (new Error((("Forbidden value (" + this.timeLeft) + ") on element of TeleportToBuddyOfferMessage.timeLeft.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.interactive.meeting

