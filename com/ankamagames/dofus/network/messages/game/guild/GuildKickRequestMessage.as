package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildKickRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5887;

        private var _isInitialized:Boolean = false;
        public var kickedId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5887);
        }

        public function initGuildKickRequestMessage(kickedId:uint=0):GuildKickRequestMessage
        {
            this.kickedId = kickedId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.kickedId = 0;
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
            this.serializeAs_GuildKickRequestMessage(output);
        }

        public function serializeAs_GuildKickRequestMessage(output:ICustomDataOutput):void
        {
            if (this.kickedId < 0)
            {
                throw (new Error((("Forbidden value (" + this.kickedId) + ") on element kickedId.")));
            };
            output.writeVarInt(this.kickedId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildKickRequestMessage(input);
        }

        public function deserializeAs_GuildKickRequestMessage(input:ICustomDataInput):void
        {
            this.kickedId = input.readVarUhInt();
            if (this.kickedId < 0)
            {
                throw (new Error((("Forbidden value (" + this.kickedId) + ") on element of GuildKickRequestMessage.kickedId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

