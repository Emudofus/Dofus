package com.ankamagames.dofus.network.messages.game.guild
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GuildGetInformationsMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5550;

        private var _isInitialized:Boolean = false;
        public var infoType:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5550);
        }

        public function initGuildGetInformationsMessage(infoType:uint=0):GuildGetInformationsMessage
        {
            this.infoType = infoType;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.infoType = 0;
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
            this.serializeAs_GuildGetInformationsMessage(output);
        }

        public function serializeAs_GuildGetInformationsMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.infoType);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GuildGetInformationsMessage(input);
        }

        public function deserializeAs_GuildGetInformationsMessage(input:ICustomDataInput):void
        {
            this.infoType = input.readByte();
            if (this.infoType < 0)
            {
                throw (new Error((("Forbidden value (" + this.infoType) + ") on element of GuildGetInformationsMessage.infoType.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.guild

