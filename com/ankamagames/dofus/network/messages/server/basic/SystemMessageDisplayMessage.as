package com.ankamagames.dofus.network.messages.server.basic
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
    public class SystemMessageDisplayMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 189;

        private var _isInitialized:Boolean = false;
        public var hangUp:Boolean = false;
        public var msgId:uint = 0;
        public var parameters:Vector.<String>;

        public function SystemMessageDisplayMessage()
        {
            this.parameters = new Vector.<String>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (189);
        }

        public function initSystemMessageDisplayMessage(hangUp:Boolean=false, msgId:uint=0, parameters:Vector.<String>=null):SystemMessageDisplayMessage
        {
            this.hangUp = hangUp;
            this.msgId = msgId;
            this.parameters = parameters;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.hangUp = false;
            this.msgId = 0;
            this.parameters = new Vector.<String>();
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
            this.serializeAs_SystemMessageDisplayMessage(output);
        }

        public function serializeAs_SystemMessageDisplayMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.hangUp);
            if (this.msgId < 0)
            {
                throw (new Error((("Forbidden value (" + this.msgId) + ") on element msgId.")));
            };
            output.writeVarShort(this.msgId);
            output.writeShort(this.parameters.length);
            var _i3:uint;
            while (_i3 < this.parameters.length)
            {
                output.writeUTF(this.parameters[_i3]);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SystemMessageDisplayMessage(input);
        }

        public function deserializeAs_SystemMessageDisplayMessage(input:ICustomDataInput):void
        {
            var _val3:String;
            this.hangUp = input.readBoolean();
            this.msgId = input.readVarUhShort();
            if (this.msgId < 0)
            {
                throw (new Error((("Forbidden value (" + this.msgId) + ") on element of SystemMessageDisplayMessage.msgId.")));
            };
            var _parametersLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _parametersLen)
            {
                _val3 = input.readUTF();
                this.parameters.push(_val3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.server.basic

