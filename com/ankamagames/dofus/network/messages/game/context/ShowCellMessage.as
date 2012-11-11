package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShowCellMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var sourceId:int = 0;
        public var cellId:uint = 0;
        public static const protocolId:uint = 5612;

        public function ShowCellMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5612;
        }// end function

        public function initShowCellMessage(param1:int = 0, param2:uint = 0) : ShowCellMessage
        {
            this.sourceId = param1;
            this.cellId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.sourceId = 0;
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
            this.serializeAs_ShowCellMessage(param1);
            return;
        }// end function

        public function serializeAs_ShowCellMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.sourceId);
            if (this.cellId < 0 || this.cellId > 559)
            {
                throw new Error("Forbidden value (" + this.cellId + ") on element cellId.");
            }
            param1.writeShort(this.cellId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShowCellMessage(param1);
            return;
        }// end function

        public function deserializeAs_ShowCellMessage(param1:IDataInput) : void
        {
            this.sourceId = param1.readInt();
            this.cellId = param1.readShort();
            if (this.cellId < 0 || this.cellId > 559)
            {
                throw new Error("Forbidden value (" + this.cellId + ") on element of ShowCellMessage.cellId.");
            }
            return;
        }// end function

    }
}
