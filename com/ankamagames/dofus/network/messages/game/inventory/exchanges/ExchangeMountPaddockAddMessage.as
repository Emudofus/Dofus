package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.mount.MountClientData;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeMountPaddockAddMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6049;

        private var _isInitialized:Boolean = false;
        public var mountDescription:MountClientData;

        public function ExchangeMountPaddockAddMessage()
        {
            this.mountDescription = new MountClientData();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6049);
        }

        public function initExchangeMountPaddockAddMessage(mountDescription:MountClientData=null):ExchangeMountPaddockAddMessage
        {
            this.mountDescription = mountDescription;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.mountDescription = new MountClientData();
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
            this.serializeAs_ExchangeMountPaddockAddMessage(output);
        }

        public function serializeAs_ExchangeMountPaddockAddMessage(output:ICustomDataOutput):void
        {
            this.mountDescription.serializeAs_MountClientData(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeMountPaddockAddMessage(input);
        }

        public function deserializeAs_ExchangeMountPaddockAddMessage(input:ICustomDataInput):void
        {
            this.mountDescription = new MountClientData();
            this.mountDescription.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

