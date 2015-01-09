package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

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
            this.serializeAs_TeleportToBuddyOfferMessage(output);
        }

        public function serializeAs_TeleportToBuddyOfferMessage(output:ICustomDataOutput):void
        {
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element dungeonId.")));
            };
            output.writeVarShort(this.dungeonId);
            if (this.buddyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.buddyId) + ") on element buddyId.")));
            };
            output.writeVarInt(this.buddyId);
            if (this.timeLeft < 0)
            {
                throw (new Error((("Forbidden value (" + this.timeLeft) + ") on element timeLeft.")));
            };
            output.writeVarInt(this.timeLeft);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TeleportToBuddyOfferMessage(input);
        }

        public function deserializeAs_TeleportToBuddyOfferMessage(input:ICustomDataInput):void
        {
            this.dungeonId = input.readVarUhShort();
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element of TeleportToBuddyOfferMessage.dungeonId.")));
            };
            this.buddyId = input.readVarUhInt();
            if (this.buddyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.buddyId) + ") on element of TeleportToBuddyOfferMessage.buddyId.")));
            };
            this.timeLeft = input.readVarUhInt();
            if (this.timeLeft < 0)
            {
                throw (new Error((("Forbidden value (" + this.timeLeft) + ") on element of TeleportToBuddyOfferMessage.timeLeft.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.interactive.meeting

