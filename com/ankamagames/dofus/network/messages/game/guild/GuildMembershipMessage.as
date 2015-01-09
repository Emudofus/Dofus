package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildMembershipMessage extends GuildJoinedMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5835;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5835);
        }

        public function initGuildMembershipMessage(guildInfo:GuildInformations=null, memberRights:uint=0, enabled:Boolean=false):GuildMembershipMessage
        {
            super.initGuildJoinedMessage(guildInfo, memberRights, enabled);
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_GuildMembershipMessage(output);
        }

        public function serializeAs_GuildMembershipMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_GuildJoinedMessage(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildMembershipMessage(input);
        }

        public function deserializeAs_GuildMembershipMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

