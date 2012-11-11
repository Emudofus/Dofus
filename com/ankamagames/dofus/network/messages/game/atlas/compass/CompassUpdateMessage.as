package com.ankamagames.dofus.network.messages.game.atlas.compass
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class CompassUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var type:uint = 0;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public static const protocolId:uint = 5591;

        public function CompassUpdateMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5591;
        }// end function

        public function initCompassUpdateMessage(param1:uint = 0, param2:int = 0, param3:int = 0) : CompassUpdateMessage
        {
            this.type = param1;
            this.worldX = param2;
            this.worldY = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.type = 0;
            this.worldX = 0;
            this.worldY = 0;
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
            this.serializeAs_CompassUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_CompassUpdateMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.type);
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
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_CompassUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_CompassUpdateMessage(param1:IDataInput) : void
        {
            this.type = param1.readByte();
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element of CompassUpdateMessage.type.");
            }
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of CompassUpdateMessage.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of CompassUpdateMessage.worldY.");
            }
            return;
        }// end function

    }
}
