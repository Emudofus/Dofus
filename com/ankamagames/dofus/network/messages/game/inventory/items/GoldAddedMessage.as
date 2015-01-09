package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.data.items.GoldItem;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GoldAddedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6030;

        private var _isInitialized:Boolean = false;
        public var gold:GoldItem;

        public function GoldAddedMessage()
        {
            this.gold = new GoldItem();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6030);
        }

        public function initGoldAddedMessage(gold:GoldItem=null):GoldAddedMessage
        {
            this.gold = gold;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.gold = new GoldItem();
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
            this.serializeAs_GoldAddedMessage(output);
        }

        public function serializeAs_GoldAddedMessage(output:ICustomDataOutput):void
        {
            this.gold.serializeAs_GoldItem(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GoldAddedMessage(input);
        }

        public function deserializeAs_GoldAddedMessage(input:ICustomDataInput):void
        {
            this.gold = new GoldItem();
            this.gold.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

