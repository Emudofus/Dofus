package com.ankamagames.dofus.network.messages.game.actions
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AbstractGameActionMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var actionId:uint = 0;
        public var sourceId:int = 0;
        public static const protocolId:uint = 1000;

        public function AbstractGameActionMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 1000;
        }// end function

        public function initAbstractGameActionMessage(param1:uint = 0, param2:int = 0) : AbstractGameActionMessage
        {
            this.actionId = param1;
            this.sourceId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.actionId = 0;
            this.sourceId = 0;
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
            this.serializeAs_AbstractGameActionMessage(param1);
            return;
        }// end function

        public function serializeAs_AbstractGameActionMessage(param1:IDataOutput) : void
        {
            if (this.actionId < 0)
            {
                throw new Error("Forbidden value (" + this.actionId + ") on element actionId.");
            }
            param1.writeShort(this.actionId);
            param1.writeInt(this.sourceId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AbstractGameActionMessage(param1);
            return;
        }// end function

        public function deserializeAs_AbstractGameActionMessage(param1:IDataInput) : void
        {
            this.actionId = param1.readShort();
            if (this.actionId < 0)
            {
                throw new Error("Forbidden value (" + this.actionId + ") on element of AbstractGameActionMessage.actionId.");
            }
            this.sourceId = param1.readInt();
            return;
        }// end function

    }
}
