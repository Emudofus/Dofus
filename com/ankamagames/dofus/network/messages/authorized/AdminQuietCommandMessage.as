package com.ankamagames.dofus.network.messages.authorized
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AdminQuietCommandMessage extends AdminCommandMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public static const protocolId:uint = 5662;

        public function AdminQuietCommandMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5662;
        }// end function

        public function initAdminQuietCommandMessage(param1:String = "") : AdminQuietCommandMessage
        {
            super.initAdminCommandMessage(param1);
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AdminQuietCommandMessage(param1);
            return;
        }// end function

        public function serializeAs_AdminQuietCommandMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AdminCommandMessage(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AdminQuietCommandMessage(param1);
            return;
        }// end function

        public function deserializeAs_AdminQuietCommandMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            return;
        }// end function

    }
}
