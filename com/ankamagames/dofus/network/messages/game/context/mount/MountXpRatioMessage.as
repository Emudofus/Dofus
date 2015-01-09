package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class MountXpRatioMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5970;

        private var _isInitialized:Boolean = false;
        public var ratio:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5970);
        }

        public function initMountXpRatioMessage(ratio:uint=0):MountXpRatioMessage
        {
            this.ratio = ratio;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.ratio = 0;
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
            this.serializeAs_MountXpRatioMessage(output);
        }

        public function serializeAs_MountXpRatioMessage(output:IDataOutput):void
        {
            if (this.ratio < 0)
            {
                throw (new Error((("Forbidden value (" + this.ratio) + ") on element ratio.")));
            };
            output.writeByte(this.ratio);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_MountXpRatioMessage(input);
        }

        public function deserializeAs_MountXpRatioMessage(input:IDataInput):void
        {
            this.ratio = input.readByte();
            if (this.ratio < 0)
            {
                throw (new Error((("Forbidden value (" + this.ratio) + ") on element of MountXpRatioMessage.ratio.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

