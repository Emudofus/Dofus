package com.ankamagames.dofus.network.messages.game.basic
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TextInformationMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var msgType:uint = 0;
        public var msgId:uint = 0;
        public var parameters:Vector.<String>;
        public static const protocolId:uint = 780;

        public function TextInformationMessage()
        {
            this.parameters = new Vector.<String>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 780;
        }// end function

        public function initTextInformationMessage(param1:uint = 0, param2:uint = 0, param3:Vector.<String> = null) : TextInformationMessage
        {
            this.msgType = param1;
            this.msgId = param2;
            this.parameters = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.msgType = 0;
            this.msgId = 0;
            this.parameters = new Vector.<String>;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_TextInformationMessage(param1);
            return;
        }// end function

        public function serializeAs_TextInformationMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.msgType);
            if (this.msgId < 0)
            {
                throw new Error("Forbidden value (" + this.msgId + ") on element msgId.");
            }
            param1.writeShort(this.msgId);
            param1.writeShort(this.parameters.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.parameters.length)
            {
                
                param1.writeUTF(this.parameters[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TextInformationMessage(param1);
            return;
        }// end function

        public function deserializeAs_TextInformationMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.msgType = param1.readByte();
            if (this.msgType < 0)
            {
                throw new Error("Forbidden value (" + this.msgType + ") on element of TextInformationMessage.msgType.");
            }
            this.msgId = param1.readShort();
            if (this.msgId < 0)
            {
                throw new Error("Forbidden value (" + this.msgId + ") on element of TextInformationMessage.msgId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUTF();
                this.parameters.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
