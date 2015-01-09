package com.ankamagames.dofus.network.messages.game.tinsel
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class TitleGainedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6364;

        private var _isInitialized:Boolean = false;
        public var titleId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6364);
        }

        public function initTitleGainedMessage(titleId:uint=0):TitleGainedMessage
        {
            this.titleId = titleId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.titleId = 0;
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
            this.serializeAs_TitleGainedMessage(output);
        }

        public function serializeAs_TitleGainedMessage(output:IDataOutput):void
        {
            if (this.titleId < 0)
            {
                throw (new Error((("Forbidden value (" + this.titleId) + ") on element titleId.")));
            };
            output.writeShort(this.titleId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_TitleGainedMessage(input);
        }

        public function deserializeAs_TitleGainedMessage(input:IDataInput):void
        {
            this.titleId = input.readShort();
            if (this.titleId < 0)
            {
                throw (new Error((("Forbidden value (" + this.titleId) + ") on element of TitleGainedMessage.titleId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.tinsel

