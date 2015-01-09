package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildHouseTeleportRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5712;

        private var _isInitialized:Boolean = false;
        public var houseId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5712);
        }

        public function initGuildHouseTeleportRequestMessage(houseId:uint=0):GuildHouseTeleportRequestMessage
        {
            this.houseId = houseId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.houseId = 0;
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
            this.serializeAs_GuildHouseTeleportRequestMessage(output);
        }

        public function serializeAs_GuildHouseTeleportRequestMessage(output:ICustomDataOutput):void
        {
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element houseId.")));
            };
            output.writeVarInt(this.houseId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildHouseTeleportRequestMessage(input);
        }

        public function deserializeAs_GuildHouseTeleportRequestMessage(input:ICustomDataInput):void
        {
            this.houseId = input.readVarUhInt();
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element of GuildHouseTeleportRequestMessage.houseId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

