package com.ankamagames.dofus.network.messages.game.pvp
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AlignmentAreaUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var areaId:uint = 0;
        public var side:int = 0;
        public static const protocolId:uint = 6060;

        public function AlignmentAreaUpdateMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6060;
        }// end function

        public function initAlignmentAreaUpdateMessage(param1:uint = 0, param2:int = 0) : AlignmentAreaUpdateMessage
        {
            this.areaId = param1;
            this.side = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.areaId = 0;
            this.side = 0;
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
            this.serializeAs_AlignmentAreaUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_AlignmentAreaUpdateMessage(param1:IDataOutput) : void
        {
            if (this.areaId < 0)
            {
                throw new Error("Forbidden value (" + this.areaId + ") on element areaId.");
            }
            param1.writeShort(this.areaId);
            param1.writeByte(this.side);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AlignmentAreaUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_AlignmentAreaUpdateMessage(param1:IDataInput) : void
        {
            this.areaId = param1.readShort();
            if (this.areaId < 0)
            {
                throw new Error("Forbidden value (" + this.areaId + ") on element of AlignmentAreaUpdateMessage.areaId.");
            }
            this.side = param1.readByte();
            return;
        }// end function

    }
}
