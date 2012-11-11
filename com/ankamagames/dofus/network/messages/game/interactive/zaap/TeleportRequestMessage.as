package com.ankamagames.dofus.network.messages.game.interactive.zaap
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TeleportRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var teleporterType:uint = 0;
        public var mapId:uint = 0;
        public static const protocolId:uint = 5961;

        public function TeleportRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5961;
        }// end function

        public function initTeleportRequestMessage(param1:uint = 0, param2:uint = 0) : TeleportRequestMessage
        {
            this.teleporterType = param1;
            this.mapId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.teleporterType = 0;
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
            this.serializeAs_TeleportRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_TeleportRequestMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.teleporterType);
            if (this.mapId < 0)
            {
                throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
            }
            param1.writeInt(this.mapId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TeleportRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_TeleportRequestMessage(param1:IDataInput) : void
        {
            this.teleporterType = param1.readByte();
            if (this.teleporterType < 0)
            {
                throw new Error("Forbidden value (" + this.teleporterType + ") on element of TeleportRequestMessage.teleporterType.");
            }
            this.mapId = param1.readInt();
            if (this.mapId < 0)
            {
                throw new Error("Forbidden value (" + this.mapId + ") on element of TeleportRequestMessage.mapId.");
            }
            return;
        }// end function

    }
}
