package com.ankamagames.dofus.network.messages.game.interactive.meeting
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class TeleportToBuddyAnswerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6293;

        private var _isInitialized:Boolean = false;
        public var dungeonId:uint = 0;
        public var buddyId:uint = 0;
        public var accept:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6293);
        }

        public function initTeleportToBuddyAnswerMessage(dungeonId:uint=0, buddyId:uint=0, accept:Boolean=false):TeleportToBuddyAnswerMessage
        {
            this.dungeonId = dungeonId;
            this.buddyId = buddyId;
            this.accept = accept;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.dungeonId = 0;
            this.buddyId = 0;
            this.accept = false;
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
            this.serializeAs_TeleportToBuddyAnswerMessage(output);
        }

        public function serializeAs_TeleportToBuddyAnswerMessage(output:ICustomDataOutput):void
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
            output.writeBoolean(this.accept);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TeleportToBuddyAnswerMessage(input);
        }

        public function deserializeAs_TeleportToBuddyAnswerMessage(input:ICustomDataInput):void
        {
            this.dungeonId = input.readVarUhShort();
            if (this.dungeonId < 0)
            {
                throw (new Error((("Forbidden value (" + this.dungeonId) + ") on element of TeleportToBuddyAnswerMessage.dungeonId.")));
            };
            this.buddyId = input.readVarUhInt();
            if (this.buddyId < 0)
            {
                throw (new Error((("Forbidden value (" + this.buddyId) + ") on element of TeleportToBuddyAnswerMessage.buddyId.")));
            };
            this.accept = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.interactive.meeting

