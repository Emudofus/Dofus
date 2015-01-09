package com.ankamagames.dofus.network.messages.web.krosmaster
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class KrosmasterTransferMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6348;

        private var _isInitialized:Boolean = false;
        public var uid:String = "";
        public var failure:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6348);
        }

        public function initKrosmasterTransferMessage(uid:String="", failure:uint=0):KrosmasterTransferMessage
        {
            this.uid = uid;
            this.failure = failure;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.uid = "";
            this.failure = 0;
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
            this.serializeAs_KrosmasterTransferMessage(output);
        }

        public function serializeAs_KrosmasterTransferMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.uid);
            output.writeByte(this.failure);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_KrosmasterTransferMessage(input);
        }

        public function deserializeAs_KrosmasterTransferMessage(input:ICustomDataInput):void
        {
            this.uid = input.readUTF();
            this.failure = input.readByte();
            if (this.failure < 0)
            {
                throw (new Error((("Forbidden value (" + this.failure) + ") on element of KrosmasterTransferMessage.failure.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.web.krosmaster

