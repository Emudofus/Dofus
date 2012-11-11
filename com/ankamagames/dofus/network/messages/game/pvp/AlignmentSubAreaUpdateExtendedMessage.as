package com.ankamagames.dofus.network.messages.game.pvp
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AlignmentSubAreaUpdateExtendedMessage extends AlignmentSubAreaUpdateMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var eventType:int = 0;
        public static const protocolId:uint = 6319;

        public function AlignmentSubAreaUpdateExtendedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6319;
        }// end function

        public function initAlignmentSubAreaUpdateExtendedMessage(param1:uint = 0, param2:int = 0, param3:Boolean = false, param4:int = 0, param5:int = 0, param6:int = 0, param7:int = 0) : AlignmentSubAreaUpdateExtendedMessage
        {
            super.initAlignmentSubAreaUpdateMessage(param1, param2, param3);
            this.worldX = param4;
            this.worldY = param5;
            this.mapId = param6;
            this.eventType = param7;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.eventType = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AlignmentSubAreaUpdateExtendedMessage(param1);
            return;
        }// end function

        public function serializeAs_AlignmentSubAreaUpdateExtendedMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AlignmentSubAreaUpdateMessage(param1);
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
            }
            param1.writeShort(this.worldX);
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            param1.writeShort(this.worldY);
            param1.writeInt(this.mapId);
            param1.writeByte(this.eventType);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AlignmentSubAreaUpdateExtendedMessage(param1);
            return;
        }// end function

        public function deserializeAs_AlignmentSubAreaUpdateExtendedMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of AlignmentSubAreaUpdateExtendedMessage.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of AlignmentSubAreaUpdateExtendedMessage.worldY.");
            }
            this.mapId = param1.readInt();
            this.eventType = param1.readByte();
            return;
        }// end function

    }
}
