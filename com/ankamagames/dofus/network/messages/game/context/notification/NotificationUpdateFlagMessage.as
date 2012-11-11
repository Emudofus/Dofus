package com.ankamagames.dofus.network.messages.game.context.notification
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class NotificationUpdateFlagMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var index:uint = 0;
        public static const protocolId:uint = 6090;

        public function NotificationUpdateFlagMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6090;
        }// end function

        public function initNotificationUpdateFlagMessage(param1:uint = 0) : NotificationUpdateFlagMessage
        {
            this.index = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.index = 0;
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
            this.serializeAs_NotificationUpdateFlagMessage(param1);
            return;
        }// end function

        public function serializeAs_NotificationUpdateFlagMessage(param1:IDataOutput) : void
        {
            if (this.index < 0)
            {
                throw new Error("Forbidden value (" + this.index + ") on element index.");
            }
            param1.writeShort(this.index);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_NotificationUpdateFlagMessage(param1);
            return;
        }// end function

        public function deserializeAs_NotificationUpdateFlagMessage(param1:IDataInput) : void
        {
            this.index = param1.readShort();
            if (this.index < 0)
            {
                throw new Error("Forbidden value (" + this.index + ") on element of NotificationUpdateFlagMessage.index.");
            }
            return;
        }// end function

    }
}
