package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildMemberLeavingMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5923;

        private var _isInitialized:Boolean = false;
        public var kicked:Boolean = false;
        public var memberId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5923);
        }

        public function initGuildMemberLeavingMessage(kicked:Boolean=false, memberId:int=0):GuildMemberLeavingMessage
        {
            this.kicked = kicked;
            this.memberId = memberId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.kicked = false;
            this.memberId = 0;
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
            this.serializeAs_GuildMemberLeavingMessage(output);
        }

        public function serializeAs_GuildMemberLeavingMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.kicked);
            output.writeInt(this.memberId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildMemberLeavingMessage(input);
        }

        public function deserializeAs_GuildMemberLeavingMessage(input:ICustomDataInput):void
        {
            this.kicked = input.readBoolean();
            this.memberId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

