package com.ankamagames.dofus.network.messages.updater.parts
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class DownloadCurrentSpeedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1511;

        private var _isInitialized:Boolean = false;
        public var downloadSpeed:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (1511);
        }

        public function initDownloadCurrentSpeedMessage(downloadSpeed:uint=0):DownloadCurrentSpeedMessage
        {
            this.downloadSpeed = downloadSpeed;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.downloadSpeed = 0;
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
            this.serializeAs_DownloadCurrentSpeedMessage(output);
        }

        public function serializeAs_DownloadCurrentSpeedMessage(output:ICustomDataOutput):void
        {
            if ((((this.downloadSpeed < 1)) || ((this.downloadSpeed > 10))))
            {
                throw (new Error((("Forbidden value (" + this.downloadSpeed) + ") on element downloadSpeed.")));
            };
            output.writeByte(this.downloadSpeed);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DownloadCurrentSpeedMessage(input);
        }

        public function deserializeAs_DownloadCurrentSpeedMessage(input:ICustomDataInput):void
        {
            this.downloadSpeed = input.readByte();
            if ((((this.downloadSpeed < 1)) || ((this.downloadSpeed > 10))))
            {
                throw (new Error((("Forbidden value (" + this.downloadSpeed) + ") on element of DownloadCurrentSpeedMessage.downloadSpeed.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.updater.parts

