package com.ankamagames.dofus.network.messages.game.context
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GameContextCreateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var context:uint = 1;
        public static const protocolId:uint = 200;

        public function GameContextCreateMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 200;
        }// end function

        public function initGameContextCreateMessage(param1:uint = 1) : GameContextCreateMessage
        {
            this.context = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.context = 1;
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
            this.serializeAs_GameContextCreateMessage(param1);
            return;
        }// end function

        public function serializeAs_GameContextCreateMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.context);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GameContextCreateMessage(param1);
            return;
        }// end function

        public function deserializeAs_GameContextCreateMessage(param1:IDataInput) : void
        {
            this.context = param1.readByte();
            if (this.context < 0)
            {
                throw new Error("Forbidden value (" + this.context + ") on element of GameContextCreateMessage.context.");
            }
            return;
        }// end function

    }
}
