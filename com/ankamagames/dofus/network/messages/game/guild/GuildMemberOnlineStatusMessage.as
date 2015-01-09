package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildMemberOnlineStatusMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6061;

        private var _isInitialized:Boolean = false;
        public var memberId:uint = 0;
        public var online:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6061);
        }

        public function initGuildMemberOnlineStatusMessage(memberId:uint=0, online:Boolean=false):GuildMemberOnlineStatusMessage
        {
            this.memberId = memberId;
            this.online = online;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.memberId = 0;
            this.online = false;
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
            this.serializeAs_GuildMemberOnlineStatusMessage(output);
        }

        public function serializeAs_GuildMemberOnlineStatusMessage(output:ICustomDataOutput):void
        {
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element memberId.")));
            };
            output.writeVarInt(this.memberId);
            output.writeBoolean(this.online);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildMemberOnlineStatusMessage(input);
        }

        public function deserializeAs_GuildMemberOnlineStatusMessage(input:ICustomDataInput):void
        {
            this.memberId = input.readVarUhInt();
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element of GuildMemberOnlineStatusMessage.memberId.")));
            };
            this.online = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

