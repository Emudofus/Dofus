package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeMountPaddockRemoveMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6050;

        private var _isInitialized:Boolean = false;
        public var mountId:Number = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6050);
        }

        public function initExchangeMountPaddockRemoveMessage(mountId:Number=0):ExchangeMountPaddockRemoveMessage
        {
            this.mountId = mountId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.mountId = 0;
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
            this.serializeAs_ExchangeMountPaddockRemoveMessage(output);
        }

        public function serializeAs_ExchangeMountPaddockRemoveMessage(output:ICustomDataOutput):void
        {
            if ((((this.mountId < -9007199254740992)) || ((this.mountId > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.mountId) + ") on element mountId.")));
            };
            output.writeDouble(this.mountId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeMountPaddockRemoveMessage(input);
        }

        public function deserializeAs_ExchangeMountPaddockRemoveMessage(input:ICustomDataInput):void
        {
            this.mountId = input.readDouble();
            if ((((this.mountId < -9007199254740992)) || ((this.mountId > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.mountId) + ") on element of ExchangeMountPaddockRemoveMessage.mountId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

