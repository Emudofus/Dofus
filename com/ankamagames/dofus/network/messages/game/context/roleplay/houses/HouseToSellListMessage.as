package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.house.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class HouseToSellListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var pageIndex:uint = 0;
        public var totalPage:uint = 0;
        public var houseList:Vector.<HouseInformationsForSell>;
        public static const protocolId:uint = 6140;

        public function HouseToSellListMessage()
        {
            this.houseList = new Vector.<HouseInformationsForSell>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6140;
        }// end function

        public function initHouseToSellListMessage(param1:uint = 0, param2:uint = 0, param3:Vector.<HouseInformationsForSell> = null) : HouseToSellListMessage
        {
            this.pageIndex = param1;
            this.totalPage = param2;
            this.houseList = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.pageIndex = 0;
            this.totalPage = 0;
            this.houseList = new Vector.<HouseInformationsForSell>;
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
            this.serializeAs_HouseToSellListMessage(param1);
            return;
        }// end function

        public function serializeAs_HouseToSellListMessage(param1:IDataOutput) : void
        {
            if (this.pageIndex < 0)
            {
                throw new Error("Forbidden value (" + this.pageIndex + ") on element pageIndex.");
            }
            param1.writeShort(this.pageIndex);
            if (this.totalPage < 0)
            {
                throw new Error("Forbidden value (" + this.totalPage + ") on element totalPage.");
            }
            param1.writeShort(this.totalPage);
            param1.writeShort(this.houseList.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.houseList.length)
            {
                
                (this.houseList[_loc_2] as HouseInformationsForSell).serializeAs_HouseInformationsForSell(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseToSellListMessage(param1);
            return;
        }// end function

        public function deserializeAs_HouseToSellListMessage(param1:IDataInput) : void
        {
            var _loc_4:HouseInformationsForSell = null;
            this.pageIndex = param1.readShort();
            if (this.pageIndex < 0)
            {
                throw new Error("Forbidden value (" + this.pageIndex + ") on element of HouseToSellListMessage.pageIndex.");
            }
            this.totalPage = param1.readShort();
            if (this.totalPage < 0)
            {
                throw new Error("Forbidden value (" + this.totalPage + ") on element of HouseToSellListMessage.totalPage.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new HouseInformationsForSell();
                _loc_4.deserialize(param1);
                this.houseList.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
