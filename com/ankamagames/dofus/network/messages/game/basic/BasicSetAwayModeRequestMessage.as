package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class BasicSetAwayModeRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var enable:Boolean = false;
        public var invisible:Boolean = false;
        public static const protocolId:uint = 5665;

        public function BasicSetAwayModeRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5665;
        }// end function

        public function initBasicSetAwayModeRequestMessage(param1:Boolean = false, param2:Boolean = false) : BasicSetAwayModeRequestMessage
        {
            this.enable = param1;
            this.invisible = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.enable = false;
            this.invisible = false;
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
            this.serializeAs_BasicSetAwayModeRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_BasicSetAwayModeRequestMessage(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.enable);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.invisible);
            param1.writeByte(_loc_2);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_BasicSetAwayModeRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_BasicSetAwayModeRequestMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readByte();
            this.enable = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.invisible = BooleanByteWrapper.getFlag(_loc_2, 1);
            return;
        }// end function

    }
}
