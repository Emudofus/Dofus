package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MountSetXpRatioRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5989;

        private var _isInitialized:Boolean = false;
        public var xpRatio:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5989);
        }

        public function initMountSetXpRatioRequestMessage(xpRatio:uint=0):MountSetXpRatioRequestMessage
        {
            this.xpRatio = xpRatio;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.xpRatio = 0;
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
            this.serializeAs_MountSetXpRatioRequestMessage(output);
        }

        public function serializeAs_MountSetXpRatioRequestMessage(output:ICustomDataOutput):void
        {
            if (this.xpRatio < 0)
            {
                throw (new Error((("Forbidden value (" + this.xpRatio) + ") on element xpRatio.")));
            };
            output.writeByte(this.xpRatio);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MountSetXpRatioRequestMessage(input);
        }

        public function deserializeAs_MountSetXpRatioRequestMessage(input:ICustomDataInput):void
        {
            this.xpRatio = input.readByte();
            if (this.xpRatio < 0)
            {
                throw (new Error((("Forbidden value (" + this.xpRatio) + ") on element of MountSetXpRatioRequestMessage.xpRatio.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

