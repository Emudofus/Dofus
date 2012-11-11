package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShowCellRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var cellId:uint = 0;
        public static const protocolId:uint = 5611;

        public function ShowCellRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5611;
        }// end function

        public function initShowCellRequestMessage(param1:uint = 0) : ShowCellRequestMessage
        {
            this.cellId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.cellId = 0;
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
            this.serializeAs_ShowCellRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_ShowCellRequestMessage(param1:IDataOutput) : void
        {
            if (this.cellId < 0 || this.cellId > 559)
            {
                throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
            }
            param1.writeShort(this.cellId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShowCellRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_ShowCellRequestMessage(param1:IDataInput) : void
        {
            this.cellId = param1.readShort();
            if (this.cellId < 0 || this.cellId > 559)
            {
                throw new Error("Forbidden value (" + this.cellId + ") on element of ShowCellRequestMessage.cellId.");
            }
            return;
        }// end function

    }
}
