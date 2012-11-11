package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeMultiCraftCrafterCanUseHisRessourcesMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var allowed:Boolean = false;
        public static const protocolId:uint = 6020;

        public function ExchangeMultiCraftCrafterCanUseHisRessourcesMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6020;
        }// end function

        public function initExchangeMultiCraftCrafterCanUseHisRessourcesMessage(param1:Boolean = false) : ExchangeMultiCraftCrafterCanUseHisRessourcesMessage
        {
            this.allowed = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.allowed = false;
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
            this.serializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.allowed);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeMultiCraftCrafterCanUseHisRessourcesMessage(param1:IDataInput) : void
        {
            this.allowed = param1.readBoolean();
            return;
        }// end function

    }
}
