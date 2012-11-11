package com.ankamagames.dofus.network.messages.game.shortcut
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutBarSwapErrorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var error:uint = 0;
        public static const protocolId:uint = 6226;

        public function ShortcutBarSwapErrorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6226;
        }// end function

        public function initShortcutBarSwapErrorMessage(param1:uint = 0) : ShortcutBarSwapErrorMessage
        {
            this.error = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.error = 0;
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
            this.serializeAs_ShortcutBarSwapErrorMessage(param1);
            return;
        }// end function

        public function serializeAs_ShortcutBarSwapErrorMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.error);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutBarSwapErrorMessage(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutBarSwapErrorMessage(param1:IDataInput) : void
        {
            this.error = param1.readByte();
            if (this.error < 0)
            {
                throw new Error("Forbidden value (" + this.error + ") on element of ShortcutBarSwapErrorMessage.error.");
            }
            return;
        }// end function

    }
}
