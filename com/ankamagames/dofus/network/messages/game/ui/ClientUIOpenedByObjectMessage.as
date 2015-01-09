package com.ankamagames.dofus.network.messages.game.ui
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ClientUIOpenedByObjectMessage extends ClientUIOpenedMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6463;

        private var _isInitialized:Boolean = false;
        public var uid:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6463);
        }

        public function initClientUIOpenedByObjectMessage(type:uint=0, uid:uint=0):ClientUIOpenedByObjectMessage
        {
            super.initClientUIOpenedMessage(type);
            this.uid = uid;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.uid = 0;
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

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ClientUIOpenedByObjectMessage(output);
        }

        public function serializeAs_ClientUIOpenedByObjectMessage(output:IDataOutput):void
        {
            super.serializeAs_ClientUIOpenedMessage(output);
            if (this.uid < 0)
            {
                throw (new Error((("Forbidden value (" + this.uid) + ") on element uid.")));
            };
            output.writeInt(this.uid);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ClientUIOpenedByObjectMessage(input);
        }

        public function deserializeAs_ClientUIOpenedByObjectMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.uid = input.readInt();
            if (this.uid < 0)
            {
                throw (new Error((("Forbidden value (" + this.uid) + ") on element of ClientUIOpenedByObjectMessage.uid.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.ui

