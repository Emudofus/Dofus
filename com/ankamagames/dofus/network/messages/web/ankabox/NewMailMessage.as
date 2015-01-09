package com.ankamagames.dofus.network.messages.web.ankabox
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class NewMailMessage extends MailStatusMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6292;

        private var _isInitialized:Boolean = false;
        public var sendersAccountId:Vector.<uint>;

        public function NewMailMessage()
        {
            this.sendersAccountId = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6292);
        }

        public function initNewMailMessage(unread:uint=0, total:uint=0, sendersAccountId:Vector.<uint>=null):NewMailMessage
        {
            super.initMailStatusMessage(unread, total);
            this.sendersAccountId = sendersAccountId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.sendersAccountId = new Vector.<uint>();
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
            this.serializeAs_NewMailMessage(output);
        }

        public function serializeAs_NewMailMessage(output:IDataOutput):void
        {
            super.serializeAs_MailStatusMessage(output);
            output.writeShort(this.sendersAccountId.length);
            var _i1:uint;
            while (_i1 < this.sendersAccountId.length)
            {
                if (this.sendersAccountId[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.sendersAccountId[_i1]) + ") on element 1 (starting at 1) of sendersAccountId.")));
                };
                output.writeInt(this.sendersAccountId[_i1]);
                _i1++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_NewMailMessage(input);
        }

        public function deserializeAs_NewMailMessage(input:IDataInput):void
        {
            var _val1:uint;
            super.deserialize(input);
            var _sendersAccountIdLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _sendersAccountIdLen)
            {
                _val1 = input.readInt();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of sendersAccountId.")));
                };
                this.sendersAccountId.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.web.ankabox

