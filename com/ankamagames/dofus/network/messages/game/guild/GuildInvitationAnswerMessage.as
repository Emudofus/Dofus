package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildInvitationAnswerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5556;

        private var _isInitialized:Boolean = false;
        public var accept:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5556);
        }

        public function initGuildInvitationAnswerMessage(accept:Boolean=false):GuildInvitationAnswerMessage
        {
            this.accept = accept;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
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
            this.serializeAs_GuildInvitationAnswerMessage(output);
        }

        public function serializeAs_GuildInvitationAnswerMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.accept);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildInvitationAnswerMessage(input);
        }

        public function deserializeAs_GuildInvitationAnswerMessage(input:ICustomDataInput):void
        {
            this.accept = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

