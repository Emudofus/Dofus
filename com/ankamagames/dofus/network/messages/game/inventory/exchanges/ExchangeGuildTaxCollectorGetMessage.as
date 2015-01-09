package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemQuantity;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ExchangeGuildTaxCollectorGetMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5762;

        private var _isInitialized:Boolean = false;
        public var collectorName:String = "";
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public var userName:String = "";
        public var experience:Number = 0;
        public var objectsInfos:Vector.<ObjectItemQuantity>;

        public function ExchangeGuildTaxCollectorGetMessage()
        {
            this.objectsInfos = new Vector.<ObjectItemQuantity>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5762);
        }

        public function initExchangeGuildTaxCollectorGetMessage(collectorName:String="", worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0, userName:String="", experience:Number=0, objectsInfos:Vector.<ObjectItemQuantity>=null):ExchangeGuildTaxCollectorGetMessage
        {
            this.collectorName = collectorName;
            this.worldX = worldX;
            this.worldY = worldY;
            this.mapId = mapId;
            this.subAreaId = subAreaId;
            this.userName = userName;
            this.experience = experience;
            this.objectsInfos = objectsInfos;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.collectorName = "";
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
            this.userName = "";
            this.experience = 0;
            this.objectsInfos = new Vector.<ObjectItemQuantity>();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ExchangeGuildTaxCollectorGetMessage(output);
        }

        public function serializeAs_ExchangeGuildTaxCollectorGetMessage(output:IDataOutput):void
        {
            output.writeUTF(this.collectorName);
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element worldX.")));
            };
            output.writeShort(this.worldX);
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element worldY.")));
            };
            output.writeShort(this.worldY);
            output.writeInt(this.mapId);
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeShort(this.subAreaId);
            output.writeUTF(this.userName);
            if ((((this.experience < -9007199254740992)) || ((this.experience > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experience) + ") on element experience.")));
            };
            output.writeDouble(this.experience);
            output.writeShort(this.objectsInfos.length);
            var _i8:uint;
            while (_i8 < this.objectsInfos.length)
            {
                (this.objectsInfos[_i8] as ObjectItemQuantity).serializeAs_ObjectItemQuantity(output);
                _i8++;
            };
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ExchangeGuildTaxCollectorGetMessage(input);
        }

        public function deserializeAs_ExchangeGuildTaxCollectorGetMessage(input:IDataInput):void
        {
            var _item8:ObjectItemQuantity;
            this.collectorName = input.readUTF();
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of ExchangeGuildTaxCollectorGetMessage.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of ExchangeGuildTaxCollectorGetMessage.worldY.")));
            };
            this.mapId = input.readInt();
            this.subAreaId = input.readShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of ExchangeGuildTaxCollectorGetMessage.subAreaId.")));
            };
            this.userName = input.readUTF();
            this.experience = input.readDouble();
            if ((((this.experience < -9007199254740992)) || ((this.experience > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experience) + ") on element of ExchangeGuildTaxCollectorGetMessage.experience.")));
            };
            var _objectsInfosLen:uint = input.readUnsignedShort();
            var _i8:uint;
            while (_i8 < _objectsInfosLen)
            {
                _item8 = new ObjectItemQuantity();
                _item8.deserialize(input);
                this.objectsInfos.push(_item8);
                _i8++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

