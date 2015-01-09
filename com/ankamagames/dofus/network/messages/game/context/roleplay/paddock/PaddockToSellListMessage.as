package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockInformationsForSell;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class PaddockToSellListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6138;

        private var _isInitialized:Boolean = false;
        public var pageIndex:uint = 0;
        public var totalPage:uint = 0;
        public var paddockList:Vector.<PaddockInformationsForSell>;

        public function PaddockToSellListMessage()
        {
            this.paddockList = new Vector.<PaddockInformationsForSell>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6138);
        }

        public function initPaddockToSellListMessage(pageIndex:uint=0, totalPage:uint=0, paddockList:Vector.<PaddockInformationsForSell>=null):PaddockToSellListMessage
        {
            this.pageIndex = pageIndex;
            this.totalPage = totalPage;
            this.paddockList = paddockList;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.pageIndex = 0;
            this.totalPage = 0;
            this.paddockList = new Vector.<PaddockInformationsForSell>();
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
            this.serializeAs_PaddockToSellListMessage(output);
        }

        public function serializeAs_PaddockToSellListMessage(output:ICustomDataOutput):void
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
            output.writeShort(this.paddockList.length);
            var _i3:uint;
            while (_i3 < this.paddockList.length)
            {
                (this.paddockList[_i3] as PaddockInformationsForSell).serializeAs_PaddockInformationsForSell(output);
                _i3++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PaddockToSellListMessage(input);
        }

        public function deserializeAs_PaddockToSellListMessage(input:ICustomDataInput):void
        {
            var _item3:PaddockInformationsForSell;
            this.pageIndex = input.readVarUhShort();
            if (this.pageIndex < 0)
            {
                throw (new Error((("Forbidden value (" + this.pageIndex) + ") on element of PaddockToSellListMessage.pageIndex.")));
            };
            this.totalPage = input.readVarUhShort();
            if (this.totalPage < 0)
            {
                throw (new Error((("Forbidden value (" + this.totalPage) + ") on element of PaddockToSellListMessage.totalPage.")));
            };
            var _paddockListLen:uint = input.readUnsignedShort();
            var _i3:uint;
            while (_i3 < _paddockListLen)
            {
                _item3 = new PaddockInformationsForSell();
                _item3.deserialize(input);
                this.paddockList.push(_item3);
                _i3++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock

