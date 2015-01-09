package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class SelectedServerDataExtendedMessage extends SelectedServerDataMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6469;

        private var _isInitialized:Boolean = false;
        public var serverIds:Vector.<uint>;

        public function SelectedServerDataExtendedMessage()
        {
            this.serverIds = new Vector.<uint>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6469);
        }

        public function initSelectedServerDataExtendedMessage(serverId:uint=0, address:String="", port:uint=0, ssl:Boolean=false, canCreateNewCharacter:Boolean=false, ticket:String="", serverIds:Vector.<uint>=null):SelectedServerDataExtendedMessage
        {
            super.initSelectedServerDataMessage(serverId, address, port, ssl, canCreateNewCharacter, ticket);
            this.serverIds = serverIds;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.serverIds = new Vector.<uint>();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_SelectedServerDataExtendedMessage(output);
        }

        public function serializeAs_SelectedServerDataExtendedMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_SelectedServerDataMessage(output);
            output.writeShort(this.serverIds.length);
            var _i1:uint;
            while (_i1 < this.serverIds.length)
            {
                if (this.serverIds[_i1] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.serverIds[_i1]) + ") on element 1 (starting at 1) of serverIds.")));
                };
                output.writeVarShort(this.serverIds[_i1]);
                _i1++;
            };
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SelectedServerDataExtendedMessage(input);
        }

        public function deserializeAs_SelectedServerDataExtendedMessage(input:ICustomDataInput):void
        {
            var _val1:uint;
            super.deserialize(input);
            var _serverIdsLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _serverIdsLen)
            {
                _val1 = input.readVarUhShort();
                if (_val1 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val1) + ") on elements of serverIds.")));
                };
                this.serverIds.push(_val1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

