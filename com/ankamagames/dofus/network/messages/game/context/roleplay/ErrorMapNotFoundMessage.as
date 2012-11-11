package com.ankamagames.dofus.network.messages.game.context.roleplay
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ErrorMapNotFoundMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mapId:uint = 0;
        public static const protocolId:uint = 6197;

        public function ErrorMapNotFoundMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6197;
        }// end function

        public function initErrorMapNotFoundMessage(param1:uint = 0) : ErrorMapNotFoundMessage
        {
            this.mapId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.mapId = 0;
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
            this.serializeAs_ErrorMapNotFoundMessage(param1);
            return;
        }// end function

        public function serializeAs_ErrorMapNotFoundMessage(param1:IDataOutput) : void
        {
            if (this.mapId < 0)
            {
                throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
            }
            param1.writeInt(this.mapId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ErrorMapNotFoundMessage(param1);
            return;
        }// end function

        public function deserializeAs_ErrorMapNotFoundMessage(param1:IDataInput) : void
        {
            this.mapId = param1.readInt();
            if (this.mapId < 0)
            {
                throw new Error("Forbidden value (" + this.mapId + ") on element of ErrorMapNotFoundMessage.mapId.");
            }
            return;
        }// end function

    }
}
