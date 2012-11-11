package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var allow:Boolean = false;
        public static const protocolId:uint = 6021;

        public function ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6021;
        }// end function

        public function initExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(param1:Boolean = false) : ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage
        {
            this.allow = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.allow = false;
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
            this.serializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.allow);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeMultiCraftSetCrafterCanUseHisRessourcesMessage(param1:IDataInput) : void
        {
            this.allow = param1.readBoolean();
            return;
        }// end function

    }
}
