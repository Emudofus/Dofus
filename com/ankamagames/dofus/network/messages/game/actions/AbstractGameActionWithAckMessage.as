package com.ankamagames.dofus.network.messages.game.actions
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AbstractGameActionWithAckMessage extends AbstractGameActionMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var waitAckId:int = 0;
        public static const protocolId:uint = 1001;

        public function AbstractGameActionWithAckMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1001;
        }// end function

        public function initAbstractGameActionWithAckMessage(param1:uint = 0, param2:int = 0, param3:int = 0) : AbstractGameActionWithAckMessage
        {
            super.initAbstractGameActionMessage(param1, param2);
            this.waitAckId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.waitAckId = 0;
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
            this.serializeAs_AbstractGameActionWithAckMessage(param1);
            return;
        }// end function

        public function serializeAs_AbstractGameActionWithAckMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractGameActionMessage(param1);
            param1.writeShort(this.waitAckId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AbstractGameActionWithAckMessage(param1);
            return;
        }// end function

        public function deserializeAs_AbstractGameActionWithAckMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.waitAckId = param1.readShort();
            return;
        }// end function

    }
}
