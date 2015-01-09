package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildChangeMemberParametersMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5549;

        private var _isInitialized:Boolean = false;
        public var memberId:uint = 0;
        public var rank:uint = 0;
        public var experienceGivenPercent:uint = 0;
        public var rights:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5549);
        }

        public function initGuildChangeMemberParametersMessage(memberId:uint=0, rank:uint=0, experienceGivenPercent:uint=0, rights:uint=0):GuildChangeMemberParametersMessage
        {
            this.memberId = memberId;
            this.rank = rank;
            this.experienceGivenPercent = experienceGivenPercent;
            this.rights = rights;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.memberId = 0;
            this.rank = 0;
            this.experienceGivenPercent = 0;
            this.rights = 0;
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
            this.serializeAs_GuildChangeMemberParametersMessage(output);
        }

        public function serializeAs_GuildChangeMemberParametersMessage(output:ICustomDataOutput):void
        {
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element memberId.")));
            };
            output.writeVarInt(this.memberId);
            if (this.rank < 0)
            {
                throw (new Error((("Forbidden value (" + this.rank) + ") on element rank.")));
            };
            output.writeVarShort(this.rank);
            if ((((this.experienceGivenPercent < 0)) || ((this.experienceGivenPercent > 100))))
            {
                throw (new Error((("Forbidden value (" + this.experienceGivenPercent) + ") on element experienceGivenPercent.")));
            };
            output.writeByte(this.experienceGivenPercent);
            if (this.rights < 0)
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element rights.")));
            };
            output.writeVarInt(this.rights);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildChangeMemberParametersMessage(input);
        }

        public function deserializeAs_GuildChangeMemberParametersMessage(input:ICustomDataInput):void
        {
            this.memberId = input.readVarUhInt();
            if (this.memberId < 0)
            {
                throw (new Error((("Forbidden value (" + this.memberId) + ") on element of GuildChangeMemberParametersMessage.memberId.")));
            };
            this.rank = input.readVarUhShort();
            if (this.rank < 0)
            {
                throw (new Error((("Forbidden value (" + this.rank) + ") on element of GuildChangeMemberParametersMessage.rank.")));
            };
            this.experienceGivenPercent = input.readByte();
            if ((((this.experienceGivenPercent < 0)) || ((this.experienceGivenPercent > 100))))
            {
                throw (new Error((("Forbidden value (" + this.experienceGivenPercent) + ") on element of GuildChangeMemberParametersMessage.experienceGivenPercent.")));
            };
            this.rights = input.readVarUhInt();
            if (this.rights < 0)
            {
                throw (new Error((("Forbidden value (" + this.rights) + ") on element of GuildChangeMemberParametersMessage.rights.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

