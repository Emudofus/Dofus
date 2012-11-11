package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class IgnoredDeleteResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var success:Boolean = false;
        public var name:String = "";
        public var session:Boolean = false;
        public static const protocolId:uint = 5677;

        public function IgnoredDeleteResultMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5677;
        }// end function

        public function initIgnoredDeleteResultMessage(param1:Boolean = false, param2:String = "", param3:Boolean = false) : IgnoredDeleteResultMessage
        {
            this.success = param1;
            this.name = param2;
            this.session = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.success = false;
            this.name = "";
            this.session = false;
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
            this.serializeAs_IgnoredDeleteResultMessage(param1);
            return;
        }// end function

        public function serializeAs_IgnoredDeleteResultMessage(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.success);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.session);
            param1.writeByte(_loc_2);
            param1.writeUTF(this.name);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IgnoredDeleteResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_IgnoredDeleteResultMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readByte();
            this.success = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.session = BooleanByteWrapper.getFlag(_loc_2, 1);
            this.name = param1.readUTF();
            return;
        }// end function

    }
}
