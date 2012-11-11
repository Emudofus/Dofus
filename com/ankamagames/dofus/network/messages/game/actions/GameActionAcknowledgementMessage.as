package com.ankamagames.dofus.network.messages.game.actions
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameActionAcknowledgementMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var valid:Boolean = false;
        public var actionId:int = 0;
        public static const protocolId:uint = 957;

        public function GameActionAcknowledgementMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 957;
        }// end function

        public function initGameActionAcknowledgementMessage(param1:Boolean = false, param2:int = 0) : GameActionAcknowledgementMessage
        {
            this.valid = param1;
            this.actionId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.valid = false;
            this.actionId = 0;
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
            this.serializeAs_GameActionAcknowledgementMessage(param1);
            return;
        }// end function

        public function serializeAs_GameActionAcknowledgementMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.valid);
            param1.writeByte(this.actionId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameActionAcknowledgementMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameActionAcknowledgementMessage(param1:IDataInput) : void
        {
            this.valid = param1.readBoolean();
            this.actionId = param1.readByte();
            return;
        }// end function

    }
}
