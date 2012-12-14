package com.ankamagames.dofus.network.messages.game.tinsel
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TitleSelectRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var titleId:uint = 0;
        public static const protocolId:uint = 6365;

        public function TitleSelectRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6365;
        }// end function

        public function initTitleSelectRequestMessage(param1:uint = 0) : TitleSelectRequestMessage
        {
            this.titleId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.titleId = 0;
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
            this.serializeAs_TitleSelectRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_TitleSelectRequestMessage(param1:IDataOutput) : void
        {
            if (this.titleId < 0)
            {
                throw new Error("Forbidden value (" + this.titleId + ") on element titleId.");
            }
            param1.writeShort(this.titleId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TitleSelectRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_TitleSelectRequestMessage(param1:IDataInput) : void
        {
            this.titleId = param1.readShort();
            if (this.titleId < 0)
            {
                throw new Error("Forbidden value (" + this.titleId + ") on element of TitleSelectRequestMessage.titleId.");
            }
            return;
        }// end function

    }
}
