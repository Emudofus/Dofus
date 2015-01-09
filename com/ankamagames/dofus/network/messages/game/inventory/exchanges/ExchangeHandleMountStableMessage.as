package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeHandleMountStableMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5965;

        private var _isInitialized:Boolean = false;
        public var actionType:int = 0;
        public var rideId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5965);
        }

        public function initExchangeHandleMountStableMessage(actionType:int=0, rideId:uint=0):ExchangeHandleMountStableMessage
        {
            this.actionType = actionType;
            this.rideId = rideId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.actionType = 0;
            this.rideId = 0;
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
            this.serializeAs_ExchangeHandleMountStableMessage(output);
        }

        public function serializeAs_ExchangeHandleMountStableMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.actionType);
            if (this.rideId < 0)
            {
                throw (new Error((("Forbidden value (" + this.rideId) + ") on element rideId.")));
            };
            output.writeVarInt(this.rideId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeHandleMountStableMessage(input);
        }

        public function deserializeAs_ExchangeHandleMountStableMessage(input:ICustomDataInput):void
        {
            this.actionType = input.readByte();
            this.rideId = input.readVarUhInt();
            if (this.rideId < 0)
            {
                throw (new Error((("Forbidden value (" + this.rideId) + ") on element of ExchangeHandleMountStableMessage.rideId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

