package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class GoldAddedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var gold:GoldItem;
        public static const protocolId:uint = 6030;

        public function GoldAddedMessage()
        {
            this.gold = new GoldItem();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6030;
        }// end function

        public function initGoldAddedMessage(param1:GoldItem = null) : GoldAddedMessage
        {
            this.gold = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.gold = new GoldItem();
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
            this.serializeAs_GoldAddedMessage(param1);
            return;
        }// end function

        public function serializeAs_GoldAddedMessage(param1:IDataOutput) : void
        {
            this.gold.serializeAs_GoldItem(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_GoldAddedMessage(param1);
            return;
        }// end function

        public function deserializeAs_GoldAddedMessage(param1:IDataInput) : void
        {
            this.gold = new GoldItem();
            this.gold.deserialize(param1);
            return;
        }// end function

    }
}
