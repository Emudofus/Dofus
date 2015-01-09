package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.paddock.PaddockItem;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class GameDataPaddockObjectAddMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5990;

        private var _isInitialized:Boolean = false;
        public var paddockItemDescription:PaddockItem;

        public function GameDataPaddockObjectAddMessage()
        {
            this.paddockItemDescription = new PaddockItem();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5990);
        }

        public function initGameDataPaddockObjectAddMessage(paddockItemDescription:PaddockItem=null):GameDataPaddockObjectAddMessage
        {
            this.paddockItemDescription = paddockItemDescription;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.paddockItemDescription = new PaddockItem();
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
            this.serializeAs_GameDataPaddockObjectAddMessage(output);
        }

        public function serializeAs_GameDataPaddockObjectAddMessage(output:ICustomDataOutput):void
        {
            this.paddockItemDescription.serializeAs_PaddockItem(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_GameDataPaddockObjectAddMessage(input);
        }

        public function deserializeAs_GameDataPaddockObjectAddMessage(input:ICustomDataInput):void
        {
            this.paddockItemDescription = new PaddockItem();
            this.paddockItemDescription.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

