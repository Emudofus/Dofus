package com.ankamagames.dofus.network.messages.web.krosmaster
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class KrosmasterTransferRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6349;

        private var _isInitialized:Boolean = false;
        public var uid:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6349);
        }

        public function initKrosmasterTransferRequestMessage(uid:String=""):KrosmasterTransferRequestMessage
        {
            this.uid = uid;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.uid = "";
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
            this.serializeAs_KrosmasterTransferRequestMessage(output);
        }

        public function serializeAs_KrosmasterTransferRequestMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.uid);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_KrosmasterTransferRequestMessage(input);
        }

        public function deserializeAs_KrosmasterTransferRequestMessage(input:ICustomDataInput):void
        {
            this.uid = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.web.krosmaster

