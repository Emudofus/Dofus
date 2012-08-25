package com.ankamagames.dofus.network.messages.server.basic
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SystemMessageDisplayMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var hangUp:Boolean = false;
        public var msgId:uint = 0;
        public var parameters:Vector.<String>;
        public static const protocolId:uint = 189;

        public function SystemMessageDisplayMessage()
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
            return 189;
        }// end function

        public function initSystemMessageDisplayMessage(param1:Boolean = false, param2:uint = 0, param3:Vector.<String> = null) : SystemMessageDisplayMessage
        {
            this.hangUp = param1;
            this.msgId = param2;
            this.parameters = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.hangUp = false;
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
            this.serializeAs_SystemMessageDisplayMessage(param1);
            return;
        }// end function

        public function serializeAs_SystemMessageDisplayMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.hangUp);
            if (this.msgId < 0)
            {
                throw new Error("Forbidden value (" + this.msgId + ") on element msgId.");
            }
            param1.writeShort(this.msgId);
            param1.writeShort(this.parameters.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.parameters.length)
            {
                
                param1.writeUTF(this.parameters[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SystemMessageDisplayMessage(param1);
            return;
        }// end function

        public function deserializeAs_SystemMessageDisplayMessage(param1:IDataInput) : void
        {
            var _loc_4:String = null;
            this.hangUp = param1.readBoolean();
            this.msgId = param1.readShort();
            if (this.msgId < 0)
            {
                throw new Error("Forbidden value (" + this.msgId + ") on element of SystemMessageDisplayMessage.msgId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
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
