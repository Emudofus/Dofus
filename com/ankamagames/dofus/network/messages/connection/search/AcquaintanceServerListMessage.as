package com.ankamagames.dofus.network.messages.connection.search
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class AcquaintanceServerListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6142;

        private var _isInitialized:Boolean = false;
        public var servers:Vector.<uint>;

        public function AcquaintanceServerListMessage()
        {
            this.servers = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6142);
        }

        public function initAcquaintanceServerListMessage(servers:Vector.<uint>=null):AcquaintanceServerListMessage
        {
            this.servers = servers;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.servers = new Vector.<uint>();
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
            this.serializeAs_AcquaintanceServerListMessage(output);
        }

        public function serializeAs_AcquaintanceServerListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.servers.length);
            var _i1:uint;
            while (_i1 < this.servers.length)
            {
                if (this.servers[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.servers[_i1]) + ") on element 1 (starting at 1) of servers.")));
                };
                output.writeVarShort(this.servers[_i1]);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AcquaintanceServerListMessage(input);
        }

        public function deserializeAs_AcquaintanceServerListMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            var _serversLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _serversLen)
            {
                _val1 = input.readVarUhShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of servers.")));
                };
                this.servers.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.connection.search

