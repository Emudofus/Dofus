package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.house.HouseInformationsForSell;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class HouseToSellListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6140;

        private var _isInitialized:Boolean = false;
        public var pageIndex:uint = 0;
        public var totalPage:uint = 0;
        public var houseList:Vector.<HouseInformationsForSell>;

        public function HouseToSellListMessage()
        {
            this.houseList = new Vector.<HouseInformationsForSell>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6140);
        }

        public function initHouseToSellListMessage(pageIndex:uint=0, totalPage:uint=0, houseList:Vector.<HouseInformationsForSell>=null):HouseToSellListMessage
        {
            this.pageIndex = pageIndex;
            this.totalPage = totalPage;
            this.houseList = houseList;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.pageIndex = 0;
            this.totalPage = 0;
            this.houseList = new Vector.<HouseInformationsForSell>();
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HouseToSellListMessage(output);
        }

        public function serializeAs_HouseToSellListMessage(output:ICustomDataOutput):void
        {
            if (this.pageIndex < 0)
            {
                throw (new Error((("Forbidden value (" + this.pageIndex) + ") on element pageIndex.")));
            };
            output.writeVarShort(this.pageIndex);
            if (this.totalPage < 0)
            {
                throw (new Error((("Forbidden value (" + this.totalPage) + ") on element totalPage.")));
            };
            output.writeVarShort(this.totalPage);
            output.writeShort(this.houseList.length);
            var _i3:uint;
            while (_i3 < this.houseList.length)
            {
                (this.houseList[_i3] as HouseInformationsForSell).serializeAs_HouseInformationsForSell(output);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseToSellListMessage(input);
        }

        public function deserializeAs_HouseToSellListMessage(input:ICustomDataInput):void
        {
            var _item3:HouseInformationsForSell;
            this.pageIndex = input.readVarUhShort();
            if (this.pageIndex < 0)
            {
                throw (new Error((("Forbidden value (" + this.pageIndex) + ") on element of HouseToSellListMessage.pageIndex.")));
            };
            this.totalPage = input.readVarUhShort();
            if (this.totalPage < 0)
            {
                throw (new Error((("Forbidden value (" + this.totalPage) + ") on element of HouseToSellListMessage.totalPage.")));
            };
            var _houseListLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _houseListLen)
            {
                _item3 = new HouseInformationsForSell();
                _item3.deserialize(input);
                this.houseList.push(_item3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses

