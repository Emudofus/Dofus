package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeGuildTaxCollectorGetMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var collectorName:String = "";
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public var userName:String = "";
        public var experience:Number = 0;
        public var objectsInfos:Vector.<ObjectItemQuantity>;
        public static const protocolId:uint = 5762;

        public function ExchangeGuildTaxCollectorGetMessage()
        {
            this.objectsInfos = new Vector.<ObjectItemQuantity>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5762;
        }// end function

        public function initExchangeGuildTaxCollectorGetMessage(param1:String = "", param2:int = 0, param3:int = 0, param4:int = 0, param5:uint = 0, param6:String = "", param7:Number = 0, param8:Vector.<ObjectItemQuantity> = null) : ExchangeGuildTaxCollectorGetMessage
        {
            this.collectorName = param1;
            this.worldX = param2;
            this.worldY = param3;
            this.mapId = param4;
            this.subAreaId = param5;
            this.userName = param6;
            this.experience = param7;
            this.objectsInfos = param8;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.collectorName = "";
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
            this.userName = "";
            this.experience = 0;
            this.objectsInfos = new Vector.<ObjectItemQuantity>;
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
            this.serializeAs_ExchangeGuildTaxCollectorGetMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeGuildTaxCollectorGetMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.collectorName);
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
            param1.writeUTF(this.userName);
            param1.writeDouble(this.experience);
            param1.writeShort(this.objectsInfos.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.objectsInfos.length)
            {
                
                (this.objectsInfos[_loc_2] as ObjectItemQuantity).serializeAs_ObjectItemQuantity(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeGuildTaxCollectorGetMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeGuildTaxCollectorGetMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            this.collectorName = param1.readUTF();
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of ExchangeGuildTaxCollectorGetMessage.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of ExchangeGuildTaxCollectorGetMessage.worldY.");
            }
            this.mapId = param1.readInt();
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of ExchangeGuildTaxCollectorGetMessage.subAreaId.");
            }
            this.userName = param1.readUTF();
            this.experience = param1.readDouble();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItemQuantity();
                _loc_4.deserialize(param1);
                this.objectsInfos.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
