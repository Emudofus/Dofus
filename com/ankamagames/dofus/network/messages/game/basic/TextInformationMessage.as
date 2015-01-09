package com.ankamagames.dofus.network.messages.game.basic
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
    public class TextInformationMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 780;

        private var _isInitialized:Boolean = false;
        public var msgType:uint = 0;
        public var msgId:uint = 0;
        public var parameters:Vector.<String>;

        public function TextInformationMessage()
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
            return (780);
        }

        public function initTextInformationMessage(msgType:uint=0, msgId:uint=0, parameters:Vector.<String>=null):TextInformationMessage
        {
            this.msgType = msgType;
            this.msgId = msgId;
            this.parameters = parameters;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.msgType = 0;
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
            this.serializeAs_TextInformationMessage(output);
        }

        public function serializeAs_TextInformationMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.msgType);
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
            this.deserializeAs_TextInformationMessage(input);
        }

        public function deserializeAs_TextInformationMessage(input:ICustomDataInput):void
        {
            var _val3:String;
            this.msgType = input.readByte();
            if (this.msgType < 0)
            {
                throw (new Error((("Forbidden value (" + this.msgType) + ") on element of TextInformationMessage.msgType.")));
            };
            this.msgId = input.readVarUhShort();
            if (this.msgId < 0)
            {
                throw (new Error((("Forbidden value (" + this.msgId) + ") on element of TextInformationMessage.msgId.")));
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
}//package com.ankamagames.dofus.network.messages.game.basic

