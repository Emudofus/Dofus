package com.ankamagames.dofus.network.messages.game.startup
{
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class StartupActionFinishedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var success:Boolean = false;
        public var actionId:uint = 0;
        public var automaticAction:Boolean = false;
        public static const protocolId:uint = 1304;

        public function StartupActionFinishedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1304;
        }// end function

        public function initStartupActionFinishedMessage(param1:Boolean = false, param2:uint = 0, param3:Boolean = false) : StartupActionFinishedMessage
        {
            this.success = param1;
            this.actionId = param2;
            this.automaticAction = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.success = false;
            this.actionId = 0;
            this.automaticAction = false;
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
            this.serializeAs_StartupActionFinishedMessage(param1);
            return;
        }// end function

        public function serializeAs_StartupActionFinishedMessage(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.success);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.automaticAction);
            param1.writeByte(_loc_2);
            if (this.actionId < 0)
            {
                throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
            }
            param1.writeInt(this.actionId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_StartupActionFinishedMessage(param1);
            return;
        }// end function

        public function deserializeAs_StartupActionFinishedMessage(param1:IDataInput) : void
        {
            var _loc_2:* = param1.readByte();
            this.success = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.automaticAction = BooleanByteWrapper.getFlag(_loc_2, 1);
            this.actionId = param1.readInt();
            if (this.actionId < 0)
            {
                throw new Error("Forbidden value (" + this.actionId + ") on element of StartupActionFinishedMessage.actionId.");
            }
            return;
        }// end function

    }
}
