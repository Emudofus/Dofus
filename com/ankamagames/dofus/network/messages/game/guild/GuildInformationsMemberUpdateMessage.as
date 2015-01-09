package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.guild.GuildMember;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildInformationsMemberUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5597;

        private var _isInitialized:Boolean = false;
        public var member:GuildMember;

        public function GuildInformationsMemberUpdateMessage()
        {
            this.member = new GuildMember();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5597);
        }

        public function initGuildInformationsMemberUpdateMessage(member:GuildMember=null):GuildInformationsMemberUpdateMessage
        {
            this.member = member;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.member = new GuildMember();
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
            this.serializeAs_GuildInformationsMemberUpdateMessage(output);
        }

        public function serializeAs_GuildInformationsMemberUpdateMessage(output:ICustomDataOutput):void
        {
            this.member.serializeAs_GuildMember(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInformationsMemberUpdateMessage(input);
        }

        public function deserializeAs_GuildInformationsMemberUpdateMessage(input:ICustomDataInput):void
        {
            this.member = new GuildMember();
            this.member.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

