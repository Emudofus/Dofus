package com.ankamagames.dofus.network.messages.game.context.notification
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class NotificationByServerMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var id:uint = 0;
        public var parameters:Vector.<String>;
        public var forceOpen:Boolean = false;
        public static const protocolId:uint = 6103;

        public function NotificationByServerMessage()
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
            return 6103;
        }// end function

        public function initNotificationByServerMessage(param1:uint = 0, param2:Vector.<String> = null, param3:Boolean = false) : NotificationByServerMessage
        {
            this.id = param1;
            this.parameters = param2;
            this.forceOpen = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.id = 0;
            this.parameters = new Vector.<String>;
            this.forceOpen = false;
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
            this.serializeAs_NotificationByServerMessage(param1);
            return;
        }// end function

        public function serializeAs_NotificationByServerMessage(param1:IDataOutput) : void
        {
            if (this.id < 0 || this.id > 65535)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeShort(this.id);
            param1.writeShort(this.parameters.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.parameters.length)
            {
                
                param1.writeUTF(this.parameters[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeBoolean(this.forceOpen);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_NotificationByServerMessage(param1);
            return;
        }// end function

        public function deserializeAs_NotificationByServerMessage(param1:IDataInput) : void
        {
            var _loc_4:String = null;
            this.id = param1.readUnsignedShort();
            if (this.id < 0 || this.id > 65535)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of NotificationByServerMessage.id.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUTF();
                this.parameters.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.forceOpen = param1.readBoolean();
            return;
        }// end function

    }
}
