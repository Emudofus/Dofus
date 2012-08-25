package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.mount.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeStartOkMountMessage extends ExchangeStartOkMountWithOutPaddockMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var paddockedMountsDescription:Vector.<MountClientData>;
        public static const protocolId:uint = 5979;

        public function ExchangeStartOkMountMessage()
        {
            this.paddockedMountsDescription = new Vector.<MountClientData>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5979;
        }// end function

        public function initExchangeStartOkMountMessage(param1:Vector.<MountClientData> = null, param2:Vector.<MountClientData> = null) : ExchangeStartOkMountMessage
        {
            super.initExchangeStartOkMountWithOutPaddockMessage(param1);
            this.paddockedMountsDescription = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.paddockedMountsDescription = new Vector.<MountClientData>;
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
            this.serializeAs_ExchangeStartOkMountMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeStartOkMountMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeStartOkMountWithOutPaddockMessage(param1);
            param1.writeShort(this.paddockedMountsDescription.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.paddockedMountsDescription.length)
            {
                
                (this.paddockedMountsDescription[_loc_2] as MountClientData).serializeAs_MountClientData(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeStartOkMountMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeStartOkMountMessage(param1:IDataInput) : void
        {
            var _loc_4:MountClientData = null;
            super.deserialize(param1);
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new MountClientData();
                _loc_4.deserialize(param1);
                this.paddockedMountsDescription.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
