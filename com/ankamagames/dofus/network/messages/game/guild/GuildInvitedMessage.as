package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.BasicGuildInformations;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class GuildInvitedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5552;

        private var _isInitialized:Boolean = false;
        public var recruterId:uint = 0;
        public var recruterName:String = "";
        public var guildInfo:BasicGuildInformations;

        public function GuildInvitedMessage()
        {
            this.guildInfo = new BasicGuildInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5552);
        }

        public function initGuildInvitedMessage(recruterId:uint=0, recruterName:String="", guildInfo:BasicGuildInformations=null):GuildInvitedMessage
        {
            this.recruterId = recruterId;
            this.recruterName = recruterName;
            this.guildInfo = guildInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.recruterId = 0;
            this.recruterName = "";
            this.guildInfo = new BasicGuildInformations();
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
            this.serializeAs_GuildInvitedMessage(output);
        }

        public function serializeAs_GuildInvitedMessage(output:IDataOutput):void
        {
            if (this.recruterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.recruterId) + ") on element recruterId.")));
            };
            output.writeInt(this.recruterId);
            output.writeUTF(this.recruterName);
            this.guildInfo.serializeAs_BasicGuildInformations(output);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_GuildInvitedMessage(input);
        }

        public function deserializeAs_GuildInvitedMessage(input:IDataInput):void
        {
            this.recruterId = input.readInt();
            if (this.recruterId < 0)
            {
                throw (new Error((("Forbidden value (" + this.recruterId) + ") on element of GuildInvitedMessage.recruterId.")));
            };
            this.recruterName = input.readUTF();
            this.guildInfo = new BasicGuildInformations();
            this.guildInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

