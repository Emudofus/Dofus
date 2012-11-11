package com.ankamagames.dofus.network.messages.game.script
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class URLOpenMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var urlId:uint = 0;
        public static const protocolId:uint = 6266;

        public function URLOpenMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6266;
        }// end function

        public function initURLOpenMessage(param1:uint = 0) : URLOpenMessage
        {
            this.urlId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.urlId = 0;
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
            this.serializeAs_URLOpenMessage(param1);
            return;
        }// end function

        public function serializeAs_URLOpenMessage(param1:IDataOutput) : void
        {
            if (this.urlId < 0)
            {
                throw new Error("Forbidden value (" + this.urlId + ") on element urlId.");
            }
            param1.writeInt(this.urlId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_URLOpenMessage(param1);
            return;
        }// end function

        public function deserializeAs_URLOpenMessage(param1:IDataInput) : void
        {
            this.urlId = param1.readInt();
            if (this.urlId < 0)
            {
                throw new Error("Forbidden value (" + this.urlId + ") on element of URLOpenMessage.urlId.");
            }
            return;
        }// end function

    }
}
