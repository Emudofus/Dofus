package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockToSellListRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var pageIndex:uint = 0;
        public static const protocolId:uint = 6141;

        public function PaddockToSellListRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6141;
        }// end function

        public function initPaddockToSellListRequestMessage(param1:uint = 0) : PaddockToSellListRequestMessage
        {
            this.pageIndex = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.pageIndex = 0;
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
            this.serializeAs_PaddockToSellListRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_PaddockToSellListRequestMessage(param1:IDataOutput) : void
        {
            if (this.pageIndex < 0)
            {
                throw new Error("Forbidden value (" + this.pageIndex + ") on element pageIndex.");
            }
            param1.writeShort(this.pageIndex);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockToSellListRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_PaddockToSellListRequestMessage(param1:IDataInput) : void
        {
            this.pageIndex = param1.readShort();
            if (this.pageIndex < 0)
            {
                throw new Error("Forbidden value (" + this.pageIndex + ") on element of PaddockToSellListRequestMessage.pageIndex.");
            }
            return;
        }// end function

    }
}
