package com.ankamagames.dofus.network.messages.updater.parts
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class DownloadErrorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 1513;

        private var _isInitialized:Boolean = false;
        public var errorId:uint = 0;
        public var message:String = "";
        public var helpUrl:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (1513);
        }

        public function initDownloadErrorMessage(errorId:uint=0, message:String="", helpUrl:String=""):DownloadErrorMessage
        {
            this.errorId = errorId;
            this.message = message;
            this.helpUrl = helpUrl;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.errorId = 0;
            this.message = "";
            this.helpUrl = "";
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
            this.serializeAs_DownloadErrorMessage(output);
        }

        public function serializeAs_DownloadErrorMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.errorId);
            output.writeUTF(this.message);
            output.writeUTF(this.helpUrl);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_DownloadErrorMessage(input);
        }

        public function deserializeAs_DownloadErrorMessage(input:ICustomDataInput):void
        {
            this.errorId = input.readByte();
            if (this.errorId < 0)
            {
                throw (new Error((("Forbidden value (" + this.errorId) + ") on element of DownloadErrorMessage.errorId.")));
            };
            this.message = input.readUTF();
            this.helpUrl = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.updater.parts

