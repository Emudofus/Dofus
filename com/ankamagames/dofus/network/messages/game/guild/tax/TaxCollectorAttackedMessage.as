package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorAttackedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var firstNameId:uint = 0;
        public var lastNameId:uint = 0;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public static const protocolId:uint = 5918;

        public function TaxCollectorAttackedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5918;
        }// end function

        public function initTaxCollectorAttackedMessage(param1:uint = 0, param2:uint = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:uint = 0) : TaxCollectorAttackedMessage
        {
            this.firstNameId = param1;
            this.lastNameId = param2;
            this.worldX = param3;
            this.worldY = param4;
            this.mapId = param5;
            this.subAreaId = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.firstNameId = 0;
            this.lastNameId = 0;
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
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
            this.serializeAs_TaxCollectorAttackedMessage(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorAttackedMessage(param1:IDataOutput) : void
        {
            if (this.firstNameId < 0)
            {
                throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
            }
            param1.writeShort(this.firstNameId);
            if (this.lastNameId < 0)
            {
                throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            param1.writeShort(this.lastNameId);
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
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeShort(this.subAreaId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorAttackedMessage(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorAttackedMessage(param1:IDataInput) : void
        {
            this.firstNameId = param1.readShort();
            if (this.firstNameId < 0)
            {
                throw new Error("Forbidden value (" + this.firstNameId + ") on element of TaxCollectorAttackedMessage.firstNameId.");
            }
            this.lastNameId = param1.readShort();
            if (this.lastNameId < 0)
            {
                throw new Error("Forbidden value (" + this.lastNameId + ") on element of TaxCollectorAttackedMessage.lastNameId.");
            }
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of TaxCollectorAttackedMessage.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of TaxCollectorAttackedMessage.worldY.");
            }
            this.mapId = param1.readInt();
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of TaxCollectorAttackedMessage.subAreaId.");
            }
            return;
        }// end function

    }
}
