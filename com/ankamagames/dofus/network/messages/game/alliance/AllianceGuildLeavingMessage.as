package com.ankamagames.dofus.network.messages.game.alliance
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class AllianceGuildLeavingMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6399;

        private var _isInitialized:Boolean = false;
        public var kicked:Boolean = false;
        public var guildId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6399);
        }

        public function initAllianceGuildLeavingMessage(kicked:Boolean=false, guildId:int=0):AllianceGuildLeavingMessage
        {
            this.kicked = kicked;
            this.guildId = guildId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.kicked = false;
            this.guildId = 0;
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
            this.serializeAs_AllianceGuildLeavingMessage(output);
        }

        public function serializeAs_AllianceGuildLeavingMessage(output:IDataOutput):void
        {
            output.writeBoolean(this.kicked);
            output.writeInt(this.guildId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_AllianceGuildLeavingMessage(input);
        }

        public function deserializeAs_AllianceGuildLeavingMessage(input:IDataInput):void
        {
            this.kicked = input.readBoolean();
            this.guildId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.alliance

