package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class BasicSwitchModeRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mode:int = 0;
        public static const protocolId:uint = 6101;

        public function BasicSwitchModeRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6101;
        }// end function

        public function initBasicSwitchModeRequestMessage(param1:int = 0) : BasicSwitchModeRequestMessage
        {
            this.mode = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.mode = 0;
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
            this.serializeAs_BasicSwitchModeRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_BasicSwitchModeRequestMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.mode);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_BasicSwitchModeRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_BasicSwitchModeRequestMessage(param1:IDataInput) : void
        {
            this.mode = param1.readByte();
            return;
        }// end function

    }
}
