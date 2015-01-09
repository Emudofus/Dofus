package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class TeleportToBuddyCloseMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6303;

        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var buddyId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6303);
        }

        public function initTeleportToBuddyCloseMessage(dungeonId:uint=0, buddyId:uint=0):TeleportToBuddyCloseMessage
        {
            this.dungeonId = dungeonId;
            this.buddyId = buddyId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dungeonId = 0;
            this.buddyId = 0;
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
            this.serializeAs_TeleportToBuddyCloseMessage(output);
        }

        public function serializeAs_TeleportToBuddyCloseMessage(output:ICustomDataOutput):void
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
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TeleportToBuddyCloseMessage(input);
        }

        public function deserializeAs_TeleportToBuddyCloseMessage(input:ICustomDataInput):void
        {
            this.dungeonId = input.readVarUhShort();
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element of TeleportToBuddyCloseMessage.dungeonId.")));
            };
            this.buddyId = input.readVarUhInt();
            if (this.buddyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.buddyId) + ") on element of TeleportToBuddyCloseMessage.buddyId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.interactive.meeting

