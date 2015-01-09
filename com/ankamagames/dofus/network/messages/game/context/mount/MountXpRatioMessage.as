package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

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
            this.serializeAs_MountXpRatioMessage(output);
        }

        public function serializeAs_MountXpRatioMessage(output:ICustomDataOutput):void
        {
            if (this.ratio < 0)
            {
                throw (new Error((("Forbidden value (" + this.ratio) + ") on element ratio.")));
            };
            output.writeByte(this.ratio);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MountXpRatioMessage(input);
        }

        public function deserializeAs_MountXpRatioMessage(input:ICustomDataInput):void
        {
            this.ratio = input.readByte();
            if (this.ratio < 0)
            {
                throw (new Error((("Forbidden value (" + this.ratio) + ") on element of MountXpRatioMessage.ratio.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

